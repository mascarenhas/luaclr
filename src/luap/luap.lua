require"cheese"

module("cheese.luap", package.seeall)

--
-- Lexical definitions
-- 

-- Keywords

function keyword(str)
	 _G[string.upper(str)] = cheese.str(str)
end

function keyword(...)
	 local args = {...}
	 for i, str in ipairs(args) do
	    keyword(str)
	 end
end

keywords("and", "break", "do", "else", "elseif", "end", "false", "for", "function",
		"if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until",
		"while")
