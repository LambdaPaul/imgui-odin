package impl_sdl2_metal
import "core:os"
import "core:fmt"
import mtl "vendor:darwin/Metal"
import ns "core:sys/darwin/Foundation"
import ca "vendor:darwin/QuartzCore"
import sdl "vendor:sdl2"
import imgui ".."
import imgui_sdl2 "../sdl2"
import imgui_mtl "../metal"

main :: proc() {
    run()
}

run :: proc() -> b32 {
    imgui.CreateContext(nil)
    io := imgui.GetIO()
    io.ConfigFlags |= imgui.ConfigFlags.NavEnableKeyboard
    io.ConfigFlags |= imgui.ConfigFlags.NavEnableGamepad
    imgui.StyleColorsDark(nil)
    
    if sdl.Init({.VIDEO, .GAMECONTROLLER, .TIMER}) != 0 {
        fmt.eprintln(sdl.GetError())
        return false
    }

    sdl.SetHint(sdl.HINT_RENDER_DRIVER, "metal")
    window := sdl.CreateWindow("Test", sdl.WINDOWPOS_CENTERED, sdl.WINDOWPOS_CENTERED, 1280, 720, {.METAL, .RESIZABLE, .ALLOW_HIGHDPI})
    if window == nil {
        fmt.eprintln(sdl.GetError())
        return false
    }

    renderer := sdl.CreateRenderer(window, -1, {.ACCELERATED, .PRESENTVSYNC})
    if renderer == nil {
        fmt.eprintln(sdl.GetError())
        return false
    }

    layer: ^ca.MetalLayer = cast(^ca.MetalLayer)sdl.RenderGetMetalLayer(renderer)
    layer->setPixelFormat(.BGRA8Unorm)
    device := layer->device()
    defer device->release()
    imgui_mtl.Init(device)
    imgui_sdl2.InitForMetal(window)

    command_queue := layer->device()->newCommandQueue()
    defer command_queue->release()

    render_pass_desc := mtl.RenderPassDescriptor.renderPassDescriptor()
    defer render_pass_desc->release()

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

        w, h: i32
        sdl.GetRendererOutputSize(renderer, &w, &h)
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
        imgui_sdl2.NewFrame()
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
    imgui_sdl2.Shutdown()
    imgui.DestroyContext(nil)

    sdl.DestroyRenderer(renderer)
    sdl.DestroyWindow(window)
    sdl.Quit()
    return true
}
