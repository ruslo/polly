// Copyright (c) 2013, Ruslan Baratov
// All rights reserved.

#include <stdlib.h> // EXIT_SUCCESS
#include <iostream> // std::cout

int main(int argc, char **argv) {
  std::cout << "argc = " << argc << std::endl;
  for (int i = 0; i < argc; ++i) {
    std::cout << "argv[" << i << "] = '" << argv[i] << "'" << std::endl;
  }
  return EXIT_SUCCESS;
}
