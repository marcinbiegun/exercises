#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "vendor/doctest.h"
#include "7lib.cpp"
  
TEST_CASE("fuel for part 2") {
    // (1)
    CHECK(Day7p2().FuelForDistance(1) == 1);

    // (5) 1 + 2 + 3 + 4 + 5 = 15
    CHECK(Day7p2().FuelForDistance(5) == 15);
}