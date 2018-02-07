#include <cstdlib> // EXIT_SUCCESS
#include <iostream> // std::cout

#if     __cplusplus >= 201703L
#  include <string>
#elif __cplusplus >= 201402L 
#  include <tuple>
#  include <functional>

auto f() // this function returns multiple values
{
    int x = 5;
    // not "return {x,7};" because the corresponding
    // tuple constructor is explicit (LWG 2051)
    return std::make_tuple(x, 7); 
}

#endif

int main() {
  std::cout << "Hello!" << std::endl;

#if     __cplusplus >= 201703L
    // C++ 17
    auto x1 = { 1, 2 };
    std::cout << "C++17: "; 
    for ( auto a : x1 ) {  std::cout << a << " "; }
    std::cout << std::endl;
#elif __cplusplus >= 201402L
    // heterogeneous tuple construction
    int n = 1;
    auto t = std::make_tuple(10, "Test", 3.14, std::ref(n), n);
    n = 7;
    std::cout << "C++14: The value of t is "  << "("
              << std::get<0>(t) << ", " << std::get<1>(t) << ", "
              << std::get<2>(t) << ", " << std::get<3>(t) << ", "
              << std::get<4>(t) << ")\n";

    // function returning multiple values
    int a, b;
    std::tie(a, b) = f();
    std::cout << "C++14: " << a << " " << b << "\n";
#endif 
  return EXIT_SUCCESS; 
}


