find_package(ut REQUIRED)
add_executable(test test.cpp)
target_link_libraries(test Boost::ut foo)