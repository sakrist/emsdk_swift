#include <emscripten.h>
#include <emscripten/console.h>
#include <cstdio>
#include <string>

extern "C" void hello();
extern "C" int add(int a, int b);

// void renderFrame() {
    
// }

int main() {
    hello();

    emscripten_console_log("emscripten_console_log C++");

    int result = add(2, 3);
    std::string str =  "add 2 and 3 = " + std::to_string(result);
    emscripten_console_log(str.c_str());

    result = add(6, 7);
    std::string str2 =  "add 6 and 7 = " + std::to_string(result);
    emscripten_console_log(str2.c_str());
    
    // Set up the render loop
    // emscripten_set_main_loop(renderFrame, 0, true);

    return 0;
}

