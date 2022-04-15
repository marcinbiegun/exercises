#include <sstream>
#include <string>
#include <iostream>
#include <fstream>
#include <vector>
#include <tuple>
#include <cmath>

/**
 * Returns textfile lines content as vector<string>
 */
std::vector<std::string> getInputLines(std::string filePath)
{
  std::ifstream inputFile(filePath);

  // Read file
  std::stringstream buffer;
  buffer << inputFile.rdbuf();

  // Split input lines
  std::vector<std::string> strings;
  std::string s;
  while (getline(buffer, s, '\n'))
  {
    strings.push_back(s);
  }
  return strings;
}

std::string getInputString(std::string filePath) {
  std::ifstream inputFile(filePath);

  // Read file
  std::stringstream buffer;
  buffer << inputFile.rdbuf();

  return buffer.str();
}

std::tuple<bool, int> safeStrToInt(std::string str)
{
  std::tuple<bool, int> errResponse = std::make_tuple(false, 0);

  if (str.length() < 1)
    return errResponse;

  try
  {
    return std::make_tuple(true, std::stoi(str));
  }
  catch (std::invalid_argument &e)
  {
    return errResponse;
  }
  return errResponse;
}

/**
 * Converts strings to integers, skips if unable to convert an element.
 */
std::vector<int> stringsToInts(std::vector<std::string> lines)
{
  std::vector<int> integers;

  for (std::string line : lines)
  {
    if (line.length() < 1)
      continue;
    try
    {
      int integer = stoi(line);
      integers.push_back(integer);
    }
    catch (std::invalid_argument &e)
    {
    }
  }

  return integers;

}

// Taken from: https://stackoverflow.com/questions/68396962/how-to-split-strings-in-c-like-in-python
std::vector<std::string> splitString(std::string str, char splitter)
{
  std::vector<std::string> result;
  std::string current = "";
  for (int i = 0; i < str.size(); i++)
  {
    if (str[i] == splitter)
    {
      if (current != "")
      {
        result.push_back(current);
        current = "";
      }
      continue;
    }
    current += str[i];
  }
  if (current.size() != 0)
    result.push_back(current);
  return result;
}

int intPow(int b, int e)
{
    return (e == 0) ? 1 : b * intPow(b, e - 1);
}

int binaryToInt(std::vector<bool> binary)
{
  int result = 0;
  int binarySize = binary.size();

  for (int i = 0; i < binarySize; i++)
  {
    if (binary[i] == true)
      result += intPow(2, binarySize - 1 - i);
  }

  return result;
}