
#include "imgui.h"
#include "imgui_impl_metal.h"

namespace cimgui
{
    #include "impl_metal.h"
}

#ifndef IMGUI_DISABLE


CIMGUI_IMPL_API bool cimgui::cImGui_ImplMetal_Init(MtlDevice* device)
{
    return ::ImGui_ImplMetal_Init(reinterpret_cast<MTL::Device*>(device));
}

CIMGUI_IMPL_API void cimgui::cImGui_ImplMetal_Shutdown(void)
{
    ::ImGui_ImplMetal_Shutdown();
}

CIMGUI_IMPL_API void cimgui::cImGui_ImplMetal_NewFrame(MtlRenderPassDescriptor* renderPassDescriptor)
{
    ::ImGui_ImplMetal_NewFrame(reinterpret_cast<MTL::RenderPassDescriptor*>(renderPassDescriptor));
}

CIMGUI_IMPL_API void cimgui::cImGui_ImplMetal_RenderDrawData(cimgui::ImDrawData* draw_data, MtlCommandBuffer* commandBuffer, MtlRenderCommandEncoder* commandEncoder)
{
    ::ImGui_ImplMetal_RenderDrawData(reinterpret_cast<::ImDrawData*>(draw_data), reinterpret_cast<MTL::CommandBuffer*>(commandBuffer), reinterpret_cast<MTL::RenderCommandEncoder*>(commandEncoder));
}

CIMGUI_IMPL_API bool cimgui::cImGui_ImplMetal_CreateFontsTexture(MtlDevice* device)
{
    return ::ImGui_ImplMetal_CreateFontsTexture(reinterpret_cast<MTL::Device*>(device));
}

CIMGUI_IMPL_API void cimgui::cImGui_ImplMetal_DestroyFontsTexture(void)
{
    ::ImGui_ImplMetal_DestroyFontsTexture();
}

CIMGUI_IMPL_API bool cimgui::cImGui_ImplMetal_CreateDeviceObjects(MtlDevice* device)
{
    return ::ImGui_ImplMetal_CreateDeviceObjects(reinterpret_cast<MTL::Device*>(device));
}

CIMGUI_IMPL_API void cimgui::cImGui_ImplMetal_DestroyDeviceObjects(void)
{
    ::ImGui_ImplMetal_DestroyDeviceObjects();
}

#endif // #ifndef IMGUI_DISABLE
