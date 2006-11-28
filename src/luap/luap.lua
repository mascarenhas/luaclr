require"cheese"

module("cheese.luap", package.seeall)

--
-- Lexical definitions
-- 

ENDLINE = cheese.choice(cheese.str("\r\n"), cheese.char("\n"), cheese.char("\r"))
SPACE = cheese.choice(cheese.char(" "), cheese.char("\t"), ENDLINE)
COMMENT = cheese.seq(cheese.str("--"),
				       cheese.star(cheese.seq(cheese.pnot(ENDLINE), any)),
				       ENDLINE)
SPACING = cheese.star(cheese.choice(SPACE, COMMENT))

-- Keywords

function keyword(str)
	 _G[string.upper(str)] = cheese.seq(cheese.str(str), SPACING)
end

function keyword(...)
	 local args = {...}
	 for i, str in ipairs(args) do
	    keyword(str)
	 end
end

function token(name, str)
	 if string.len(str) == 1 then
	    _G[string.upper(name)] = cheese.seq(cheese.char(str), SPACING))
	 else
	    _G[string.upper(name)] = cheese.seq(cheese.str(str), SPACING))
	 end
end

function tokens(tab)
	 for name, token in pairs(tab) do
	     token(name, token)
	 end
end

keywords("and", "break", "do", "else", "elseif", "end", "false", "for", "function",
		"if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until",
		"while")

tokens{
	plus = "+",
	minus = "-",
	star = "*",
	slash = "/",
	percent = "%",
	hat = "^",
	eq = "==",
	neq = "~=",
	leq = "<=",
	geq = ">=",
	lt = "<",
	gt = ">",
	assign = "=",
	lpar = "(",
	rpar = ")",
	lcurly = "{",
	rcurly = "}",
	lbra = "[",
	rbra = "]",
	semi = ";",
	colon = ":",
	comma = ",",
	dot = ".",
	range = "..",
	ellipse = "..."
}

