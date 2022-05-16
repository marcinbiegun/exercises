#include <iostream>

class Resource {
public:
    int Value;

    Resource(int InValue) {
        Value = InValue;
    }
};

class A
{
public:
    A()
    {
        // See: https://stackoverflow.com/questions/962132/calling-virtual-functions-inside-constructors
        // Calling virtual functions from a constructor or destructor is dangerous
        // and should be avoided whenever possible. All C++ implementations should call
        // the version of the function defined at the level of the hierarchy
        // in the current constructor and no further.

        // This will fail on "uninitilized pure virutal function call"
        CreateAndInitializeResource();
    }
    virtual Resource* CreateResource() = 0;

private:

    void CreateAndInitializeResource()
    {
        Res = CreateResource();
        if (Res)
        {
            // some code...
        }
    }

    Resource* Res;
};

class B : public A
{
public:
    virtual Resource* CreateResource()
    {
        Resource* R = new Resource(1);
    }
};
 
int main()
{
    // We can use A type, it can be useful to treat A as an interface class
    A* a = new B();

    // But this will fail on "uninitilized pure virutal function call"
    delete a;
}