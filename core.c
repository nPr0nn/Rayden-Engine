
#include "core.h"
#include "thirdparty/include/raylib/raylib.h"

// starting engine routines
void core_start(void)
{
  #ifndef PLATFORM_WEB
    SetConfigFlags(FLAG_WINDOW_RESIZABLE);
  #endif

  InitWindow(800, 450, "Rayden Game Engine");
  SetTargetFPS(60);   
}

// main engine loop
void core_loop(void)
{
  
  BeginDrawing();
    ClearBackground(BLACK);
    DrawText("Let's ball", 190, 200, 20, RED);
  EndDrawing();

}

// ending engine routine 
void core_terminate(void)
{
  CloseWindow(); 
}
