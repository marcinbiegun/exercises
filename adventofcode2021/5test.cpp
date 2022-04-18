#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "vendor/doctest.h"
#include "5lib.cpp"
  
TEST_CASE("test parsing lines") {
    std::string line = "100,234 -> 312,3";

    std::tuple<int, int, int, int> parsed = parseLine(line);
    int startX = std::get<0>(parsed);
    int startY = std::get<1>(parsed);
    int endX = std::get<2>(parsed);
    int endY = std::get<3>(parsed);

    CHECK(startX == 100);
    CHECK(startY == 234);
    CHECK(endX == 312);
    CHECK(endY == 3);
}

TEST_CASE("test setting and reading fields in VentsBoard") {
    VentsBoard Board = VentsBoard();

    CHECK(Board.Get(5, 999) == 0);
    Board.Set(5, 999, 1);
    CHECK(Board.Get(5, 999) == 1);
}

TEST_CASE("test lineToPints() single point") {
    std::vector<std::tuple<int, int>> points = lineToPoints(1, 1, 1, 1);
    CHECK(points.size() == 1);
    int x = std::get<0>(points[0]);
    int y = std::get<1>(points[0]);
    CHECK(x == 1);
    CHECK(y == 1);
}

TEST_CASE("test lineToPints() horizontal line") {
    std::vector<std::tuple<int, int>> points = lineToPoints(50, 60, 52, 60);
    CHECK(points.size() == 3);
    int x1 = std::get<0>(points[0]);
    int y1 = std::get<1>(points[0]);
    int x2 = std::get<0>(points[1]);
    int y2 = std::get<1>(points[1]);
    int x3 = std::get<0>(points[2]);
    int y3 = std::get<1>(points[2]);
    CHECK(x1 == 50);
    CHECK(y1 == 60);
    CHECK(x2 == 51);
    CHECK(y2 == 60);
    CHECK(x3 == 52);
    CHECK(y3 == 60);
}

TEST_CASE("test lineToPints() diagonal line") {
    std::vector<std::tuple<int, int>> points = lineToPoints(52, 100, 50, 102);
    CHECK(points.size() == 3);
    int x1 = std::get<0>(points[0]);
    int y1 = std::get<1>(points[0]);
    int x2 = std::get<0>(points[1]);
    int y2 = std::get<1>(points[1]);
    int x3 = std::get<0>(points[2]);
    int y3 = std::get<1>(points[2]);
    CHECK(x1 == 52);
    CHECK(y1 == 100);
    CHECK(x2 == 51);
    CHECK(y2 == 101);
    CHECK(x3 == 50);
    CHECK(y3 == 102);
}
