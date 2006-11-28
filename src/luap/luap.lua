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
SPACING = cheese.skip(cheese.star(cheese.choice(SPACE, COMMENT)))
NAME_CHARS = cheese.class("_", "_", "a", "z", "A", "Z", "0", "9")

-- Keywords

function keyword(str)
	 _G[string.upper(str)] = cheese.seq(cheese.str(str), cheese.pnot(NAME_CHARS), SPACING)
end

function keywords(...)
	 local args = {...}
	 for i, str in ipairs(args) do
	    keyword(str)
	 end
	 KEYWORDS = cheese.choice(unpack(table.map(args,
	 	  function (str)
		  	   return _G[string.upper(str)]
		  end)))
end

keywords("and", "break", "do", "else", "elseif", "end", "false", "for", "function",
		"if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until",
		"while")

-- Operations

function op(name, str)
	 if string.len(str) == 1 then
	    _G[string.upper(name)] = cheese.seq(cheese.char(str), SPACING))
	 else
	    _G[string.upper(name)] = cheese.seq(cheese.str(str), SPACING))
	 end
end

function def_ops(tab)
	 for name, sop in pairs(tab) do
	     op(name, sop)
	 end
end

ops = {
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

def_ops(ops)

-- Escape codes

function escape(str, code)
	 return cheese.bind(cheese.str(str), function (_) return code end)
end

escapes = {
	bell = escape("\\a", "\a"),
	bspace = escape("\\b", "\b"),
	ffeed = escape("\\f", "\f"),
	lfeed = cheese.bind(cheese.choice(cheese.str("\\n"),
								cheese.str("\\\n")),
					function (_) return "\n" end)	
	cr = escape("\\r", "\r"),
	htab = escape("\\t", "\t"),
	vtab = escape("\\v", "\v"),
	bslash = escape("\\\\", "\\"),
	dquote = escape("\\\"", "\""),
	squote = escape("\\\'", "\'")
	num = cheese.bind(cheese.concat(cheese.seq(cheese.char("\\"), cheese.digit, 
	      						  cheese.opt(cheese.digit), cheese.opt(cheese.digit))),
					function (esc)
					   return string.char(tonumber(string.sub(esc, 2, -1)))
					end)
}

function def_escapes(tab)
	 local escs = {}
	 for name, esc in pairs(escapes)
	     table.insert(escs, esc)
	 end
	 _G["ESCAPE"] = cheese.choice(unpack(escs))
end

def_escapes(escapes)

-- Literals and identifiers

INVALID = cheese.choice(
			cheese.char("\n"), cheese.char("\\"), cheese.char(string.char(0)))

INVALID_DQUOTE = cheese.choice(INVALID, cheese.char("\""))

DQUOTE_STRING = cheese.seq(cheese.char("\""),
						  cheese.star(
							cheese.choice(ESCAPE,
										cheese.seq(
											cheese.pnot(INVALID_DQUOTE),
											cheese.any))),
						  cheese.char("\""))

INVALID_SQUOTE = cheese.choise(INVALID, cheese.char("\'"))

SQUOTE_STRING = cheese.seq(cheese.char("\'"),
						  cheese.star(
							cheese.choice(ESCAPE,
										cheese.seq(
											cheese.pnot(INVALID_SQUOTE),
											cheese.any))),
						  cheese.char("\'"))

STRING = cheese.bind(cheese.concat(cheese.seq(
								cheese.choice(SQUOTE_STRING, DQUOTE_STRING),
								SPACING)),
       	 			function (str) return { tag = "string", val = str } end

DECIMAL = cheese.plus(cheese.digit)

SIGN = cheese.opt(cheese.char("-"))

EXPONENT = cheese.seq(cheese.choice(cheese.char("e"), cheese.char("E")), SIGN, DECIMAL)

NUMBER = cheese.bind(cheese.concat(cheese.seq(SIGN, DECIMAL,
				    cheese.opt(cheese.seq(cheese.char("."), DECIMAL)),
				    cheese.opt(EXPONENT))),
				function (str) return { tag = "number", val = tonumber(str) } end

LITERAL = cheese.choice(NUMBER, STRING)

NAME = cheese.bind(cheese.concat(cheese.seq(cheese.pnot(KEYWORDS),
									   cheese.class("_", "_", "a", "z", "A", "Z"),
       							      	   	   cheese.star(NAME_CHARS))),
				function (str) return { tag = "name", val = str } end 

FIELDSEP = cheese.choice(COMMA, SEMI)

--
-- Hierarchical definitions
--

Block = cheese.bind(cheese.seq(cheese.star(cheese.seq(Stat, cheese.opt(SEMI))),
      				 		     cheese.opt(cheese.seq(LastStat, cheese.opt(SEMI)))),
				 function (tree)
				 	  local chunk_node = { tag = "block", stats = {}}
					  for _, v in ipairs(tree[1]) do
					      table.insert(chunk_node.stats, v[1])
					  end
					  if tree[2][1] then
					     table.insert(chunk_node.stats, tree[2][1][1])
					  end
					  return chunk_node
				 end)

Chunk = cheese.bind(cheese.seq(SPACING, Block), function (tree) return tree[2] end

DoBlock = cheese.bind(cheese.seq(DO, Block, END), function (tree) return tree[2] end)

While = cheese.bind(cheese.seq(WHILE, Exp, DO, Block, END),
      				   function (tree)
				   	    return { tag = "while", exp = tree[2], block = tree[4] }
				   end)

Repeat = cheese.bind(cheese.seq(REPEAT, Block, UNTIL, Exp),
       	 			  function (tree)
				  	   return { tag = "repeat", exp = tree[4], block = tree[2] }
			 	  end)

If = cheese.bind(cheese.seq(IF, Exp, THEN, Block,
     				     	   cheese.star(cheese.seq(ELSEIF, Exp, THEN, Block)),
					   cheese.opt(cheese.seq(ELSE, Block)), END),
				  function (tree)
				  	   local if_node = { tag = "if", clauses = {}}
					   table.insert(if_node.clauses, { cond = tree[2], block = tree[4] })
					   for _, v in ipairs(tree[5]) do
					       table.insert(if_node.clauses, { cond = v[2], block = v[4] })
					   end
					   if tree[6] then
					      if_node.else = tree[6][1][2]
					   end
					   return if_node
				  end)

NumFor = cheese.bind(cheese.seq(FOR, NAME, ASSIGN, Exp, COMMA, Exp, 
       	 			     cheese.opt(cheese.seq(COMMA, Exp)), DO, Block, END),
				   function (tree)
				   	    local for_node = { tag = "nfor", var = tree[2], start = tree[4],
					    	  end = tree[6], block = tree[9] }
					    if tree[7] then for_node.step = tree[7][1][2] end
					    return for_node
				   end)

GenFor = cheese.bind(cheese.seq(FOR, NameList, IN, ExpList1, DO, Block, END),
       	 			   function (tree)
				   	    return { tag = "gfor", vars = tree[2], exps = tree[4], block = tree[6] }
				   end)

FuncDef = cheese.bind(cheese.seq(FUNCTION, FuncName, FuncBody),
	  			   function (tree)
				   	    return { tag = "funcdef", name = tree[2], body = tree[3] }
				   end)

LocalFuncDef = cheese.bind(cheese.seq(LOCAL, FUNCTION, NAME, FuncBody),
	       			   function (tree)
				   	    return { tag = "locfunc", name = tree[3], body = tree[4] }
				   end)

LocalDef = cheese.bind(cheese.seq(LOCAL, NameList, cheese.opt(cheese.seq(ASSIGN, ExpList1))),
	   			   function (tree)
				   	    local locdef_node = { tag = "locdef", names = tree[2] }
					    if tree[3] then locdef_node.exps = tree[3][1][2] end
					    return locdef_node
				   end)

Assigment = cheese.bind(cheese.seq(VarList1, ASSIGN, ExpList1),
	    			   function (tree)
				   	    return { tag = "assign", vars = tree[1], exps = tree[3] }
				   end)

Stat = cheese.choice(FunctionCall, Assignment, DoBlock, While, Repeat, If, NumFor,
       					     	      GenFor, FuncDef, LocalFuncDef, LocalDef)

LastStat = cheese.bind(cheese.choice(cheese.seq(RETURN, ExpList1), cheese.concat(BREAK)),
	   			   function (tree)
				   	    if tree[1] == "break" then
					       return { tag = "break" }
					    else
						return { tag = "return", exps = tree[1][2] }
					    end
				   end)

FuncName = cheese.bind(cheese.seq(NAME, cheese.star(cheese.seq(DOT, NAME)),
	   							    cheese.opt(cheese.seq(COLON, NAME))),
				   function (tree)
				   	    local funcname_node = { tag = "funcname", names = { tree[1] } }
				   	    for _, v in tree[2] do
					    	table.insert(funcname_node.names, v[2])
					    end
					    if tree[3] then funcname_node.self = tree[3][1][2] end
					    return funcname_node
				   end)

VarList1 = cheese.bind(cheese.seq(Var, cheese.star(cheese.seq(COMMA, Var))),
	   			   function (tree)
				   	    if #tree[2] == 0 then return tree[1] end
				   	    local varlist_node = { tag = "varlist", vars = { tree[1] } }
					    for _, v in tree[2] do
					    	table.insert(varlist_node.vars, v[2])
					    end
					    return varlist_node
				   end)

Var = cheese.bind(PrimaryExp, function (pexp)
							pexp.tag = "var"
							if pexp.exps[#pexp.exps].tag == "methodcall" or
							   pexp.exps[#pexp.exps].tag == "args" then
							     return cheese.parse_error("syntax error")
							end
							return pexp 
						 end)

PrefixExp = cheese.bind(cheese.choice(NAME, cheese.seq(LPAR, Exp, RPAR)),
	    			   function (tree)
				   	    if tree.tag == "name" then return tree else return tree[2] end
				   end)

ExpList1 = cheese.bind(cheese.seq(Exp, cheese.star(cheese.seq(COMMA, Exp)),
	   			       				      cheese.opt(COMMA)),
				   function (tree)
				   	    if #tree[2] == 0 then return tree[1] end
					    local explist_node = { tag = "explist", exps = { tree[1] } }
					    for _, v in pairs(tree[2]) do
					       table.insert(explist_node.exps, v[2])
					    end
					    return explist_node
				   end)

NameList = cheese.bind(cheese.seq(NAME, cheese.star(cheese.seq(COMMA, NAME))),
	   			   function (tree)
				   	    if #tree[2] == 0 then return tree[1] end
					    local namelist_node = { tree[1] }
					    for _, v in pairs(tree[2]) do
					    	table.insert(namelist_node, v[2])
					    end
					    return namelist_node
				   end)

PrimaryExp = cheese.bind(cheese.seq(PrefixExp,
				cheese.star(cheese.choice(NameIndex, ExpIndex, MethodCall, FuncArgs))),
				   function (tree)
				   	    local pexp_node = { tag = "pexp", exps = {} }
					    table.insert(var_node.exps, tree[1])
					    for _, v in pairs(tree[2]) do
					       table.insert(var_node.exps, v)
					    end
					    return pexp_node
				   end)

FunctionCall = cheese.bind(PrimaryExp, function (pexp)
							pexp.tag = "functioncall"
							if pexp.exps[#pexp.exps].tag ~= "methodcall" and
							   pexp.exps[#pexp.exps].tag ~= "args" then
							     return cheese.parse_error("syntax error")
							end 
						 end)

SimpleExp = cheese.choice(NUMBER, STRING, NIL, TRUE, FALSE, ELLIPSE,
	    				      	   Constructor, AnonFunction, PrimaryExp)

AnonFunction = cheese.bind(cheese.seq(FUNCTION, FuncBody),
	       			   function (tree)
				   	    return { tag = "function", body = tree[2] }
				   end)

Constructor = cheese.bind(cheese.seq(LCUR, cheese.opt(FieldList), RCUR),
	      			   function (tree)
				   	    return { tag = "cons", fields = tree[2] }    
				   end)

FieldList = cheese.bind(cheese.seq(Field, cheese.star(cheese.seq(FIELDSEP, Field)),
	    				  				   cheese.opt(FIELDSEP)),
				  function (tree)
				  	   local fieldlist_node = { tree[1] }
					   for _, v in pairs(tree[2]) do table.insert(fiedlist_node, v[2]) end
					   return fieldlist_node
				  end)

Field = cheese.choice(NameField, IndexField, Exp)

NameField = cheese.bind(cheese.seq(NAME, ASSIGN, Exp),
	    			 function (tree) return { tag = "field", name = tree[1], exp = tree[3] } end)

IndexField = cheese.bind(cheese.seq(LBRA, Exp, RBRA, EQ, Exp),
	    			 function (tree) return { tag = "field", name = tree[2], exp = tree[5] } end)

FuncBody = cheese.bind(cheese.seq(LPAR, cheese.opt(ParList1), RPAR, Block),
	   			 function (tree)
				 	  return { tag = "body", parlist = tree[2], block = tree[4] }
				 end)

ParList1 = cheese.bind(cheese.choice(cheese.seq(NameList,
									      cheese.opt(cheese.seq(COMMA, ELLIPSE))),
							    cheese.concat(ELLIPSE)),
				  function (tree)
				  	   if tree == "..." then return { varargs = true } end
					   if tree[2] then
					      tree[1].varargs = true
					      return tree[1]
					   end
				  end)
