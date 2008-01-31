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
local tracing
local tasktab = {}
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

local function trace(a)
  layout = layout - 1
  if layout <= 0 then
    io.write("\n")
    layout = 50
  end
  io.write(a)
end

local task_proto = {}

function task_proto:tick(pkt)
  return self[self.state](self, pkt)
end

function task_proto:waitpkt()
  local pkt = self.wkq
  self.wkq = pkt.link
  self.state = (self.wkq and "runpkt") or "run"
  return self:tick(pkt)
end

function task_proto:run(pkt)
  if tracing then
    trace(self.id)
  end
  local task = self:fn(pkt)
  return task:tick()
end

task_proto.runpkt = task_proto.run

function task_proto:wait()
  return self.link:tick()
end

task_proto.hold = task_proto.wait
task_proto.holdpkt = task_proto.wait
task_proto.holdwait = task_proto.wait
task_proto.holdwaitpkt = task_proto.wait

function task_proto:quit()
  return nil
end

local suspend_table = {
  run = "wait",
  runpkt = "waitpkt",
  hold = "holdwait",
  holdpkt = "holdwaitpkt"
}

function task_proto:suspend()
  self.state = suspend_table[self.state] or self.state
  return self
end

local holdcount = 0

local hold_table = {
  run = "hold",
  runpkt = "holdpkt",
  wait = "holdwait",
  waitpkt = "holdwaitpkt"
}

function task_proto:hold_self()
  holdcount = holdcount + 1
  self.state = hold_table[self.state] or self.state
  return self.link or { tick = task_proto.quit }
end

local function find_task(id)
  local t = tasktab[id]
  if not t then error("\nBad task id " .. id) end
  return t
end

local release_table = {
  hold = "run",
  holdpkt = "runpkt",
  holdwait = "wait",
  holdwaitpkt = "waitpkt"
}

function task_proto:release(id)
  local t = find_task(id)
  t.state = release_table[t.state] or t.state
  if t.pri > self.pri then
    return t
  else
    return self
  end
end

local qpktcount = 0

local queue_table = {
  run = "runpkt",
  hold = "holdpkt",
  wait = "waitpkt",
  holdwait = "holdwaitpkt"
}

function task_proto:qpkt(pkt)
  local t = find_task(pkt.id)
  qpktcount = qpktcount + 1
  pkt.link = nil
  pkt.id = self.id
  if not t.wkq then
    t.wkq = pkt
    t.state = queue_table[t.state] or t.state
    if t.pri > self.pri then return t end
  else
    t.wkq = append(pkt, t.wkq)
  end
  return self
end

local function task(id, link, pri, wkq, state, fn, v1, v2)
  local t = { link = link, id = id, pri = pri,
	      wkq = wkq, state = state, fn = fn,
	      v1 = v1, v2 = v2 }
  for k, v in pairs(task_proto) do
    t[k] = v
  end
  tasktab[id] = t
  return t
end

local floor = math.floor

local function fn_idle(self, pkt)
  self.v2 = self.v2 - 1
  if self.v2 == 0 then return self:hold_self() end
  if (self.v1 % 2) == 0 then
    self.v1 = floor(self.v1 / 2)
    return self:release(I_DEVA)
  else
    self.v1 = bxor(floor(self.v1 / 2), 0xD008)
    return self:release(I_DEVB)
  end
end

local alphabet = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
		   'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
		   'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' }

local function fn_work(self, pkt)
  if not pkt then return self:suspend() end
  self.v1 = I_HANDLERA + I_HANDLERB - self.v1
  pkt.id = self.v1
  pkt.a1 = 1
  for i = 1, BUFSIZE do
    self.v2 = self.v2 + 1
    if self.v2 > 26 then self.v2 = 1 end
    pkt.a2[i] = alphabet[self.v2]
  end
  return self:qpkt(pkt)
end

local function fn_handler(self, pkt)
  if pkt then
    if pkt.kind == "work" then
      self.v1 = append(pkt, self.v1)
    else
      self.v2 = append(pkt, self.v2)
    end
  end

  if self.v1 then
    local workpkt = self.v1
    local count = workpkt.a1
    if count > BUFSIZE then
      self.v1 = self.v1.link
      return self:qpkt(workpkt)
    end

    if self.v2 then
      local devpkt = self.v2
      self.v2 = self.v2.link
      devpkt.a1 = workpkt.a2[count]
      workpkt.a1 = count + 1
      return self:qpkt(devpkt)
    end
  end

  return self:suspend()
end

local function fn_dev(self, pkt)
  if not pkt then
    if not self.v1 then return self:suspend() end
    pkt = self.v1
    self.v1 = nil
    return self:qpkt(pkt)
  else
    self.v1 = pkt
    if tracing then trace(pkt.a1) end
    return self:hold_self()
  end
end

local function main()
  local wkq
  print("Benchmark starting")
  local idle = task(I_IDLE, nil, 0, wkq, "run", fn_idle, 1, COUNT)
  wkq = packet(nil, 0, "work")
  wkq = packet(wkq, 0, "work")
  local work = task(I_WORK, idle, 1000, wkq, "waitpkt", fn_work, I_HANDLERA, 0)
  wkq = packet(nil, I_DEVA, "dev")
  wkq = packet(wkq, I_DEVA, "dev")
  wkq = packet(wkq, I_DEVA, "dev")
  local handlera = task(I_HANDLERA, work,  2000, wkq, "waitpkt", fn_handler, nil, nil)
  wkq = packet(nil, I_DEVB, "dev")
  wkq = packet(wkq, I_DEVB, "dev")
  wkq = packet(wkq, I_DEVB, "dev")
  local handlerb = task(I_HANDLERB, handlera, 3000, wkq, "waitpkt", fn_handler, nil, nil)
  wkq = nil
  local deva = task(I_DEVA, handlerb, 4000, wkq, "wait", fn_dev, nil, nil)
  local devb = task(I_DEVB, deva, 5000, wkq, "wait", fn_dev, nil, nil)
  print("Starting")
  local t1 = os.clock()
  devb:tick()
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
