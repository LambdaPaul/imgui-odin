package imgui_sdl2

when ODIN_OS == .Windows {
	foreign import imgui_sdl2 "../lib/dcimgui_impl_sdl2.lib"
}
else when ODIN_OS == .Linux {
	foreign import imgui_sdl2 "../lib/linux/libdcimgui_impl_sdl2.a"
} 
else when ODIN_OS == .Darwin {
	foreign import imgui_sdl2 "../lib/darwin/libdcimgui_impl_sdl2_arm64.a"
} 

import sdl "vendor:sdl2"

GamepadMode :: enum {
	AutoFirst = 0,
	AutoAll = 1,
	Manual = 2,
}

@(default_calling_convention = "cdecl", link_prefix = "cImGui_ImplSDL2_")
foreign imgui_sdl2 {
	InitForOpenGL :: proc(window: ^sdl.Window, sdl_gl_context: rawptr) -> b8 ---
	InitForVulkan :: proc(window: ^sdl.Window) -> b8 ---
	InitForD3D :: proc(window: ^sdl.Window) -> b8 ---
	InitForMetal :: proc(window: ^sdl.Window) -> b8 ---
	InitForSDLRenderer :: proc(window: ^sdl.Window, renderer: ^sdl.Renderer) -> b8 ---
	InitForOther :: proc(window: ^sdl.Window) -> b8 ---
	Shutdown :: proc() ---
	NewFrame :: proc() ---
	ProcessEvent :: proc(event: ^sdl.Event) -> b8 ---
	SetGamepadMode :: proc(mode: 	GamepadMode) ---
	SetGamepadModeEx :: proc(mode: 	GamepadMode, manual_gamepads_array: ^^sdl.GameController, manual_gamepads_count: i32) ---
}
