local cheese = require"cheese"

module("cheese.luap", package.seeall)

local defs = _M

keywords = { "and", "break", "do", "else", "elseif", "end", "false", "for", "function",
	 "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until",
	 "while" }

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

prec_classes = {
  { "OR" },
  { "AND" },
  { "EQ", "NEQ", "LEQ", "GEQ", "LT", "GT" },
  { "RANGE", right = true },
  { "PLUS", "MINUS" },
  { "STAR", "SLASH", "PERCENT" },
  { "NOT", "HASH", "MINUS", unary = true },
  { "HAT" }
}


cheese.open_grammar("lua_grammar")

--
-- Lexical definitions
-- 

local EOF = pnot(any)
local ENDLINE = str("\r\n") / char("\n") / char("\r")
local SPACE = char(" ") / char("\t") / ENDLINE
local REST_LONG_COMMENT = ext(function (strm)
			    local level = strm.bracket_level
			    local close_bracket = char("]") .. str(string.rep("=", level)) .. char("]")
			    local eat_comment = (star(pnot(close_bracket) .. any) .. opt(close_bracket)) % skip
			    return cheese.compile({ comment = eat_comment }).comment(strm)
			  end)
local LONG_COMMENT = ((str("--[") .. star(char("=")) .. char("[")) % concat % 
			  function (bracket)
			    strm.bracket_level = string.len(bracket) - 4
			  end) .. REST_LONG_COMMENT
local SHORT_COMMENT = str("--") .. star(pnot(ENDLINE).. any) .. ENDLINE / EOF
local SPACING = star(SPACE / COMMENT) % skip

NAME_CHARS = class("_", {"a", "z"}, {"A", "Z"}, {"0", "9"})
COMMENT = LONG_COMMENT / SHORT_COMMENT

-- Keywords

local function keyword(str)
  _G[string.upper(str)] = str(str) .. pnot(NAME_CHARS) .. SPACING
end

local keyword_tab = {}

local function keywords(args)
  for i, str in ipairs(args) do
    keyword_tab[str] = true
    keyword(str)
    args[i] = string.upper(args[i])
  end
end

keywords(defs.keywords)

-- Operators

local function op(name, token)
  if string.len(str) == 1 then
    _G[string.upper(name)] = char(token) .. SPACING
  else
    _G[string.upper(name)] = str(token) .. SPACING
  end
end

local function ops(tab)
  for name, sop in pairs(tab) do
    op(name, sop)
  end
end

ops(defs.ops)

-- Escape codes

local function escape(token, code)
  return str(token) % function () return code end
end

local escapes = {
  escape("\\a", "\a"),
  escape("\\b", "\b"),
  escape("\\f", "\f"),
  (str("\\n") / str("\\\n")) % function () return "\n" end,
  escape("\\r", "\r"),
  escape("\\t", "\t"),
  escape("\\v", "\v"),
  escape("\\\\", "\\"),
  escape("\\\"", "\""),
  escape("\\\'", "\'"),
  (char("\\") .. digit .. opt(digit) opt(digit)) % concat %
	            function (esc)
		      return string.char(tonumber(string.sub(esc, 2, -1)))
		    end
}

local function def_escapes(tab)
  local escs = {}
  for name, esc in pairs(escapes) do
    table.insert(escs, esc)
  end
  ESCAPE = choice(unpack(escs))
end

def_escapes(escapes)

-- Literals and identifiers

local INVALID = char("\n") / char("\\") / char(string.char(0))

local INVALID_DQUOTE = INVALID / char("\"")

local DQUOTE_STRING = char("\"") % skip .. star(ESCAPE / (pnot(INVALID_DQUOTE) .. any)) .. char("\"") % skip

local INVALID_SQUOTE = INVALID / char("\'")

local SQUOTE_STRING = char("\'") % skip .. star(ESCAPE / (pnot(INVALID_SQUOTE) .. any)) .. char("\'") % skip

local SHORT_STRING = (SQUOTE_STRING / DQUOTE_STRING .. SPACING) % concat %
		       function (str) return { tag = "string", val = str } end

local REST_LONG_STRING = ext(function (strm)
			    local level = strm.bracket_level
			    local bracket = char("]") .. str(string.rep("=", level)) .. char("]")
			    local not_bracket = pnot(bracket)
			    local brackets = cheese.compile({ bracket = bracket, not_bracket = not_bracket })
			    bracket, not_bracket = brackets.bracket, brackets.not_bracket
			    local ischar
			    local rest_string = {}
			    repeat
			      ischar = pcall(not_bracket, strm)
			      if ischar then table.insert(rest_string, strm:getc()) end
			    until not ischar
			    bracket(strm)
			    if rest_string[1] == "\n" then rest_string[1] = "" end
			    return table.concat(rest_string) 
			  end)

