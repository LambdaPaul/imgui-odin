package imgui_glfw


when ODIN_OS == .Windows {
	foreign import imgui_glfw "../lib/dcimgui_impl_glfw.lib"
}
else when ODIN_OS == .Linux {
	foreign import imgui_glfw "../lib/linux/libdcimgui_impl_glfw.a"
}
else when ODIN_OS == .Darwin {
	foreign import imgui_glfw "../lib/darwin/libdcimgui_impl_glfw_arm64.a"
}

import glfw "vendor:glfw"

@(default_calling_convention = "cdecl", link_prefix = "cImGui_ImplGlfw_")
foreign imgui_glfw {
	InitForOpenGL :: proc(window: glfw.WindowHandle, install_callbacks: b32) -> b32 ---
	InitForVulkan :: proc(window: glfw.WindowHandle, install_callbacks: b32) -> b32 ---
	InitForOther :: proc(window: glfw.WindowHandle, install_callbacks: b32) -> b32 ---
	Shutdown :: proc() ---
	NewFrame :: proc() ---
	InstallEmscriptenCallbacks :: proc(window: glfw.WindowHandle, canvas_selector: cstring) ---
	InstallCallbacks :: proc(window: glfw.WindowHandle) ---
	RestoreCallbacks :: proc(window: glfw.WindowHandle) ---
	SetCallbacksChainForAllWindows :: proc(chain_for_all_windows: b32) ---
	WindowFocusCallback :: proc(window: glfw.WindowHandle, focused: i32) ---
	CursorEnterCallback :: proc(window: glfw.WindowHandle, entered: i32) ---
	CursorPosCallback :: proc(window: glfw.WindowHandle, x: f64, y: f64) ---
	MouseButtonCallback :: proc(window: glfw.WindowHandle, button: i32, action: i32, mods: i32) ---
	ScrollCallback :: proc(window: glfw.WindowHandle, xoffset: f64, yoffset: f64) ---
	KeyCallback :: proc(window: glfw.WindowHandle, key: i32, scancode: i32, action: i32, mods: i32) ---
	CharCallback :: proc(window: glfw.WindowHandle, c: u32) ---
	MonitorCallback :: proc(monitor: glfw.MonitorHandle, event: i32) ---
	Sleep :: proc(milliseconds: i32) ---
}
