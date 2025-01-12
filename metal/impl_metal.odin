#+build darwin
package impl_metal

import imgui "../"
import mtl "vendor:darwin/Metal"

foreign import impl_metal "../lib/darwin/libdcimgui_impl_metal_arm64.a"

@(default_calling_convention = "cdecl", link_prefix = "cImGui_ImplMetal_")
foreign impl_metal {
    Init :: proc(device: ^mtl.Device) -> b8 ---
    Shutdown :: proc() ---
    NewFrame :: proc( renderPassDescriptor: ^mtl.RenderPassDescriptor) ---
    RenderDrawData :: proc(drawData: ^imgui.ImDrawData, commandBuffer: ^mtl.CommandBuffer, commandEncoder: ^mtl.CommandEncoder) ---
    CreateFontsTexture :: proc(device: ^mtl.Device) -> b8 ---
    DestroyFontsTexture :: proc () ---
    CreateDeviceObjects :: proc(device: ^mtl.Device) -> b8 ---
    DestroyDeviceObjects :: proc () ---
}
