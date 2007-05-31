-- fibonacci function with cache

-- very inefficient fibonacci function
local function fib(n)
	if n<2 then
		return n
	else
		return fib(n-1)+fib(n-2)
	end
end

local function fib_iter(n)
      local a, b = 1, 1
      for i = 3, n do
        b, a = b + a, b
      end
      return b
end

-- a general-purpose value cache
function cache(f)
	local c={}
	return function (x)
		local y=c[x]
		if not y then
			y=f(x)
			c[x]=y
		end
		return y
	end
end

-- run and time it
function test(s,f,n_iter)
	local c=os.clock()
	local v
	local n = n
	local x
	for i = 1, n_iter do
	  v=f(n)
	  x = i
        end
	local t=os.clock()
	print(s,n,x,v,t-c)
end

n=24
n=tonumber(n)
print("","n","iter","value","time")
test("plain",fib,100)
fib=cache(fib)
test("cached",fib,1000000)
fib=fib_iter
test("iter",fib,1000000)
