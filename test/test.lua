local parse = require"cheese"
local stream = require"stream.string"

parse.open_grammar"rules"

aei = (plus(class("a","e","i")) .. pnot(str("ou"))) %
      	  function (res)
	    return table.concat(res[1])
	    	  end

foobar = str("foobar")

join = aei / foobar

close()

local parsers = parse.compile(rules)

local ok, res = pcall(parsers.join, stream.new("aei"))
print(res)

local res = parsers.join(stream.new("foobar"))
print(res)
