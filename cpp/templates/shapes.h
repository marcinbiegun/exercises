#pragma once

namespace Inheritance {
    class Shape {
    public:
        virtual float Area() { return 0.f; };
    };

    class Circle : public Shape {
        float diameter = 0.f;

    public:
        Circle(float in_diameter);
        float Area() override;
    };

    class Rectangle : public Shape {
        float width = 0.f;
        float height = 0.f;

    public:
        Rectangle(float in_width, float in_height);
        float Area() override;
    };

    class Square : public Shape {
        float side = 0.f;

    public:
        Square(float in_side);
        float Area() override;
    };
}

class Circle {
    float diameter = 0.f;

public:
    Circle(float in_diameter);
    float Area();
};

class Rectangle {
    float width = 0.f;
    float height = 0.f;

public:
    Rectangle(float in_width, float in_height);
    float Area();
};

class Square {
    float side = 0.f;

public:
    Square(float in_side);
    float Area();
};

// Does not have an area
class Apple {
};
