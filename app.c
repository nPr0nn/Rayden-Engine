
#include "core.h"

#ifdef PLATFORM_WEB
    #include <emscripten/emscripten.h>
#endif

int main()
{
  core_start();
  
  #ifdef PLATFORM_WEB
    emscripten_set_main_loop(core_loop, 0, 1);
  #else 
    while(!WindowShouldClose()) core_loop();
  #endif

  core_terminate();
  return 0;
}
