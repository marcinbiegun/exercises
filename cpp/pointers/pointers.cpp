#include <iostream>
using namespace std;

int main()
{
    int x = 5;
    int *x_ptr = &x;
    int x_val = *x_ptr;

    cout << x << "\n";
    cout << x_ptr << "\n";
    cout << x_val << "\n";

    cout << "---"
         << "\n";

    *x_ptr = 7;
    cout << *x_ptr << "\n";
    cout << x_val << "\n";

    return 0;
}