package impl_sdl2_vulkan
import "core:fmt"
import "core:strings"
import "core:bytes"

import imgui ".."
import imgui_vk "../vulkan"
import imgui_sdl2 "../sdl2"
import sdl "vendor:sdl2"
import vk "vendor:vulkan"

vk_allocator: ^vk.AllocationCallbacks = nil
vk_instance: vk.Instance = nil
vk_physical_device: vk.PhysicalDevice = nil
vk_device: vk.Device = nil
vk_queue_family: u32 = max(u32)
vk_queue: vk.Queue = nil
vk_debugreport: vk.DebugReportCallbackEXT = 0
vk_pipeline_cache: vk.PipelineCache = 0
vk_descriptor_pool: vk.DescriptorPool = 0

imgui_vk_main_window_data: imgui_vk.Window
imgui_vk_min_image_count: u32 = 2
imgui_vk_swap_chain_rebuild: b32 = false

main :: proc() { run() }

vk_select_physical_device :: proc() -> vk.PhysicalDevice {
	vk_res: vk.Result
	gpu_count: u32 = 0

	vk_res = vk.EnumeratePhysicalDevices(vk_instance, &gpu_count, nil)
	if !vk_res_ok(vk_res) do return nil
	
	if gpu_count <= 0 {
		fmt.eprintln("no gpus found")
		return nil
	}

	gpus := make([dynamic]vk.PhysicalDevice, gpu_count)
	vk_res = vk.EnumeratePhysicalDevices(vk_instance, &gpu_count, raw_data(gpus))
	if !vk_res_ok(vk_res) do return nil

	for gpu, i in gpus {
		properties: vk.PhysicalDeviceProperties = {}
		vk.GetPhysicalDeviceProperties(gpu, &properties)
		if properties.deviceType == .DISCRETE_GPU do return gpu
	}

	return gpus[0]
}

is_ext_available :: proc(properties: [] vk.ExtensionProperties, extension: cstring)-> b32 {
	for &property in properties {
		if cstring(&property.extensionName[0]) == extension do return true
	}
	return false
}

vk_res_ok :: proc(res: vk.Result) -> b32 {
	if res >= .SUCCESS {
	 	if res != .SUCCESS do fmt.eprintln("[VULKAN Info]", res)
		return true
	}

	fmt.eprintln("[VULKAN Error]", res)
	return false
}

