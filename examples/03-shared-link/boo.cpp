#include <iostream>

#include "boo_export.h"

int foo();

BOO_EXPORT int boo() {
  std::cout << "boo: " << foo() << std::endl;
  return 42;
}
