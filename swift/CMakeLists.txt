cmake_minimum_required(VERSION 3.21.0)

# Project name and version
project(SwiftLibrary VERSION 1.0 LANGUAGES NONE)


if (NOT DEFINED SWIFT_TOOLCHAIN OR NOT EXISTS "${SWIFT_TOOLCHAIN}")
    file(GLOB TOOLCHAINS "/Library/Developer/Toolchains/*" "$ENV{HOME}/Library/Developer/Toolchains/*")
    # Filter out non-directories (just in case)
    list(FILTER TOOLCHAINS INCLUDE REGEX ".*\\.xctoolchain$")

    # Print found toolchains
    message(STATUS "Available Swift Toolchains:")
    foreach(TOOLCHAIN ${TOOLCHAINS})
        message(STATUS " - ${TOOLCHAIN}")
    endforeach()

    message(FATAL_ERROR "Error: SWIFT_TOOLCHAIN is not set or does not exist. Please set it before running CMake.\nExample: cmake -DSWIFT_TOOLCHAIN=/path/to/toolchain ..")
endif()

# Set the Swift compiler path
set(SWIFT_COMPILER "${SWIFT_TOOLCHAIN}/usr/bin/swiftc")
set(AR_COMPILER "${SWIFT_TOOLCHAIN}/usr/bin/llvm-ar")


# Specify the source file

set(SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/hello.swift"
"${CMAKE_CURRENT_SOURCE_DIR}/add.swift")
set(OUTPUT_FILE "${CMAKE_BINARY_DIR}/out.o")

set(LIBRARY_NAME "hello")
set(STATIC_LIB "${CMAKE_BINARY_DIR}/lib${LIBRARY_NAME}.a")

# Set compiler flags
set(SWIFT_FLAGS
    -Osize
    -Xcc -fdeclspec
    -parse-as-library
    -target wasm32-unknown-none-wasm
    -enable-experimental-feature Extern
    -enable-experimental-feature Embedded
    -wmo
)

# Add a custom command to build the object file
add_custom_command(
    OUTPUT ${OUTPUT_FILE}
    COMMAND ${SWIFT_COMPILER} ${SWIFT_FLAGS} -c ${SOURCES} -o ${OUTPUT_FILE}
    DEPENDS ${SOURCES}
    COMMENT "Compiling ${SOURCES} to WebAssembly object file"
    VERBATIM
)

# Create a static library from the object file
add_custom_command(
    OUTPUT ${STATIC_LIB}
    COMMAND ${AR_COMPILER} rcs ${STATIC_LIB} ${OUTPUT_FILE}
    DEPENDS ${OUTPUT_FILE}
    COMMENT "Creating static library ${STATIC_LIB}"
    VERBATIM
)


add_library(${LIBRARY_NAME} STATIC IMPORTED)
set_target_properties(${LIBRARY_NAME} PROPERTIES IMPORTED_LOCATION ${STATIC_LIB})

# Define the build target for the static library
add_custom_target(${PROJECT_NAME} ALL
    DEPENDS ${STATIC_LIB}
    COMMENT "Building static Swift library ${STATIC_LIB}"
)
