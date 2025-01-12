@echo off
setlocal EnableDelayedExpansion
set SDL2_DIR=C:\tools\SDL2-2.30.11\
set GLFW_DIR=C:\tools\glfw-3.4.bin.WIN64\
set SDL3_DIR="C:\tools\SDL3\"

where /Q cl.exe || (
	set __VSCMD_ARG_NO_LOGO=1
	for /f "tokens=*" %%i in ('"%PROGRAMFILES(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -requires Microsoft.VisualStudio.Workload.NativeDesktop -property installationPath') do set VS=%%i
	if "!VS!" equ "" (
		echo Cannot find VS
		exit /b 1
	)
	call "!VS!\VC\Auxiliary\Build\vcvarsall.bat" amd64 || exit /b 1
)

pushd %~dp0

cl /nologo /Oi /GF /MP /MT /utf-8 /O2 /c ^
	/I imgui\ ^
	imgui\imgui.cpp ^
	imgui\imgui_draw.cpp ^
	imgui\imgui_tables.cpp ^
	imgui\imgui_widgets.cpp ^
	imgui\imgui_demo.cpp ^
	dcimgui.cpp

lib /nologo /out:"lib\dcimgui.lib" ^
	imgui.obj ^
	imgui_draw.obj ^
	imgui_tables.obj ^
	imgui_widgets.obj ^
	imgui_demo.obj ^
	dcimgui.obj

del	imgui.obj ^
	imgui_draw.obj ^
	imgui_tables.obj ^
	imgui_widgets.obj ^
	imgui_demo.obj ^
	dcimgui.obj

if exist %SDL2_DIR% (
	echo Building SDL2 Backend
	cl /nologo /Oi /GF /MP /MT /utf-8 /O2 /c ^
		imgui\backends/imgui_impl_sdl2.cpp ^
		sdl2\impl_sdl2.cpp ^
		/I imgui\ ^
		/I imgui/backends\ ^
		/I %SDL2_DIR%\include 

	lib /nologo /out:"lib\dcimgui_impl_sdl2.lib" ^
		%SDL2_DIR%\lib\x64\SDL2.lib ^
		%SDL2_DIR%\lib\x64\SDL2main.lib ^
		impl_sdl2.obj ^
		imgui_impl_sdl2.obj

	del imgui_impl_sdl2.obj ^
		impl_sdl2.obj
)

if exist %GLFW_DIR% (
	echo Building GLFW Backend
	cl /nologo /Oi /GF /MP /MT /utf-8 /O2 /c ^
		imgui\backends/imgui_impl_glfw.cpp ^
		glfw\impl_glfw.cpp ^
		/I imgui\ ^
		/I imgui/backends\ ^
		/I %GLFW_DIR%\include\

	lib /nologo /out:"lib\dcimgui_impl_glfw.lib" ^
		%GLFW_DIR%\lib-vc2022\glfw3_mt.lib ^
		impl_glfw.obj ^
		imgui_impl_glfw.obj

	del imgui_impl_glfw.obj ^
		impl_glfw.obj
)

if exist %SDL3_DIR% (
	echo Building SDL3 Backend
	cl /nologo /Oi /GF /MP /MT /utf-8 /O2 /c ^
		imgui\backends/imgui_impl_sdl3.cpp ^
		sdl3\impl_sdl3.cpp ^
		/I imgui\ ^
		/I imgui/backends\ ^
		/I %SDL3_DIR%\include ^
		/link %SDL3_DIR%\lib\x64\SDL3.lib %SDL3_DIR%\lib\x64\SDL3main.lib 

	lib /nologo /out:"lib\dcimgui_impl_sdl3.lib" ^
		impl_sdl3.obj ^
		imgui_impl_sdl3.obj

	del imgui_impl_sdl3.obj ^
		impl_sdl3.obj
)


	echo Building OpenGL3 Backend

	cl /nologo /Oi /GF /MP /MT /utf-8 /O2 /c ^
		imgui/backends/imgui_impl_opengl3.cpp ^
		opengl3/impl_opengl3.cpp ^
		/I imgui\ ^
		/I imgui\backends\

	lib /nologo /out:".\lib\dcimgui_impl_opengl3.lib" ^
		impl_opengl3.obj ^
		imgui_impl_opengl3.obj ^
		Opengl32.lib

	del imgui_impl_opengl3.obj ^
		impl_opengl3.obj


if exist %VULKAN_SDK% (
	echo Building Vulkan Backend
	cl /nologo /Oi /GF /MP /MT /utf-8 /O2 /c ^
		imgui/backends/imgui_impl_vulkan.cpp ^
		vulkan/impl_vulkan.cpp ^
		/I imgui\ ^
		/I imgui\backends\ ^
		/I %VULKAN_SDK%\Include\ 

	lib /nologo /out:".\lib\dcimgui_impl_vulkan.lib" ^
		impl_vulkan.obj ^
		imgui_impl_vulkan.obj ^
		%VULKAN_SDK%\Lib\vulkan-1.lib

	del imgui_impl_vulkan.obj ^
		impl_vulkan.obj
)

popd

rem @echo off
rem setlocal

rem REM Define the file to check
rem set "fileToCheck="

rem REM Get the last modified date of the file
rem forfiles /p "%fileToCheck%" /c "cmd /c echo @fdate" > lastModifiedDate.txt

rem REM Read the last modified date
rem set /p lastModified=<lastModifiedDate.txt

rem REM Define the stored date (you can store this in a file or a variable)
rem set storedDate=2024-01-01

rem REM Compare dates
rem if "%lastModified%" neq "%storedDate%" (
rem     REM File has been modified, execute build command
rem     echo Building...
rem     REM Add your build command here
rem     REM Example: call build.bat
rem ) else (
rem     echo No changes detected.
rem )

rem endlocal