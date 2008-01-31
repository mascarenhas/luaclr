-- Richards' benchmark
-- Derived from C version

local COUNT = 10000
local QPKTCOUNT = 23246
local HOLDCOUNT = 9297
local MAXINT = 32767
local I_IDLE = 1
local I_WORK = 2
local I_HANDLERA = 3
local I_HANDLERB = 4
local I_DEVA = 5
local I_DEVB = 6

local BUFSIZE = 4
local layout = 0
local tasktab = {}
local tasklist
local taskid
local tracing
local ascii_0 = 48

local tab = {  -- tab[i][j] = xor(i-1, j-1)
  {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, },
  {1, 0, 3, 2, 5, 4, 7, 6, 9, 8, 11, 10, 13, 12, 15, 14, },
  {2, 3, 0, 1, 6, 7, 4, 5, 10, 11, 8, 9, 14, 15, 12, 13, },
  {3, 2, 1, 0, 7, 6, 5, 4, 11, 10, 9, 8, 15, 14, 13, 12, },
  {4, 5, 6, 7, 0, 1, 2, 3, 12, 13, 14, 15, 8, 9, 10, 11, },
  {5, 4, 7, 6, 1, 0, 3, 2, 13, 12, 15, 14, 9, 8, 11, 10, },
  {6, 7, 4, 5, 2, 3, 0, 1, 14, 15, 12, 13, 10, 11, 8, 9, },
  {7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10, 9, 8, },
  {8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, },
  {9, 8, 11, 10, 13, 12, 15, 14, 1, 0, 3, 2, 5, 4, 7, 6, },
  {10, 11, 8, 9, 14, 15, 12, 13, 2, 3, 0, 1, 6, 7, 4, 5, },
  {11, 10, 9, 8, 15, 14, 13, 12, 3, 2, 1, 0, 7, 6, 5, 4, },
  {12, 13, 14, 15, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3, },
  {13, 12, 15, 14, 9, 8, 11, 10, 5, 4, 7, 6, 1, 0, 3, 2, },
  {14, 15, 12, 13, 10, 11, 8, 9, 6, 7, 4, 5, 2, 3, 0, 1, },
  {15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, },
}

local function bxor (a,b)
  local res, c = 0, 1
  while a > 0 and b > 0 do
    local a2, b2 = a % 16, b % 16
    res = res + tab[a2+1][b2+1]*c
    a = (a-a2)/16
    b = (b-b2)/16
    c = c*16
  end
  res = res + a*c + b*c
  return res
end


local function append(pkt, list)
  pkt.link = nil
  if not list then return pkt end
  local l = list
  while l.link do l = l.link end
  l.link = pkt
  return list
end

local function packet(link, id, kind)
  return { id = id, link = link, kind = kind, a1 = nil, a2 = {} }
end

local function task(id, pri, wkq, state, fn, v1, v2)
  local t = { link = tasklist, id = id, pri = pri,
	      wkq = wkq, state = state, fn = fn,
	      v1 = v1, v2 = v2 }
  tasklist = t
  tasktab[id] = t
end

local function trace(a)
  layout = layout - 1
  if layout <= 0 then
    io.write("\n")
    layout = 50
  end
  io.write(a)
end

local schedule = {}

local tcb, pkt, v1, v2

function schedule.waitpkt()
  pkt = tcb.wkq
  tcb.wkq = pkt.link
  tcb.state = (tcb.wkq and "runpkt") or "run"
  return schedule[tcb.state]()
end

function schedule.run()
  taskid = tcb.id
  v1 = tcb.v1
  v2 = tcb.v2
  if tracing then
    trace(taskid)
  end
  local newtcb = tcb.fn(pkt)
  tcb.v1 = v1
  tcb.v2 = v2
  tcb = newtcb
  pkt = nil
  return schedule[tcb.state]()
end

schedule.runpkt = schedule.run

function schedule.wait()
  tcb = tcb.link
  pkt = nil
  return schedule[tcb.state]()
end

schedule.hold = schedule.wait
schedule.holdpkt = schedule.wait
schedule.holdwait = schedule.wait
schedule.holdwaitpkt = schedule.wait

function schedule.quit()
  return
end

local function wait()
  if tcb.state == "run" then
    tcb.state = "wait"
  elseif tcb.state == "runpkt" then
    tcb.state = "waitpkt"
  elseif tcb.state == "hold" then
    tcb.state = "holdwait"
  elseif tcb.state == "holdpkt" then
    tcb.state = "holdwaitpkt"
  end
  return tcb
end

local holdcount = 0

