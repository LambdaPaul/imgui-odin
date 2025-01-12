
typedef void MtlDevice;
typedef void MtlRenderPassDescriptor;
typedef void MtlCommandBuffer;
typedef void MtlRenderCommandEncoder;

#pragma once

#ifdef __cplusplus
extern "C"
{
#endif
#ifndef IMGUI_DISABLE
#include "../dcimgui.h"

typedef struct ImDrawData_t ImDrawData;
CIMGUI_IMPL_API bool cImGui_ImplMetal_Init(MtlDevice* device);
CIMGUI_IMPL_API void cImGui_ImplMetal_Shutdown(void);
CIMGUI_IMPL_API void cImGui_ImplMetal_NewFrame(MtlRenderPassDescriptor* renderPassDescriptor);
CIMGUI_IMPL_API void cImGui_ImplMetal_RenderDrawData(ImDrawData* draw_data, MtlCommandBuffer* commandBuffer, MtlRenderCommandEncoder* commandEncoder);
CIMGUI_IMPL_API bool cImGui_ImplMetal_CreateFontsTexture(MtlDevice* device);
CIMGUI_IMPL_API void cImGui_ImplMetal_DestroyFontsTexture(void);
CIMGUI_IMPL_API bool cImGui_ImplMetal_CreateDeviceObjects(MtlDevice* device);
CIMGUI_IMPL_API void cImGui_ImplMetal_DestroyDeviceObjects(void);

#endif// #ifndef IMGUI_DISABLE
#ifdef __cplusplus
} // End of extern "C" block
#endif
