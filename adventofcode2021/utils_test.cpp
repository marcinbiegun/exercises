#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "vendor/doctest.h"
#include "utils.cpp"

TEST_CASE("test binaryToInt()") {
    std::vector<bool> binaryEmpty{};
    std::vector<bool> binary0{ 0 };
    std::vector<bool> binary1{ 1 };
    std::vector<bool> binary16{ 1, 0, 0, 0, 0 };
    std::vector<bool> binary17{ 1, 0, 0, 0, 1 };
    std::vector<bool> binary25{ 1, 1, 0, 0, 1 };

    CHECK(binaryToInt(binaryEmpty) == 0);
    CHECK(binaryToInt(binary0) == 0);
    CHECK(binaryToInt(binary1) == 1);
    CHECK(binaryToInt(binary16) == 16);
    CHECK(binaryToInt(binary17) == 17);
    CHECK(binaryToInt(binary25) == 25);
}

TEST_CASE("safeStrToInt whitespace test") {
    std::tuple<bool, int> result = std::make_tuple(false, -1);
    
    result = safeStrToInt(std::string("55"));
    CHECK(std::get<0>(result) == true);
    CHECK(std::get<1>(result) == 55);

    result = safeStrToInt(std::string("   55"));
    CHECK(std::get<0>(result) == true);
    CHECK(std::get<1>(result) == 55);

    result = safeStrToInt(std::string("   55     "));
    CHECK(std::get<0>(result) == true);
    CHECK(std::get<1>(result) == 55);

    result = safeStrToInt(std::string("\n   55   \n  "));
    CHECK(std::get<0>(result) == true);
    CHECK(std::get<1>(result) == 55);
}