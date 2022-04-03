#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "vendor/doctest.h"
#include "3lib.cpp"

TEST_CASE("test processLine()") {
    std::string line = "0011";
    std::vector<int> shifts(4, 0);

    processLine(line, shifts);

    CHECK(shifts[0] == -1);
    CHECK(shifts[1] == -1);
    CHECK(shifts[2] == 1);
    CHECK(shifts[3] == 1);
}

TEST_CASE("test readBinaryLine()") {
    std::string line = "0011";

    CHECK(readBinaryLine(line) == std::vector<bool>{0, 0, 1, 1});
}
