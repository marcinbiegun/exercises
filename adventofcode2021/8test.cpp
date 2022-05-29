#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "vendor/doctest.h"
#include "8lib2.cpp"
  
TEST_CASE("subtract") {
    string a = "abcdef";
    string b = "acf";

    CHECK(Day8Solution::subtract(a, b) == "bde");
}

TEST_CASE("invert") {
    CHECK(Day8Solution::invert("abcdefg") == "");
    CHECK(Day8Solution::invert("abdefg") == "c");
    CHECK(Day8Solution::invert("g") == "abcdef");
}