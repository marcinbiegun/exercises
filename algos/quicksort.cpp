#include <iostream>
#include <vector>

// Based on this explanation: https://www.youtube.com/watch?v=7h1s2SojIRw

void swap(std::vector<int>& numbers, int a, int b) {
    int tmp = numbers[a];
    numbers[a] = numbers[b];
    numbers[b] = tmp;
}

int partition(std::vector<int>& numbers, int low, int high)  {
    int pivot = low;
    int pivot_value = numbers[pivot];

    int i = low;
    int j = high + 1;

    do {
        // Move from left to right, looking for numbers > pivot_value
        do {
            i++;
        } while (numbers[i] < pivot_value && i <= high);

        // Move from right to left, looking for numbers < pivot_value
        do {
            j--;
        } while (numbers[j] > pivot_value);

        // Swap numbers
        if (i < j) {
            swap(numbers, i, j);
        }

    } while (i < j);

    // Now we can put the pivot in the right (sorted) position
    numbers[pivot] = numbers[j];
    numbers[j] = pivot_value;

    return j;

}

void quicksort(std::vector<int>& numbers, int low, int high) {
    if (low < high) {
        int p = partition(numbers, low, high);
        quicksort(numbers, low, p-1);
        quicksort(numbers, p+1, high);
    }
}

int main() {
    std::vector<int> numbers = {3,6,1,7,4,5,6,9,8,7,9,1,0,3,4,7,6,5,4,3,1};

    std::cout << "Input:  ";
    for (int number : numbers)
        std::cout << number << ", ";
    std::cout << "\n";

    quicksort(numbers, 0, numbers.size() - 1);

    std::cout << "Sorted: ";
    for (int number : numbers)
        std::cout << number << ", ";
    std::cout << "\n";

    return 0;
}
