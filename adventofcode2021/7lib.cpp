#include <iostream>
#include <vector>
#include <cstdlib>
#include <limits>
#include <algorithm>
#include <unordered_map>

class Day7 {
public:
    Day7(std::vector<int> inPositions);
    uint64_t ComputeResult();
    uint64_t ComputeSingle(int inPos);

    std::vector<int> positions;
};

Day7::Day7(std::vector<int> inPositions)
{
    positions = inPositions;
    std::sort(positions.begin(), positions.end());
}

uint64_t Day7::ComputeResult() {
    return ComputeSingle(positions.size() / 2);
}

uint64_t Day7::ComputeSingle(int inPos) {
    uint64_t fuelNeeded = 0;
    for (int pos : positions) {
        fuelNeeded += std::abs(inPos - pos);
    }
    return fuelNeeded;
};




class Day7p2 {
public:
    Day7p2();
    Day7p2(std::vector<int> inPositions);
    uint64_t ComputeResult();
    uint64_t ComputeSingle(int inPos);
    uint64_t FuelForDistance(int distance);

    std::vector<int> positions;
    std::unordered_map<uint64_t, uint64_t> fuelDistCache;
};

Day7p2::Day7p2()
{
    positions = std::vector<int>{};
}

Day7p2::Day7p2(std::vector<int> inPositions)
{
    positions = inPositions;
    std::sort(positions.begin(), positions.end());
}

uint64_t Day7p2::ComputeResult() {
    return ComputeSingle(positions.size() / 2);
}

uint64_t Day7p2::ComputeSingle(int inPos) {
    uint64_t fuelNeeded = 0;
    for (int pos : positions) {
        int distance = std::abs(inPos - pos);
        fuelNeeded += FuelForDistance(distance);
    }
    return fuelNeeded;
};

uint64_t Day7p2::FuelForDistance(int distance) {
    if (fuelDistCache.count(distance))
        return fuelDistCache[distance];

    uint64_t fuelNeeded = 0;
    for (int i = 1; i <= distance; i++) {
        fuelNeeded += i;
    }

    fuelDistCache[distance] = fuelNeeded;
    return fuelNeeded;
};

