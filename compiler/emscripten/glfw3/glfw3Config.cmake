# Copyright (c) 2016, Alexandre Pretyman
# Emscripten CMake target to emulate native glfw target
if(NOT TARGET glfw)
  add_library(glfw INTERFACE IMPORTED)
  set_target_properties(
      glfw
      PROPERTIES
        INTERFACE_LINK_LIBRARIES "-s LEGACY_GL_EMULATION=1;-s USE_GLFW=3"
  )
endif()
