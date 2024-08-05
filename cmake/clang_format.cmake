find_program(CLANG_FORMAT_BIN NAMES clang-format)

if(CLANG_FORMAT_BIN)
  message(STATUS "Found: clang-format")
  file(GLOB_RECURSE CPP_FILES *.h *.hpp *.cpp *.cc *.cxx *.cppm *.ixx *.cxxm *.c++m *.ccm)

  add_custom_target(
    format
    COMMENT "Running clang-format to format all files..."
    COMMAND clang-format -i ${CPP_FILES})
endif()