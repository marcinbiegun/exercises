#include <iostream>
#include <vector>
#include <string>
#include "./utils.cpp"
#include "./8lib.cpp"

int main() {
    std::vector<std::string> lines = getInputLines("8input.txt");
    std::vector<std::vector<std::string>> wordPacks;

    // Read 14 words
    for (auto line : lines) {
        std::vector<std::string> wordPack;
        for (std::string word : splitString(line, ' ')) {
            std::string cleanWord = strip(word);
            if (cleanWord != "|")
                wordPack.push_back(cleanWord);
        }
        wordPacks.push_back(wordPack);
    }

    uint64_t sum = 0;
    for (auto wordPack : wordPacks) {
        int solution = Day8Solution::Solve(wordPack);
        cout << "Solution: " << solution << endl;
        sum += solution;
    }

    cout << "TOTAL: " << sum << endl;

    return 0;
}