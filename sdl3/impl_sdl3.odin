package imgui_sdl3
#panic(`SDL3 will be supported once it is stable and available in Odin`)
import sdl "vendor:sdl3"

foreign import imgui_sdl3 "libdcimgui.so"

GamepadMode :: enum {
	AutoFirst = 0,
	AutoAll = 1,
	Manual = 2,
}

@(default_calling_convention = "cdecl", link_prefix = "cImGui_")
foreign imgui {
	InitForOpenGL :: proc(window: ^sdl.Window, sdl_gl_context: rawptr) -> b32 ---
	InitForVulkan :: proc(window: ^sdl.Window) -> b32 ---
	InitForD3D :: proc(window: ^sdl.Window) -> b32 ---
	InitForMetal :: proc(window: ^sdl.Window) -> b32 ---
	InitForSDLRenderer :: proc(window: ^sdl.Window, renderer: ^sdl.Renderer) -> b32 ---
	InitForOther :: proc(window: ^sdl.Window) -> b32 ---
	Shutdown :: proc() ---
	NewFrame :: proc() ---
	ProcessEvent :: proc(event: ^sdl.Event) -> b32 ---
	SetGamepadMode :: proc(mode: GamepadMode) ---
	SetGamepadModeEx :: proc(mode: GamepadMode, manual_gamepads_array: ^^sdl.Gamepad, manual_gamepads_count: i32) ---
}