# cpp23-project-template
C++23 Project Template with CMake 3.30 to support C++20 modules and C++23 `import std`

- [Requirements](#requirements)
- [Build Commands](#build-commands)
- [Suggested Project Structure](#suggested-project-structure)
- [Using clang++ and libc++](#use-clang-and-libc)
- [References](#references)

## Requirements

- C++23
- Clang/LLVM 19.1.0
    - Clang/LLVM 18 does not install module-related files by default: https://gitlab.kitware.com/cmake/cmake/-/issues/25965#note_1523575
- CMake 3.30
- Ninja 1.11 (used as CMake generator)
- Linux

## Build Commands

```sh
mkdir build
cd build
cmake .. # add -G ninja if not set to default
cmake --build .
```

## Suggested Project Structure

```
project_root/
│
├── module/                      # Modules directory
│   ├── <MODULE_NAME>/           # Specific module
│   │   ├── <MODULE_NAME>.cppm   # Module primary interface unit
│   │   ├── submodule1/          # First submodule directory
│   │   │   └── ...              # submodule1 related module partition units
│   │   ├── submodule2/
│   │   │   └── ...
│   │   └── ...
│   ├── common/                  # Common utilities used across modules
│   └── ...                      # Other Modules
│
├── test/                        # Test code for modules
│   └── ...
│
├── docs/                        # Documentation
│   └── ...
│
├── build/                       # Build scripts and configurations
│   └── ...
│
└── main.cpp                     # Main application entry point, if applicable
```

## Use clang++ and libc++

- Build clang++ and libc++ from LLVM
    ```sh
    wget https://github.com/llvm/llvm-project/releases/download/llvmorg-19.1.0-rc1/llvm-project-19.1.0-rc1.src.tar.xz
    tar xf llvm-project-19.1.0-rc1.src.tar.xz
    cd llvm-project-19.1.0-rc1.src
    mkdir build
    cd build
    cmake -DLLVM_ENABLE_PROJECTS="clang" \
        -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
        -DCMAKE_BUILD_TYPE=Release \
        -DLLVM_TARGETS_TO_BUILD="X86" \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        ../llvm
    make -jN    # replace N with number of CPU cores you want to use for the build
    sudo make install
    sudo ldconfig
    ```
    - add following to `~/.bashrc`:
        ```sh
        export PATH=/usr/local/bin:$PATH
        export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
        export LD_LIBRARY_PATH=/usr/local/lib/x86_64-unknown-linux-gnu:$LD_LIBRARY_PATH
        ```
- install pre-built binaries (when clang 19 binaries are released)
    ```sh
    wget https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.8/clang+llvm-18.1.8-x86_64-linux-gnu-ubuntu-18.04.tar.xz
    tar -xvf clang+llvm-18.1.8-x86_64-linux-gnu-ubuntu-18.04.tar.xz
    sudo mv clang+llvm-18.1.8-x86_64-linux-gnu-ubuntu-18.04 /opt/clang-18.1.8
    echo 'export PATH=/opt/clang-18.1.8/bin:$PATH' >> ~/.bashrc
    echo 'export LD_LIBRARY_PATH=/opt/clang-18.1.8/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
    source ~/.bashrc
    clang++ --version
    ```
    - If getting error:
        ```
        clang++: error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory
        ```
        - then run:
        ```sh
        sudo apt-get update
        sudo apt-get install libtinfo5
        ```
    - If getting error:
        ```
        ./a: error while loading shared libraries: libc++abi.so.1: cannot open shared object file: No such file or directory
        ```
        - then run:
            ```sh
            echo 'export LD_LIBRARY_PATH=/opt/clang-18.1.8/lib/x86_64-unknown-linux-gnu::$LD_LIBRARY_PATH' >> ~/.bashrc
            ```

## References

- [import CMake; the Experiment is Over!](https://www.kitware.com/import-cmake-the-experiment-is-over/)
- [import std in CMake 3.30](https://www.kitware.com/import-std-in-cmake-3-30/#11901aae-49be-4b00-868a-09413f3de1e9-link)
- https://github.com/cpm-cmake/CPM.cmake
