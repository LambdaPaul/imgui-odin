#!/usr/bin/env bash

set -xu

mkdir -p lib/darwin/

clang++ -std=c++17 \
	-c \
	-O2 -fno-exceptions -fno-rtti \
	-I./imgui \
	./imgui/imgui.cpp \
	./imgui/imgui_draw.cpp \
	./imgui/imgui_tables.cpp \
	./imgui/imgui_widgets.cpp \
	./imgui/imgui_demo.cpp \
	dcimgui.cpp

libtool -static -o ./lib/darwin/libdcimgui_arm64.a imgui.o imgui_draw.o imgui_tables.o imgui_widgets.o imgui_demo.o dcimgui.o
rm imgui.o imgui_draw.o imgui_tables.o imgui_widgets.o imgui_demo.o dcimgui.o

# clang++ -c \
# 	-O2 -fno-exceptions -fno-rtti \
# 	-I./imgui/ \
# 	-I./imgui/backends/ \
# 	# -I/usr/include/SDL3 \
# 	./imgui/backends/imgui_impl_sdl3.cpp \
# 	./sdl3/impl_sdl3.cpp 

clang++ -std=c++17 \
	-c \
	-O2 -fno-exceptions -fno-rtti \
	-I./imgui/ \
	-I./imgui/backends/ \
	$(sdl2-config --cflags) \
	./imgui/backends/imgui_impl_sdl2.cpp \
	./sdl2/impl_sdl2.cpp

libtool -static -o ./lib/darwin/libdcimgui_impl_sdl2_arm64.a imgui_impl_sdl2.o impl_sdl2.o
rm imgui_impl_sdl2.o impl_sdl2.o

clang++ -std=c++17 \
	-c \
	-O2 -fno-exceptions -fno-rtti \
	-I./imgui/ \
	-I./imgui/backends/ \
	$(pkg-config --cflags glfw3) \
	./imgui/backends/imgui_impl_glfw.cpp \
	./glfw/impl_glfw.cpp

libtool -static -o ./lib/darwin/libdcimgui_impl_glfw_arm64.a imgui_impl_glfw.o impl_glfw.o
rm imgui_impl_glfw.o impl_glfw.o

clang++ -std=c++17 \
	-c \
	-O2 -fno-exceptions -fno-rtti \
	-I./imgui/ \
	-I./imgui/backends/ \
	$(pkg-config --cflags vulkan) \
	./imgui/backends/imgui_impl_vulkan.cpp \
	./vulkan/impl_vulkan.cpp

libtool -static -o ./lib/darwin/libdcimgui_impl_vulkan_arm64.a imgui_impl_vulkan.o impl_vulkan.o
rm imgui_impl_vulkan.o impl_vulkan.o

clang++ -std=c++17 \
	-c \
	-O2 -fno-exceptions -fno-rtti \
	-I./imgui/ \
	-I./imgui/backends/ \
	./imgui/backends/imgui_impl_opengl3.cpp \
 	./opengl3/impl_opengl3.cpp

libtool -static -o ./lib/darwin/libdcimgui_impl_opengl3_arm64.a imgui_impl_opengl3.o impl_opengl3.o
rm imgui_impl_opengl3.o impl_opengl3.o

clang++ -c \
    -ObjC++ \
	-O2 -fno-exceptions -fno-rtti \
    -std=c++17 \
    -arch arm64 \
    -DIMGUI_IMPL_METAL_CPP=1\
    -I"$METAL_CPP_DIR"  \
	-I./imgui/ \
	-I./imgui/backends/ \
    imgui/backends/imgui_impl_metal.mm 

clang++ -c -std=c++17 \
	-O2 -fno-exceptions -fno-rtti \
    -arch arm64 \
    -I"$METAL_CPP_DIR"  \
    -DIMGUI_IMPL_METAL_CPP=1\
	-I./imgui/ \
	-I./imgui/backends/ \
 	./metal/impl_metal.cpp 

libtool -static -o ./lib/darwin/libdcimgui_impl_metal_arm64.a imgui_impl_metal.o impl_metal.o
rm imgui_impl_metal.o impl_metal.o

# clang++ 
    # -framework CoreGraphics -framework CoreVideo -framework Metal -framework MetalKit -framework Cocoa \
    # -std=c++17 -I ../../Downloads/metal-cpp/ impl_metal.o -DIMGUI_IMPL_METAL_CPP^C

mkdir -p examples_macos_exec

odin build examples/impl_glfw_opengl3.odin 	-file -out:examples_macos_exec/glfw_opengl3 	-extra-linker-flags:-lstdc++
odin build examples/impl_glfw_vulkan.odin 	-file -out:examples_macos_exec/glfw_vulkan 	-extra-linker-flags:"-lstdc++ -lvulkan"
odin build examples/impl_glfw_metal.odin 	-file -out:examples_macos_exec/glfw_metal	-extra-linker-flags:"-lstdc++"

odin build examples/impl_sdl2_opengl3.odin 	-file -out:examples_macos_exec/sdl2_opengl3 	-extra-linker-flags:-lstdc++
odin build examples/impl_sdl2_vulkan.odin 	-file -out:examples_macos_exec/sdl2_vulkan 	-extra-linker-flags:"-lstdc++ -lvulkan"
odin build examples/impl_sdl2_metal.odin 	-file -out:examples_macos_exec/sdl2_metal	-extra-linker-flags:"-lstdc++" # -print-linker-flags


# clang++ -std=c++17 -undefined dynamic_lookup -fPIC \
#       -o  ./lib/libdcimgui_impl_sdl2.dylib \
#       -I./imgui/ \
#       -I./imgui/backends/ \
#       -I/opt/homebrew/Cellar/sdl2/2.30.10/include/SDL2 \
#       -L/opt/homebrew/Cellar/sdl2/2.30.10/lib/ \
#       -lSDL2 \
#       ./imgui/backends/imgui_impl_sdl2.cpp \
#       ./sdl2/impl_sdl2.cpp

# clang++ -std=c++17 -undefined dynamic_lookup -fPIC \
#       -o  ./lib/libdcimgui_impl_glfw_arm64.dylib \
#       -I./imgui/ \
#       -I./imgui/backends/ \
#       -I/opt/homebrew/Cellar/glfw/3.4/include/ \
#       ./imgui/backends/imgui_impl_glfw.cpp \
#       ./glfw/impl_glfw.cpp

