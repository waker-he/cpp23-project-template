#include <boost/ut.hpp>
import std;
import foo;

int
main()
{
    using namespace boost::ut;

    "foo"_test = [] {
        Foo f;
        expect(f.size() == 1_i);
        expect(f.size() == 2_i);
    };
}