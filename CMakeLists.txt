cmake_minimum_required(VERSION 3.10)
project(SchoolCompilerProject)

find_package(FLEX REQUIRED)

include_directories(include)

# Generate scanner.c from scanner.l
FLEX_TARGET(Scanner src/scanner.l ${CMAKE_CURRENT_BINARY_DIR}/scanner.cpp)

# Add the executable
add_executable(compile
        ${FLEX_Scanner_OUTPUTS}
        src/listing.cc
)

# Link includes
target_include_directories(compile PRIVATE include)
