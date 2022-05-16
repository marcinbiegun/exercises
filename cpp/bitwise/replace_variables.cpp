#include <bitset>
#include <iostream>
#include <bitset>

int main() {

    // Switch places without using extra variable
    int a = 10;
    int b = 2;

    std::cout << "a = " << a << std::endl;
    std::cout << "b = " << b << std::endl;
    std::cout << "(switching) " << std::endl;

    a = a + b;
    b = a - b;
    a = a - b;

    std::cout << "a = " << a << std::endl;
    std::cout << "b = " << b << std::endl;
    std::cout << std::endl;


    // Now with bit shifts
    std::bitset<4> n = 0b0011;
    std::bitset<4> m = 0b1111;

    std::cout << "n = " << n << std::endl;
    std::cout << "m = " << m << std::endl;
    std::cout << "(switching) " << std::endl;

    // n = 0011 ^ 1111 = 1100
    n = n ^ m;

    // m = 1100 ^ 1111 = 0011
    m = n ^ m;

    // n = 1100 ^ 0011 = 1111
    n = n ^ m;

    std::cout << "n = " << n << std::endl;
    std::cout << "m = " << m << std::endl;

    return 0;
}