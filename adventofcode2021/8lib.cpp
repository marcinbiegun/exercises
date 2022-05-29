#include <iostream>
#include <vector>
#include <set>
#include <unordered_map>

//
//   0:      1:      2:      3:      4:
//  aaaa    ....    aaaa    aaaa    ....
// b    c  .    c  .    c  .    c  b    c
// b    c  .    c  .    c  .    c  b    c
//  ....    ....    dddd    dddd    dddd
// e    f  .    f  e    .  .    f  .    f
// e    f  .    f  e    .  .    f  .    f
//  gggg    ....    gggg    gggg    ....
//
//   5:      6:      7:      8:      9:
//  aaaa    aaaa    aaaa    aaaa    aaaa
// b    .  b    .  .    c  b    c  b    c
// b    .  b    .  .    c  b    c  b    c
//  dddd    dddd    ....    dddd    dddd
// .    f  e    f  .    f  e    f  .    f
// .    f  e    f  .    f  e    f  .    f
//  gggg    gggg    ....    gggg    gggg
//
//
// Digits with unique bars amount:
//
// digit "1" has 2 bars
// digit "4" has 4 bars
// digit "7" has 3 bars
// digit "8" has 7 bars
// 
// Digits with non-unique bars amount:
//
// digit "2" has 5 bars
// digit "3" has 5 bars
// digit "5" has 5 bars
//
// digit "6" has 6 bars
// digit "9" has 6 bars
// digit "0" has 6 bars

using namespace std;

class Day8Solution {
public:
    static int Solve(vector<std::string> words) {
        vector<std::string> question = {words.end() - 4, words.end()};
        vector<std::string> digits = {words.begin(), words.begin() + 10};
        unordered_map<int, std::string> digitMap;
        vector<std::string> unmatched;

        // 1. Identify digits with unique bar counts
        for (string digit : digits) {
            if (digit.size() == 2)
                digitMap[1] = digit;
            else if (digit.size() == 4)
                digitMap[4] = digit;
            else if (digit.size() == 3)
                digitMap[7] = digit;
            else if (digit.size() == 7)
                digitMap[8] = digit;
            else
                unmatched.push_back(digit);
        }

        // 2. Identify "bd" bars pair (unordered)
        // (digit 4 - digit 1) gives us "bd" map but with no specific order
        string unordered_bd = subtract(digitMap[4], digitMap[1]);

        // 3. Deduct digits with 6 bars
        for (auto& digit : unmatched) {
            // 6 or 9 or 0
            if (digit.size() == 6) {
                // Includes both bards of 1, then it's 0 or 9
                if (subtract(digit, digitMap[1]).size() == 4) {
                    // Includes both parts of unorderd_bd (4-1) then it's 9
                    if (subtract(digit, unordered_bd).size() == 4)
                        digitMap[9] = digit;
                    // else it's 0
                    else
                        digitMap[0] = digit;
                // else it's 6
                } else {
                    digitMap[6] = digit;
                }
            }
        }

        // 4. Deduct "e" bar
        string onlyE = subtract(digitMap[8], digitMap[9]);
        if (onlyE.length() != 1)
            throw "it should be a single bar!";

        // 5. Deduct digits with 5 bars
        for (auto& digit : unmatched) {
            // 2 or 3 or 5
            if (digit.size() == 5) {
                // does not contain "e" then it's 3 or 5
                if (subtract(digit, onlyE).size() == 5) {
                    // if loses 3 bars by -7  then it's a 3
                    if (subtract(digit, digitMap[7]).size() == 2)
                        digitMap[3] = digit;
                    // else (loses 2) it's a 5
                    else
                        digitMap[5] = digit;
                // else it's 2
                } else
                {
                    digitMap[2] = digit;
                }
            }
        }

        // Done!
        if (digitMap.size() != 10)
            throw "we should have all digits by now!";
        
        // Prepare sorted inverted map for read
        unordered_map<std::string, int> digitMapReversed;
        for (auto i = digitMap.begin(); i != digitMap.end(); i++) {
            string letters = i->second;
            sort(letters.begin(), letters.end());
            digitMapReversed[letters] = i->first;
        }

        int result = 0;
        for (string q : question) {
            std::sort(q.begin(), q.end());
            int digit = digitMapReversed[q];
            // builtd integer result
            result *= 10;
            result += digit;
        }

        return result;
    }

    static string invert(const string& a) {
        set<char> aChars{};
        for (const char& c : a)
            aChars.insert(c);

        vector<char> allChars{'a', 'b', 'c', 'd', 'e', 'f', 'g'};

        string result = "";
        for (const char& c : allChars) {
            if (aChars.count(c) == 0)
                result.push_back(c);
        }

        return result;
    }

    static string subtract(const string& a, const string& b) {
        set<char> bChars{};
        for (const char& c : b)
            bChars.insert(c);

        string result = "";
        for (const char& c : a) {
            if (bChars.count(c) == 0)
                result.push_back(c);
        }
        return result;
    }
    
};
