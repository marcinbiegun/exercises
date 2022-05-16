#include <string>
#include <vector>
#include <memory>
#include <iostream>

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
    void Add(const StructA& InStruct) {
        Elements.push_back(std::shared_ptr<VirtualStruct>(new StructA(InStruct)));
    }

    void Add(const StructB& InStruct) {
        Elements.push_back(std::shared_ptr<VirtualStruct>(new StructB(InStruct)));
    }

    void DoTheProcessing() {
        for (std::shared_ptr<VirtualStruct> Element : Elements) {
            if (Element->GetType()) {
                StructA* str = static_cast<StructA*>(Element.get());
                std::cout << "Processing A key=" << str->Key << ", val=" << str->IntData;
            }
            else {
                StructB str = *static_cast<StructB*>(Element.get());
                std::cout << "Processing B key=" << str.Key << ", val=" << str.FloatData;
            }
            std::cout << std::endl;
        }
    }

private:
    std::vector<std::shared_ptr<VirtualStruct>> Elements;
};

int main() {
    ProcessingSystem* system = new ProcessingSystem();

    StructA a1 = {std::string("a1"), 1};
    StructA a2 = {std::string("a2"), 2};
    StructA a3 = {std::string("a3"), 3};

    StructB b1 = {std::string("b1"), 0.1f};
    StructB b2 = {std::string("b2"), 0.2f};
    StructB b3 = {std::string("b3"), 0.3f};

    system->Add(a1);
    system->Add(b1);
    system->Add(a2);
    system->Add(b2);
    system->Add(a3);
    system->Add(b3);

    system->DoTheProcessing();

    return 0;
}