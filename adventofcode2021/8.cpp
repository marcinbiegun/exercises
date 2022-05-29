#include <iostream>
#include <vector>
#include <string>
#include "./utils.cpp"
#include "./8lib.cpp"

int main() {
    std::vector<std::string> lines = getInputLines("8input.txt");
    std::vector<std::vector<std::string>> wordPacks;

    for (auto line : lines) {
        std::vector<std::string> wordPack;

        for (std::string word : splitString(line, ' ')) {
            std::string cleanWord = strip(word);
            if (cleanWord != "|")
                wordPack.push_back(cleanWord);
        }

        wordPacks.push_back(wordPack);
    }

    int counter = 0;
    // digit 1 has 2 parts on
    // digit 4 has 4 parts on
    // digit 7 has 3 parts on
    // digit 8 has 7 parts on
    for (auto wordPack : wordPacks) {
        vector<std::string> question = {wordPack.end() - 4, wordPack.end()};
        // vector<std::string> digits = {wordPack.begin(), wordPack.begin() + 10};
        for (auto word : question) {
            switch (word.length()) {
                case 2:
                case 3:
                case 4:
                case 7:
                    counter++;
                    break;
                default:
                    break;
            }
        }
        //std::cout << std::endl;
    }

    // Day7 computor(numbers);
    // uint64_t result = computor.ComputeResult();
    
    std::cout << "Amount of digits 1, 4, 7, 8 in output: " << counter << std::endl;

    return 0;
}