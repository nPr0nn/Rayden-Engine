#include <cstdio>
#include <chrono>
#include <thread>

#define CR_HOST CR_UNSAFE // try to best manage static states
#include "../engine/engine_context.h"
#include "../thirdparty/include/chot/cr.h"
#include "../core.h"

const char *plugin = CR_PLUGIN("core");

int main(int argc, char *argv[])
{
  cr_plugin ctx;

  // start engine
  // EngineContext engine_context;
  core_start();

  // save engine data to be used during hot reloading
  // ctx.userdata = &engine_context; 
  cr_plugin_open(ctx, plugin);
  
  // call the plugin update function with the plugin context to execute it 
  while(!WindowShouldClose()) { 
    cr_plugin_update(ctx);    
    // fflush(stdout);
    // fflush(stderr);
    // std::this_thread::sleep_for(std::chrono::milliseconds(10));
  }
  
  // cleanup the plugin context
  cr_plugin_close(ctx);
  return 0;
}
