package impl_glfw_vulkan
import "core:fmt"
import "core:strings"
import "core:bytes"
import "base:runtime"
import "vendor:glfw"
import vk "vendor:vulkan"

import imgui ".."
import imgui_glfw "../glfw"
import imgui_vk "../vulkan"

vk_allocator: ^vk.AllocationCallbacks = nil
vk_instance: vk.Instance = nil
vk_physical_device: vk.PhysicalDevice = nil
vk_device: vk.Device = nil
vk_queue_family: u32 = max(u32)
vk_queue: vk.Queue = nil
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

glfw_error_cb :: proc "c" (error: i32, desc: cstring) {
    context = runtime.default_context()
    fmt.eprintln("[GLFW Error]", error, desc)
}

run :: proc() -> b32 {
    glfw.SetErrorCallback(glfw_error_cb)
    glfw.Init() or_return
    glfw.WindowHint(glfw.CLIENT_API, glfw.NO_API)

	window := glfw.CreateWindow(
		1280,
		720,
		"Test",
		nil,
		nil
	)

	glfw.VulkanSupported() or_return
	vk.load_proc_addresses(glfw.GetInstanceProcAddress(nil, "vkGetInstanceProcAddr"))
	vk_res: vk.Result
	extensions := make([dynamic]cstring)
	defer delete(extensions)
	for ext in glfw.GetRequiredInstanceExtensions() do append(&extensions, ext)

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

		vk_res = vk.CreateInstance(&create_info, vk_allocator, &vk_instance)
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
	vk_res = glfw.CreateWindowSurface(vk_instance, window, vk_allocator, &surface) 
	vk_res_ok(vk_res) or_return	

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
    imgui_window.SurfaceFormat = imgui_vk.SelectSurfaceFormat(vk_physical_device, surface, raw_data(req_surface_img_fmt), i32(len(req_surface_img_fmt)), req_surface_color_space)

	present_modes: [] vk.PresentModeKHR = {.MAILBOX, .IMMEDIATE, .FIFO}
	imgui_window.PresentMode = imgui_vk.SelectPresentMode(vk_physical_device, surface, raw_data(present_modes), i32(len(present_modes)))
	assert(imgui_vk_min_image_count >= 2)
	fb_w, fb_h := glfw.GetFramebufferSize(window)
	imgui_window.ClearEnable = true // This is enabled by default in Cpp; required for the attachment to clear
	imgui_vk.CreateOrResizeWindow(vk_instance, vk_physical_device, vk_device, imgui_window, vk_queue_family, vk_allocator, fb_w, fb_h, imgui_vk_min_image_count)

	imgui.CreateContext(nil)
	io := imgui.GetIO()
	io.ConfigFlags |= imgui.ConfigFlags.NavEnableKeyboard
	io.ConfigFlags |= imgui.ConfigFlags.NavEnableGamepad
	imgui.StyleColorsDark(nil)

	imgui_glfw.InitForVulkan(window, true)
	init_info: imgui_vk.InitInfo = {}
	init_info.Instance = vk_instance
	init_info.PhysicalDevice = vk_physical_device
	init_info.Device = vk_device
	init_info.QueueFamily = vk_queue_family
	init_info.Queue = vk_queue
	init_info.PipelineCache = vk_pipeline_cache
	init_info.DescriptorPool = vk_descriptor_pool
	init_info.RenderPass = imgui_window.RenderPass
	init_info.Subpass = 0
	init_info.MinImageCount = imgui_vk_min_image_count
	init_info.ImageCount = imgui_window.ImageCount
	init_info.MSAASamples = {._1}
	init_info.Allocator = vk_allocator
	check_vk_res :: proc(res: vk.Result) { vk_res_ok(res) }
	init_info.CheckVkResultFn = check_vk_res
	imgui_vk.Init(&init_info)

    clear_color: [4]f32 = {0.45, 0.55, 0.60, 1.00}
    _cc := clear_color.xyz
    show_demo_window: b8 = true
    show_another_window: b8 = false
    _f: f32 = 0
    _counter: i32 = 0


	for !glfw.WindowShouldClose(window) {
        glfw.PollEvents()


		fb_w, fb_h = glfw.GetFramebufferSize(window)
		if fb_w > 0 && fb_h > 0 && (imgui_vk_swap_chain_rebuild || imgui_vk_main_window_data.Width != fb_w || imgui_vk_main_window_data.Height != fb_h) {
			imgui_vk.SetMinImageCount(imgui_vk_min_image_count)
			imgui_vk.CreateOrResizeWindow(vk_instance, vk_physical_device, vk_device, &imgui_vk_main_window_data, vk_queue_family, vk_allocator, fb_w, fb_h, imgui_vk_min_image_count)
			imgui_vk_main_window_data.FrameIndex = 0
			imgui_vk_swap_chain_rebuild = false
		}

        if glfw.GetWindowAttrib(window, glfw.ICONIFIED) != 0 {
            imgui_glfw.Sleep(10)
            continue
        }

		imgui_vk.NewFrame()
        imgui_glfw.NewFrame()
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
		is_minimized := draw_data.DisplaySize.x <= 0 || draw_data.DisplaySize.y <= 0
		if !is_minimized {
	        imgui_window.ClearValue.color.float32.r = clear_color.r * clear_color.a
	        imgui_window.ClearValue.color.float32.g = clear_color.g * clear_color.a
	        imgui_window.ClearValue.color.float32.b = clear_color.b * clear_color.a
	        imgui_window.ClearValue.color.float32.a = clear_color.a
			frame_render(imgui_window, draw_data)
			frame_present(imgui_window)
		}
	}
	vk_res = vk.DeviceWaitIdle(vk_device)
	vk_res_ok(vk_res) or_return
	imgui_vk.Shutdown()
	imgui_glfw.Shutdown()
	imgui.DestroyContext(nil)

    imgui_vk.DestroyWindow(vk_instance, vk_device, &imgui_vk_main_window_data, vk_allocator)
	vk.DestroyDescriptorPool(vk_device, vk_descriptor_pool,  vk_allocator)
	vk.DestroyDevice(vk_device, vk_allocator)
	vk.DestroyInstance(vk_instance, vk_allocator) 

    glfw.DestroyWindow(window)
    glfw.Terminate()
	return true
}

