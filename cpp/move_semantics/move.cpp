#include <iostream>
#include <utility>

// tutorial: https://app.pluralsight.com/course-player?clipId=cb53713c-26d3-4c14-93cb-982d6a5adcf4

class Resource {
    std::string name;

public:

    Resource(std::string inName = "empty");
    Resource(Resource& r);
    Resource(Resource&& r);
    Resource& operator=(Resource&& r);
};

Resource::Resource(std::string inName) {
    name = inName;
    std::cout << "Used normal constructor\n";
}

Resource::Resource(Resource& r) : name{r.name} {
    std::cout << "Used copy constructor\n";
}

Resource::Resource(Resource&& r) : name{std::move(r.name)} {
    std::cout << "Used move constructor\n";
}

Resource& Resource::operator=(Resource&& r) {
    // Safe check to not break on moving from self
    if (this != &r) {
        name = std::move(r.name);

        // Not needed
        r.name.clear();
        std::cout << "Used move assignment\n";
    }
    return *this;
}

std::string generateLongString() {
    return "";
}


int main() {
    Resource r1 ("Resource1");
    Resource r2(r1);

    return 0;
}
