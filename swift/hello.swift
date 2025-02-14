// @_extern(wasm, module: "env", name: "emscripten_console_log")
@_extern(c)
func emscripten_console_log(_ address: UnsafePointer<UInt8>)

func print_sw(_ string: StaticString) {
  emscripten_console_log(string.utf8Start)
}

@_cdecl("hello")
func hello() {
  print_sw("Hello, World from Swift!")
}

@_cdecl("add")
func add(_ a:Int, _ b:Int) -> Int {
  return a + b
}


