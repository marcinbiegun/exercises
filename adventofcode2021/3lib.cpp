#include <vector>
#include <string>

void processLine(std::string line, std::vector<int>& outShifts) {
  for (int i = 0; i < line.size(); i++)
  {
    if (line[i] == '0') {
      outShifts[i] = outShifts[i] - 1;
    }
    else if (line[i] == '1') 
    {
      outShifts[i] = outShifts[i] + 1;
    }
  }
}