run :: proc() -> b32 {
window := sdl.CreateWindow(
		"Test",
		sdl.WINDOWPOS_CENTERED,
		sdl.WINDOWPOS_CENTERED,
		1280,
		720,
		{.VULKAN, .RESIZABLE, .ALLOW_HIGHDPI}
	)
	defer sdl.DestroyWindow(window)

	vk.load_proc_addresses(sdl.Vulkan_GetVkGetInstanceProcAddr())

	vk_res: vk.Result
	sdl_res: sdl.bool

	extensions_count: u32
	sdl_res = sdl.Vulkan_GetInstanceExtensions(window, &extensions_count, nil)

	extensions := make([dynamic]cstring, extensions_count)
	defer delete(extensions)
	sdl_res = sdl.Vulkan_GetInstanceExtensions(window, &extensions_count, raw_data(extensions))

 	{
		create_info: vk.InstanceCreateInfo = {}
		create_info.sType = .INSTANCE_CREATE_INFO

		properties_count: u32
		vk_res = vk.EnumerateInstanceExtensionProperties(nil, &properties_count, nil)
		vk_res_ok(vk_res) or_return

		properties := make([dynamic]vk.ExtensionProperties, properties_count)
		defer delete(properties)
		vk_res = vk.EnumerateInstanceExtensionProperties(nil, &properties_count, raw_data(properties))
		vk_res_ok(vk_res) or_return

		ext: cstring
		ext = vk.KHR_GET_PHYSICAL_DEVICE_PROPERTIES_2_EXTENSION_NAME
		if is_ext_available(properties[:], ext) do append(&extensions, ext)
		ext = vk.KHR_PORTABILITY_ENUMERATION_EXTENSION_NAME
		if is_ext_available(properties[:], ext) {
			append(&extensions, ext)
			create_info.flags = create_info.flags + {.ENUMERATE_PORTABILITY_KHR}
		}

		create_info.enabledExtensionCount = cast(u32)len(extensions)
		create_info.ppEnabledExtensionNames = raw_data(extensions)

		vk_res = vk.CreateInstance(&create_info, vk_allocator, &vk_instance);
		vk_res_ok(vk_res) or_return
	}

	vk.load_proc_addresses(vk_instance)
	vk_physical_device = vk_select_physical_device()


	{
		count: u32
		vk.GetPhysicalDeviceQueueFamilyProperties(vk_physical_device, &count, nil)
		queues: [dynamic]vk.QueueFamilyProperties = make([dynamic]vk.QueueFamilyProperties, count)
		defer delete(queues)
		vk.GetPhysicalDeviceQueueFamilyProperties(vk_physical_device, &count, raw_data(queues))
		for q_item, i in queues {
			if .GRAPHICS in q_item.queueFlags {
				vk_queue_family = u32(i)
				break
			}
		}
		if vk_queue_family == max(u32) do return false

	}

	{
		device_extensions:= make([dynamic] cstring)
		defer delete(device_extensions)
		append(&device_extensions, "VK_KHR_swapchain")
		properties_count: u32
		vk.EnumerateDeviceExtensionProperties(vk_physical_device, nil, &properties_count, nil)
		properties := make([dynamic]vk.ExtensionProperties, properties_count)
		defer delete(properties)
		vk.EnumerateDeviceExtensionProperties(vk_physical_device, nil, &properties_count, raw_data(properties))

		queue_priority: []f32 = { 1.0 }
		queue_info: [1]vk.DeviceQueueCreateInfo = {}
		queue_info[0].sType = .DEVICE_QUEUE_CREATE_INFO
		queue_info[0].queueFamilyIndex = vk_queue_family
		queue_info[0].queueCount = 1
		queue_info[0].pQueuePriorities = raw_data(queue_priority)
		create_info: vk.DeviceCreateInfo = {}
		create_info.sType = .DEVICE_CREATE_INFO
		create_info.queueCreateInfoCount = len(queue_info)
		create_info.pQueueCreateInfos = raw_data(queue_info[:])
		create_info.enabledExtensionCount = u32(len(device_extensions))
		create_info.ppEnabledExtensionNames = raw_data(device_extensions)
		vk_res = vk.CreateDevice(vk_physical_device, &create_info, vk_allocator, &vk_device)
		vk_res_ok(vk_res) or_return
		vk.GetDeviceQueue(vk_device, vk_queue_family, 0, &vk_queue)
	}
	vk.load_proc_addresses(vk_device)
	{
		pool_sizes: []vk.DescriptorPoolSize = {{.COMBINED_IMAGE_SAMPLER, 1}}
		pool_info: vk.DescriptorPoolCreateInfo = {}
		pool_info.sType = .DESCRIPTOR_POOL_CREATE_INFO
		pool_info.flags = {.FREE_DESCRIPTOR_SET}
		pool_info.maxSets = 1
		pool_info.poolSizeCount = u32(len(pool_sizes))
		pool_info.pPoolSizes = raw_data(pool_sizes)
		vk_res = vk.CreateDescriptorPool(vk_device, &pool_info, vk_allocator, &vk_descriptor_pool)
		vk_res_ok(vk_res) or_return	
	}

	
	surface: vk.SurfaceKHR
	sdl.Vulkan_CreateSurface(window, vk_instance, &surface) or_return

	imgui_window: ^imgui_vk.Window = &imgui_vk_main_window_data
	imgui_window.Surface = surface

	response: b32
	vk_res = vk.GetPhysicalDeviceSurfaceSupportKHR(vk_physical_device, vk_queue_family, surface, &response)
	vk_res_ok(vk_res) or_return
	if !response {
		fmt.eprintln("GetPhysicalDeviceSurfaceSupportKHR failed")
		return false
	}
	req_surface_img_fmt: [] vk.Format = {.B8G8R8A8_UNORM, .R8G8B8A8_UNORM, .B8G8R8_UNORM, .R8G8B8_UNORM}
	req_surface_color_space: vk.ColorSpaceKHR = .SRGB_NONLINEAR
    imgui_window.SurfaceFormat = imgui_vk.SelectSurfaceFormat(vk_physical_device, surface, raw_data(req_surface_img_fmt), i32(len(req_surface_img_fmt)), req_surface_color_space);

	present_modes: [] vk.PresentModeKHR = {.MAILBOX, .IMMEDIATE, .FIFO}
	imgui_window.PresentMode = imgui_vk.SelectPresentMode(vk_physical_device, surface, &present_modes[0], i32(len(present_modes)))
	assert(imgui_vk_min_image_count >= 2)
	w,h: i32
	sdl.GetWindowSize(window, &w, &h)
	imgui_window.ClearEnable = true // This is enabled by default in Cpp; required for the attachment to clear
	imgui_vk.CreateOrResizeWindow(vk_instance, vk_physical_device, vk_device, imgui_window, vk_queue_family, vk_allocator, w, h, imgui_vk_min_image_count)

	imgui.CreateContext(nil)
	io := imgui.GetIO()
	io.ConfigFlags |= imgui.ConfigFlags.NavEnableKeyboard
	io.ConfigFlags |= imgui.ConfigFlags.NavEnableGamepad
	imgui.StyleColorsDark(nil)

	imgui_sdl2.InitForVulkan(window)
	init_info: imgui_vk.InitInfo = {}
	init_info.Allocator = vk_allocator
	check_vk_res :: proc(res: vk.Result) { vk_res_ok(res) }
	init_info.CheckVkResultFn = check_vk_res
	init_info.DescriptorPool = vk_descriptor_pool
	init_info.Device = vk_device
	init_info.ImageCount = imgui_window.ImageCount
	init_info.Instance = vk_instance
	init_info.MSAASamples = {._1}
	init_info.MinImageCount = imgui_vk_min_image_count
	init_info.PhysicalDevice = vk_physical_device
	init_info.PipelineCache = vk_pipeline_cache
	init_info.Queue = vk_queue
	init_info.QueueFamily = vk_queue_family
	init_info.RenderPass = imgui_window.RenderPass
	init_info.Subpass = 0
	imgui_vk.Init(&init_info)

    clear_color: [4]f32 = {0.45, 0.55, 0.60, 1.00}
    _cc := clear_color.xyz
    show_demo_window: b8 = true
    show_another_window: b8 = false
    _f: f32 = 0
    _counter: i32 = 0

	done: b32 = false
	for !done {
		event: sdl.Event
		for sdl.PollEvent(&event) {
			imgui_sdl2.ProcessEvent(&event)
			if event.type == .QUIT do done = true
			if event.type == .WINDOWEVENT && event.window.event == .CLOSE do done = true
		}

		fb_w, fb_h: i32
		sdl.GetWindowSize(window, &fb_w, &fb_h)
		if fb_w > 0 && fb_h > 0 && (imgui_vk_swap_chain_rebuild || imgui_vk_main_window_data.Width != fb_w || imgui_vk_main_window_data.Height != fb_h) {
			imgui_vk.SetMinImageCount(imgui_vk_min_image_count)
			imgui_vk.CreateOrResizeWindow(vk_instance, vk_physical_device, vk_device, &imgui_vk_main_window_data, vk_queue_family, vk_allocator, fb_w, fb_h, imgui_vk_min_image_count)
			imgui_vk_main_window_data.FrameIndex = 0
			imgui_vk_swap_chain_rebuild = false
		}

		imgui_sdl2.NewFrame()
		imgui_vk.NewFrame()
		imgui.NewFrame()

		if show_demo_window do imgui.ShowDemoWindow(&show_demo_window)
        {

            imgui.Begin("Hello, world!")                          // Create a window called "Hello, world!" and append into it.

            imgui.Text("This is some useful text.")               // Display some text (you can use a format strings too)
            imgui.Checkbox("Demo Window", &show_demo_window)      // Edit bools storing our window open/close state
            imgui.Checkbox("Another Window", &show_another_window)

            imgui.SliderFloat("float", &_f, 0.0, 1.0)            // Edit 1 float using a slider from 0.0f to 1.0f
        	_cc = clear_color.xyz
            imgui.ColorEdit3("clear color", &_cc, {}) // Edit 3 floats representing a color
	        imgui.SliderFloat3("clear color", &_cc, 0, 1)
	        clear_color.xyz = _cc


            if imgui.Button("Button") do _counter += 1                            // Buttons return true when clicked (most widgets return true when edited/activated)
                
            imgui.SameLine()
            imgui.Text("counter = %d", _counter)

            imgui.Text("Application average %.3f ms/frame (%.1f FPS)", 1000.0 / io.Framerate, io.Framerate)
            imgui.End()
        }

        // 3. Show another simple window.
        if show_another_window {
            imgui.Begin("Another Window", &show_another_window)   // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
            imgui.Text("Hello from another window!")
            if imgui.Button("Close Me") do show_another_window = false
            imgui.End()
        }

		imgui.Render()

		draw_data: ^imgui.ImDrawData = imgui.GetDrawData()
		
        imgui_window.ClearValue.color.float32[0] = clear_color.x * clear_color.w;
        imgui_window.ClearValue.color.float32[1] = clear_color.y * clear_color.w;
        imgui_window.ClearValue.color.float32[2] = clear_color.z * clear_color.w;
        imgui_window.ClearValue.color.float32[3] = clear_color.w;
		frame_render(imgui_window, draw_data)
		frame_present(imgui_window)


	}

    imgui_vk.DestroyWindow(vk_instance, vk_device, &imgui_vk_main_window_data, vk_allocator);

	vk.DestroyDescriptorPool(vk_device, vk_descriptor_pool,  vk_allocator)
	vk.DestroyDevice(vk_device, vk_allocator)
	vk.DestroyInstance(vk_instance, vk_allocator) 

	sdl.DestroyWindow(window)
	sdl.Quit()
	return true
}

