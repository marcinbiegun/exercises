#include <array>
#include <stdio.h>
#include <stdexcept>
#include <algorithm>
#include <tuple>
#include <string>
#include <iostream>

#include "utils.cpp"

std::tuple<int, int, int, int> parseLine(std::string InLine) {
  std::vector<std::string> coords = splitString(InLine, ' ');
  if (coords.size() != 3)
    throw std::invalid_argument("Error: invalid line");

  std::vector<std::string> startCoords = splitString(coords[0], ',');
  if (startCoords.size() != 2)
    throw std::invalid_argument("Error: invalid start coords");

  std::vector<std::string> endCoords = splitString(coords[2], ',');
  if (endCoords.size() != 2)
    throw std::invalid_argument("Error: invalid end coords");

  auto [startXOk, startX] = safeStrToInt(startCoords[0]);
  auto [startYOk, startY] = safeStrToInt(startCoords[1]);
  auto [endXOk, endX] = safeStrToInt(endCoords[0]);
  auto [endYOk, endY] = safeStrToInt(endCoords[1]);
  
  if (startXOk != true || startYOk != true || endXOk != true || endYOk != true)
    throw std::invalid_argument("Error: unable to convert to int");

  return std::make_tuple(startX, startY, endX, endY);
}

std::vector<std::tuple<int, int>> lineToPoints(int startX, int startY, int endX, int endY) {
  std::vector<std::tuple<int, int>> Points;
  Points.push_back(std::make_tuple(startX, startY));

  while (startX != endX || startY != endY) {
    if (startX < endX)
      startX++;
    if (startX > endX)
      startX--;
    if (startY < endY)
      startY++;
    if (startY > endY)
      startY--;
    Points.push_back(std::make_tuple(startX, startY));
  }

  return Points;
}

// TODO: make the size dynamic (provided in constructor)
const int VENTS_SIZE = 1000;

struct VentsBoard {
  std::array<int, VENTS_SIZE * VENTS_SIZE> values;

  VentsBoard() {
    values.fill(0);
  }

  void StoreLine(int startX, int startY, int endX, int endY) {
    std::vector<std::tuple<int, int>> Points = lineToPoints(startX, startY, endX, endY);
    for (std::tuple<int, int> Point : Points) {
      Increment(std::get<0>(Point), std::get<1>(Point));
    }
  }

  void Set(int x, int y, int value) {
    int localCoord = ConvertCoord2Dto1D(x, y);
    values[localCoord] = value;
  }

  void Increment(int x, int y) {
    Set(x, y, Get(x, y) + 1);
  }

  int Get(int x, int y) {
    int localCoord = ConvertCoord2Dto1D(x, y);
    return values[localCoord];
  }

  int ConvertCoord2Dto1D(int x, int y) {
    if (x < 0 or x >= VENTS_SIZE)
      throw std::invalid_argument("Error: invalid X coord");

    if (y < 0 or y >= VENTS_SIZE)
      throw std::invalid_argument("Error: invalid Y coord");

    return x + y * VENTS_SIZE;
  }

  void Print() {
    for (size_t i = 0; i < values.size(); i++)
    {
      if (values[i] == 0)
        std::cout << ".";
      else
        std::cout << values[i];
      if (i % VENTS_SIZE == 0)
        std::cout << "\n";
    }
  }
};

void printCoord(int startX, int startY, int endX, int endY) {
  std::cout << startX << "," << startY << " -> " << endX << "," << endY << "\n";
}
