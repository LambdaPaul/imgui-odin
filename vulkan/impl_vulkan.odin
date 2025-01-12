package impl_vulkan

import imgui "../"
import vk "vendor:vulkan"

when ODIN_OS == .Windows {
	foreign import impl_vulkan "../lib/dcimgui_impl_vulkan.lib"
} else when ODIN_OS == .Linux {
	foreign import impl_vulkan "../lib/linux/libdcimgui_impl_vulkan.a"
} else when ODIN_OS == .Darwin {
	foreign import impl_vulkan "../lib/darwin/libdcimgui_impl_vulkan_arm64.a"
	// #panic(`Vulkan backend is not implemented yet for macOS; Consider using Metal instead`)
}

@(default_calling_convention = "cdecl", link_prefix = "cImGui_ImplVulkan_")
foreign impl_vulkan {
	Init :: proc(info: ^InitInfo) -> b8 ---
	Shutdown :: proc() ---
	NewFrame :: proc() ---
	RenderDrawData :: proc(draw_data: ^imgui.ImDrawData, command_buffer: vk.CommandBuffer, pipeline: vk.Pipeline = 0) ---
	CreateFontsTexture :: proc() -> b8 ---
	DestroyFontsTexture :: proc() ---
	SetMinImageCount :: proc(min_image_count: u32) ---
	AddTexture :: proc(sampler: vk.Sampler, image_view: vk.ImageView, image_layout: vk.ImageLayout) -> vk.DescriptorSet ---
	RemoveTexture :: proc(descriptor_set: vk.DescriptorSet) ---
	LoadFunctions :: proc(loader_func: proc(function_name: cstring, user_data: rawptr), user_data: rawptr = nil) -> b8 ---
}

@(default_calling_convention = "cdecl", link_prefix = "cImGui_ImplVulkanH_")
foreign impl_vulkan {
	CreateOrResizeWindow :: proc(
		instance: vk.Instance, 
		physical_device: vk.PhysicalDevice, 
		device: vk.Device, 
		wnd: ^Window, 
		queue_family: u32, 
		allocator: ^vk.AllocationCallbacks, 
		w: i32, 
		h: i32, 
		min_image_count: u32) ---
	DestroyWindow :: proc(instance: vk.Instance, device: vk.Device, wnd: ^Window, allocator: ^vk.AllocationCallbacks) ---
	SelectSurfaceFormat :: proc(physical_device: vk.PhysicalDevice, surface: vk.SurfaceKHR, request_formats: [^]vk.Format, request_formats_count: i32, request_color_space: vk.ColorSpaceKHR) -> vk.SurfaceFormatKHR ---
	SelectPresentMode :: proc(physical_device: vk.PhysicalDevice, surface: vk.SurfaceKHR, request_modes: [^]vk.PresentModeKHR, request_modes_count: i32) -> vk.PresentModeKHR ---
	GetMinImageCountFromPresentMode :: proc(present_mode: vk.PresentModeKHR) -> i32 ---
}
InitInfo :: struct {
	Instance:                    vk.Instance,
	PhysicalDevice:              vk.PhysicalDevice,
	Device:                      vk.Device,
	QueueFamily:                 u32,
	Queue:                       vk.Queue,
	DescriptorPool:              vk.DescriptorPool,
	RenderPass:                  vk.RenderPass,
	MinImageCount:               u32,
	ImageCount:                  u32,
	MSAASamples:                 vk.SampleCountFlags,
	PipelineCache:               vk.PipelineCache,
	Subpass:                     u32,
	DescriptorPoolSize:          u32,
	UseDynamicRendering:         b8,
	PipelineRenderingCreateInfo: vk.PipelineRenderingCreateInfoKHR,
	Allocator:                   ^vk.AllocationCallbacks,
	CheckVkResultFn:             proc(err: vk.Result),
	MinAllocationSize:           vk.DeviceSize,
}

RenderState :: struct {
	CommandBuffer:  vk.CommandBuffer,
	Pipeline:       vk.Pipeline,
	PipelineLayout: vk.PipelineLayout,
}
Frame :: struct {
	CommandPool:    vk.CommandPool,
	CommandBuffer:  vk.CommandBuffer,
	Fence:          vk.Fence,
	Backbuffer:     vk.Image,
	BackbufferView: vk.ImageView,
	Framebuffer:    vk.Framebuffer,
}
FrameSemaphores :: struct {
	ImageAcquiredSemaphore:  vk.Semaphore,
	RenderCompleteSemaphore: vk.Semaphore,
}
Window :: struct {
	Width:               i32,
	Height:              i32,
	Swapchain:           vk.SwapchainKHR,
	Surface:             vk.SurfaceKHR,
	SurfaceFormat:       vk.SurfaceFormatKHR,
	PresentMode:         vk.PresentModeKHR,
	RenderPass:          vk.RenderPass,
	Pipeline:            vk.Pipeline,
	UseDynamicRendering: b8,
	ClearEnable:         b8,
	ClearValue:          vk.ClearValue,
	FrameIndex:          u32,
	ImageCount:          u32,
	SemaphoreCount:      u32,
	SemaphoreIndex:      u32,
	Frames:              [^]Frame,
	FrameSemaphores:     [^]FrameSemaphores,
}
