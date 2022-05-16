#include <iostream>

#include "../inc/shapes.cpp"

float getArea(Inheritance::Shape* shape) {
    return shape->Area();
}

void printArea(Inheritance::Shape* shape, std::string name) {
    std::cout << name;
    std::cout << " area: ";
    printf("%0.2f", getArea(shape));
    std::cout << "\n";
}

template <typename T> float t_getArea(T shape) {
    return shape->Area();
}

template <typename T> void t_printArea(T shape, std::string name) {
    std::cout << name;
    std::cout << " area: ";
    printf("%0.2f", t_getArea(shape));
    std::cout << "\n";
}

int main() {
    //
    // Shapes that inherit from a bae Shape class
    //
    Inheritance::Circle* i_circle = new Inheritance::Circle(10.f);
    Inheritance::Rectangle* i_rectangle = new Inheritance::Rectangle(10.f, 20.f);
    Inheritance::Square* i_square = new Inheritance::Square(7.5f);

    std::cout << "[Inheritance] " << std::endl;
    printArea(i_circle, "circle");
    printArea(i_rectangle, "rectangle");
    printArea(i_square, "aquare");

    //
    // Shapes with no inheritance, but sharing common Area() function
    //
    Circle* circle = new Circle(10.f);
    Rectangle* rectangle = new Rectangle(10.f, 20.f);
    Square* square = new Square(7.5f);

    std::cout << std::endl;
    std::cout << "[Template] " << std::endl;
    t_printArea(circle, "circle");
    t_printArea(rectangle, "rectangle");
    t_printArea(square, "aquare");

    // Does not compile as there is no Apple->Area()
    // Apple* apple = new Apple();
    // t_printArea(apple, "apple");

    //
    // Clean up
    //
    delete i_circle;
    delete i_rectangle;
    delete i_square;

    return 0;
}
