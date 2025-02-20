
// TODO: Find a better way to do this
@_cdecl("exit")
func exit(_ r:Int ) {  
}

@_cdecl("emscripten_get_now")
func emscripten_get_now() -> Double {
  return 0
}