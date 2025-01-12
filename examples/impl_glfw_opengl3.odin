package impl_glfw_opengl3
import "base:runtime"
import "core:os"
import "core:fmt"
import "vendor:glfw"
import gl "vendor:OpenGL"
import imgui ".."
import imgui_glfw "../glfw"
import imgui_gl3 "../opengl3"

main :: proc() {
    run()
}

glfw_error_cb :: proc "c" (error: i32, desc: cstring) {
    context = runtime.default_context()
    fmt.eprintln("[GLFW Error]", error, desc)
}

run :: proc() -> b32 {
    glfw.SetErrorCallback(glfw_error_cb)
    glfw.Init() or_return

    glsl_version: cstring = "#version 330"
    // glsl_version: cstring = "#version 130"
    glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)
    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3)
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 2)
    glfw.WindowHint(glfw.OPENGL_FORWARD_COMPAT, true)

    window := glfw.CreateWindow(1280, 720, "Test", nil, nil)
    if window == nil do return false
    glfw.MakeContextCurrent(window)
    glfw.SwapInterval(1)    

    gl.load_up_to(3, 3, glfw.gl_set_proc_address)


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
