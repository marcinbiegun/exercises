#include <iostream>
#include <bitset>
#include <exception>



int main() {
    int a = 1;

    try {
        throw std::invalid_argument("Argument cannot be zero!");
    } catch (const std::exception& ex)  {
        std::cout << "Catched exception: " << ex.what() << std::endl;
    }

    std::cout << "Done." << std::endl;

    return 0;
}