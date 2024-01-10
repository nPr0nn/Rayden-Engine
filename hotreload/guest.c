
#include "../engine/engine_context.h"
#include "../thirdparty/include/chot/cr.h"
#include "../core.h"
#include <assert.h>
#include <stdio.h>

// main func
// static EngineContext* engine_context = NULL; 
CR_EXPORT int cr_main(struct cr_plugin *ctx, enum cr_op operation)
{
  assert(ctx);
  // engine_context = (EngineContext*) ctx->userdata;

  switch (operation) {
    case CR_LOAD:    
      printf("LOAD\n");
    case CR_UNLOAD: 
    case CR_CLOSE:
    case CR_STEP:
      break;   
  }
  
  core_loop(ctx);
  
  return 0;
}
