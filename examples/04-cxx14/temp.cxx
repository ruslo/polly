/* 
 * Stolen from: https://stackoverflow.com/a/30940639/51789 
 */ 
#include <iostream>
#include <tuple>
#include <functional>

auto f() // this function returns multiple values
{
    int x = 5;
    return std::make_tuple(x, 7); // not "return {x,7};" because the corresponding
                                  // tuple constructor is explicit (LWG 2051)
}

int main()
{
    // heterogeneous tuple construction
    int n = 1;
    auto t = std::make_tuple(10, "Test", 3.14, std::ref(n), n);
    n = 7;
    std::cout << "The value of t is "  << "("
              << std::get<0>(t) << ", " << std::get<1>(t) << ", "
              << std::get<2>(t) << ", " << std::get<3>(t) << ", "
              << std::get<4>(t) << ")\n";

    // function returning multiple values
    int a, b;
    std::tie(a, b) = f();
    std::cout << a << " " << b << "\n";
}

