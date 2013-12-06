#include <iostream>

int foo();

int boo() {
  std::cout << "boo: " << foo() << std::endl;
  return 42;
}
