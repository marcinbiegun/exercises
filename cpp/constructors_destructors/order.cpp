#include <iostream>

class Shape {

private:
    float size;

public:

    Shape(float inSize) {
        size = inSize;
        std::cout << "Constructing Shape...\n";
    }

    ~Shape() {
        std::cout << "Destructing Shape...\n";
    }

    virtual float Radius() { return 0; }
};

class Circle : public Shape {
    float width, height;

public:

    // Circle is required to call parent constructor (not possible to
    // call default Shape() constructor automatically becaise it does not exist)
    // or it won't compile.
    Circle(float inWidth, float inHeight) : Shape(inWidth) {

        Shape(inWidth);

        width = inWidth;
        height = inHeight;
        std::cout << "Constructing Circle...\n";
    }

    ~Circle() {
        std::cout << "Destructing Shape...\n";
    }
};

int main() {
    Shape* s = new Shape(10.f);
    Circle* c = new Circle(5.f, 5.f);

    delete s;
    delete c;

    return 0;
};
