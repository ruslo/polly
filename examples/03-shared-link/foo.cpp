#include <iostream>

#include "foo_export.h"

FOO_EXPORT int foo() {
  std::cout << "foo" << std::endl;
  return 0x42;
}
