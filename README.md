# Dear ImGui Bindings for Odin

## Usage

Copy the repo as a directory to your project and import it like you typically would in Odin. See the examples directory for working Odin code. 

There is no need to run the build scripts unless you want to build the static libraries for yourself or if you want to build all the examples.

Note that Vulkan (if you use the Vulkan renderer) and C++ Standard Library\* must be linked when you use this library on macOS and Linux where it is preferred to link libraries dynamically.

\*for thread safety; if not needed, you must recompile with it `-fno-threadsafe-statics`

## Supported Backends

### Windows

| Windows | OpenGL | Vulkan | D3D11 |
|---------|--------|--------|-------|
| SDL2    | X      | X      | -     |
| GLFW    | X      | X      | -     |

### macOS

| macOS | OpenGL | Vulkan | Metal |
|-------|--------|--------|-------|
| SDL2  | X      | X      | X     |
| GLFW  | X      | X      | X     |

### Linux

| Linux | OpenGL | Vulkan |
|---------|--------|--------|
| SDL2    | X      | X      |
| GLFW    | X      | X      |

SDL3 will be supported once the package is available in Odin's vendor library.

## Examples

You can run an example like so:
(replace `{backend}` and `{renderer}` with the one you want)

### Windows
```batch
odin run examples/impl_{backend}_{renderer}.odin -file
```

### macOS/Linux:
```sh
odin run examples/impl_{backend}_{renderer}.odin -file -extra-linker-flags:"-lstdc++"
```

If you use Vulkan as a renderer on macOS or Linux, don't forget to link Vulkan as mentioned before: `-extra-linker-flags:"-lstdc++ -lvulkan"`.

## Building

### Windows

```batch
./build.bat
```

### Linux

```sh
./build_linux.sh
```

### macOS

For Metal renderer, you must provide the path to the Metal Cpp header files in the `METAL_CPP_DIR` environment variable like so:

```sh
METAL_CPP_DIR="replace this with the metal cpp path" ./build_mac.sh
```
