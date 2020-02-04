#include <iostream>
using namespace std;

int main()
{
    int x = 5;
    int* x_ptr = &x;
    int x_copy = *x_ptr;
    int &x_ref = *x_ptr;

    cout << "x == " << x << "\n";
    cout << "x_ptr == " << x_ptr << "\n";
    cout << "x_copy == " << x_copy << "\n";
    cout << "x_ref == " << x_ref << "\n";

    cout << "\n--- after *x_ptr = 7\n";
    *x_ptr = 7;

    cout << "x == " << x << "\n";
    cout << "x_ptr == " << x_ptr << "\n";
    cout << "x_copy == " << x_copy << "\n";
    cout << "x_ref == " << x_ref << "\n";

    cout << "\n--- after x_ref = 999\n";
    x_ref = 999;

    cout << "x == " << x << "\n";
    cout << "x_ptr == " << x_ptr << "\n";
    cout << "x_copy == " << x_copy << "\n";
    cout << "x_ref == " << x_ref << "\n";

    return 0;
}