local LONG_STRING = (((str("[") .. star(char("=")) .. char("[")) % concat % 
			  function (bracket)
			    strm.bracket_level = string.len(bracket) - 2
			  end) .. REST_LONG_STRING .. SPACING) % concat % function (str)
			    return { tag = "string", val = str } end

STRING = SHORT_STRING / LONG_STRING

local DEC_DIGITS = plus(digit)

local HEXA_DIGITS = plus(class({"a", "f"}, {"A", "F"}, {"0", "9"}))

local HEXA_NUMBER = str("0x") .. HEXA_DIGITS .. SPACING

local SIGN = opt(char("-"))

local EXPONENT = class("e", "E") .. SIGN .. DEC_DIGITS

local DEC_NUMBER = DEC_DIGITS .. opt(char(".") .. DEC_DIGITS) .. opt(EXPONENT) .. SPACING

NUMBER = (HEXA_NUMBER / DEC_NUMBER) % concat %
		     function (str) return { tag = "number", val = tonumber(str) } end

LITERAL = NUMBER / STRING

NAME = (class("_", {"a", "z"}, {"A", "Z"}) .. star(NAME_CHARS) .. SPACING) % concat %
		   function (str)
		     if keyword_tab[str] then
		       error(str .. " is a reserved word")
		     else
		       return { tag = "name", val = str }
		     end
		   end 

FIELDSEP = COMMA / SEMI

--
-- Hierarchical definitions
--

function gen_expr(prec)
  if prec > #defs.prec_classes then
    _G["Exp_" .. prec] = SimpleExp
  else
    gen_expr(prec + 1)
    local this_class = {}
    for _, op in ipairs(defs.prec_classes[prec]) do
      table.insert(this_class, ref(op))
    end
    local function expr()
      if defs.prec_classes[prec].unary then
	return (star(choice(unpack(this_class))) .. _G["Exp_" .. (prec + 1)]) %
			   function (tree)
			     if #tree[1] == 0 then return tree[2] end
			     local node = { tag = "unop", op = cheese.concat(tree[1][1]) }
			     local res = node
			     for i = 2, #tree[1] do
			       node.operand = { tag = "unop", op = cheese.concat(tree[1][i]) }
			       node = node.operand
			     end
			     node.operand = tree[2]						
			     return res						   	
			   end
      else
	local operator
	if #this_class == 1 then
	  operator = this_class[1]
	else
	  operator = choice(unpack(this_class)) 
        end
	return (_G["Exp_" .. (prec + 1)] .. star(operator .. _G["Exp_" .. (prec + 1)])) %
			   function (tree)
			     if #tree[2] == 0 then return tree[1] end
			     if defs.prec_classes[prec].right then
			       local node = { tag = "binop", op = cheese.concat(tree[2][1][1]),
				 left = tree[1] }
			       local res = node
			       for i = 1, #tree[2]-1 do
				 node.right = { tag = "binop", op = cheese.concat(tree[2][i][1]),
				   left = tree[2][i][2] }
				 node = node.right
			       end
			       node.right = tree[2][#tree[2]][2]	     
			       return res
			     else
			       local node = { tag = "binop", op = cheese.concat(tree[2][#tree[2]][1]),
				 right = tree[2][#tree[2]][2] }
			       local res = node
			       for i = #tree[2]-1, 1, -1 do
				 node.left = { tag = "binop", op = cheese.concat(tree[2][i][1]),
				   right = tree[2][i][2] }
				 node = node.left
			       end
			       node.left = tree[1]
			       return res
			     end
			   end
      end
    end
    _G["Exp_" .. prec] = expr()
  end
end

gen_expr(1)

local Exp = Exp_1

FuncName = (NAME .. star(DOT .. NAME) .. opt(COLON .. NAME)) %
		       function (tree)
			 local funcname_node = { tag = "funcname", var = tree[1], indexes = {} }
			 for _, v in ipairs(tree[2]) do
			   table.insert(funcname_node.indexes, v[2].val)
			 end
		       	 if #tree[3]>0 then funcname_node.self = tree[3][1][2].val end
			 return funcname_node
		       end

NameField = cheese.bind(cheese.seq(NAME, ASSIGN, Exp),
			function (tree)
			  return { tag = "namefield", name = tree[1].val, exp = tree[3] }
			end)

IndexField = cheese.bind(cheese.seq(LBRA, Exp, RBRA, ASSIGN, Exp),
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

LastStat = cheese.bind(cheese.choice(cheese.seq(RETURN, cheese.opt(ExpList1)), cheese.concat(BREAK)),
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


