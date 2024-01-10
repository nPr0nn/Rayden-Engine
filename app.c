
#include "core.h"
#include "engine/engine_context.h"

typedef void (*main_loop_ptr)(void*);
#ifdef PLATFORM_WEB 
  #include <emscripten.h>
  void engine_run(void* ctx, main_loop_ptr core_loop){
    emscripten_set_main_loop_arg(core_loop, ctx, -1, 1);   
  }
#else 
  void engine_run(void* ctx, main_loop_ptr core_loop){ 
    while(!WindowShouldClose()) { 
      core_loop(ctx); 
    }    
  }
#endif

int main()
{
  EngineContext engine_context; 
  core_start(); 
  engine_run(&engine_context, core_loop);
  core_terminate();
  return 0;
}
