#include <iostream>

struct Vector2 {
    float x, y;
};

struct Vector4 {
    union {
        // 4 floats
        struct {
            float x, y, z, w;
        };
        // also 4 floats
        struct {
            Vector2 a;
            Vector2 b;
        };
    };
};


void printVector(Vector2 InVector) {
    std::cout << "Vector2(" << InVector.x << ", " << InVector.y << ")\n";
}

int main() {
    Vector4 vector { 1.f, 2.f, 3.f, 4.f };

    printVector(vector.a);
    printVector(vector.b);

    vector.y = 200.f;
    vector.w = 300.f;

    std::cout << "-----\n";

    printVector(vector.a);
    printVector(vector.b);

    return 0;
};