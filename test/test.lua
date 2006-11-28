local parse = require"cheese"
local stream = require"stream.string"

local aei = parse.bind(parse.seq(parse.plus(parse.class("a","a","e","e","i","i")),
				                   parse.pnot(parse.str("ou"))),
      	  function (res)
	    return table.concat(res[1])
	  end)

local foobar = parse.str("foobar")

local parser = parse.choice(aei, foobar)

local ok, res = pcall(parser, stream.new("aei"))
print(res)

local res = parser(stream.new("foobar"))
print(res)
