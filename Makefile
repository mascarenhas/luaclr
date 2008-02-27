LUA_INCLUDE_DIR= /usr/include/lua5.1
LUA_MODULE_DIR= /usr/share/lua/5.1
LUA_LIB_DIR= /usr/lib/lua/5.1

CS_FILES= src/luanetc/closure.cs  src/luanetc/clrfunction.cs  src/luanetc/reference.cs  src/luanetc/singletons.cs  src/luanetc/stdlib.cs  src/luanetc/string.cs  src/luanetc/table.cs  src/luanetc/value.cs

lua.dll: $(CS_FILES)
	gmcs /t:library /out:lua.dll $(CS_FILES)

run.exe: run.cs
	gmcs /r:lua.dll run.cs

all: lua.dll run.exe

install:
	cp src/cheese.lua $(LUA_MODULE_DIR)
	mkdir -p $(LUA_MODULE_DIR)/stream
	cp src/stream/*.lua $(LUA_MODULE_DIR)/stream
	mkdir -p $(LUA_MODULE_DIR)/cheese
	cp src/parsers.lua $(LUA_MODULE_DIR)/cheese
	cp src/luap/luap.lua $(LUA_MODULE_DIR)/cheese
	mkdir -p $(LUA_MODULE_DIR)/cheese/luap
	cp src/luap/dump.lua $(LUA_MODULE_DIR)/cheese/luap
	mkdir -p $(LUA_MODULE_DIR)/cheese/luanetc
	cp src/luanetc/*.lua $(LUA_MODULE_DIR)/cheese/luanetc

uninstall:
	rm -f $(LUA_MODULE_DIR)/cheese.lua
	rm -rf $(LUA_MODULE_DIR)/cheese
	rm -rf $(LUA_MODULE_DIR)/stream

.PHONY: test

test:
	cd test && cat test-files | xargs lua51 parse.lua && cd ..
