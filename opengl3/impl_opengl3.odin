package impl_opengl3

import imgui "../"
import vk "vendor:vulkan"

when ODIN_OS == .Windows {
	foreign import impl_opengl3 "../lib/dcimgui_impl_opengl3.lib"
}
else when ODIN_OS == .Linux {
	foreign import impl_opengl3 "../lib/linux/libdcimgui_impl_opengl3.a"
}
else when ODIN_OS == .Darwin {
	foreign import impl_opengl3 "../lib/darwin/libdcimgui_impl_opengl3_arm64.a"
}

@(default_calling_convention = "cdecl", link_prefix = "cImGui_ImplOpenGL3_")
foreign impl_opengl3 {
	Init :: proc() -> b32 ---
	InitEx :: proc(glsl_version: cstring) -> b32 ---
	Shutdown :: proc() ---
	NewFrame :: proc() ---
	RenderDrawData :: proc(draw_data: ^imgui.ImDrawData) ---
	CreateFontsTexture :: proc() -> b32 ---
	DestroyFontsTexture :: proc() ---
	CreateDeviceObjects :: proc() -> b32 ---
	DestroyDeviceObjects :: proc() ---
}