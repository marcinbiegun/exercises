#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "vendor/doctest.h"
#include "4lib.cpp"
  

TEST_CASE("storing multiple Bingos") {
    std::vector<Bingo> collection;
    Bingo A = Bingo();
    collection.push_back(A);
    Bingo B = Bingo();
    collection.push_back(B);
}

TEST_CASE("selecting Bingo numbers") {
    Bingo B = Bingo();

    CHECK(B.numbers[0][0] == -1);

    B.numbers[0][0] = 1;
    B.numbers[0][1] = 2;
    B.numbers[0][2] = 3;
    B.numbers[0][3] = 4;
    B.numbers[0][4] = 5;

    B.SelectNumber(1);
    B.SelectNumber(2);
    B.SelectNumber(3);
    B.SelectNumber(4);
    B.SelectNumber(5);

    CHECK(B.IsNumberSelected(0) == false);
    CHECK(B.IsNumberSelected(1) == true);
    CHECK(B.IsNumberSelected(5) == true);
}

TEST_CASE("Bingo vertical win condition") {
    Bingo BingoVertical = Bingo();

    CHECK(BingoVertical.numbers[0][0] == -1);

    BingoVertical.numbers[0][0] = 1;
    BingoVertical.numbers[0][1] = 2;
    BingoVertical.numbers[0][2] = 3;
    BingoVertical.numbers[0][3] = 4;
    BingoVertical.numbers[0][4] = 5;

    BingoVertical.SelectNumber(1);
    BingoVertical.SelectNumber(2);
    BingoVertical.SelectNumber(3);
    BingoVertical.SelectNumber(4);

    CHECK(BingoVertical.IsWon() == false);

    BingoVertical.SelectNumber(5);

    CHECK(BingoVertical.IsWon() == true);
}

TEST_CASE("Bingo vertical win condition") {
    Bingo BingoHorizontal = Bingo();

    CHECK(BingoHorizontal.numbers[0][0] == -1);

    BingoHorizontal.numbers[0][0] = 1;
    BingoHorizontal.numbers[1][0] = 2;
    BingoHorizontal.numbers[2][0] = 3;
    BingoHorizontal.numbers[3][0] = 4;
    BingoHorizontal.numbers[4][0] = 5;

    BingoHorizontal.SelectNumber(1);
    BingoHorizontal.SelectNumber(2);
    BingoHorizontal.SelectNumber(3);
    BingoHorizontal.SelectNumber(4);

    CHECK(BingoHorizontal.IsWon() == false);

    BingoHorizontal.SelectNumber(5);

    CHECK(BingoHorizontal.IsWon() == true);
}

TEST_CASE("inialize with text") {
  std::string text = std::string(" 1 86 98 16  6\n93 69 33 49 71\n54 43 77 29 47\n82 73 99 31 27\n28 48 36 89 20");
  Bingo B = Bingo(text);

  CHECK(B.numbers[0][0] == 1);
  CHECK(B.numbers[0][1] == 86);

  B.SelectNumber(1);
  B.SelectNumber(93);
  B.SelectNumber(54);
  B.SelectNumber(82);
  B.SelectNumber(28);

  CHECK(B.IsWon() == true);
}