#include <string>
#include <vector>
#include <memory>
#include <iostream>

enum PossibleTypes {
  INT,
  FLOAT
};

struct UnionStruct {
    std::string Key;
    PossibleTypes ValueType;

    union {
        int IntValue;
        float FloatValue;
    };

    PossibleTypes GetType() {
        return ValueType;
    }

    UnionStruct(std::string InKey, int InIntValue) {
        Key = InKey;
        IntValue = InIntValue;
        ValueType = PossibleTypes::INT;
    }

    UnionStruct(std::string InKey, float InFloatValue) {
        Key = InKey;
        FloatValue = InFloatValue;
        ValueType = PossibleTypes::FLOAT;
    }
};

struct VirtualStruct {
    virtual bool GetType() const = 0;
};

struct StructA : public VirtualStruct {
    std::string Key;
    int IntData;

    StructA(std::string InKey, int InIntData) {
        Key = InKey;
        IntData = InIntData;
    }

    virtual bool GetType() const override {
        return true;
    }
};


struct StructB : public VirtualStruct {
    std::string Key;
    float FloatData;

    StructB(std::string InKey, float InFloatData) {
        Key = InKey;
        FloatData = InFloatData;
    }

    virtual bool GetType() const override {
        return false;
    }
};

class ProcessingSystem {
public:
    void Add(const UnionStruct& InUnionStruct) {
        Elements.push_back(std::shared_ptr<UnionStruct>(new UnionStruct(InUnionStruct)));
    }

    void DoTheProcessing() {
        for (std::shared_ptr<UnionStruct> Element : Elements) {
            switch (Element->GetType()) {
                case PossibleTypes::INT:
                 std::cout << "Processing A key=" << Element->Key << ", val=" << Element->IntValue;
                 break;
                case PossibleTypes::FLOAT:
                 std::cout << "Processing A key=" << Element->Key << ", val=" << Element->FloatValue;
                 break;
            };
            std::cout << std::endl;
        }
    }

private:
    std::vector<std::shared_ptr<UnionStruct>> Elements;
};

int main() {
    ProcessingSystem* system = new ProcessingSystem();

    UnionStruct a1 = {std::string("a1"), 1};
    UnionStruct a2 = {std::string("a2"), 2};
    UnionStruct a3 = {std::string("a3"), 3};
    UnionStruct b1 = {std::string("b1"), 0.1f};
    UnionStruct b2 = {std::string("b2"), 0.2f};
    UnionStruct b3 = {std::string("b3"), 0.3f};

    system->Add(a1);
    system->Add(b1);
    system->Add(a2);
    system->Add(b2);
    system->Add(a3);
    system->Add(b3);

    system->DoTheProcessing();

    return 0;
}