frame_render:: proc(igvk_window: ^imgui_vk.Window, draw_data: ^imgui.ImDrawData) {
	vk_res: vk.Result

	img_acquired_semaphore: vk.Semaphore = igvk_window.FrameSemaphores[igvk_window.SemaphoreIndex].ImageAcquiredSemaphore
	render_complete_semaphore: vk.Semaphore = igvk_window.FrameSemaphores[igvk_window.SemaphoreIndex].RenderCompleteSemaphore
	vk_res = vk.AcquireNextImageKHR(vk_device, igvk_window.Swapchain, max(u64), img_acquired_semaphore, 0, &igvk_window.FrameIndex)

	if vk_res == .ERROR_OUT_OF_DATE_KHR || vk_res == .SUBOPTIMAL_KHR {
		imgui_vk_swap_chain_rebuild = true
		return
	}
	if vk_res == .TIMEOUT do return
	if !vk_res_ok(vk_res) do return

	fd: imgui_vk.Frame = igvk_window.Frames[igvk_window.FrameIndex]
	{

		vk_res = vk.WaitForFences(vk_device, 1, &fd.Fence, true, max(u64))
		if !vk_res_ok(vk_res) do return

		vk_res = vk.ResetFences(vk_device, 1, &fd.Fence)
		if !vk_res_ok(vk_res) do return
	}
	{
		vk_res = vk.ResetCommandPool(vk_device, fd.CommandPool, {})
		if !vk_res_ok(vk_res) do return

		info: vk.CommandBufferBeginInfo = {}
		info.sType = .COMMAND_BUFFER_BEGIN_INFO
		info.flags = {.ONE_TIME_SUBMIT}
		vk_res = vk.BeginCommandBuffer(fd.CommandBuffer, &info)
		if !vk_res_ok(vk_res) do return
	}
	{
		info: vk.RenderPassBeginInfo = {}
		info.sType = .RENDER_PASS_BEGIN_INFO
		info.renderPass = igvk_window.RenderPass
		info.framebuffer = fd.Framebuffer
		info.renderArea.extent.width = u32(igvk_window.Width)
		info.renderArea.extent.height = u32(igvk_window.Height)
		info.clearValueCount = 1
		info.pClearValues = &igvk_window.ClearValue
		vk.CmdBeginRenderPass(fd.CommandBuffer, &info, .INLINE)
	}

	imgui_vk.RenderDrawData(draw_data, fd.CommandBuffer)
	vk.CmdEndRenderPass(fd.CommandBuffer)

	{
		wait_stage: vk.PipelineStageFlags = {.COLOR_ATTACHMENT_OUTPUT}
		info: vk.SubmitInfo = {}
		info.sType = .SUBMIT_INFO
		info.waitSemaphoreCount = 1
		info.pWaitSemaphores = &img_acquired_semaphore
		info.pWaitDstStageMask = &wait_stage
		info.commandBufferCount = 1
		info.pCommandBuffers = &fd.CommandBuffer
		info.signalSemaphoreCount = 1
		info.pSignalSemaphores = &render_complete_semaphore
		vk_res = vk.EndCommandBuffer(fd.CommandBuffer)
		if !vk_res_ok(vk_res) do return
		vk_res = vk.QueueSubmit(vk_queue, 1, &info, fd.Fence)
		if !vk_res_ok(vk_res) do return
	}
}

frame_present:: proc(igvk_window: ^imgui_vk.Window) {
	vk_res: vk.Result
	if imgui_vk_swap_chain_rebuild do return
	render_complete_semaphore := igvk_window.FrameSemaphores[igvk_window.SemaphoreIndex].RenderCompleteSemaphore
	info: vk.PresentInfoKHR = {}
	info.sType = .PRESENT_INFO_KHR
	info.waitSemaphoreCount = 1
	info.pWaitSemaphores = &render_complete_semaphore
	info.swapchainCount = 1
	info.pSwapchains = &igvk_window.Swapchain
	info.pImageIndices = &igvk_window.FrameIndex
	vk_res = vk.QueuePresentKHR(vk_queue, &info)
	if vk_res == .ERROR_OUT_OF_DATE_KHR || vk_res == .SUBOPTIMAL_KHR {
		imgui_vk_swap_chain_rebuild = true
		return
	}
	if !vk_res_ok(vk_res) do return
	igvk_window.SemaphoreIndex = (igvk_window.SemaphoreIndex + 1) % igvk_window.SemaphoreCount
}
