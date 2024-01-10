
CC        = clang
CXX       = g++
CFLAGS    = -ldl
LIBS      = -lm -Lpath/to/raylib/lib -Wl,--whole-archive -lraylib -Wl,--no-whole-archive
BUILD_DIR = builds

.PHONY: run app web clean

#----------------- app
APP_SRC    := app.c core.c

run:
	$(BUILD_DIR)/linux/app

app: $(BUILD_DIR)/linux/app

$(BUILD_DIR)/linux/app: $(APP_SRC) | $(BUILD_DIR)/linux
	$(CC) -o $@ $^ $(LIBS) $(CFLAGS)
	
#----------------- hotreload
#TODO: Implement 

HOST_SRC   := hotreload/host.cpp core.c
PLUGIN_SRC := hotreload/guest.c core.c

# Output binaries
HOST_BIN   := hot
PLUGIN_BIN := libcore.so

hotrun:
	cd $(BUILD_DIR)/linux && ./hot
	
hotreload: $(HOST_BIN) $(PLUGIN_BIN)

$(HOST_BIN): $(HOST_SRC)
	$(CXX) -o $@ $^ $(LIBS) -lpthread $(CFLAGS)

$(PLUGIN_BIN): $(PLUGIN_SRC)
	$(CC) -shared -fPIC -o $@ $^ $(LIBS) $(CFLAGS)
	mv *.so builds/linux && mv hot builds/linux
	
#----------------- web
web: $(BUILD_DIR)/web/config/index.html

$(BUILD_DIR)/web/config/index.html: $(BUILD_DIR)/web/config/CMakeCache.txt | $(BUILD_DIR)/web/config
	cd $(BUILD_DIR)/web/config && emmake make
	cd $(BUILD_DIR)/web/config && mv *.js .. && mv *.wasm .. 	
	emrun $(BUILD_DIR)/web/index.html

$(BUILD_DIR)/web/config/CMakeCache.txt: | $(BUILD_DIR)/web/config
	cd $(BUILD_DIR)/web/config && emcmake cmake .. -DPLATFORM=Web -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXE_LINKER_FLAGS="-s USE_GLFW=3" -DCMAKE_EXECUTABLE_SUFFIX=".js"

#----------------- create folders

$(BUILD_DIR)/linux $(BUILD_DIR)/web/config:
	mkdir -p $@

#----------------- cleaning	
clean:
	rm -rf $(BUILD_DIR)/linux/*

clean_web:
	rm -rf $(BUILD_DIR)/web/config/* $(BUILD_DIR)/web/*.js $(BUILD_DIR)/web/*.wasm
