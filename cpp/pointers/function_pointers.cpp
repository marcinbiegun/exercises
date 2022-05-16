#include <iostream>

int add(int a, int b) {
    return a+b;
}

int main() {
    // This pointer needs to match functions return value and param types
    int (*pointerToAdd)(int, int);
    pointerToAdd = add;

    int c = pointerToAdd(1, 2);

    std::cout << "C == " << c << std::endl;
    return 0;
}