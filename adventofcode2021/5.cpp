#include <vector>
#include <iostream>

#include "5lib.cpp"

int main()
{
  std::vector<std::string> lines = getInputLines("5input.txt");
  std::cout << "input lines: " << lines.size() << "\n";

  VentsBoard Board = VentsBoard();
  int skippedLines = 0;

  for (auto line : lines) {
    const auto [startX, startY, endX, endY] = parseLine(line);

    if (startX == endX || startY == endY)
      Board.StoreLine(startX, startY, endX, endY);
    else
      skippedLines++;
  }

  std::cout << "Skipped lines: " << skippedLines << "\n";

  int countValuesAboveOne = 0;
  for (int val : Board.values) {
    if (val > 1)
      countValuesAboveOne++;
  }
  
  // Board.Print();

  // 7414
  std::cout << "Count of fields with value above 1 is: " << countValuesAboveOne << "\n";

  return 0;
}