#include <vector>
#include <iostream>

#include "utils.cpp"
#include "3lib.cpp"

int main()
{
  std::vector<std::string> lines = getInputLines("3input.txt");
  int bitsCount = lines[0].size();
  std::cout << "bitsCount: " << bitsCount << "\n";

  std::vector<std::vector<bool>> linesBinary;
  for (int i = 0; i < lines.size(); i++) {
    linesBinary.push_back(readBinaryLine(lines[i]));
  }

  std::vector<bool> oxygenLastNumber = scanAndReduce(linesBinary, 1);
  std::cout << "Oxygen last number = ";
  printBinaryLine(oxygenLastNumber);
  int oxygen = binaryToInt(oxygenLastNumber);
  std::cout << "Oxygen = " << oxygen << "\n";

  std::vector<bool> co2LastNumber = scanAndReduce(linesBinary, 0);
  std::cout << "CO2 last number = ";
  printBinaryLine(co2LastNumber);
  int co2 = binaryToInt(co2LastNumber);
  std::cout << "CO2 = " << co2 << "\n";

  std::cout << "Oxygen * CO2 = " << oxygen * co2 << "\n";

  return 0;
}