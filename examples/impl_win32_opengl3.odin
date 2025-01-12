package impl_wini32_opengl3
import "base:runtime"
import "core:os"
import "core:fmt"
import win32 "core:sys/windows"
import gl "vendor:OpenGL"
import imgui ".."
import imgui_win32 "../win32"
import imgui_gl3 "../opengl3"

main :: proc() {
    run()
}

win32_hrc: win32.HGLRC
win32_main_window: win32.HDC
win32_width: i32
win32_height: i32

win32_gl_create :: proc(hwnd: win32.HWND, data: win32.HDC) -> b8
{
    hdc: win32.HDC = win32.GetDC(hwnd)
    pfd: win32.PIXELFORMATDESCRIPTOR = {}
    pfd.nSize = size_of(pfd)
    pfd.nVersion = 1
    pfd.dwFlags = 0 // TODO flags
    pfd.iPixelType = 0 // more flags
    pfd.cColorBits = 32

    pf: i32 = win32.ChoosePixelFormat(hdc, &pfd)
    if pf == 0 do return false
    if !win32.SetPixelFormat(hdc, pf, &pfd) do return false
    win32.ReleaseDC(hwnd, hdc)
    data = win32.GetDC(hwnd)
    if win32_hrc == 0 do win32_hrc = win32.wglCreateContext(data)
    return true 
}

run :: proc() -> b32 {
    wc: win32.WNDCLASSEXW = {}

    imgui.CreateContext(nil)
    io := imgui.GetIO()
    io.ConfigFlags |= imgui.ConfigFlags.NavEnableKeyboard
    io.ConfigFlags |= imgui.ConfigFlags.NavEnableGamepad
    imgui.StyleColorsDark(nil)

    imgui_glfw.InitForOpenGL(window, true)
    imgui_gl3.InitEx(glsl_version)
    clear_color: [4]f32 = {0.45, 0.55, 0.60, 1.00}
    _cc := clear_color.xyz
    show_demo: b8 = true

    for !glfw.WindowShouldClose(window) {
        glfw.PollEvents()
        if glfw.GetWindowAttrib(window, glfw.ICONIFIED) != 0 {
            imgui_glfw.Sleep(10)
            continue
        }

        imgui_gl3.NewFrame()
        imgui_glfw.NewFrame()
        imgui.NewFrame()

        if imgui.Button("Toggle DearImgui Demo") do show_demo = !show_demo
        if show_demo do imgui.ShowDemoWindow(&show_demo)

        _cc = clear_color.xyz
        imgui.ColorEdit3("clear color", &_cc, .None)
        imgui.SliderFloat3("clear color", &_cc, 0, 1)
        clear_color.xyz = _cc
        imgui.Render()

        dw, dh:= glfw.GetFramebufferSize(window)
        gl.Viewport(0, 0, dw, dh)
        gl.ClearColor(clear_color.x * clear_color.w, clear_color.y * clear_color.w, clear_color.z * clear_color.w, clear_color.w);
        gl.Clear(gl.COLOR_BUFFER_BIT);

        imgui_gl3.RenderDrawData(imgui.GetDrawData());
        glfw.SwapBuffers(window);

    }

    imgui_gl3.Shutdown()
    imgui_glfw.Shutdown()
    imgui.DestroyContext(nil)

    glfw.DestroyWindow(window)
    glfw.Terminate()
    return true
}
