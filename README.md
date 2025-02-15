# Swift + WebAssembly Integration Example

This project demonstrates how to integrate Swift code compiled to WebAssembly with a C++ application using Emscripten.

## Prerequisites

- Emscripten SDK
- Swift Toolchain (swift-6.0.3-RELEASE)
- CMake (3.21.0 or higher)

## Project Structure

```
emsdk_swift/
├── CMakeLists.txt        # Main CMake configuration
├── swift/               
│   ├── CMakeLists.txt    # Swift library CMake configuration
│   └── hello.swift       # Swift source code
└── src/
    └── main.cpp          # C++ application source
```

## Setup Instructions

1. Install Swift Toolchain:
   ```bash
   # Download and install swift-6.0.3-RELEASE.xctoolchain
   ```

2. Install Emscripten:
   ```bash
   git clone https://github.com/emscripten-core/emsdk.git
   cd emsdk
   ./emsdk install latest
   ./emsdk activate latest
   source ./emsdk_env.sh
   ```

Option to build via SwiftPM.
Lots of limitations. Not sure if this is even needed until we get some Foundation. 

## Building the Project

```bash
mkdir build
cd build
emcmake cmake -DSWIFT_TOOLCHAIN=__path__/swift-6.0.3-RELEASE.xctoolchain ..
emmake make
```

This will:
1. Compile Swift code to WebAssembly object file
2. Create a static library from the Swift object file
3. Build the C++ application linking with the Swift library
4. Generate HTML/JS wrapper for WebAssembly

## Output

After building, you'll find in the `build` directory:
- `app-demo.html`: The web page containing your application
- `app-demo.wasm`: The WebAssembly binary
- `app-demo.js`: JavaScript glue code

## Running

To run the application:
```bash
emrun --serve_after_exit --serve_after_close --no_browser app-demo.html
```


