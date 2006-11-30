LUA_INCLUDE_DIR= /usr/local/include/lua51
LUA_MODULE_DIR= /usr/local/share/lua/5.1
LUA_LIB_DIR= /usr/local/lib/lua/5.1
LDFLAGS= -bundle -undefined dynamic_lookup
CFLAGS= -O2 -Wall -I$(LUA_INCLUDE_DIR)

all: src/struct/struct.o
	export MACOSX_DEPLOYMENT_TARGET=10.3 && gcc $(LDFLAGS) -o bin/struct.so src/struct/struct.o 

install:
	cp src/cheese.lua $(LUA_MODULE_DIR)
	mkdir -p $(LUA_MODULE_DIR)/stream
	cp src/stream/*.lua $(LUA_MODULE_DIR)/stream
	mkdir -p $(LUA_MODULE_DIR)/cheese
	cp src/luap/luap.lua $(LUA_MODULE_DIR)/cheese
	cp bin/struct.so $(LUA_LIB_DIR)

uninstall:
	rm -f $(LUA_MODULE_DIR)/cheese.lua
	rm -rf $(LUA_MODULE_DIR)/cheese
	rm -rf $(LUA_MODULE_DIR)/stream
	rm -f $(LUA_LIB_DIR)/struct.so

clean:
	rm -f bin/*
	rm -f src/struct/struct.o

test: install
	cd test && lua51 parse.lua && cd ..

