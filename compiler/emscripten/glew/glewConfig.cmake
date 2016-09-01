# Copyright (c) 2016, Alexandre Pretyman, Ruslan Baratov
# Emscripten CMake target to emulate native glew::glew target
if(NOT TARGET glew::glew)
  add_library(glew::glew INTERFACE IMPORTED)
  set_target_properties(
      glew::glew
      PROPERTIES
        INTERFACE_COMPILE_DEFINITIONS "GLEWMX"
        INTERFACE_LINK_LIBRARIES "-s LEGACY_GL_EMULATION=1"
  )
endif()
