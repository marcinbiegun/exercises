#include <sstream>
#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

/**
 * Returns textfile lines content as vector<string>
 */
vector<string> getInputLines() {
  ifstream inputFile("1input.txt");

  // Read file
  stringstream buffer;
  buffer << inputFile.rdbuf();

  // Split input lines
  vector<string> strings;
  string s;
  while (getline(buffer, s, '\n')) {
    strings.push_back(s);
  }
  return strings;
}

/**
 * Converts strings to integers, skips if unable to convert an element.
 */
vector<int> stringsToInts(vector<string> lines) {
  vector<int> integers;

  for (string line : lines) {
    if (line.length() < 1)
      continue;
    try {
      int integer = stoi(line);
      integers.push_back(integer);
    }
    catch (std::invalid_argument& e) {
    }
  }

  return integers;
}

int main() {
    vector<string> lines = getInputLines();
    cout << "Input lines: " << lines.size() << endl;
    vector<int> ints = stringsToInts(lines);

    int value_inc_counter = 0;
    for (int i = 1; i < ints.size(); i++) {
      int prev_measurement = ints[i-1];
      int this_measurement = ints[i];

      // cout << "this measurement: " << this_measurement << endl;
      if (this_measurement > prev_measurement)
        value_inc_counter++;
    }

    cout << "Values inreased times: " << value_inc_counter<< endl;

    return 0;
}

