
Recommended to use VS Code

make sure ../.vscode/settings.json pointing to right wasm toolchain

check that your swift is from toolchain via 
`which swift`

set SWIFT_TOOLCHAIN env variable to make sure swift don't try link with Xcode frameworks
```bash
export SWIFT_TOOLCHAIN=~/Library/Developer/Toolchains/swift-wasm-6.0.2-RELEASE.xctoolchain
```


Run command to build package
```swift
swift build --triple wasm32-unknown-none-wasm \
 -c release -Xswiftc -Xclang-linker -Xswiftc -mexec-model=reactor \
  -Xlinker --export=add --export=strerror -Xlinker --export=main 
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