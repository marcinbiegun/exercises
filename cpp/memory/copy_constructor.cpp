#include <cstring>

class ArrayWrapperCopy
{
public:
    void *data;
    unsigned int allocationSize;

public:
    ArrayWrapperCopy(unsigned int size) : allocationSize(size), data(size > 0 ? new float[size] : nullptr) {}

    virtual ~ArrayWrapperCopy()
    {
        delete [] data;
    }

    ArrayWrapperCopy(const ArrayWrapperCopy &other) : allocationSize(other.allocationSize), data(new float[allocationSize])
    {
        std::memcpy(data, other.data, allocationSize);
    }
};

class ArrayWrapperMove : public ArrayWrapperCopy
{
public:
    ArrayWrapperMove(unsigned int size) : ArrayWrapperCopy(size) {}

    ArrayWrapperMove(ArrayWrapperMove &&other) : ArrayWrapperCopy(0)
    {
        allocationSize = other.allocationSize;
        data = other.data;
        other.data = nullptr;
        other.allocationSize = 0;
    }

}

typedef ArrayWrapperCopy ArrayWrapper;

ArrayWrapper ProcessArray(const ArrayWrapper &arg)
{
    ArrayWrapper localCopy(arg);
    // process localCopy
    return localCopy;
}


void Process()
{
    ArrayWrapper dataArray(1024);
    // generate data in dataArray

    ArrayWrapper processedArray(ProcessArray(dataArray));
    ArrayWrapper twiceProcessedArray(ProcessArray(processedArray));

    // do some other stuff with the processed data
}

int main() {
    return 0;
}