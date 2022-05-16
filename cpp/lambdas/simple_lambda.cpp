#include <iostream>
#include <vector>
#include <algorithm>

template<typename F>
int countWithLambda(std::vector<int> nums, F& lambda) {
    int count = 0;
    for (int num : nums) {
        if (lambda(num))
            count++;
    }
    return count;
}

int main() {
    std::vector<int> nums = { 2, 3, 4, 5, -1, 1 };

    auto isOdd = [](int num) { return num % 2 == 1; };

    int count = std::count_if(nums.begin(), nums.end(), isOdd);
    std::cout << "Number of odds: " << count << std::endl;

    count = countWithLambda(nums, isOdd);
    std::cout << "Number of odds (my counter): " << count << std::endl;

    return 0;
}