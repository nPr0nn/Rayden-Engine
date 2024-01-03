
CC        = gcc
CXX       = g++
CFLAGS    = -m32
LIBS      = -Lthirdparty/include/raylib -lraylib -lm -ldl
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

#----------------- web
web: $(BUILD_DIR)/web/config/index.html

$(BUILD_DIR)/web/config/index.html: $(BUILD_DIR)/web/config/CMakeCache.txt | $(BUILD_DIR)/web/config
	cd $(BUILD_DIR)/web/config && emmake make
	cd $(BUILD_DIR)/web/config && mv *.js .. && mv *.wasm .. 	
	emrun $(BUILD_DIR)/web/index.html

$(BUILD_DIR)/web/config/CMakeCache.txt: | $(BUILD_DIR)/web/config
	cd $(BUILD_DIR)/web/config && emcmake cmake ../../.. -DPLATFORM=Web -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXE_LINKER_FLAGS="-s USE_GLFW=3" -DCMAKE_EXECUTABLE_SUFFIX=".js"

#----------------- create folders

$(BUILD_DIR)/linux $(BUILD_DIR)/web/config:
	mkdir -p $@

#----------------- cleaning
clean:
	rm *.so hot
	
clean_app:
	rm -rf $(BUILD_DIR)/linux/*

clean_web:
	rm -rf $(BUILD_DIR)/web/config/* $(BUILD_DIR)/web/*.js $(BUILD_DIR)/web/*.wasm
