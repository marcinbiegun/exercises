#include <iostream>
#include <bitset>

int main() {

    short int i = 16;
    std::cout << "int i = " << i << std::endl;
    std::cout << "i as binary = " << std::bitset<8*sizeof(i)>(i) << std::endl;

    i = -16;
    std::cout << "int i = " << i << std::endl;
    std::cout << "i as binary = " << std::bitset<8*sizeof(i)>(i) << std::endl;

    std::cout << std::endl;

    // Decimal to two's compomnent

    std::bitset<16> n_bit = 0b0000000000100000; 
    std::bitset<16> n_max_bit = 0b0111111111111111; 
    std::bitset<16> n_min_bit = 0b1000000000000000;

    short int n = static_cast<short int>(n_bit.to_ulong());
    short int n_max = static_cast<short int>(n_max_bit.to_ulong());
    short int n_min = static_cast<short int>(n_min_bit.to_ulong());

    std::cout << "n as biary = " << n_bit << std::endl;
    std::cout << "n as int   = " << n << std::endl;
    std::cout << "short int max = " << n_max << std::endl;
    std::cout << "short int min = " << n_min << std::endl;

    return 0;
}