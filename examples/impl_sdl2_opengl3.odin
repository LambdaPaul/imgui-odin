package impl_sdl2_opengl3
import os "core:os"
import fmt "core:fmt"
import sdl "vendor:sdl2"
import gl "vendor:OpenGL"
import imgui ".."
import imgui_sdl2 "../sdl2"
import imgui_gl3 "../opengl3"

main :: proc() {
    run()
}

run :: proc() -> b32 {
    if sdl.Init({.VIDEO, .GAMECONTROLLER, .TIMER}) != 0 {
        fmt.eprintln(sdl.GetError())
        return false
    }

    glsl_version: cstring = "#version 330"
    sdl.GL_SetAttribute(.CONTEXT_FLAGS, 0)
    sdl.GL_SetAttribute(.CONTEXT_PROFILE_MASK, i32(sdl.GLprofile.CORE))
    sdl.GL_SetAttribute(.CONTEXT_MAJOR_VERSION, 3)
    sdl.GL_SetAttribute(.CONTEXT_MINOR_VERSION, 0)

    sdl.GL_SetAttribute(.DOUBLEBUFFER, 1)
    sdl.GL_SetAttribute(.DEPTH_SIZE, 24)
    sdl.GL_SetAttribute(.STENCIL_SIZE, 8)

    window_flags: sdl.WindowFlags = {.OPENGL, .RESIZABLE, .HIDDEN, .ALLOW_HIGHDPI}
    window := sdl.CreateWindow("Test", sdl.WINDOWPOS_CENTERED, sdl.WINDOWPOS_CENTERED, 1280, 720, window_flags)
    if window == nil {
        fmt.eprintln(sdl.GetError())
        return false
    }

    gl_ctx := sdl.GL_CreateContext(window)
    if gl_ctx == nil {
        fmt.eprintln(sdl.GetError())
        return false
    }

    sdl.GL_MakeCurrent(window, gl_ctx)
    gl.load_up_to(3, 3, sdl.gl_set_proc_address)

    sdl.GL_SetSwapInterval(1)
    sdl.ShowWindow(window)

    imgui.CreateContext(nil)
    io := imgui.GetIO()
    io.ConfigFlags |= imgui.ConfigFlags.NavEnableKeyboard
    io.ConfigFlags |= imgui.ConfigFlags.NavEnableGamepad
    imgui.StyleColorsDark(nil)
    
    imgui_sdl2.InitForOpenGL(window, gl_ctx)
    imgui_gl3.InitEx(glsl_version)
    clear_color: [4]f32 = {0.45, 0.55, 0.60, 1.00}
    _cc := clear_color.xyz
    done: b32 = false
    show_demo: b8 = true

    for !done {
        event: sdl.Event
        for sdl.PollEvent(&event) {
            imgui_sdl2.ProcessEvent(&event)
            if event.type == .QUIT do done = true
            if event.type == .WINDOWEVENT && event.window.event == .CLOSE do done = true
        }

        imgui_gl3.NewFrame()
        imgui_sdl2.NewFrame()
        imgui.NewFrame()

        if imgui.Button("Toggle DearImgui Demo") do show_demo = !show_demo
        if show_demo do imgui.ShowDemoWindow(&show_demo)

        _cc = clear_color.xyz
        imgui.ColorEdit3("clear color", &_cc, .None)
        imgui.SliderFloat3("clear color", &_cc, 0, 1)
        clear_color.xyz = _cc
        imgui.Render()

        gl.Viewport(0, 0, i32(io.DisplaySize.x), i32(io.DisplaySize.y))
        gl.ClearColor(clear_color.x * clear_color.w, clear_color.y * clear_color.w, clear_color.z * clear_color.w, clear_color.w);
        gl.Clear(gl.COLOR_BUFFER_BIT);

        imgui_gl3.RenderDrawData(imgui.GetDrawData());
        sdl.GL_SwapWindow(window);

    }

    imgui_gl3.Shutdown()
    imgui_sdl2.Shutdown()
    imgui.DestroyContext(nil)

    sdl.GL_DeleteContext(gl_ctx)
    sdl.DestroyWindow(window)
    sdl.Quit()
    return true
}
