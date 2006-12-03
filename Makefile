LUA_INCLUDE_DIR= /usr/local/include/lua51
LUA_MODULE_DIR= /usr/local/share/lua/5.1
LUA_LIB_DIR= /usr/local/lib/lua/5.1
LDFLAGS= -bundle -undefined dynamic_lookup
CFLAGS= -O2 -Wall -I$(LUA_INCLUDE_DIR)

install:
	cp src/cheese.lua $(LUA_MODULE_DIR)
	mkdir -p $(LUA_MODULE_DIR)/stream
	cp src/stream/*.lua $(LUA_MODULE_DIR)/stream
	mkdir -p $(LUA_MODULE_DIR)/cheese
	cp src/parsers.lua $(LUA_MODULE_DIR)/cheese
	cp src/luap/luap.lua $(LUA_MODULE_DIR)/cheese
	mkdir -p $(LUA_MODULE_DIR)/cheese/luap
	cp src/luap/dump.lua $(LUA_MODULE_DIR)/cheese/luap

uninstall:
	rm -f $(LUA_MODULE_DIR)/cheese.lua
	rm -rf $(LUA_MODULE_DIR)/cheese
	rm -rf $(LUA_MODULE_DIR)/stream

.PHONY: test

test:
	cd test && cat test-files | xargs lua51 parse.lua && cd ..
