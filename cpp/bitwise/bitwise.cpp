#include <iostream>
#include <bitset>

int main() {
    std::bitset<4> a;
    a = 0b0110;
    std::bitset<4> b;
    b = 0b1111;
    std::bitset<4> c;
    c = 0b0000;

    std::cout << "bitset   a = " << a << std::endl;
    std::cout << "bitset   b = " << b << std::endl;
    std::cout << "bitset   c = " << c << std::endl;
    std::cout << std::endl;

    // Binary NOT
    std::cout << "bitset  ~a = " << ~a << std::endl;
    std::cout << "bitset  ~b = " << ~b << std::endl;
    std::cout << "bitset  ~c = " << ~c << std::endl;
    std::cout << std::endl;
 
    // Binary AND
    std::cout << "bitset a&b = " << (a & b) << std::endl;
    std::cout << "bitset a&c = " << (a & c) << std::endl;
    std::cout << std::endl;

    // Binary OR
    std::cout << "bitset a|b = " << (a | b) << std::endl;
    std::cout << "bitset a|c = " << (a | c) << std::endl;
    std::cout << std::endl;

    // Binary XOR
    std::cout << "bitset a^b = " << (a ^ b) << std::endl;
    std::cout << "bitset a^c = " << (a ^ c) << std::endl;
    std::cout << std::endl;

    // // Binary XOR (true if different values)
    // std::cout << "bitset a^b = " << a^b << std::endl;

    return 0;
}