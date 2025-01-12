#!/usr/bin/env bash 
set -xue

mkdir -p lib/linux/

clang++ \
	-c \
	-O2 -fno-exceptions -fno-rtti \
	-I./imgui \
	./imgui/imgui.cpp \
	./imgui/imgui_draw.cpp \
	./imgui/imgui_tables.cpp \
	./imgui/imgui_widgets.cpp \
	./imgui/imgui_demo.cpp \
	dcimgui.cpp

ar rcs ./lib/linux/libdcimgui.a imgui.o imgui_draw.o imgui_tables.o imgui_widgets.o imgui_demo.o dcimgui.o
rm imgui.o imgui_draw.o imgui_tables.o imgui_widgets.o imgui_demo.o dcimgui.o

# clang++ -c \
# 	-O2 -fno-exceptions -fno-rtti \
# 	-I./imgui/ \
# 	-I./imgui/backends/ \
# 	# -I/usr/include/SDL3 \
# 	./imgui/backends/imgui_impl_sdl3.cpp \
# 	./sdl3/impl_sdl3.cpp 

clang++ \
	-c \
	-O2 -fno-exceptions -fno-rtti \
	-I./imgui/ \
	-I./imgui/backends/ \
	$(sdl2-config --cflags) \
	./imgui/backends/imgui_impl_sdl2.cpp \
	./sdl2/impl_sdl2.cpp

ar rcs ./lib/linux/libdcimgui_impl_sdl2.a imgui_impl_sdl2.o impl_sdl2.o
rm imgui_impl_sdl2.o impl_sdl2.o

clang++ \
	-c \
	-O2 -fno-exceptions -fno-rtti \
	-I./imgui/ \
	-I./imgui/backends/ \
	./imgui/backends/imgui_impl_glfw.cpp \
	./glfw/impl_glfw.cpp

ar rcs ./lib/linux/libdcimgui_impl_glfw.a imgui_impl_glfw.o impl_glfw.o
rm imgui_impl_glfw.o impl_glfw.o

clang++ -c \
	-O2 -fno-exceptions -fno-rtti \
	-I./imgui/ \
	-I./imgui/backends/ \
	./imgui/backends/imgui_impl_vulkan.cpp \
	./vulkan/impl_vulkan.cpp

ar rcs ./lib/linux/libdcimgui_impl_vulkan.a imgui_impl_vulkan.o impl_vulkan.o
rm imgui_impl_vulkan.o impl_vulkan.o

clang++ -c \
	-O2 -fno-exceptions -fno-rtti \
	-I./imgui/ \
	-I./imgui/backends/ \
	./imgui/backends/imgui_impl_opengl3.cpp \
 	./opengl3/impl_opengl3.cpp

ar rcs ./lib/linux/libdcimgui_impl_opengl3.a imgui_impl_opengl3.o impl_opengl3.o
rm imgui_impl_opengl3.o impl_opengl3.o


mkdir -p examples_linux_exec

odin build examples/impl_glfw_opengl3.odin 	-file -out:examples_linux_exec/glfw_opengl3 	-extra-linker-flags:-lstdc++
odin build examples/impl_glfw_vulkan.odin 	-file -out:examples_linux_exec/glfw_vulkan 	-extra-linker-flags:"-lstdc++ -lvulkan"
odin build examples/impl_sdl2_opengl3.odin 	-file -out:examples_linux_exec/sdl2_opengl3 	-extra-linker-flags:-lstdc++
odin build examples/impl_sdl2_vulkan.odin 	-file -out:examples_linux_exec/sdl2_vulkan 	-extra-linker-flags:"-lstdc++ -lvulkan"
