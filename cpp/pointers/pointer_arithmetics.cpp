#include <iostream>

// Unsized array, we need to pass the size
void printArray(int arr[], int size) {
    // Would not work here!
    // int arrSize = sizeof(arr) / sizeof(arr[0]);

    for (int i = 0; i < size; i++) {
        std::cout << arr[i] << " ";
    }
}

void printArray10(int arr[10]) {
    int arrSize = 10;
    for (int i = 0; i < arrSize; i++) {
        std::cout << arr[i] << " ";
    }
}

void printArray5(int arr[5]) {
    int arrSize = 5;
    for (int i = 0; i < arrSize; i++) {
        std::cout << arr[i] << " ";
    }
}

void printArray2(int arr[2]) {
    int arrSize = 2;
    for (int i = 0; i < arrSize; i++) {
        std::cout << arr[i] << " ";
    }
}

int main() {
    std::cout << "elo\n";

    int i = 5;

    // & this is "Address of" operator
    // * this is "Indirection" operator

    // Pointer stores two things:
    //    1. type of variable
    //    2. memory address of the variable

    std::cout << "i value == " << i << std::endl;
    std::cout << "i addr == " << &i << std::endl;

    // Assign i addr to iPtr pointer
    int* iPtr = &i;

    // The value of pointer is a memory address
    std::cout << "iPtr value == " << iPtr << std::endl;

    // Using indirection operator we can access the variable value
    std::cout << "iPtr indirect value == " << *iPtr << std::endl;

    int arr[] = {10, 20, 30, 40, 50};
    int arrSize = sizeof(arr) / sizeof(arr[0]);

    std::cout << "arr[0] size == " << sizeof(arr[0]) << std::endl;
    std::cout << "arr size == " << sizeof(arr) << std::endl;
    std::cout << "arr number of elements == " << arrSize << std::endl;

    std::cout << "arr[0] value == " << arr[0] << std::endl;
    std::cout << "arr[0] addr == " << &arr[0] << std::endl;

    int* arrPtr = arr;

    std::cout << "arrPtr value == " << arrPtr << std::endl;
    std::cout << "arrPtr indirect value == " << *arrPtr << std::endl;

    std::cout << "arr[1] == " << arr[1] << std::endl;
    std::cout << "arrPtr + 1 == " << *(arrPtr + 1) << std::endl;

    std::cout << "Print arr as int[] with size: ";
    printArray(arr, arrSize);
    std::cout << std::endl;

    std::cout << "Print arr as int[5] array: ";
    printArray5(arr);
    std::cout << std::endl;
    
    std::cout << "Print arr as int[5] array: ";
    printArray5(arr);
    std::cout << std::endl;

    std::cout << "Print arr as int[10] array: ";
    printArray10(arr);
    std::cout << std::endl;

    return 0;
}