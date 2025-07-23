set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
cmake_minimum_required(VERSION 3.15)
project(advent_of_code C)

# Options to pick year, day, and part
set(YEAR 2022 CACHE STRING "Year of Advent of Code")
set(DAY 01 CACHE STRING "Day of Advent of Code")
set(PART 1 CACHE STRING "Part of the day's problem")

# Build paths dynamically
set(SOURCE_DIR "${CMAKE_SOURCE_DIR}/${YEAR}/${DAY}")
set(PART_SRC "${SOURCE_DIR}/part${PART}.c")


file(READ "${SOURCE_DIR}/language.txt" LANGUAGE_RAW)
string(STRIP "${LANGUAGE_RAW}" LANGUAGE)  # Trim whitespace

if(NOT LANGUAGE STREQUAL "C")
  message(FATAL_ERROR "Selected problem (year=${YEAR} day=${DAY} part=${PART}) is written in '${LANGUAGE}', not C. Build aborted.")
endif()
# Include directories for reusable modules
include_directories(${CMAKE_SOURCE_DIR}/include)

# Source files for utils
file(GLOB UTILS_SRC "${CMAKE_SOURCE_DIR}/src/*.c")

# Executable name
set(EXE_NAME "aoc_${YEAR}_${DAY}_part${PART}")

# Add executable with selected source files
add_executable(${EXE_NAME} ${PART_SRC} ${UTILS_SRC})


target_include_directories(${EXE_NAME} PRIVATE "${CMAKE_SOURCE_DIR}/include")


# Optionally, you can add flags here
target_compile_options(${EXE_NAME} PRIVATE -Wall -Wextra -O2)

message(STATUS "Configuring for year=${YEAR}, day=${DAY}, part=${PART}")
message(STATUS "Building target: ${EXE_NAME}")

