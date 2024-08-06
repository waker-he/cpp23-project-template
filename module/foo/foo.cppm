export module foo;

import std;

export struct Foo
{
    int size()
    {
        return 1;
    }

    void
    helloworld()
    {
        std::println("Hello World!");
    }
};