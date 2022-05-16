#include <iostream>

void printBinary(int i) {
    int bytes = sizeof(i);
    int bits = bytes * 8;

    std::string binary = "";

    while (bits > 0) {
        bits--;
        //std::cout << i % 2;
        binary.append(std::to_string(i % 2));
        i /= 2;
    }

    std::reverse(binary.begin(), binary.end());

    std::cout << binary;
}

void printBinaryBitset(int i) {
    std::cout << std::bitset<8*sizeof(i)>(i);
}

int main() {
    // Bitwise shift left works like multiplication by 2
    unsigned int n = 1;

    std::cout << "Bitshift left by 1" << std::endl;
    for (int i = 1; i < sizeof(n)*8 + 5; i ++) {
        std::cout << "n = " << n << " = "; printBinary(n); std::cout << std::endl;
        n = n << 1;
    }

    std::cout << std::endl;

    return 0;
}