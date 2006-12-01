require"cheese"

module("cheese.luap", package.seeall)

--
-- Lexical definitions
-- 

EOF = cheese.pnot(cheese.any)
ENDLINE = cheese.choice(cheese.str("\r\n"), cheese.char("\n"), cheese.char("\r"))
SPACE = cheese.choice(cheese.char(" "), cheese.char("\t"), ENDLINE)
COMMENT = cheese.seq(cheese.str("--"),
		     cheese.star(cheese.seq(cheese.pnot(ENDLINE), cheese.any)),
		     ENDLINE)
SPACING = cheese.skip(cheese.star(cheese.choice(SPACE, COMMENT)))
NAME_CHARS = cheese.class("_", "_", "a", "z", "A", "Z", "0", "9")

-- Keywords

function keyword(str)
  _M[string.upper(str)] = cheese.seq(cheese.str(str), cheese.pnot(NAME_CHARS), SPACING)
end

keyword_tab = {}

function keywords(...)
  local args = {...}
  for i, str in ipairs(args) do
    keyword_tab[str] = true
    keyword(str)
    args[i] = string.upper(args[i])
  end
  KEYWORDS = cheese.choice(unpack(args))
end

keywords("and", "break", "do", "else", "elseif", "end", "false", "for", "function",
	 "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until",
	 "while")

-- Operations

function op(name, str)
  if string.len(str) == 1 then
    _M[string.upper(name)] = cheese.seq(cheese.char(str), SPACING)
  else
    _M[string.upper(name)] = cheese.seq(cheese.str(str), SPACING)
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
  hash = "#",
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
  return cheese.bind(cheese.str(str), function () return code end)
end

escapes = {
  bell = escape("\\a", "\a"),
  bspace = escape("\\b", "\b"),
  ffeed = escape("\\f", "\f"),
  lfeed = cheese.bind(cheese.choice(cheese.str("\\n"),
				    cheese.str("\\\n")),
		      function () return "\n" end),	
  cr = escape("\\r", "\r"),
  htab = escape("\\t", "\t"),
  vtab = escape("\\v", "\v"),
  bslash = escape("\\\\", "\\"),
  dquote = escape("\\\"", "\""),
  squote = escape("\\\'", "\'"),
  num = cheese.bind(cheese.concat(cheese.seq(cheese.char("\\"), cheese.digit, 
					     cheese.opt(cheese.digit), cheese.opt(cheese.digit))),
		    function (esc)
		      return string.char(tonumber(string.sub(esc, 2, -1)))
		    end)
}

function def_escapes(tab)
  local escs = {}
  for name, esc in pairs(escapes) do
    table.insert(escs, esc)
  end
  ESCAPE = cheese.choice(unpack(escs))
end

def_escapes(escapes)

-- Literals and identifiers

INVALID = cheese.choice(cheese.char("\n"), cheese.char("\\"), cheese.char(string.char(0)))

INVALID_DQUOTE = cheese.choice(INVALID, cheese.char("\""))

DQUOTE_STRING = cheese.seq(cheese.skip(cheese.char("\"")),
			   cheese.star(
				       cheese.choice(ESCAPE,
						     cheese.seq(
								cheese.pnot(INVALID_DQUOTE),
								cheese.any))),
			   cheese.skip(cheese.char("\"")))

INVALID_SQUOTE = cheese.choice(INVALID, cheese.char("\'"))

SQUOTE_STRING = cheese.seq(cheese.skip(cheese.char("\'")),
			   cheese.star(
				       cheese.choice(ESCAPE,
						     cheese.seq(
								cheese.pnot(INVALID_SQUOTE),
								cheese.any))),
			   cheese.skip(cheese.char("\'")))

STRING = cheese.bind(cheese.concat(cheese.seq(
					      cheese.choice(SQUOTE_STRING, DQUOTE_STRING),
					      SPACING)),
		     function (str) return { tag = "string", val = str } end)

DECIMAL = cheese.plus(cheese.digit)

SIGN = cheese.opt(cheese.char("-"))

EXPONENT = cheese.seq(cheese.choice(cheese.char("e"), cheese.char("E")), SIGN, DECIMAL)

NUMBER = cheese.bind(cheese.concat(cheese.seq(DECIMAL,
					      cheese.opt(cheese.seq(cheese.char("."), DECIMAL)),
					      cheese.opt(EXPONENT), SPACING)),
		     function (str) return { tag = "number", val = tonumber(str) } end)

