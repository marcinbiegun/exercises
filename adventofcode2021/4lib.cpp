#include <array>
#include <stdexcept>
#include <algorithm>
#include <tuple>
#include <string>
#include <iostream>

#include "utils.cpp"

const int BINGO_SIZE = 5;
typedef std::array<int, 5> int_array_5;
typedef std::array<bool, 5> bool_array_5;

struct Bingo {

  bool disabled = false;
  std::array<int_array_5, 5> numbers;
  std::array<bool_array_5, 5> selected;
  std::array<bool_array_5, 5> selectedInverted;

  Bingo() {
    for (auto& row : numbers) {
      row.fill(-1);
    }
    for (auto& row : selected) {
      row.fill(false);
    }
    for (auto& row : selectedInverted) {
      row.fill(false);
    }
  }

  Bingo(std::string InText) {
    for (auto& row : numbers) {
      row.fill(-1);
    }
    for (auto& row : selected) {
      row.fill(false);
    }
    for (auto& row : selectedInverted) {
      row.fill(false);
    }

    int x = 0;
    for (std::string line : splitString(InText, '\n')) {
      std::vector<int> lineNumbers;
      for (std::string numberString : splitString(line, ' ')) {
        std::tuple<bool, int> numberParsed = safeStrToInt(numberString);
        if (std::get<0>(numberParsed))
          lineNumbers.push_back(std::get<1>(numberParsed));
      }

      // Skip empty
      if (lineNumbers.size() == 0) {
        continue;
      }

      // Raise if not matching the fixed size
      if (lineNumbers.size() < BINGO_SIZE) {
        throw std::invalid_argument("Error: invalid amount of numbers in the line: " + line);
      }

      for (int y = 0; y < lineNumbers.size(); y++) {
        numbers[x][y] = lineNumbers[y];
      }

      x++;
    }
  }


  bool IsWon() {
    for (auto& row : selected) {
      if (std::all_of(row.begin(), row.end(), [](bool s) { return s == true; }))
        return true;
    }

    for (auto& row : selectedInverted) {
      if (std::all_of(row.begin(), row.end(), [](bool s) { return s == true; }))
        return true;
    }

    return false;
  }

  void SelectNumber(int InNumber) {
    for (int x = 0; x < numbers.size(); x++)
    {
      for (int y = 0; y < numbers[x].size(); y++)
      {
        if (numbers[x][y] == InNumber) {
          selected[x][y] = true;
          selectedInverted[y][x] = true;
        }
      }
    }
  }

  bool IsNumberSelected(int InNumber) {
    std::tuple<int, int> coords = GetNumberCoord(InNumber);
    int x = std::get<0>(coords);
    int y = std::get<1>(coords);

    // No such number
    if (x < 0)
      return false;

    bool isSelected = selected[x][y];
    return isSelected;
  }

  std::tuple<int, int> GetNumberCoord(int InNumber) {
    for (int x = 0; x < numbers.size(); x++)
    {
      for (int y = 0; y < numbers[x].size(); y++)
      {
        if (numbers[x][y] == InNumber)
          return std::make_tuple(x, y);
      }
    }
    return std::make_tuple(-1, -1);
  }

  int SumOfUnselected() {
    int sum = 0;

    for (int x = 0; x < numbers.size(); x++)
    {
      for (int y = 0; y < numbers[x].size(); y++)
      {
        if (!selected[x][y])
          sum += numbers[x][y];
      }
    }

    return sum;
  }
};
