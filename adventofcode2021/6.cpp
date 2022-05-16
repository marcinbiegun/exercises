#include <iostream>
#include <vector>
#include "./utils.cpp"


/**
 * Rules:
 *   - when timer goes to 0, it creates another entity
 *   - spawns every 7 days (when timer goes negative, then resets to 6)
 *   - a new spawn has internal timer of 8 (+2 more than after reset)
 */

// Bruteforce method
std::vector<int> simulate(std::vector<int> numbers) {
    std::vector<int> newNumbers;

    for (int i = 0; i < numbers.size(); i++) {
        int number = numbers[i];
        number--;

        bool spawn = false;
        if (number < 0) {
            number = 6;
            spawn = true;
        }

        newNumbers.push_back(number);
        if (spawn)
            newNumbers.push_back(8);
    }

    return newNumbers;
}

int main() {
    std::cout << "hello" << std::endl;

    std::string inputString = getInputString("6input.txt");
    std::vector<std::string> inputNumbers = splitString(inputString, ',');
    std::vector<int> numbers;
    for (auto inputNumber : inputNumbers) {
        auto [numberOk, number] = safeStrToInt(inputNumber);
        if (numberOk)
            numbers.push_back(number);
    }

    for (auto num : numbers) {
        std::cout << num << std::endl;
    }

    int simulateTurns = 80;
    int turnsCount = 0;
    for (int i = 0; i < simulateTurns; i++) {
        numbers = simulate(numbers);
        turnsCount++;

        std::cout << "After turn " << turnsCount << " there are " <<  numbers.size() << " starfishes" << std::endl;
    }

    return 0;
}