frame_render:: proc(imgui_vk_window: ^imgui_vk.Window, draw_data: ^imgui.ImDrawData) {
	vk_res: vk.Result

	img_acquired_semaphore: vk.Semaphore = imgui_vk_window.FrameSemaphores[imgui_vk_window.SemaphoreIndex].ImageAcquiredSemaphore
	render_complete_semaphore: vk.Semaphore = imgui_vk_window.FrameSemaphores[imgui_vk_window.SemaphoreIndex].RenderCompleteSemaphore
	vk_res = vk.AcquireNextImageKHR(vk_device, imgui_vk_window.Swapchain, max(u64), img_acquired_semaphore, 0, &imgui_vk_window.FrameIndex)
	
	if vk_res == .TIMEOUT do return
	if vk_res == .ERROR_OUT_OF_DATE_KHR || vk_res == .SUBOPTIMAL_KHR {
		imgui_vk_swap_chain_rebuild = true
		return
	}
	if !vk_res_ok(vk_res) do return

	fd: imgui_vk.Frame = imgui_vk_window.Frames[imgui_vk_window.FrameIndex]
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
		info.renderPass = imgui_vk_window.RenderPass
		info.framebuffer = fd.Framebuffer
		info.renderArea.extent.width = u32(imgui_vk_window.Width)
		info.renderArea.extent.height = u32(imgui_vk_window.Height)
		info.clearValueCount = 1
		info.pClearValues = &imgui_vk_window.ClearValue
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
