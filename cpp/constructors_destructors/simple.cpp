#include <iostream>

class Employee {

private:
    std::string Name;

public:

    Employee(std::string InName) {
        std::cout << "Constructing...\n";
        Name = InName;
    }

    ~Employee() {
        std::cout << "Destructing...\n";
    }

    std::string GetName() {
        return Name;
    }

    void SetName(std::string InName) {
        Name = InName;
    }
};

int main() {
    std::cout << "hello" << std::endl;

    Employee* Bob = new Employee("Bob Smith");

    std::cout << "Employee name: " << Bob->GetName() << std::endl;

    delete Bob;

    return 0;
};
