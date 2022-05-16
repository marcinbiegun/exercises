#include <iostream>

int main() {
    // Int is 4 bytes or more
    // See: https://www.intel.com/content/www/us/en/developer/articles/technical/size-of-long-integer-type-on-different-architecture-and-os.html
    //
    // 4-byte int can hold values -32767 to 32767
    // 8-byte int can hold values -2147483647 to 2147483647
    //
    // On MacOS Intel64 the size of int is 8 bytes

    int i = 0;
    i = 2147483647;
    std::cout << i << std::endl;
    std::cout << ++i << std::endl;

    return 0;
}