LITERAL = cheese.choice(NUMBER, STRING)

NAME = cheese.bind(cheese.concat(cheese.seq(cheese.class("_", "_", "a", "z", "A", "Z"),
					    cheese.star(NAME_CHARS), SPACING)),
		   function (str)
		     if keyword_tab[str] then
		       error(str .. " is a reserved word")
		     else
		       return { tag = "name", val = str }
		     end
		   end) 

FIELDSEP = cheese.choice(COMMA, SEMI)

--
-- Hierarchical definitions
--

PrecClasses = {
  { OR },
  { AND },
  { EQ, NEQ, LEQ, GEQ, LT, GT },
  { RANGE, right = true },
  { PLUS, MINUS },
  { STAR, SLASH, PERCENT },
  { NOT, HASH, MINUS, unary = true },
  { HAT }
}

function gen_expr(prec)
  if prec > #PrecClasses then
    _M["Exp_" .. prec] = cheese.lazy(function () return SimpleExp end)
  else
    gen_expr(prec + 1)
    local function expr()
      if PrecClasses[prec].unary then
	return cheese.bind(cheese.seq(cheese.star(cheese.choice(unpack(PrecClasses[prec]))),
				      _M["Exp_" .. (prec + 1)]),
			   function (tree)
			     if #tree[1] == 0 then return tree[2] end
			     local node = { tag = "unop", op = cheese.flatten(tree[1][1]) }
			     local res = node
			     for i = 2, #tree[1] do
			       node.operand = { tag = "unop", op = cheese.flatten(tree[1][i]) }
			       node = node.operand
			     end
			     node.operand = tree[2]						
			     return res						   	
			   end)
      else
	local operator
	if #PrecClasses[prec] == 1 then
	  operator = PrecClasses[prec][1]
	else
	  operator = cheese.choice(unpack(PrecClasses[prec])) 
        end
	return cheese.bind(cheese.seq(_M["Exp_" .. (prec + 1)],
				      cheese.star(cheese.seq(operator,
							     _M["Exp_" .. (prec + 1)]))),
			   function (tree)
			     if #tree[2] == 0 then return tree[1] end
			     if PrecClasses[prec].right then
			       local node = { tag = "binop", op = cheese.flatten(tree[2][1][1]),
				 left = tree[1] }
			       local res = node
			       for i = 1, #tree[2]-1 do
				 node.right = { tag = "binop", op = cheese.flatten(tree[2][i][1]),
				   left = tree[2][i][2] }
				 node = node.right
			       end
			       node.right = tree[2][#tree[2]][2]	     
			       return res
			     else
			       local node = { tag = "binop", op = cheese.flatten(tree[2][#tree[2]][1]),
				 right = tree[2][#tree[2]][2] }
			       local res = node
			       for i = #tree[2]-1, 1, -1 do
				 node.left = { tag = "binop", op = cheese.flatten(tree[2][i][1]),
				   right = tree[2][i][2] }
				 node = node.left
			       end
			       node.left = tree[1]
			       return res
			     end
			   end)
      end
    end
    _M["Exp_" .. prec] = expr()
  end
end

gen_expr(1)

Exp = Exp_1

--Precedence = {
--  [HAT] = {10, 9},
--  [RANGE] = {5, 4},
--  [EQ] = {3, 3},
--  [NEQ] = {3, 3},
--  [LEQ] = {3, 3},
--  [GEQ] = {3, 3},
--  [LT] = {3, 3},
--  [GT] = {3, 3},
--  [AND] = {2, 2},
--  [OR] = {1, 1},
--  [PLUS] = {6, 6},
--  [MINUS] = {6, 6},
--  [SLASH] = {7, 7},
--  [MOD] = {7, 7},
--  [STAR] = {7, 7}
--}

--UnaryPrec = 8

--UNOP = cheese.choice(MINUS, NOT, HASH)

FuncName = cheese.bind(cheese.seq(NAME, cheese.star(cheese.seq(DOT, NAME)),
				  cheese.opt(cheese.seq(COLON, NAME))),
		       function (tree)
			 local funcname_node = { tag = "funcname", var = tree[1], indexes = {} }
			 for _, v in ipairs(tree[2]) do
			   table.insert(funcname_node.indexes, v[2].val)
			 end
		       	 if #tree[3]>0 then funcname_node.self = tree[3][1][2].val end
			 return funcname_node
		       end)

NameField = cheese.bind(cheese.seq(NAME, ASSIGN, Exp),
			function (tree)
			  return { tag = "namefield", name = tree[1].val, exp = tree[3] }
			end)

IndexField = cheese.bind(cheese.seq(LBRA, Exp, RBRA, EQ, Exp),
			 function (tree)
			   return { tag = "indexfield", name = tree[2], exp = tree[5] }
			 end)

Field = cheese.choice(NameField, IndexField, Exp)

FieldList = cheese.bind(cheese.seq(Field, cheese.star(cheese.seq(FIELDSEP, Field)),
				   cheese.opt(FIELDSEP)),
			function (tree)
			  local fieldlist_node = { tree[1] }
			  for _, v in ipairs(tree[2]) do table.insert(fieldlist_node, v[2]) end
			  return fieldlist_node
			end)

Constructor = cheese.bind(cheese.seq(LCURLY, cheese.opt(FieldList), RCURLY),
			  function (tree)
			    return { tag = "constructor", fields = tree[2] }    
			  end)

NameIndex = cheese.bind(cheese.seq(DOT, NAME), function (tree) return { tag = "nameindex", name = tree[2].val } end)

ExpIndex = cheese.bind(cheese.seq(LBRA, Exp, RBRA), function (tree) return { tag = "expindex", exp = tree[2] } end)

ExpList1 = cheese.bind(cheese.seq(Exp, cheese.star(cheese.seq(COMMA, Exp)),
				  cheese.opt(COMMA)),
		       function (tree)
			 --if #tree[2] == 0 then return tree[1] end
			 local explist_node = { tree[1] }
			 for _, v in ipairs(tree[2]) do
			   table.insert(explist_node, v[2])
			 end
		         return explist_node
		       end)

FuncArgs = cheese.bind(cheese.choice(Constructor, STRING, cheese.seq(LPAR, cheese.opt(ExpList1), RPAR)),
		       function (tree)
			 if tree.tag then
			   return { tree }
			 else
			   return tree[2]
			 end
		       end)

MethodCall = cheese.bind(cheese.seq(COLON, NAME, FuncArgs), function (tree) return { tag = "method",
								name = tree[2].val, args = tree[3] } end)

PrefixExp = cheese.bind(cheese.choice(NAME, cheese.seq(LPAR, Exp, RPAR)),
			function (tree)
			  if tree.tag == "name" then return tree else return tree[2] end
			end)

PrimaryExp = cheese.bind(cheese.seq(PrefixExp,
				    cheese.star(cheese.choice(NameIndex, ExpIndex,
							      MethodCall, FuncArgs))),
			 function (tree)
			   if #tree[2] == 0 then return tree[1] end
			   local pexp_node = { tag = "primaryexp", prefix = tree[1], indexes = {} }
			   for _, v in ipairs(tree[2]) do
			     table.insert(pexp_node.indexes, v)
			   end
			   return pexp_node
		         end)

FunctionCall = cheese.bind(PrimaryExp,
			   function (pexp)
			     local indexes = pexp.indexes
			     if (not indexes) or (indexes[#indexes].tag and 
			        indexes[#indexes].tag ~= "method") then
			       return error("not a function call")
       			     else
			       pexp.tag = "call"
			       if indexes[#indexes].tag then
				 pexp.method = indexes[#indexes].name
				 pexp.args = indexes[#indexes].args
			       else pexp.args = indexes[#indexes] end
			       table.remove(indexes, #indexes)
			       return pexp
			     end
			   end)

FuncBody = cheese.lazy(function ()
			 return cheese.bind(cheese.seq(LPAR, cheese.opt(ParList1), RPAR, Block, END),
					    function (tree)
					      return { tag = "body", parlist = tree[2],
						block = tree[4] }
					    end)
		       end)

AnonFunction = cheese.bind(cheese.seq(FUNCTION, FuncBody),
			   function (tree)
			     return { tag = "function", parlist = tree[2].parlist, block = tree[2].block }
			   end)

SimpleExp = cheese.choice(NUMBER, STRING, cheese.concat(NIL), cheese.concat(TRUE),
			  cheese.concat(FALSE), cheese.concat(ELLIPSE),
			  Constructor, AnonFunction, FunctionCall, PrimaryExp)

NameList = cheese.bind(cheese.seq(NAME, cheese.star(cheese.seq(COMMA, NAME))),
		       function (tree)
			 --if #tree[2] == 0 then return tree[1] end
			 local namelist_node = { tree[1] }
			 for _, v in ipairs(tree[2]) do
			   table.insert(namelist_node, v[2])
			 end
		         return namelist_node
		       end, true)

ParList1 = cheese.bind(cheese.choice(cheese.seq(NameList,
						cheese.opt(cheese.seq(COMMA, ELLIPSE))),
				     cheese.concat(ELLIPSE)),
		       function (tree)
			 if tree == "..." then return { varargs = true } end
			 if #tree[2] > 0 then
			   tree[1].varargs = true
			 end
			 return tree[1]
		       end, true)

Var = cheese.bind(PrimaryExp,
		  function (pexp)
		    if (not pexp.indexes and pexp.tag == "name") then
		      return { tag = "var", prefix = pexp, indexes = {} }
		    elseif (pexp.indexes and pexp.indexes[#pexp.indexes].tag ~= "method") then
		      pexp.tag = "var"		  
		      return pexp 
      		    else
		      return error("invalid lvalue")
		    end
		  end, true)

VarList1 = cheese.bind(cheese.seq(Var, cheese.star(cheese.seq(COMMA, Var))),
		       function (tree)
			 local varlist_node = { tree[1] }
			 for _, v in ipairs(tree[2]) do
			   table.insert(varlist_node, v[2])
			 end
		         return varlist_node
		     end, true)

Stat = cheese.lazy(function ()
		     return cheese.choice(FunctionCall, Assignment, DoBlock, While,
					  Repeat, If, NumFor, GenFor, FuncDef,
					  LocalFuncDef, LocalDef)
		   end)

LastStat = cheese.bind(cheese.choice(cheese.seq(RETURN, ExpList1), cheese.concat(BREAK)),
		       function (tree)
			 if tree == "break" then
			   return { tag = "break" }
			 else
			   return { tag = "return", exps = tree[2] }
			 end
		       end, true)

Block = cheese.bind(cheese.seq(cheese.star(cheese.seq(Stat, cheese.opt(SEMI))),
			       cheese.opt(cheese.seq(LastStat, cheese.opt(SEMI)))),
		    function (tree)
		      local chunk_node = {}
		      for _, v in ipairs(tree[1]) do
			table.insert(chunk_node, v[1])
		      end
		      if #tree[2] > 0 then
			table.insert(chunk_node, tree[2][1])
		      end
		      return chunk_node
		    end)

Chunk = cheese.bind(cheese.seq(SPACING, Block, EOF), function (tree) return { tag = "chunk", block = tree[2] } end)

DoBlock = cheese.bind(cheese.seq(DO, Block, END), function (tree) return { tag = "do", block = tree[2] } end)

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
		   if #tree[6] > 0 then
		     if_node.block_else = tree[6][2]
		   end
		   return if_node
	         end)

NumFor = cheese.bind(cheese.seq(FOR, NAME, ASSIGN, Exp, COMMA, Exp, 
				cheese.opt(cheese.seq(COMMA, Exp)), DO, Block, END),
		     function (tree)
		       local for_node = { tag = "nfor", var = tree[2].val, start = tree[4],
			 finish = tree[6], block = tree[9] }
		       if #tree[7] > 0 then for_node.step = tree[7][2] end
		       return for_node
		     end)

GenFor = cheese.bind(cheese.seq(FOR, NameList, IN, ExpList1, DO, Block, END),
		     function (tree)
		       return { tag = "gfor", vars = tree[2], exps = tree[4], block = tree[6] }
		     end)

FuncDef = cheese.bind(cheese.seq(FUNCTION, FuncName, FuncBody),
		      function (tree)
			return { tag = "function", name = tree[2], parlist = tree[3].parlist, block = tree[3].block }
		      end)

LocalFuncDef = cheese.bind(cheese.seq(LOCAL, FUNCTION, NAME, FuncBody),
			   function (tree)
			     return { tag = "function", islocal = true, 
			       name = tree[3], parlist = tree[4].parlist, block = tree[4].block }
			   end)

LocalDef = cheese.bind(cheese.seq(LOCAL, NameList, cheese.opt(cheese.seq(ASSIGN, ExpList1))),
		       function (tree)
			 local locdef_node = { tag = "local", names = tree[2] }
			 if #tree[3] > 0 then locdef_node.exps = tree[3][2] end
			 return locdef_node
		       end)

Assignment = cheese.bind(cheese.seq(VarList1, ASSIGN, ExpList1),
			 function (tree)
			   return { tag = "assign", vars = tree[1], exps = tree[3] }
			 end)


