#include <iostream>
#include <bitset>
#include <exception>


class Object {
    std::string name;

public:
    Object(std::string inName) {
        name = inName;
        std::cout << "Constructing object " << name << ".\n";
    }

    ~Object() {
        std::cout << "Destructing object " << name << ".\n";
    }
};


int someOperation(int a, int b) {

    Object* o_heap = new Object("before throw on HEAP");
    Object o_stack = Object("before throw on STACK");

    // LEAK!! Object o will leak, as the execution will stop here before the destructor is called
    // A solution would be to delete objects in scope before raising.
    std::cout << "Raising exception.\n";
    throw std::logic_error("Buba happened");


    delete o_heap;

    return a + b;
}

void test() {
    int a = 1;
    int b = 2;

    try {
        // BEWARE! Object o will leak, as the execution will stop here before the destructor is called
        Object* o_heap = new Object("in try block on HEAP");

        // This object will be destructed as a part of cleanup happening inside try{} block
        // on exception raised
        Object o_stack = Object("in try block on STACK");

        // This raises error
        someOperation(a, b);

        delete o_heap;
    } catch (const std::exception& ex)  {
        // LEAK!! We no longer have access to o_heap to destruct it
        // A solution would be to delete objects in scope before raising, to do that we need to declare those
        // objects BEFORE the TRY block clause.

        // No need to delete o here
        std::cout << "Catched exception: " << ex.what() << std::endl;
    }
}

int main() {
    test();

    std::cout << "Done." << std::endl;

    return 0;
}
