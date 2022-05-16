#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "vendor/doctest.h"
#include "6lib.cpp"
  
TEST_CASE("recursive - whenWillItSpawn") {
    // Handles negative value
    CHECK(std::vector<int> {} == Day6Recursive::whenItWillSpawn(0, -9));

    // 0 turns to simulate, will not spawn
    CHECK(std::vector<int> {} == Day6Recursive::whenItWillSpawn(0, 0));

    // Spawns now
    CHECK(std::vector<int> {1} == Day6Recursive::whenItWillSpawn(0, 1));

    CHECK(std::vector<int> {1, 8} == Day6Recursive::whenItWillSpawn(0, 8));
    CHECK(std::vector<int> {1, 8, 15} == Day6Recursive::whenItWillSpawn(0, 15));
    CHECK(std::vector<int> {1, 8, 15} == Day6Recursive::whenItWillSpawn(0, 20));
};

TEST_CASE("test case from description - brute force") {
    std::vector<int> numbers { 3,4,3,1,2 };
    int after18days = 26;
    int after80days = 5934;

    CHECK(Day6Brute::solve(numbers, 18) == 26);
    CHECK(Day6Brute::solve(numbers, 80) == 5934);
};

TEST_CASE("test case from description - recursive") {
    std::vector<int> numbers { 3,4,3,1,2 };

    CHECK(Day6Recursive::solve(numbers, 18) == 26);
    CHECK(Day6Recursive::solve(numbers, 80) == 5934);
};

TEST_CASE("test case from description - dynamic") {
    std::vector<int> numbers { 3,4,3,1,2 };

    CHECK(Day6Dynamic::solve(numbers, 18) == 26);
    CHECK(Day6Dynamic::solve(numbers, 80) == 5934);
};
