#include <iostream>
#include <vector>
#include <array>
#include <exception>


/**
 * Rules:
 *   - when timer goes to 0, it creates another entity
 *   - spawns every 7 days (when timer goes negative, then resets to 6)
 *   - a new spawn has internal timer of 8 (+2 more than after reset)
 */

//
// Brute force
// 
namespace Day6Brute {
    std::vector<int> simulateTurn(std::vector<int> numbers) {
        int initialSize = numbers.size();

        for (int i = 0; i < initialSize; i++) {
            int newValue = numbers[i] - 1;
            if (newValue < 0) {
                newValue = 6;
                numbers.push_back(8);
            }
            numbers[i] = newValue;
        }

        return numbers;
    }

    int solve(std::vector<int> numbers, int turns) {
        for (int i = 1; i <= turns; i++) {
            numbers = simulateTurn(numbers);
        }
        return numbers.size();
    }
}

//
// Recursive
// 

namespace Day6Recursive {
    std::vector<int> whenItWillSpawn(int number, int turns) {
        std::vector<int> spawnsAt;

        // First spawn
        int firstSpawnAt = number + 1;
        if (firstSpawnAt <= turns)
            spawnsAt.push_back(firstSpawnAt);

        // More spawns
        int moreSpawns = (turns - number) / 7;
        for (int i = 1; i <= moreSpawns; i++) {
            spawnsAt.push_back(firstSpawnAt + 7*i);
        }

        return spawnsAt;
    }

    int countNumbersAfterDays(int number, int turnsLeft, int totalNumbers = 0) {
        totalNumbers++;

        for (int spawnAt : whenItWillSpawn(number, turnsLeft)) {
            int turnsLeftForThisNumber = turnsLeft - spawnAt;
            if (turnsLeftForThisNumber > 0) {
                totalNumbers = countNumbersAfterDays(8, turnsLeftForThisNumber, totalNumbers);
            }
        }

        return totalNumbers;
    }

    int solve(std::vector<int> numbers, int turns) {
        int totalNumbers = 0;
        for (int number : numbers) {
            totalNumbers += countNumbersAfterDays(number, turns + 1);
        }
        return totalNumbers;
    }
}

//
// Dynamic programming
// 

namespace Day6Dynamic {
    unsigned long long int solve(std::vector<int> numbers, int turns) {
        std::array<unsigned long long int, 9> counters;
        counters.fill(0);

        for (int number : numbers) {
            counters[number]++;
        }
        
        for (int i = 1; i <= turns; i++) {
            unsigned long long int newSpawnsCount = counters[0];
            counters[0] = counters[1];
            counters[1] = counters[2];
            counters[2] = counters[3];
            counters[3] = counters[4];
            counters[4] = counters[5];
            counters[5] = counters[6];
            counters[6] = counters[7] + newSpawnsCount;
            counters[7] = counters[8];
            counters[8] = newSpawnsCount;
        }

        unsigned long long int total = 0;
        for (auto count : counters) {
            total += count;
        }

        return total;
    }
}