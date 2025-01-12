package impl_sdl2_metal
import "base:runtime"
import "core:os"
import "core:fmt"
import mtl "vendor:darwin/Metal"
import ns "core:sys/darwin/Foundation"
import ca "vendor:darwin/QuartzCore"
import glfw "vendor:glfw"
import imgui ".."
import imgui_glfw "../glfw"
import imgui_mtl "../metal"

main :: proc() {
    run()
}

glfw_error_cb :: proc "c" (error: i32, desc: cstring) {
    context = runtime.default_context()
    fmt.eprintln("[GLFW Error]", error, desc)
}

run :: proc() -> b32 {
    imgui.CreateContext(nil)
    io := imgui.GetIO()
    io.ConfigFlags |= imgui.ConfigFlags.NavEnableKeyboard
    io.ConfigFlags |= imgui.ConfigFlags.NavEnableGamepad
    imgui.StyleColorsDark(nil)
    
    glfw.SetErrorCallback(glfw_error_cb)
    glfw.Init() or_return
    glfw.WindowHint(glfw.CLIENT_API, glfw.NO_API)

    window := glfw.CreateWindow(1280, 720, "Test", nil, nil)
    if window == nil do return false
    
    device := mtl.CreateSystemDefaultDevice()
    defer device->release()

    command_queue := device->newCommandQueue()
    defer command_queue->release()

    imgui_glfw.InitForOpenGL(window, true)
    imgui_mtl.Init(device)

    ns_win := glfw.GetCocoaWindow(window)
    ns_view := glfw.GetCocoaView(window)

    layer := ca.MetalLayer.layer()

    layer->setDevice(device)
    layer->setPixelFormat(.BGRA8Unorm)

    ns_view->setLayer(layer)
    ns_view->setWantsLayer(true)

    render_pass_desc := mtl.RenderPassDescriptor.renderPassDescriptor()
    defer render_pass_desc->release()

    clear_color: [4]f32 = {0.45, 0.55, 0.60, 1.00}
    _cc := clear_color.xyz
    show_demo: b8 = true

    for !glfw.WindowShouldClose(window) {
        glfw.PollEvents()

        w, h: i32 = glfw.GetFramebufferSize(window)
        layer->setDrawableSize({width=ns.Float(w), height=ns.Float(h)})

        drawable := layer->nextDrawable()
        defer drawable->release()

        col_attachment := render_pass_desc->colorAttachments()->object(0)
        col_attachment->setClearColor(mtl.ClearColor{
            f64(clear_color[0] * clear_color[3]),
            f64(clear_color[1] * clear_color[3]),
            f64(clear_color[2] * clear_color[3]), 
            f64(clear_color[3])})
        col_attachment->setTexture(drawable->texture())
        col_attachment->setLoadAction(.Clear)
        col_attachment->setStoreAction(.Store)

        command_buffer := command_queue->commandBuffer()
        defer command_buffer->release()

        render_encoder := command_buffer->renderCommandEncoderWithDescriptor(render_pass_desc)
        defer render_encoder->release()
        render_encoder->pushDebugGroup(ns.MakeConstantString("test"))

        imgui_mtl.NewFrame(render_pass_desc)
        imgui_glfw.NewFrame()
        imgui.NewFrame()

        if imgui.Button("Toggle DearImgui Demo") do show_demo = !show_demo
        if show_demo do imgui.ShowDemoWindow(&show_demo)

        _cc = clear_color.xyz
        imgui.ColorEdit3("clear color", &_cc, .None)
        imgui.SliderFloat3("clear color", &_cc, 0, 1)
        clear_color.xyz = _cc
        imgui.Render()


        imgui_mtl.RenderDrawData(imgui.GetDrawData(), command_buffer, render_encoder);

        render_encoder->popDebugGroup()
        render_encoder->endEncoding()

        command_buffer->presentDrawable(drawable)
        command_buffer->commit()

    }

    imgui_mtl.Shutdown()
    imgui_glfw.Shutdown()
    imgui.DestroyContext(nil)

    glfw.DestroyWindow(window)
    glfw.Terminate()
    return true
}
