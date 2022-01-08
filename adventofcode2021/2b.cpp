#include <sstream>
#include <iostream>
#include <fstream>
#include <vector>
#include <tuple>

using namespace std;

/**
 * UTILS
 */

/**
 * Returns textfile lines content as vector<string>
 */
vector<string> getInputLines(string filePath)
{
  ifstream inputFile(filePath);

  // Read file
  stringstream buffer;
  buffer << inputFile.rdbuf();

  // Split input lines
  vector<string> strings;
  string s;
  while (getline(buffer, s, '\n'))
  {
    strings.push_back(s);
  }
  return strings;
}

tuple<bool, int> safeStrToInt(string str)
{
  tuple<bool, int> errResponse = make_tuple(false, 0);

  if (str.length() < 1)
    return errResponse;

  try
  {
    return make_tuple(true, stoi(str));
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
vector<int> stringsToInts(vector<string> lines)
{
  vector<int> integers;

  for (string line : lines)
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
vector<string> splitString(string str, char splitter)
{
  vector<string> result;
  string current = "";
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

/**
 * END OF UTILS
 */

enum Direction
{
  Forward,
  Down,
  Up
};

struct DataPoint
{
  Direction dir;
  int amount;
};

struct Position
{
  int horizontal = 0;
  int depth = 0;
  int aim = 0;
};

tuple<bool, DataPoint> readDataPoint(string line)
{
  DataPoint data;
  vector<string> parts = splitString(line, ' ');
  auto errResponse = make_tuple(false, data);

  // Bad line
  if (parts.size() < 2)
  {
    cout << "Unble to read line: " << line << endl;
    return errResponse;
  }

  // Read Direction
  string directionStr = parts[0];
  if (directionStr == "forward")
  {
    data.dir = Direction::Forward;
  }
  else if (directionStr == "up")
  {
    data.dir = Direction::Up;
  }
  else if (directionStr == "down")
  {
    data.dir = Direction::Down;
  }
  else
  {
    cout << "Unble to read direction: " << directionStr << endl;
    return errResponse;
  }

  // Read Amount
  tuple<bool, int> amountInt = safeStrToInt(parts[1]);
  if (!get<0>(amountInt))
  {
    cout << "Unable to read integer: " << parts[1] << endl;
    return errResponse;
  }

  data.amount = get<1>(amountInt);

  return make_tuple(true, data);
}

void updatePosition(Position &pos, DataPoint &data)
{
  switch (data.dir)
  {
  case Direction::Forward:
    pos.horizontal += data.amount;
    pos.depth += pos.aim * data.amount;
    break;
  case Direction::Up:
    pos.aim -= data.amount;
    break;
  case Direction::Down:
    pos.aim += data.amount;
    break;
  default:
    cout << "Unknown direction: " << data.dir << endl;
  }
}

int main()
{
  vector<string> lines = getInputLines("2input.txt");
  cout << "Input lines count: " << lines.size() << endl;

  Position pos;

  for (int i = 0; i < lines.size(); i++)
  {
    tuple<bool, DataPoint> dataTuple = readDataPoint(lines[i]);

    // Bad line
    if (!get<0>(dataTuple))
    {
      cout << "Skipped line due to errors:: " << lines[i] << endl;
      continue;
    }

    DataPoint data = get<1>(dataTuple);
    updatePosition(pos, data);
  }

  cout << "Final horizontal position: " << pos.horizontal << endl;
  cout << "Final depth position: " << pos.depth << endl;
  cout << "Multiplication result: " << pos.depth * pos.horizontal << endl;

  return 0;
}
