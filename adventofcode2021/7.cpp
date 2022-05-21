#include <iostream>
#include <vector>
#include "./utils.cpp"
#include "./7lib.cpp"

int main() {
    std::string inputString = getInputString("7input.txt");
    std::vector<std::string> inputNumbers = splitString(inputString, ',');
    std::vector<int> numbers;
    for (auto inputNumber : inputNumbers) {
        auto [numberOk, number] = safeStrToInt(inputNumber);
        if (numberOk)
            numbers.push_back(number);
    }

    Day7 computor(numbers);
    uint64_t result = computor.ComputeResult();
    
    std::cout << "The result is: " << result << std::endl;

    return 0;
}