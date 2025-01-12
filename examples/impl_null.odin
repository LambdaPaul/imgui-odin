package impl_null
import "core:fmt"
import imgui ".."

main :: proc() {
    fmt.println("CreateContext()")
	imgui.CreateContext()
    io := imgui.GetIO()

    tex_pixels: cstring
    tex_w, tex_h: i32
	imgui.ImFontAtlas_GetTexDataAsRGBA32(io.Fonts, &tex_pixels, &tex_w, &tex_h, nil)
    for n: i32 = 0; n < 20; n += 1 {
        fmt.println("NewFrame()", n)
        io.DisplaySize.x = 1920
        io.DisplaySize.y = 1920
        io.DeltaTime = 1.0 / 60.0
        imgui.NewFrame()

        f: f32 = 0.0
        imgui.Text("Hello, world!")
        imgui.SliderFloat("float", &f, 0.0, 1.0)
        imgui.Text("Application average %.3f ms/frame (%.1f FPS)", 1000.0 / io.Framerate, io.Framerate)
        imgui.ShowDemoWindow()

        imgui.Render()
    }

    fmt.println("DestroyContext()")
    imgui.DestroyContext()
}