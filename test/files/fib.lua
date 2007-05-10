-- fibonacci function with cache

-- very inefficient fibonacci function
local function fib(n)
	if n<2 then
		return n
	else
		return fib(n-1)+fib(n-2)
	end
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
function test(s,f)
	local c=os.clock()
	local v
	local n = n
	for i = 1, 500 do
	  v=f(n)
        end
	local t=os.clock()
	print(s,n,v,t-c)
end

n=24
n=tonumber(n)
print("","n","value","time")
test("plain",fib)
fib=cache(fib)
test("cached",fib)
