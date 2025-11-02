cmake_minimum_required(VERSION 3.10)
project(Compiler_project)

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

include_directories(include)

# Generate scanner.cpp from scanner.l
FLEX_TARGET(Scanner src/scanner.l ${CMAKE_CURRENT_BINARY_DIR}/scanner.cpp)

# Generate parser.cpp and tokens.h from parser.y
BISON_TARGET(Parser src/parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.cpp
        DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/tokens.h)

# Combine Flex and Bison
ADD_FLEX_BISON_DEPENDENCY(Scanner Parser)

# Add the executable
add_executable(compile
        ${FLEX_Scanner_OUTPUTS}
        ${BISON_Parser_OUTPUTS}
        src/listing.cc
)

# Link includes
target_include_directories(compile PRIVATE
        include
        ${CMAKE_CURRENT_BINARY_DIR}  # for tokens.h
)