local function hold_self()
  holdcount = holdcount + 1
  if tcb.state == "run" then
    tcb.state = "hold"
  elseif tcb.state == "runpkt" then
    tcb.state = "holdpkt"
  elseif tcb.state == "wait" then
    tcb.state = "holdwait"
  elseif tcb.state == "waitpkt" then
    tcb.state = "holdwaitpkt"
  end
  return tcb.link or { state = "quit" }
end

local function find_tcb(id)
  local t = tasktab[id]
  if not t then error("\nBad task id " .. id) end
  return t
end

local function release(id)
  local t = find_tcb(id)
  if t.state == "hold" then
    t.state = "run"
  elseif t.state == "holdpkt" then
    t.state = "runpkt"
  elseif t.state == "holdwait" then
    t.state = "wait"
  elseif t.state == "holdwaitpkt" then
    t.state = "waitpkt"
  end
  if t.pri > tcb.pri then
    return t
  else
    return tcb
  end
end

local qpktcount = 0

local function qpkt(pkt)
  local t = find_tcb(pkt.id)
  qpktcount = qpktcount + 1
  pkt.link = nil
  pkt.id = taskid
  if not t.wkq then
    t.wkq = pkt
    if t.state == "run" then
      t.state = "runpkt"
    elseif t.state == "hold" then
      t.state = "holdpkt"
    elseif t.state == "wait" then
      t.state = "waitpkt"
    elseif t.state == "holdwait" then
      t.state = "holdwaitpkt"
    end
    if t.pri > tcb.pri then return t end
  else
    t.wkq = append(pkt, t.wkq)
  end
  return tcb
end

local floor = math.floor

local function fn_idle(pkt)
  v2 = v2 - 1
  if v2 == 0 then return hold_self() end
  if (v1 % 2) == 0 then
    v1 = floor(v1 / 2)
    return release(I_DEVA)
  else
    v1 = bxor(floor(v1 /2), 0xD008)
    return release(I_DEVB)
  end
end

local alphabet = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
		   'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
		   'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' }

local function fn_work(pkt)
  if not pkt then return wait() end
  v1 = I_HANDLERA + I_HANDLERB - v1
  pkt.id = v1
  pkt.a1 = 1
  for i = 1, BUFSIZE do
    v2 = v2 + 1
    if v2 > 26 then v2 = 1 end
    pkt.a2[i] = alphabet[v2]
  end
  return qpkt(pkt)
end

local function fn_handler(pkt)
  if pkt then
    if pkt.kind == "work" then
      v1 = append(pkt, v1)
    else
      v2 = append(pkt, v2)
    end
  end

  if v1 then
    local workpkt = v1
    local count = workpkt.a1
    if count > BUFSIZE then
      v1 = v1.link
      return qpkt(workpkt)
    end

    if v2 then
      local devpkt = v2
      v2 = v2.link
      devpkt.a1 = workpkt.a2[count]
      workpkt.a1 = count + 1
      return qpkt(devpkt)
    end
  end

  return wait()
end

local function fn_dev(pkt)
  if not pkt then
    if not v1 then return wait() end
    pkt = v1
    v1 = nil
    return qpkt(pkt)
  else
    v1 = pkt
    if tracing then trace(pkt.a1) end
    return hold_self()
  end
end

local function main()
  local wkq
  print("Benchmark starting")
  task(I_IDLE, 0, wkq, "run", fn_idle, 1, COUNT)
  wkq = packet(nil, 0, "work")
  wkq = packet(wkq, 0, "work")
  task(I_WORK, 1000, wkq, "waitpkt", fn_work, I_HANDLERA, 0)
  wkq = packet(nil, I_DEVA, "dev")
  wkq = packet(wkq, I_DEVA, "dev")
  wkq = packet(wkq, I_DEVA, "dev")
  task(I_HANDLERA, 2000, wkq, "waitpkt", fn_handler, nil, nil)
  wkq = packet(nil, I_DEVB, "dev")
  wkq = packet(wkq, I_DEVB, "dev")
  wkq = packet(wkq, I_DEVB, "dev")
  task(I_HANDLERB, 3000, wkq, "waitpkt", fn_handler, nil, nil)
  wkq = nil
  task(I_DEVA, 4000, wkq, "wait", fn_dev, nil, nil)
  task(I_DEVB, 5000, wkq, "wait", fn_dev, nil, nil)
  tcb = tasklist
  print("Starting")
  local t1 = os.clock()
  schedule[tcb.state]()
  local t2 = os.clock()
  print("\nfinished")
  print("qpkt count = " .. qpktcount .. " holdcount = " .. holdcount)
  local results
  if qpktcount == QPKTCOUNT and holdcount == HOLDCOUNT then
    results = "correct"
  else
    results = "incorrect"
  end
  print("these results are " .. results)
  print("\nend of run")
  print("Time: ", t2-t1)
end

main()
