#include <vector>
#include <iostream>

#include "4lib.cpp"

int main()
{
  std::ifstream inputFile("4input.txt");

  // Read file
  std::stringstream buffer;
  buffer << inputFile.rdbuf();

  // Split input lines
  std::vector<std::string> strings;
  std::string s;


  std::string InputNumbersLine;
  bool InputLoaded = false;
  int BingoLines = 0;
  std::string BingoStr;
  std::vector<Bingo> bingos;

  std::cout << "Starting\n";

  while (getline(buffer, s, '\n'))
  {
    if (!InputLoaded) {
      InputNumbersLine = s;
      InputLoaded = true;
      std::cout << "Set input numbers to " << s << "\n";
    } else {
      // Reset bingo input
      if (s == std::string("")) {
        if (BingoLines > 0) {
          // std::cout << "Saving Bingo\n";
          // std::cout << BingoStr;
          // std::cout << "\n";
          Bingo newBingo = Bingo(BingoStr);
          bingos.push_back(newBingo);
          BingoStr.clear();
          BingoLines = 0;
          continue;
        }
        // std::cout << "Not Saving Bingo (0 lines)\n";
        BingoStr.clear();
        BingoLines = 0;
      }
      // Bingo input
      else {
        // std::cout << "Adding to Bingo...\n";
        BingoLines++;
        BingoStr.append(s);
        BingoStr.append("\n");
      }
    }
  }

  // Parse numbers
  std::vector<std::string> InputNumberStrings = splitString(InputNumbersLine, ',');
  std::vector<int> InputNumbers;
  for (std::string& str : InputNumberStrings) {
    std::tuple<bool, int> parsed = safeStrToInt(str);
    if (std::get<0>(parsed))
      InputNumbers.push_back(std::get<1>(parsed));
  }

  std::cout << "Done.\n";
  std::cout << "Loaded bingos: " << bingos.size() << "\n";

  // Now simulate the game
  int counter = 0;

  // For each number
  for (int number : InputNumbers) {
    std::cout << "Selecting number " << counter << "/" << InputNumbers.size() << "\n";

    // For each bingo
    for (Bingo& bingo : bingos) {

      // Select and check win condition
      bingo.SelectNumber(number);
      if (bingo.IsWon()) {
        std::cout << "FOUND A WINNER!" << "\n";
        int finalResult = bingo.SumOfUnselected() * number;
        std::cout << "The final result is: " << finalResult << "\n";
        return 0;
      }
    }
    counter++;
  }

  std::cout << "No winner found :(" << "\n";
  return 0;
}