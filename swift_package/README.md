
Recommended to use VS Code

This is odd example. I would say even stupid :D. Using results of Emsdk build from [main readme](../README.md)

make sure ../.vscode/settings.json pointing to right swift toolchain.

check that your swift is from toolchain via 
`which swift`

set SWIFT_TOOLCHAIN env variable to make sure swift don't try link with Xcode frameworks
```bash
export SWIFT_TOOLCHAIN=/Library/Developer/Toolchains/swift-6.0.3-RELEASE.xctoolchain
```


Run command to build package
```swift
swift build --triple wasm32-unknown-none-wasm -c release -Xswiftc -Xclang-linker -Xswiftc -mexec-model=reactor
 ```

add `-Xlinker --export=__main_argc_argv`
for:
```swift
@main
enum Main
{
    static func main()
    {
      // code
    }
}
```

To export additional functions add this:
 `-Xlinker --export=add`

Option to specify type of WASM, more read [here](https://dylibso.com/blog/wasi-command-reactor/)
`-Xswiftc -mexec-model=reactor`


`emscripten_stack_init`, `emscripten_stack_get_current`
is part of compiler-rt

