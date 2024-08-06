# Create a library
add_library(foo)
# Add the module file to the library
target_sources(foo
  PUBLIC
    FILE_SET CXX_MODULES FILES
      foo/foo.cppm
)