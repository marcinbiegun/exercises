#include <vector>
#include <iostream>

#include "utils.cpp"
#include "3lib.cpp"

int main()
{
  std::vector<std::string> lines = getInputLines("3input.txt");
  int bitsCount = lines[0].size();
  std::cout << "bistCount: " << bitsCount << "\n";

  // Fill shits
  // int shifts[bitsCount];
  std::vector<int> shifts(bitsCount, 0);
  for (int i = 0; i < lines.size(); i++) {
    processLine(lines[i], shifts);
  }

  // Negative shift means 0 is most common bit, while positive means 1 is most common
  std::vector<bool> shiftsBinary(bitsCount, 0);
  std::vector<bool> shiftsBinaryInverted(bitsCount, 0);
  for (int i = 0; i < shifts.size(); i++)
  {
    if (shifts[i] < 0)
    {
      std::cout << "0";
      shiftsBinary[i] = false;
      shiftsBinaryInverted[i] = true;
    }
    else if (shifts[i] > 0)
    {
      std::cout << "1";
      shiftsBinary[i] = true;
      shiftsBinaryInverted[i] = false;
    }
    else
    {
      throw std::invalid_argument("shift should always be negative or positive, not zero!");
    }
  }
  std::cout << "\n";

  int gamma = binaryToInt(shiftsBinary);
  int epsilon = binaryToInt(shiftsBinaryInverted);

  std::cout << "gamma: " << gamma << "\n";
  std::cout << "epsilon: " << epsilon << "\n";
  std::cout << "gamma * epsilon: " << gamma * epsilon << "\n";

  return 0;
}