#include <vector>
#include <iostream>

#include "5lib.cpp"

int main()
{
  std::vector<std::string> lines = getInputLines("5input.txt");
  std::cout << "input lines: " << lines.size() << "\n";

  VentsBoard Board = VentsBoard();
  int horizontalAndVerticalLines = 0;
  int diagonalLines = 0;
  int skippedLines = 0;

  for (auto line : lines) {
    const auto [startX, startY, endX, endY] = parseLine(line);

    if (startX == endX || startY == endY) {
      horizontalAndVerticalLines++;
      // std::cout << "Hor/Vert: ";
      // printCoord(startX, startY, endX, endY);
      Board.StoreLine(startX, startY, endX, endY);
    } else if (std::abs(endX - startX) == std::abs(endY - startY)) {
      diagonalLines++;
      // std::cout << "Diagonal: ";
      // printCoord(startX, startY, endX, endY);
      Board.StoreLine(startX, startY, endX, endY);
    } else {
      // std::cout << "Skipped: ";
      // printCoord(startX, startY, endX, endY);
      skippedLines++;
    }
  }

  std::cout << "Diagonal lines: " << diagonalLines << "\n";
  std::cout << "Hor/Vert lines: " << horizontalAndVerticalLines << "\n";
  std::cout << "Skipped lines: " << skippedLines << "\n";

  int countValuesAboveOne = 0;
  for (int val : Board.values) {
    if (val > 1)
      countValuesAboveOne++;
  }
  
  // Board.Print();

  // 19676
  std::cout << "Count of fields with value above 1 is: " << countValuesAboveOne << "\n";

  return 0;
}