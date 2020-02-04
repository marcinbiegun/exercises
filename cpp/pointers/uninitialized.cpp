#include <iostream>
using namespace std;

void foo(int *&p)
{
}

int main()
{
    int *p;
    foo(p); // trick compiler

    cout << *p;

    return 0;
}