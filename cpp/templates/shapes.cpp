#include <math.h> 

#include "./shapes.h"    

// Inheritance finitions

Inheritance::Circle::Circle(float in_diameter) {
    diameter = in_diameter;
}

Inheritance::Rectangle::Rectangle(float in_width, float in_height) {
    width = in_width;
    height = in_height;
}

Inheritance::Square::Square(float in_side) {
    side = in_side;
}

float Inheritance::Circle::Area() {
    return M_PI * pow(diameter, 2.f);
}

float Inheritance::Rectangle::Area() {
    return width * height;
}

float Inheritance::Square::Area() {
    return side * side;
}

// Non inheritance definitions

Circle::Circle(float in_diameter) {
    diameter = in_diameter;
}

Rectangle::Rectangle(float in_width, float in_height) {
    width = in_width;
    height = in_height;
}

Square::Square(float in_side) {
    side = in_side;
}

float Circle::Area() {
    return M_PI * pow(diameter, 2.f);
}

float Rectangle::Area() {
    return width * height;
}

float Square::Area() {
    return side * side;
}