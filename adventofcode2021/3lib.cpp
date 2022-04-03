#include <vector>
#include <string>
#include <iostream>

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

std::vector<bool> readBinaryLine(std::string line) {
  std::vector<bool> binaryLine(line.size());

  for (int i = 0; i < line.size(); i++)
  {
    if (line[i] == '0') {
      binaryLine[i] = 0;
    }
    else if (line[i] == '1') 
    {
      binaryLine[i] = 1;
    }
    else {
      throw std::invalid_argument("Got a non-binary character");
    }
  }

  return binaryLine;
}

bool findBitToKeep(std::vector<std::vector<bool>> rows, bool bitCriteria, int currentColumn) {
  int deviation = 0;

  for (int i = 0; i < rows.size(); i++) {
    if (rows[i][currentColumn])
      deviation++;
    else
      deviation--;
  }

  // Find most common (or equal)
  if (bitCriteria) {
    if (deviation == 0)
      return 1;
    // 1 is most common, so keep 1
    if (deviation > 0)
      return 1;
    // 0 is most common, so keep 0
    if (deviation < 0)
      return 0;
  }
  // Find most uncommon (or equal)
  else
  {
    if (deviation == 0)
      return 0;
    // 1 is most common, so keep 0
    if (deviation > 0)
      return 0;
    // 0 is most common, so keep 1 most UNcommon
    if (deviation < 0)
      return 1;
  }
}

std::vector<std::vector<bool>> dropRows(std::vector<std::vector<bool>> rows, bool bitToKeep, int currentColumn) {
  std::vector<std::vector<bool>> newRows;

  for (int i = 0; i < rows.size(); i++) {
    if (rows[i][currentColumn] == bitToKeep)
      newRows.push_back(rows[i]);
  }

  return newRows;
}

void printBinaryLine(std::vector<bool> row) {
  for (int i = 0; i < row.size(); i++) {
    std::cout << (row[i] == true ? 1 : 0);
  }
  std::cout << "\n";
}

void printBinaryLines(std::vector<std::vector<bool>> rows) {
  for (int i = 0; i < rows.size(); i++) {
    printBinaryLine(rows[i]);
  }
}

std::vector<bool> scanAndReduce(std::vector<std::vector<bool>> rows, bool bitCriteria, int currentColumn = 0) {
  // 1. Check if can return result
  if (rows.size() == 0)
      throw std::invalid_argument("Removed all rows!");
  if (rows.size() == 1)
      return rows[0];

  // Correct counter
  if (currentColumn >= rows[0].size())
    currentColumn = 0;

  // 2. Find most common bit
  bool bitToKeep = findBitToKeep(rows, bitCriteria, currentColumn);

  // Debug output
  //
  // std::cout << "scanAndReduce with rows left: " << rows.size() << "\n";
  // std::cout << "  ---------------- " << currentColumn << "\n";
  // printBinaryLines(rows);
  // std::cout << "  bitCriteria: " << bitCriteria << "\n";
  // std::cout << "  currentColumn: " << currentColumn << "\n";
  // std::cout << "  bitToKeep: " << (bitToKeep == true ? 1 : 0) << "\n";

  // 3. Remove numbers
  std::vector<std::vector<bool>> newRows = dropRows(rows, bitToKeep, currentColumn);

  // 4. Call again
  return scanAndReduce(newRows, bitCriteria, currentColumn +1);
}
