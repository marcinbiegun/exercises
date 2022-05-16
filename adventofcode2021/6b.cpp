#include <iostream>
#include <vector>
#include "./utils.cpp"
#include "./6lib.cpp"

int main() {
    std::string inputString = getInputString("6input.txt");
    std::vector<std::string> inputNumbers = splitString(inputString, ',');
    std::vector<int> numbers;
    for (auto inputNumber : inputNumbers) {
        auto [numberOk, number] = safeStrToInt(inputNumber);
        if (numberOk)
            numbers.push_back(number);
    }

    int days = 256;
    int totalFishes = Day6Dynamic::solve(numbers, days);

    std::cout << "After " << days << " there are " << totalFishes << " fishes.";

    return 0;
}