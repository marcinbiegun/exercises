#include <iostream>
#include <vector>

int main() {
    std::vector<int> nums = { 3, 5, 7, 9 };

    for (auto itr = nums.begin(); itr != nums.end(); ++itr) {
        std::cout << "num = " << *itr << std::endl;
    }

    return 0;
}