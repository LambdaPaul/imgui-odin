package imgui

when ODIN_OS == .Windows {
	foreign import imgui "lib/dcimgui.lib"
} 
else when ODIN_OS == .Linux {
	foreign import imgui "lib/linux/libdcimgui.a"
}
else when ODIN_OS == .Darwin {
    foreign import imgui "lib/darwin/libdcimgui_arm64.a"
}

va_list :: struct #align(16) {
	_: [4096]u8,
}

WindowFlags :: enum i32 {
	None = 0,
	NoTitleBar = 1,
	NoResize = 2,
	NoMove = 4,
	NoScrollbar = 8,
	NoScrollWithMouse = 16,
	NoCollapse = 32,
	AlwaysAutoResize = 64,
	NoBackground = 128,
	NoSavedSettings = 256,
	NoMouseInputs = 512,
	MenuBar = 1024,
	HorizontalScrollbar = 2048,
	NoFocusOnAppearing = 4096,
	NoBringToFrontOnFocus = 8192,
	AlwaysVerticalScrollbar = 16384,
	AlwaysHorizontalScrollbar = 32768,
	NoNavInputs = 65536,
	NoNavFocus = 131072,
	UnsavedDocument = 262144,
	NoNav = 196608,
	NoDecoration = 43,
	NoInputs = 197120,
	ChildWindow = 16777216,
	Tooltip = 33554432,
	Popup = 67108864,
	Modal = 134217728,
	ChildMenu = 268435456,
}
ChildFlags :: enum i32 {
	None = 0,
	Borders = 1,
	AlwaysUseWindowPadding = 2,
	ResizeX = 4,
	ResizeY = 8,
	AutoResizeX = 16,
	AutoResizeY = 32,
	AlwaysAutoResize = 64,
	FrameStyle = 128,
	NavFlattened = 256,
	Border = 1,
}
ItemFlags :: enum i32 {
	None = 0,
	NoTabStop = 1,
	NoNav = 2,
	NoNavDefaultFocus = 4,
	ButtonRepeat = 8,
	AutoClosePopups = 16,
	AllowDuplicateId = 32,
}
InputTextFlags :: enum i32 {
	None = 0,
	CharsDecimal = 1,
	CharsHexadecimal = 2,
	CharsScientific = 4,
	CharsUppercase = 8,
	CharsNoBlank = 16,
	AllowTabInput = 32,
	EnterReturnsTrue = 64,
	EscapeClearsAll = 128,
	CtrlEnterForNewLine = 256,
	ReadOnly = 512,
	Password = 1024,
	AlwaysOverwrite = 2048,
	AutoSelectAll = 4096,
	ParseEmptyRefVal = 8192,
	DisplayEmptyRefVal = 16384,
	NoHorizontalScroll = 32768,
	NoUndoRedo = 65536,
	ElideLeft = 131072,
	CallbackCompletion = 262144,
	CallbackHistory = 524288,
	CallbackAlways = 1048576,
	CallbackCharFilter = 2097152,
	CallbackResize = 4194304,
	CallbackEdit = 8388608,
}
TreeNodeFlags :: enum i32 {
	None = 0,
	Selected = 1,
	Framed = 2,
	AllowOverlap = 4,
	NoTreePushOnOpen = 8,
	NoAutoOpenOnLog = 16,
	DefaultOpen = 32,
	OpenOnDoubleClick = 64,
	OpenOnArrow = 128,
	Leaf = 256,
	Bullet = 512,
	FramePadding = 1024,
	SpanAvailWidth = 2048,
	SpanFullWidth = 4096,
	SpanTextWidth = 8192,
	SpanAllColumns = 16384,
	NavLeftJumpsBackHere = 32768,
	CollapsingHeader = 26,
	AllowItemOverlap = 4,
}
PopupFlags :: enum i32 {
	None = 0,
	MouseButtonLeft = 0,
	MouseButtonRight = 1,
	MouseButtonMiddle = 2,
	MouseButtonMask_ = 31,
	MouseButtonDefault_ = 1,
	NoReopen = 32,
	NoOpenOverExistingPopup = 128,
	NoOpenOverItems = 256,
	AnyPopupId = 1024,
	AnyPopupLevel = 2048,
	AnyPopup = 3072,
}
SelectableFlags :: enum i32 {
	None = 0,
	NoAutoClosePopups = 1,
	SpanAllColumns = 2,
	AllowDoubleClick = 4,
	Disabled = 8,
	AllowOverlap = 16,
	Highlight = 32,
	DontClosePopups = 1,
	AllowItemOverlap = 16,
}
ComboFlags :: enum i32 {
	None = 0,
	PopupAlignLeft = 1,
	HeightSmall = 2,
	HeightRegular = 4,
	HeightLarge = 8,
	HeightLargest = 16,
	NoArrowButton = 32,
	NoPreview = 64,
	WidthFitPreview = 128,
	HeightMask_ = 30,
}
TabBarFlags :: enum i32 {
	None = 0,
	Reorderable = 1,
	AutoSelectNewTabs = 2,
	TabListPopupButton = 4,
	NoCloseWithMiddleMouseButton = 8,
	NoTabListScrollingButtons = 16,
	NoTooltip = 32,
	DrawSelectedOverline = 64,
	FittingPolicyResizeDown = 128,
	FittingPolicyScroll = 256,
	FittingPolicyMask_ = 384,
	FittingPolicyDefault_ = 128,
}
TabItemFlags :: enum i32 {
	None = 0,
	UnsavedDocument = 1,
	SetSelected = 2,
	NoCloseWithMiddleMouseButton = 4,
	NoPushId = 8,
	NoTooltip = 16,
	NoReorder = 32,
	Leading = 64,
	Trailing = 128,
	NoAssumedClosure = 256,
}
FocusedFlags :: enum i32 {
	None = 0,
	ChildWindows = 1,
	RootWindow = 2,
	AnyWindow = 4,
	NoPopupHierarchy = 8,
	RootAndChildWindows = 3,
}
HoveredFlags :: enum i32 {
	None = 0,
	ChildWindows = 1,
	RootWindow = 2,
	AnyWindow = 4,
	NoPopupHierarchy = 8,
	AllowWhenBlockedByPopup = 32,
	AllowWhenBlockedByActiveItem = 128,
	AllowWhenOverlappedByItem = 256,
	AllowWhenOverlappedByWindow = 512,
	AllowWhenDisabled = 1024,
	NoNavOverride = 2048,
	AllowWhenOverlapped = 768,
	RectOnly = 928,
	RootAndChildWindows = 3,
	ForTooltip = 4096,
	Stationary = 8192,
	DelayNone = 16384,
	DelayShort = 32768,
	DelayNormal = 65536,
	NoSharedDelay = 131072,
}
DragDropFlags :: enum i32 {
	None = 0,
	SourceNoPreviewTooltip = 1,
	SourceNoDisableHover = 2,
	SourceNoHoldToOpenOthers = 4,
	SourceAllowNullID = 8,
	SourceExtern = 16,
	PayloadAutoExpire = 32,
	PayloadNoCrossContext = 64,
	PayloadNoCrossProcess = 128,
	AcceptBeforeDelivery = 1024,
	AcceptNoDrawDefaultRect = 2048,
	AcceptNoPreviewTooltip = 4096,
	AcceptPeekOnly = 3072,
	SourceAutoExpirePayload = 32,
}
DataType :: enum i32 {
	S8 = 0,
	U8 = 1,
	S16 = 2,
	U16 = 3,
	S32 = 4,
	U32 = 5,
	S64 = 6,
	U64 = 7,
	Float = 8,
	Double = 9,
	Bool = 10,
	COUNT = 11,
}
Dir :: enum i32 {
	None = -1,
	Left = 0,
	Right = 1,
	Up = 2,
	Down = 3,
	COUNT = 4,
}
SortDirection :: enum i32 {
	None = 0,
	Ascending = 1,
	Descending = 2,
}
Key :: enum i32 {
	None = 0,
	NamedKey_BEGIN = 512,
	Tab = 512,
	LeftArrow = 513,
	RightArrow = 514,
	UpArrow = 515,
	DownArrow = 516,
	PageUp = 517,
	PageDown = 518,
	Home = 519,
	End = 520,
	Insert = 521,
	Delete = 522,
	Backspace = 523,
	Space = 524,
	Enter = 525,
	Escape = 526,
	LeftCtrl = 527,
	LeftShift = 528,
	LeftAlt = 529,
	LeftSuper = 530,
	RightCtrl = 531,
	RightShift = 532,
	RightAlt = 533,
	RightSuper = 534,
	Menu = 535,
	Num0 = 536,
	Num1 = 537,
	Num2 = 538,
	Num3 = 539,
	Num4 = 540,
	Num5 = 541,
	Num6 = 542,
	Num7 = 543,
	Num8 = 544,
	Num9 = 545,
	A = 546,
	B = 547,
	C = 548,
	D = 549,
	E = 550,
	F = 551,
	G = 552,
	H = 553,
	I = 554,
	J = 555,
	K = 556,
	L = 557,
	M = 558,
	N = 559,
	O = 560,
	P = 561,
	Q = 562,
	R = 563,
	S = 564,
	T = 565,
	U = 566,
	V = 567,
	W = 568,
	X = 569,
	Y = 570,
	Z = 571,
	F1 = 572,
	F2 = 573,
	F3 = 574,
	F4 = 575,
	F5 = 576,
	F6 = 577,
	F7 = 578,
	F8 = 579,
	F9 = 580,
	F10 = 581,
	F11 = 582,
	F12 = 583,
	F13 = 584,
	F14 = 585,
	F15 = 586,
	F16 = 587,
	F17 = 588,
	F18 = 589,
	F19 = 590,
	F20 = 591,
	F21 = 592,
	F22 = 593,
	F23 = 594,
	F24 = 595,
	Apostrophe = 596,
	Comma = 597,
	Minus = 598,
	Period = 599,
	Slash = 600,
	Semicolon = 601,
	Equal = 602,
	LeftBracket = 603,
	Backslash = 604,
	RightBracket = 605,
	GraveAccent = 606,
	CapsLock = 607,
	ScrollLock = 608,
	NumLock = 609,
	PrintScreen = 610,
	Pause = 611,
	Keypad0 = 612,
	Keypad1 = 613,
	Keypad2 = 614,
	Keypad3 = 615,
	Keypad4 = 616,
	Keypad5 = 617,
	Keypad6 = 618,
	Keypad7 = 619,
	Keypad8 = 620,
	Keypad9 = 621,
	KeypadDecimal = 622,
	KeypadDivide = 623,
	KeypadMultiply = 624,
	KeypadSubtract = 625,
	KeypadAdd = 626,
	KeypadEnter = 627,
	KeypadEqual = 628,
	AppBack = 629,
	AppForward = 630,
	GamepadStart = 631,
	GamepadBack = 632,
	GamepadFaceLeft = 633,
	GamepadFaceRight = 634,
	GamepadFaceUp = 635,
	GamepadFaceDown = 636,
	GamepadDpadLeft = 637,
	GamepadDpadRight = 638,
	GamepadDpadUp = 639,
	GamepadDpadDown = 640,
	GamepadL1 = 641,
	GamepadR1 = 642,
	GamepadL2 = 643,
	GamepadR2 = 644,
	GamepadL3 = 645,
	GamepadR3 = 646,
	GamepadLStickLeft = 647,
	GamepadLStickRight = 648,
	GamepadLStickUp = 649,
	GamepadLStickDown = 650,
	GamepadRStickLeft = 651,
	GamepadRStickRight = 652,
	GamepadRStickUp = 653,
	GamepadRStickDown = 654,
	MouseLeft = 655,
	MouseRight = 656,
	MouseMiddle = 657,
	MouseX1 = 658,
	MouseX2 = 659,
	MouseWheelX = 660,
	MouseWheelY = 661,
	ReservedForModCtrl = 662,
	ReservedForModShift = 663,
	ReservedForModAlt = 664,
	ReservedForModSuper = 665,
	NamedKey_END = 666,
	ImGuiMod_None = 0,
	ImGuiMod_Ctrl = 4096,
	ImGuiMod_Shift = 8192,
	ImGuiMod_Alt = 16384,
	ImGuiMod_Super = 32768,
	ImGuiMod_Mask_ = 61440,
	NamedKey_COUNT = 154,
	COUNT = 666,
	ImGuiMod_Shortcut = 4096,
	ModCtrl = 4096,
	ModShift = 8192,
	ModAlt = 16384,
	ModSuper = 32768,
}
InputFlags :: enum i32 {
	None = 0,
	Repeat = 1,
	RouteActive = 1024,
	RouteFocused = 2048,
	RouteGlobal = 4096,
	RouteAlways = 8192,
	RouteOverFocused = 16384,
	RouteOverActive = 32768,
	RouteUnlessBgFocused = 65536,
	RouteFromRootWindow = 131072,
	Tooltip = 262144,
}
ConfigFlags :: enum i32 {
	None = 0,
	NavEnableKeyboard = 1,
	NavEnableGamepad = 2,
	NoMouse = 16,
	NoMouseCursorChange = 32,
	NoKeyboard = 64,
	IsSRGB = 1048576,
	IsTouchScreen = 2097152,
	NavEnableSetMousePos = 4,
	NavNoCaptureKeyboard = 8,
}
BackendFlags :: enum i32 {
	None = 0,
	HasGamepad = 1,
	HasMouseCursors = 2,
	HasSetMousePos = 4,
	RendererHasVtxOffset = 8,
}
Col :: enum i32 {
	Text = 0,
	TextDisabled = 1,
	WindowBg = 2,
	ChildBg = 3,
	PopupBg = 4,
	Border = 5,
	BorderShadow = 6,
	FrameBg = 7,
	FrameBgHovered = 8,
	FrameBgActive = 9,
	TitleBg = 10,
	TitleBgActive = 11,
	TitleBgCollapsed = 12,
	MenuBarBg = 13,
	ScrollbarBg = 14,
	ScrollbarGrab = 15,
	ScrollbarGrabHovered = 16,
	ScrollbarGrabActive = 17,
	CheckMark = 18,
	SliderGrab = 19,
	SliderGrabActive = 20,
	Button = 21,
	ButtonHovered = 22,
	ButtonActive = 23,
	Header = 24,
	HeaderHovered = 25,
	HeaderActive = 26,
	Separator = 27,
	SeparatorHovered = 28,
	SeparatorActive = 29,
	ResizeGrip = 30,
	ResizeGripHovered = 31,
	ResizeGripActive = 32,
	TabHovered = 33,
	Tab = 34,
	TabSelected = 35,
	TabSelectedOverline = 36,
	TabDimmed = 37,
	TabDimmedSelected = 38,
	TabDimmedSelectedOverline = 39,
	PlotLines = 40,
	PlotLinesHovered = 41,
	PlotHistogram = 42,
	PlotHistogramHovered = 43,
	TableHeaderBg = 44,
	TableBorderStrong = 45,
	TableBorderLight = 46,
	TableRowBg = 47,
	TableRowBgAlt = 48,
	TextLink = 49,
	TextSelectedBg = 50,
	DragDropTarget = 51,
	NavCursor = 52,
	NavWindowingHighlight = 53,
	NavWindowingDimBg = 54,
	ModalWindowDimBg = 55,
	COUNT = 56,
	TabActive = 35,
	TabUnfocused = 37,
	TabUnfocusedActive = 38,
	NavHighlight = 52,
}
StyleVar :: enum i32 {
	Alpha = 0,
	DisabledAlpha = 1,
	WindowPadding = 2,
	WindowRounding = 3,
	WindowBorderSize = 4,
	WindowMinSize = 5,
	WindowTitleAlign = 6,
	ChildRounding = 7,
	ChildBorderSize = 8,
	PopupRounding = 9,
	PopupBorderSize = 10,
	FramePadding = 11,
	FrameRounding = 12,
	FrameBorderSize = 13,
	ItemSpacing = 14,
	ItemInnerSpacing = 15,
	IndentSpacing = 16,
	CellPadding = 17,
	ScrollbarSize = 18,
	ScrollbarRounding = 19,
	GrabMinSize = 20,
	GrabRounding = 21,
	TabRounding = 22,
	TabBorderSize = 23,
	TabBarBorderSize = 24,
	TabBarOverlineSize = 25,
	TableAngledHeadersAngle = 26,
	TableAngledHeadersTextAlign = 27,
	ButtonTextAlign = 28,
	SelectableTextAlign = 29,
	SeparatorTextBorderSize = 30,
	SeparatorTextAlign = 31,
	SeparatorTextPadding = 32,
	COUNT = 33,
}
ButtonFlags :: enum i32 {
	None = 0,
	MouseButtonLeft = 1,
	MouseButtonRight = 2,
	MouseButtonMiddle = 4,
	MouseButtonMask_ = 7,
	EnableNav = 8,
}
ColorEditFlags :: enum i32 {
	None = 0,
	NoAlpha = 2,
	NoPicker = 4,
	NoOptions = 8,
	NoSmallPreview = 16,
	NoInputs = 32,
	NoTooltip = 64,
	NoLabel = 128,
	NoSidePreview = 256,
	NoDragDrop = 512,
	NoBorder = 1024,
	AlphaBar = 65536,
	AlphaPreview = 131072,
	AlphaPreviewHalf = 262144,
	HDR = 524288,
	DisplayRGB = 1048576,
	DisplayHSV = 2097152,
	DisplayHex = 4194304,
	Uint8 = 8388608,
	Float = 16777216,
	PickerHueBar = 33554432,
	PickerHueWheel = 67108864,
	InputRGB = 134217728,
	InputHSV = 268435456,
	DefaultOptions_ = 177209344,
	DisplayMask_ = 7340032,
	DataTypeMask_ = 25165824,
	PickerMask_ = 100663296,
	InputMask_ = 402653184,
}
SliderFlags :: enum i32 {
	None = 0,
	Logarithmic = 32,
	NoRoundToFormat = 64,
	NoInput = 128,
	WrapAround = 256,
	ClampOnInput = 512,
	ClampZeroRange = 1024,
	NoSpeedTweaks = 2048,
	AlwaysClamp = 1536,
	InvalidMask_ = 1879048207,
}
MouseButton :: enum i32 {
	Left = 0,
	Right = 1,
	Middle = 2,
	COUNT = 5,
}
MouseCursor :: enum i32 {
	None = -1,
	Arrow = 0,
	TextInput = 1,
	ResizeAll = 2,
	ResizeNS = 3,
	ResizeEW = 4,
	ResizeNESW = 5,
	ResizeNWSE = 6,
	Hand = 7,
	NotAllowed = 8,
	COUNT = 9,
}
MouseSource :: enum i32 {
	Mouse = 0,
	TouchScreen = 1,
	Pen = 2,
	COUNT = 3,
}
Cond :: enum i32 {
	None = 0,
	Always = 1,
	Once = 2,
	FirstUseEver = 4,
	Appearing = 8,
}
TableFlags :: enum i32 {
	None = 0,
	Resizable = 1,
	Reorderable = 2,
	Hideable = 4,
	Sortable = 8,
	NoSavedSettings = 16,
	ContextMenuInBody = 32,
	RowBg = 64,
	BordersInnerH = 128,
	BordersOuterH = 256,
	BordersInnerV = 512,
	BordersOuterV = 1024,
	BordersH = 384,
	BordersV = 1536,
	BordersInner = 640,
	BordersOuter = 1280,
	Borders = 1920,
	NoBordersInBody = 2048,
	NoBordersInBodyUntilResize = 4096,
	SizingFixedFit = 8192,
	SizingFixedSame = 16384,
	SizingStretchProp = 24576,
	SizingStretchSame = 32768,
	NoHostExtendX = 65536,
	NoHostExtendY = 131072,
	NoKeepColumnsVisible = 262144,
	PreciseWidths = 524288,
	NoClip = 1048576,
	PadOuterX = 2097152,
	NoPadOuterX = 4194304,
	NoPadInnerX = 8388608,
	ScrollX = 16777216,
	ScrollY = 33554432,
	SortMulti = 67108864,
	SortTristate = 134217728,
	HighlightHoveredColumn = 268435456,
	SizingMask_ = 57344,
}
TableColumnFlags :: enum i32 {
	None = 0,
	Disabled = 1,
	DefaultHide = 2,
	DefaultSort = 4,
	WidthStretch = 8,
	WidthFixed = 16,
	NoResize = 32,
	NoReorder = 64,
	NoHide = 128,
	NoClip = 256,
	NoSort = 512,
	NoSortAscending = 1024,
	NoSortDescending = 2048,
	NoHeaderLabel = 4096,
	NoHeaderWidth = 8192,
	PreferSortAscending = 16384,
	PreferSortDescending = 32768,
	IndentEnable = 65536,
	IndentDisable = 131072,
	AngledHeader = 262144,
	IsEnabled = 16777216,
	IsVisible = 33554432,
	IsSorted = 67108864,
	IsHovered = 134217728,
	WidthMask_ = 24,
	IndentMask_ = 196608,
	StatusMask_ = 251658240,
	NoDirectResize_ = 1073741824,
}
TableRowFlags :: enum i32 {
	None = 0,
	Headers = 1,
}
TableBgTarget :: enum i32 {
	None = 0,
	RowBg0 = 1,
	RowBg1 = 2,
	CellBg = 3,
}
MultiSelectFlags :: enum i32 {
	None = 0,
	SingleSelect = 1,
	NoSelectAll = 2,
	NoRangeSelect = 4,
	NoAutoSelect = 8,
	NoAutoClear = 16,
	NoAutoClearOnReselect = 32,
	BoxSelect1d = 64,
	BoxSelect2d = 128,
	BoxSelectNoScroll = 256,
	ClearOnEscape = 512,
	ClearOnClickVoid = 1024,
	ScopeWindow = 2048,
	ScopeRect = 4096,
	SelectOnClick = 8192,
	SelectOnClickRelease = 16384,
	NavWrapX = 65536,
}
SelectionRequestType :: enum i32 {
	None = 0,
	SetAll = 1,
	SetRange = 2,
}
ImDrawFlags :: enum i32 {
	None = 0,
	Closed = 1,
	RoundCornersTopLeft = 16,
	RoundCornersTopRight = 32,
	RoundCornersBottomLeft = 64,
	RoundCornersBottomRight = 128,
	RoundCornersNone = 256,
	RoundCornersTop = 48,
	RoundCornersBottom = 192,
	RoundCornersLeft = 80,
	RoundCornersRight = 160,
	RoundCornersAll = 240,
	RoundCornersDefault_ = 240,
	RoundCornersMask_ = 496,
}
ImDrawListFlags :: enum i32 {
	None = 0,
	AntiAliasedLines = 1,
	AntiAliasedLinesUseTex = 2,
	AntiAliasedFill = 4,
	AllowVtxOffset = 8,
}
ImFontAtlasFlags :: enum i32 {
	None = 0,
	NoPowerOfTwoHeight = 1,
	NoMouseCursors = 2,
	NoBakedLines = 4,
}
ViewportFlags :: enum i32 {
	None = 0,
	IsPlatformWindow = 1,
	IsPlatformMonitor = 2,
	OwnedByApp = 4,
}
ID :: u32
ImS8 :: i8
ImU8 :: u8
ImS16 :: i16
ImU16 :: u16
ImS32 :: i32
ImU32 :: u32
ImS64 :: i64
ImU64 :: u64
KeyChord :: i32
ImTextureID :: ImU64
ImDrawIdx :: u16
ImWchar32 :: u32
ImWchar16 :: u16
ImWchar :: ImWchar32
SelectionUserData :: ImS64
InputTextCallback :: proc "c" (data: ^InputTextCallbackData) -> i32
SizeCallback :: proc "c" (data: ^SizeCallbackData)
MemAllocFunc :: proc "c" (sz: u32, user_data: rawptr) -> rawptr
MemFreeFunc :: proc "c" (ptr: rawptr, user_data: rawptr)
ImDrawCallback :: proc "c" (parent_list: ^ImDrawList, cmd: ^ImDrawCmd)
@(default_calling_convention = "cdecl", link_prefix = "ImGui_")
foreign imgui {
	CreateContext :: proc(shared_font_atlas: ^ImFontAtlas = nil) -> ^Context ---
	DestroyContext :: proc(ctx: ^Context = nil) ---
	GetCurrentContext :: proc() -> ^Context ---
	SetCurrentContext :: proc(ctx: ^Context) ---
	GetIO :: proc() -> ^IO ---
	GetPlatformIO :: proc() -> ^PlatformIO ---
	GetStyle :: proc() -> ^Style ---
	NewFrame :: proc() ---
	EndFrame :: proc() ---
	Render :: proc() ---
	GetDrawData :: proc() -> ^ImDrawData ---
	ShowDemoWindow :: proc(p_open: ^b8 = nil) ---
	ShowMetricsWindow :: proc(p_open: ^b8) ---
	ShowDebugLogWindow :: proc(p_open: ^b8) ---
	ShowIDStackToolWindow :: proc() ---
	ShowIDStackToolWindowEx :: proc(p_open: ^b8) ---
	ShowAboutWindow :: proc(p_open: ^b8) ---
	ShowStyleEditor :: proc(ref: ^Style) ---
	ShowStyleSelector :: proc(label: cstring) -> b8 ---
	ShowFontSelector :: proc(label: cstring) ---
	ShowUserGuide :: proc() ---
	GetVersion :: proc() -> cstring ---
	StyleColorsDark :: proc(dst: ^Style) ---
	StyleColorsLight :: proc(dst: ^Style) ---
	StyleColorsClassic :: proc(dst: ^Style) ---
	Begin :: proc(name: cstring, p_open: ^b8 = nil, flags: WindowFlags = .None) -> b8 ---
	End :: proc() ---
	BeginChild :: proc(str_id: cstring, size: ImVec2, child_flags: ChildFlags, window_flags: WindowFlags) -> b8 ---
	BeginChildID :: proc(id: ID, size: ImVec2, child_flags: ChildFlags, window_flags: WindowFlags) -> b8 ---
	EndChild :: proc() ---
	IsWindowAppearing :: proc() -> b8 ---
	IsWindowCollapsed :: proc() -> b8 ---
	IsWindowFocused :: proc(flags: FocusedFlags) -> b8 ---
	IsWindowHovered :: proc(flags: HoveredFlags) -> b8 ---
	GetWindowDrawList :: proc() -> ^ImDrawList ---
	GetWindowPos :: proc() -> ImVec2 ---
	GetWindowSize :: proc() -> ImVec2 ---
	GetWindowWidth :: proc() -> f32 ---
	GetWindowHeight :: proc() -> f32 ---
	SetNextWindowPos :: proc(pos: ImVec2, cond: Cond) ---
	SetNextWindowPosEx :: proc(pos: ImVec2, cond: Cond, pivot: ImVec2) ---
	SetNextWindowSize :: proc(size: ImVec2, cond: Cond) ---
	SetNextWindowSizeConstraints :: proc(size_min: ImVec2, size_max: ImVec2, custom_callback: SizeCallback, custom_callback_data: rawptr) ---
	SetNextWindowContentSize :: proc(size: ImVec2) ---
	SetNextWindowCollapsed :: proc(collapsed: b8, cond: Cond) ---
	SetNextWindowFocus :: proc() ---
	SetNextWindowScroll :: proc(scroll: ImVec2) ---
	SetNextWindowBgAlpha :: proc(alpha: f32) ---
	SetWindowPos :: proc(pos: ImVec2, cond: Cond) ---
	SetWindowSize :: proc(size: ImVec2, cond: Cond) ---
	SetWindowCollapsed :: proc(collapsed: b8, cond: Cond) ---
	SetWindowFocus :: proc() ---
	SetWindowFontScale :: proc(scale: f32) ---
	SetWindowPosStr :: proc(name: cstring, pos: ImVec2, cond: Cond) ---
	SetWindowSizeStr :: proc(name: cstring, size: ImVec2, cond: Cond) ---
	SetWindowCollapsedStr :: proc(name: cstring, collapsed: b8, cond: Cond) ---
	SetWindowFocusStr :: proc(name: cstring) ---
	GetScrollX :: proc() -> f32 ---
	GetScrollY :: proc() -> f32 ---
	SetScrollX :: proc(scroll_x: f32) ---
	SetScrollY :: proc(scroll_y: f32) ---
	GetScrollMaxX :: proc() -> f32 ---
	GetScrollMaxY :: proc() -> f32 ---
	SetScrollHereX :: proc(center_x_ratio: f32) ---
	SetScrollHereY :: proc(center_y_ratio: f32) ---
	SetScrollFromPosX :: proc(local_x: f32, center_x_ratio: f32) ---
	SetScrollFromPosY :: proc(local_y: f32, center_y_ratio: f32) ---
	PushFont :: proc(font: ^ImFont) ---
	PopFont :: proc() ---
	PushStyleColor :: proc(idx: Col, col: ImU32) ---
	PushStyleColorImVec4 :: proc(idx: Col, col: ImVec4) ---
	PopStyleColor :: proc() ---
	PopStyleColorEx :: proc(count: i32) ---
	PushStyleVar :: proc(idx: StyleVar, val: f32) ---
	PushStyleVarImVec2 :: proc(idx: StyleVar, val: ImVec2) ---
	PushStyleVarX :: proc(idx: StyleVar, val_x: f32) ---
	PushStyleVarY :: proc(idx: StyleVar, val_y: f32) ---
	PopStyleVar :: proc() ---
	PopStyleVarEx :: proc(count: i32) ---
	PushItemFlag :: proc(option: ItemFlags, enabled: b8) ---
	PopItemFlag :: proc() ---
	PushItemWidth :: proc(item_width: f32) ---
	PopItemWidth :: proc() ---
	SetNextItemWidth :: proc(item_width: f32) ---
	CalcItemWidth :: proc() -> f32 ---
	PushTextWrapPos :: proc(wrap_local_pos_x: f32) ---
	PopTextWrapPos :: proc() ---
	GetFont :: proc() -> ^ImFont ---
	GetFontSize :: proc() -> f32 ---
	GetFontTexUvWhitePixel :: proc() -> ImVec2 ---
	GetColorU32 :: proc(idx: Col) -> ImU32 ---
	GetColorU32Ex :: proc(idx: Col, alpha_mul: f32) -> ImU32 ---
	GetColorU32ImVec4 :: proc(col: ImVec4) -> ImU32 ---
	GetColorU32ImU32 :: proc(col: ImU32) -> ImU32 ---
	GetColorU32ImU32Ex :: proc(col: ImU32, alpha_mul: f32) -> ImU32 ---
	GetStyleColorVec4 :: proc(idx: Col) -> ^ImVec4 ---
	GetCursorScreenPos :: proc() -> ImVec2 ---
	SetCursorScreenPos :: proc(pos: ImVec2) ---
	GetContentRegionAvail :: proc() -> ImVec2 ---
	GetCursorPos :: proc() -> ImVec2 ---
	GetCursorPosX :: proc() -> f32 ---
	GetCursorPosY :: proc() -> f32 ---
	SetCursorPos :: proc(local_pos: ImVec2) ---
	SetCursorPosX :: proc(local_x: f32) ---
	SetCursorPosY :: proc(local_y: f32) ---
	GetCursorStartPos :: proc() -> ImVec2 ---
	Separator :: proc() ---
	SameLine :: proc() ---
	SameLineEx :: proc(offset_from_start_x: f32, spacing: f32) ---
	NewLine :: proc() ---
	Spacing :: proc() ---
	Dummy :: proc(size: ImVec2) ---
	Indent :: proc() ---
	IndentEx :: proc(indent_w: f32) ---
	Unindent :: proc() ---
	UnindentEx :: proc(indent_w: f32) ---
	BeginGroup :: proc() ---
	EndGroup :: proc() ---
	AlignTextToFramePadding :: proc() ---
	GetTextLineHeight :: proc() -> f32 ---
	GetTextLineHeightWithSpacing :: proc() -> f32 ---
	GetFrameHeight :: proc() -> f32 ---
	GetFrameHeightWithSpacing :: proc() -> f32 ---
	PushID :: proc(str_id: cstring) ---
	PushIDStr :: proc(str_id_begin: cstring, str_id_end: cstring) ---
	PushIDPtr :: proc(ptr_id: rawptr) ---
	PushIDInt :: proc(int_id: i32) ---
	PopID :: proc() ---
	GetID :: proc(str_id: cstring) -> ID ---
	GetIDStr :: proc(str_id_begin: cstring, str_id_end: cstring) -> ID ---
	GetIDPtr :: proc(ptr_id: rawptr) -> ID ---
	GetIDInt :: proc(int_id: i32) -> ID ---
	TextUnformatted :: proc(text: cstring) ---
	TextUnformattedEx :: proc(text: cstring, text_end: cstring) ---
	Text :: proc(fmt: cstring, #c_vararg __unnamed_arg1__: ..any) ---
	TextV :: proc(fmt: cstring, args: va_list) ---
	TextColored :: proc(col: ImVec4, fmt: cstring, #c_vararg __unnamed_arg2__: ..any) ---
	TextColoredV :: proc(col: ImVec4, fmt: cstring, args: va_list) ---
	TextDisabled :: proc(fmt: cstring, #c_vararg __unnamed_arg1__: ..any) ---
	TextDisabledV :: proc(fmt: cstring, args: va_list) ---
	TextWrapped :: proc(fmt: cstring, #c_vararg __unnamed_arg1__: ..any) ---
	TextWrappedV :: proc(fmt: cstring, args: va_list) ---
	LabelText :: proc(label: cstring, fmt: cstring, #c_vararg __unnamed_arg2__: ..any) ---
	LabelTextV :: proc(label: cstring, fmt: cstring, args: va_list) ---
	BulletText :: proc(fmt: cstring, #c_vararg __unnamed_arg1__: ..any) ---
	BulletTextV :: proc(fmt: cstring, args: va_list) ---
	SeparatorText :: proc(label: cstring) ---
	Button :: proc(label: cstring) -> b8 ---
	ButtonEx :: proc(label: cstring, size: ImVec2) -> b8 ---
	SmallButton :: proc(label: cstring) -> b8 ---
	InvisibleButton :: proc(str_id: cstring, size: ImVec2, flags: ButtonFlags) -> b8 ---
	ArrowButton :: proc(str_id: cstring, dir: Dir) -> b8 ---
	Checkbox :: proc(label: cstring, v: ^b8) -> b8 ---
	CheckboxFlagsIntPtr :: proc(label: cstring, flags: ^i32, flags_value: i32) -> b8 ---
	CheckboxFlagsUintPtr :: proc(label: cstring, flags: ^u32, flags_value: u32) -> b8 ---
	RadioButton :: proc(label: cstring, active: b8) -> b8 ---
	RadioButtonIntPtr :: proc(label: cstring, v: ^i32, v_button: i32) -> b8 ---
	ProgressBar :: proc(fraction: f32, size_arg: ImVec2, overlay: cstring) ---
	Bullet :: proc() ---
	TextLink :: proc(label: cstring) -> b8 ---
	TextLinkOpenURL :: proc(label: cstring) ---
	TextLinkOpenURLEx :: proc(label: cstring, url: cstring) ---
	Image :: proc(user_texture_id: ImTextureID, image_size: ImVec2) ---
	ImageEx :: proc(user_texture_id: ImTextureID, image_size: ImVec2, uv0: ImVec2, uv1: ImVec2, tint_col: ImVec4, border_col: ImVec4) ---
	ImageButton :: proc(str_id: cstring, user_texture_id: ImTextureID, image_size: ImVec2) -> b8 ---
	ImageButtonEx :: proc(str_id: cstring, user_texture_id: ImTextureID, image_size: ImVec2, uv0: ImVec2, uv1: ImVec2, bg_col: ImVec4, tint_col: ImVec4) -> b8 ---
	BeginCombo :: proc(label: cstring, preview_value: cstring, flags: ComboFlags) -> b8 ---
	EndCombo :: proc() ---
	ComboChar :: proc(label: cstring, current_item: ^i32, items: ^[]cstring, items_count: i32) -> b8 ---
	ComboCharEx :: proc(label: cstring, current_item: ^i32, items: ^[]cstring, items_count: i32, popup_max_height_in_items: i32) -> b8 ---
	Combo :: proc(label: cstring, current_item: ^i32, items_separated_by_zeros: cstring) -> b8 ---
	ComboEx :: proc(label: cstring, current_item: ^i32, items_separated_by_zeros: cstring, popup_max_height_in_items: i32) -> b8 ---
	ComboCallback :: proc(label: cstring, current_item: ^i32, getter: proc "c" (user_data: rawptr, idx: i32) -> cstring, user_data: rawptr, items_count: i32) -> b8 ---
	ComboCallbackEx :: proc(label: cstring, current_item: ^i32, getter: proc "c" (user_data: rawptr, idx: i32) -> cstring, user_data: rawptr, items_count: i32, popup_max_height_in_items: i32) -> b8 ---
	DragFloat :: proc(label: cstring, v: ^f32) -> b8 ---
	DragFloatEx :: proc(label: cstring, v: ^f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: SliderFlags) -> b8 ---
	DragFloat2 :: proc(label: cstring, v: ^[2]f32) -> b8 ---
	DragFloat2Ex :: proc(label: cstring, v: ^[2]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: SliderFlags) -> b8 ---
	DragFloat3 :: proc(label: cstring, v: ^[3]f32) -> b8 ---
	DragFloat3Ex :: proc(label: cstring, v: ^[3]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: SliderFlags) -> b8 ---
	DragFloat4 :: proc(label: cstring, v: ^[4]f32) -> b8 ---
	DragFloat4Ex :: proc(label: cstring, v: ^[4]f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, flags: SliderFlags) -> b8 ---
	DragFloatRange2 :: proc(label: cstring, v_current_min: ^f32, v_current_max: ^f32) -> b8 ---
	DragFloatRange2Ex :: proc(label: cstring, v_current_min: ^f32, v_current_max: ^f32, v_speed: f32, v_min: f32, v_max: f32, format: cstring, format_max: cstring, flags: SliderFlags) -> b8 ---
	DragInt :: proc(label: cstring, v: ^i32) -> b8 ---
	DragIntEx :: proc(label: cstring, v: ^i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: SliderFlags) -> b8 ---
	DragInt2 :: proc(label: cstring, v: ^[2]i32) -> b8 ---
	DragInt2Ex :: proc(label: cstring, v: ^[2]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: SliderFlags) -> b8 ---
	DragInt3 :: proc(label: cstring, v: ^[3]i32) -> b8 ---
	DragInt3Ex :: proc(label: cstring, v: ^[3]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: SliderFlags) -> b8 ---
	DragInt4 :: proc(label: cstring, v: ^[4]i32) -> b8 ---
	DragInt4Ex :: proc(label: cstring, v: ^[4]i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, flags: SliderFlags) -> b8 ---
	DragIntRange2 :: proc(label: cstring, v_current_min: ^i32, v_current_max: ^i32) -> b8 ---
	DragIntRange2Ex :: proc(label: cstring, v_current_min: ^i32, v_current_max: ^i32, v_speed: f32, v_min: i32, v_max: i32, format: cstring, format_max: cstring, flags: SliderFlags) -> b8 ---
	DragScalar :: proc(label: cstring, data_type: DataType, p_data: rawptr) -> b8 ---
	DragScalarEx :: proc(label: cstring, data_type: DataType, p_data: rawptr, v_speed: f32, p_min: rawptr, p_max: rawptr, format: cstring, flags: SliderFlags) -> b8 ---
	DragScalarN :: proc(label: cstring, data_type: DataType, p_data: rawptr, components: i32) -> b8 ---
	DragScalarNEx :: proc(label: cstring, data_type: DataType, p_data: rawptr, components: i32, v_speed: f32, p_min: rawptr, p_max: rawptr, format: cstring, flags: SliderFlags) -> b8 ---
	SliderFloat :: proc(label: cstring, v: ^f32, v_min: f32, v_max: f32) -> b8 ---
	SliderFloatEx :: proc(label: cstring, v: ^f32, v_min: f32, v_max: f32, format: cstring, flags: SliderFlags) -> b8 ---
	SliderFloat2 :: proc(label: cstring, v: ^[2]f32, v_min: f32, v_max: f32) -> b8 ---
	SliderFloat2Ex :: proc(label: cstring, v: ^[2]f32, v_min: f32, v_max: f32, format: cstring, flags: SliderFlags) -> b8 ---
	SliderFloat3 :: proc(label: cstring, v: ^[3]f32, v_min: f32, v_max: f32) -> b8 ---
	SliderFloat3Ex :: proc(label: cstring, v: ^[3]f32, v_min: f32, v_max: f32, format: cstring, flags: SliderFlags) -> b8 ---
	SliderFloat4 :: proc(label: cstring, v: ^[4]f32, v_min: f32, v_max: f32) -> b8 ---
	SliderFloat4Ex :: proc(label: cstring, v: ^[4]f32, v_min: f32, v_max: f32, format: cstring, flags: SliderFlags) -> b8 ---
	SliderAngle :: proc(label: cstring, v_rad: ^f32) -> b8 ---
	SliderAngleEx :: proc(label: cstring, v_rad: ^f32, v_degrees_min: f32, v_degrees_max: f32, format: cstring, flags: SliderFlags) -> b8 ---
	SliderInt :: proc(label: cstring, v: ^i32, v_min: i32, v_max: i32) -> b8 ---
	SliderIntEx :: proc(label: cstring, v: ^i32, v_min: i32, v_max: i32, format: cstring, flags: SliderFlags) -> b8 ---
	SliderInt2 :: proc(label: cstring, v: ^[2]i32, v_min: i32, v_max: i32) -> b8 ---
	SliderInt2Ex :: proc(label: cstring, v: ^[2]i32, v_min: i32, v_max: i32, format: cstring, flags: SliderFlags) -> b8 ---
	SliderInt3 :: proc(label: cstring, v: ^[3]i32, v_min: i32, v_max: i32) -> b8 ---
	SliderInt3Ex :: proc(label: cstring, v: ^[3]i32, v_min: i32, v_max: i32, format: cstring, flags: SliderFlags) -> b8 ---
	SliderInt4 :: proc(label: cstring, v: ^[4]i32, v_min: i32, v_max: i32) -> b8 ---
	SliderInt4Ex :: proc(label: cstring, v: ^[4]i32, v_min: i32, v_max: i32, format: cstring, flags: SliderFlags) -> b8 ---
	SliderScalar :: proc(label: cstring, data_type: DataType, p_data: rawptr, p_min: rawptr, p_max: rawptr) -> b8 ---
	SliderScalarEx :: proc(label: cstring, data_type: DataType, p_data: rawptr, p_min: rawptr, p_max: rawptr, format: cstring, flags: SliderFlags) -> b8 ---
	SliderScalarN :: proc(label: cstring, data_type: DataType, p_data: rawptr, components: i32, p_min: rawptr, p_max: rawptr) -> b8 ---
	SliderScalarNEx :: proc(label: cstring, data_type: DataType, p_data: rawptr, components: i32, p_min: rawptr, p_max: rawptr, format: cstring, flags: SliderFlags) -> b8 ---
	VSliderFloat :: proc(label: cstring, size: ImVec2, v: ^f32, v_min: f32, v_max: f32) -> b8 ---
	VSliderFloatEx :: proc(label: cstring, size: ImVec2, v: ^f32, v_min: f32, v_max: f32, format: cstring, flags: SliderFlags) -> b8 ---
	VSliderInt :: proc(label: cstring, size: ImVec2, v: ^i32, v_min: i32, v_max: i32) -> b8 ---
	VSliderIntEx :: proc(label: cstring, size: ImVec2, v: ^i32, v_min: i32, v_max: i32, format: cstring, flags: SliderFlags) -> b8 ---
	VSliderScalar :: proc(label: cstring, size: ImVec2, data_type: DataType, p_data: rawptr, p_min: rawptr, p_max: rawptr) -> b8 ---
	VSliderScalarEx :: proc(label: cstring, size: ImVec2, data_type: DataType, p_data: rawptr, p_min: rawptr, p_max: rawptr, format: cstring, flags: SliderFlags) -> b8 ---
	InputText :: proc(label: cstring, buf: cstring, buf_size: u32, flags: InputTextFlags) -> b8 ---
	InputTextEx :: proc(label: cstring, buf: cstring, buf_size: u32, flags: InputTextFlags, callback: InputTextCallback, user_data: rawptr) -> b8 ---
	InputTextMultiline :: proc(label: cstring, buf: cstring, buf_size: u32) -> b8 ---
	InputTextMultilineEx :: proc(label: cstring, buf: cstring, buf_size: u32, size: ImVec2, flags: InputTextFlags, callback: InputTextCallback, user_data: rawptr) -> b8 ---
	InputTextWithHint :: proc(label: cstring, hint: cstring, buf: cstring, buf_size: u32, flags: InputTextFlags) -> b8 ---
	InputTextWithHintEx :: proc(label: cstring, hint: cstring, buf: cstring, buf_size: u32, flags: InputTextFlags, callback: InputTextCallback, user_data: rawptr) -> b8 ---
	InputFloat :: proc(label: cstring, v: ^f32) -> b8 ---
	InputFloatEx :: proc(label: cstring, v: ^f32, step: f32, step_fast: f32, format: cstring, flags: InputTextFlags) -> b8 ---
	InputFloat2 :: proc(label: cstring, v: ^[2]f32) -> b8 ---
	InputFloat2Ex :: proc(label: cstring, v: ^[2]f32, format: cstring, flags: InputTextFlags) -> b8 ---
	InputFloat3 :: proc(label: cstring, v: ^[3]f32) -> b8 ---
	InputFloat3Ex :: proc(label: cstring, v: ^[3]f32, format: cstring, flags: InputTextFlags) -> b8 ---
	InputFloat4 :: proc(label: cstring, v: ^[4]f32) -> b8 ---
	InputFloat4Ex :: proc(label: cstring, v: ^[4]f32, format: cstring, flags: InputTextFlags) -> b8 ---
	InputInt :: proc(label: cstring, v: ^i32) -> b8 ---
	InputIntEx :: proc(label: cstring, v: ^i32, step: i32, step_fast: i32, flags: InputTextFlags) -> b8 ---
	InputInt2 :: proc(label: cstring, v: ^[2]i32, flags: InputTextFlags) -> b8 ---
	InputInt3 :: proc(label: cstring, v: ^[3]i32, flags: InputTextFlags) -> b8 ---
	InputInt4 :: proc(label: cstring, v: ^[4]i32, flags: InputTextFlags) -> b8 ---
	InputDouble :: proc(label: cstring, v: ^f64) -> b8 ---
	InputDoubleEx :: proc(label: cstring, v: ^f64, step: f64, step_fast: f64, format: cstring, flags: InputTextFlags) -> b8 ---
	InputScalar :: proc(label: cstring, data_type: DataType, p_data: rawptr) -> b8 ---
	InputScalarEx :: proc(label: cstring, data_type: DataType, p_data: rawptr, p_step: rawptr, p_step_fast: rawptr, format: cstring, flags: InputTextFlags) -> b8 ---
	InputScalarN :: proc(label: cstring, data_type: DataType, p_data: rawptr, components: i32) -> b8 ---
	InputScalarNEx :: proc(label: cstring, data_type: DataType, p_data: rawptr, components: i32, p_step: rawptr, p_step_fast: rawptr, format: cstring, flags: InputTextFlags) -> b8 ---
	ColorEdit3 :: proc(label: cstring, col: ^[3]f32, flags: ColorEditFlags) -> b8 ---
	ColorEdit4 :: proc(label: cstring, col: ^[4]f32, flags: ColorEditFlags) -> b8 ---
	ColorPicker3 :: proc(label: cstring, col: ^[3]f32, flags: ColorEditFlags) -> b8 ---
	ColorPicker4 :: proc(label: cstring, col: ^[4]f32, flags: ColorEditFlags, ref_col: ^f32) -> b8 ---
	ColorButton :: proc(desc_id: cstring, col: ImVec4, flags: ColorEditFlags) -> b8 ---
	ColorButtonEx :: proc(desc_id: cstring, col: ImVec4, flags: ColorEditFlags, size: ImVec2) -> b8 ---
	SetColorEditOptions :: proc(flags: ColorEditFlags) ---
	TreeNode :: proc(label: cstring) -> b8 ---
	TreeNodeStr :: proc(str_id: cstring, fmt: cstring, #c_vararg __unnamed_arg2__: ..any) -> b8 ---
	TreeNodePtr :: proc(ptr_id: rawptr, fmt: cstring, #c_vararg __unnamed_arg2__: ..any) -> b8 ---
	TreeNodeV :: proc(str_id: cstring, fmt: cstring, args: va_list) -> b8 ---
	TreeNodeVPtr :: proc(ptr_id: rawptr, fmt: cstring, args: va_list) -> b8 ---
	TreeNodeEx :: proc(label: cstring, flags: TreeNodeFlags) -> b8 ---
	TreeNodeExStr :: proc(str_id: cstring, flags: TreeNodeFlags, fmt: cstring, #c_vararg __unnamed_arg3__: ..any) -> b8 ---
	TreeNodeExPtr :: proc(ptr_id: rawptr, flags: TreeNodeFlags, fmt: cstring, #c_vararg __unnamed_arg3__: ..any) -> b8 ---
	TreeNodeExV :: proc(str_id: cstring, flags: TreeNodeFlags, fmt: cstring, args: va_list) -> b8 ---
	TreeNodeExVPtr :: proc(ptr_id: rawptr, flags: TreeNodeFlags, fmt: cstring, args: va_list) -> b8 ---
	TreePush :: proc(str_id: cstring) ---
	TreePushPtr :: proc(ptr_id: rawptr) ---
	TreePop :: proc() ---
	GetTreeNodeToLabelSpacing :: proc() -> f32 ---
	CollapsingHeader :: proc(label: cstring, flags: TreeNodeFlags) -> b8 ---
	CollapsingHeaderBoolPtr :: proc(label: cstring, p_visible: ^b8, flags: TreeNodeFlags) -> b8 ---
	SetNextItemOpen :: proc(is_open: b8, cond: Cond) ---
	SetNextItemStorageID :: proc(storage_id: ID) ---
	Selectable :: proc(label: cstring) -> b8 ---
	SelectableEx :: proc(label: cstring, selected: b8, flags: SelectableFlags, size: ImVec2) -> b8 ---
	SelectableBoolPtr :: proc(label: cstring, p_selected: ^b8, flags: SelectableFlags) -> b8 ---
	SelectableBoolPtrEx :: proc(label: cstring, p_selected: ^b8, flags: SelectableFlags, size: ImVec2) -> b8 ---
	BeginMultiSelect :: proc(flags: MultiSelectFlags) -> ^MultiSelectIO ---
	BeginMultiSelectEx :: proc(flags: MultiSelectFlags, selection_size: i32, items_count: i32) -> ^MultiSelectIO ---
	EndMultiSelect :: proc() -> ^MultiSelectIO ---
	SetNextItemSelectionUserData :: proc(selection_user_data: SelectionUserData) ---
	IsItemToggledSelection :: proc() -> b8 ---
	BeginListBox :: proc(label: cstring, size: ImVec2) -> b8 ---
	EndListBox :: proc() ---
	ListBox :: proc(label: cstring, current_item: ^i32, items: ^[]cstring, items_count: i32, height_in_items: i32) -> b8 ---
	ListBoxCallback :: proc(label: cstring, current_item: ^i32, getter: proc "c" (user_data: rawptr, idx: i32) -> cstring, user_data: rawptr, items_count: i32) -> b8 ---
	ListBoxCallbackEx :: proc(label: cstring, current_item: ^i32, getter: proc "c" (user_data: rawptr, idx: i32) -> cstring, user_data: rawptr, items_count: i32, height_in_items: i32) -> b8 ---
	PlotLines :: proc(label: cstring, values: ^f32, values_count: i32) ---
	PlotLinesEx :: proc(label: cstring, values: ^f32, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: ImVec2, stride: i32) ---
	PlotLinesCallback :: proc(label: cstring, values_getter: proc "c" (data: rawptr, idx: i32) -> f32, data: rawptr, values_count: i32) ---
	PlotLinesCallbackEx :: proc(label: cstring, values_getter: proc "c" (data: rawptr, idx: i32) -> f32, data: rawptr, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: ImVec2) ---
	PlotHistogram :: proc(label: cstring, values: ^f32, values_count: i32) ---
	PlotHistogramEx :: proc(label: cstring, values: ^f32, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: ImVec2, stride: i32) ---
	PlotHistogramCallback :: proc(label: cstring, values_getter: proc "c" (data: rawptr, idx: i32) -> f32, data: rawptr, values_count: i32) ---
	PlotHistogramCallbackEx :: proc(label: cstring, values_getter: proc "c" (data: rawptr, idx: i32) -> f32, data: rawptr, values_count: i32, values_offset: i32, overlay_text: cstring, scale_min: f32, scale_max: f32, graph_size: ImVec2) ---
	BeginMenuBar :: proc() -> b8 ---
	EndMenuBar :: proc() ---
	BeginMainMenuBar :: proc() -> b8 ---
	EndMainMenuBar :: proc() ---
	BeginMenu :: proc(label: cstring) -> b8 ---
	BeginMenuEx :: proc(label: cstring, enabled: b8) -> b8 ---
	EndMenu :: proc() ---
	MenuItem :: proc(label: cstring) -> b8 ---
	MenuItemEx :: proc(label: cstring, shortcut: cstring, selected: b8, enabled: b8) -> b8 ---
	MenuItemBoolPtr :: proc(label: cstring, shortcut: cstring, p_selected: ^b8, enabled: b8) -> b8 ---
	BeginTooltip :: proc() -> b8 ---
	EndTooltip :: proc() ---
	SetTooltip :: proc(fmt: cstring, #c_vararg __unnamed_arg1__: ..any) ---
	SetTooltipV :: proc(fmt: cstring, args: va_list) ---
	BeginItemTooltip :: proc() -> b8 ---
	SetItemTooltip :: proc(fmt: cstring, #c_vararg __unnamed_arg1__: ..any) ---
	SetItemTooltipV :: proc(fmt: cstring, args: va_list) ---
	BeginPopup :: proc(str_id: cstring, flags: WindowFlags) -> b8 ---
	BeginPopupModal :: proc(name: cstring, p_open: ^b8, flags: WindowFlags) -> b8 ---
	EndPopup :: proc() ---
	OpenPopup :: proc(str_id: cstring, popup_flags: PopupFlags) ---
	OpenPopupID :: proc(id: ID, popup_flags: PopupFlags) ---
	OpenPopupOnItemClick :: proc(str_id: cstring, popup_flags: PopupFlags) ---
	CloseCurrentPopup :: proc() ---
	BeginPopupContextItem :: proc() -> b8 ---
	BeginPopupContextItemEx :: proc(str_id: cstring, popup_flags: PopupFlags) -> b8 ---
	BeginPopupContextWindow :: proc() -> b8 ---
	BeginPopupContextWindowEx :: proc(str_id: cstring, popup_flags: PopupFlags) -> b8 ---
	BeginPopupContextVoid :: proc() -> b8 ---
	BeginPopupContextVoidEx :: proc(str_id: cstring, popup_flags: PopupFlags) -> b8 ---
	IsPopupOpen :: proc(str_id: cstring, flags: PopupFlags) -> b8 ---
	BeginTable :: proc(str_id: cstring, columns: i32, flags: TableFlags) -> b8 ---
	BeginTableEx :: proc(str_id: cstring, columns: i32, flags: TableFlags, outer_size: ImVec2, inner_width: f32) -> b8 ---
	EndTable :: proc() ---
	TableNextRow :: proc() ---
	TableNextRowEx :: proc(row_flags: TableRowFlags, min_row_height: f32) ---
	TableNextColumn :: proc() -> b8 ---
	TableSetColumnIndex :: proc(column_n: i32) -> b8 ---
	TableSetupColumn :: proc(label: cstring, flags: TableColumnFlags) ---
	TableSetupColumnEx :: proc(label: cstring, flags: TableColumnFlags, init_width_or_weight: f32, user_id: ID) ---
	TableSetupScrollFreeze :: proc(cols: i32, rows: i32) ---
	TableHeader :: proc(label: cstring) ---
	TableHeadersRow :: proc() ---
	TableAngledHeadersRow :: proc() ---
	TableGetSortSpecs :: proc() -> ^TableSortSpecs ---
	TableGetColumnCount :: proc() -> i32 ---
	TableGetColumnIndex :: proc() -> i32 ---
	TableGetRowIndex :: proc() -> i32 ---
	TableGetColumnName :: proc(column_n: i32) -> cstring ---
	TableGetColumnFlags :: proc(column_n: i32) -> TableColumnFlags ---
	TableSetColumnEnabled :: proc(column_n: i32, v: b8) ---
	TableGetHoveredColumn :: proc() -> i32 ---
	TableSetBgColor :: proc(target: TableBgTarget, color: ImU32, column_n: i32) ---
	Columns :: proc() ---
	ColumnsEx :: proc(count: i32, id: cstring, borders: b8) ---
	NextColumn :: proc() ---
	GetColumnIndex :: proc() -> i32 ---
	GetColumnWidth :: proc(column_index: i32) -> f32 ---
	SetColumnWidth :: proc(column_index: i32, width: f32) ---
	GetColumnOffset :: proc(column_index: i32) -> f32 ---
	SetColumnOffset :: proc(column_index: i32, offset_x: f32) ---
	GetColumnsCount :: proc() -> i32 ---
	BeginTabBar :: proc(str_id: cstring, flags: TabBarFlags) -> b8 ---
	EndTabBar :: proc() ---
	BeginTabItem :: proc(label: cstring, p_open: ^b8, flags: TabItemFlags) -> b8 ---
	EndTabItem :: proc() ---
	TabItemButton :: proc(label: cstring, flags: TabItemFlags) -> b8 ---
	SetTabItemClosed :: proc(tab_or_docked_window_label: cstring) ---
	LogToTTY :: proc(auto_open_depth: i32) ---
	LogToFile :: proc(auto_open_depth: i32, filename: cstring) ---
	LogToClipboard :: proc(auto_open_depth: i32) ---
	LogFinish :: proc() ---
	LogButtons :: proc() ---
	LogText :: proc(fmt: cstring, #c_vararg __unnamed_arg1__: ..any) ---
	LogTextV :: proc(fmt: cstring, args: va_list) ---
	BeginDragDropSource :: proc(flags: DragDropFlags) -> b8 ---
	SetDragDropPayload :: proc(type: cstring, data: rawptr, sz: u32, cond: Cond) -> b8 ---
	EndDragDropSource :: proc() ---
	BeginDragDropTarget :: proc() -> b8 ---
	AcceptDragDropPayload :: proc(type: cstring, flags: DragDropFlags) -> ^Payload ---
	EndDragDropTarget :: proc() ---
	GetDragDropPayload :: proc() -> ^Payload ---
	BeginDisabled :: proc(disabled: b8) ---
	EndDisabled :: proc() ---
	PushClipRect :: proc(clip_rect_min: ImVec2, clip_rect_max: ImVec2, intersect_with_current_clip_rect: b8) ---
	PopClipRect :: proc() ---
	SetItemDefaultFocus :: proc() ---
	SetKeyboardFocusHere :: proc() ---
	SetKeyboardFocusHereEx :: proc(offset: i32) ---
	SetNavCursorVisible :: proc(visible: b8) ---
	SetNextItemAllowOverlap :: proc() ---
	IsItemHovered :: proc(flags: HoveredFlags) -> b8 ---
	IsItemActive :: proc() -> b8 ---
	IsItemFocused :: proc() -> b8 ---
	IsItemClicked :: proc() -> b8 ---
	IsItemClickedEx :: proc(mouse_button: MouseButton) -> b8 ---
	IsItemVisible :: proc() -> b8 ---
	IsItemEdited :: proc() -> b8 ---
	IsItemActivated :: proc() -> b8 ---
	IsItemDeactivated :: proc() -> b8 ---
	IsItemDeactivatedAfterEdit :: proc() -> b8 ---
	IsItemToggledOpen :: proc() -> b8 ---
	IsAnyItemHovered :: proc() -> b8 ---
	IsAnyItemActive :: proc() -> b8 ---
	IsAnyItemFocused :: proc() -> b8 ---
	GetItemID :: proc() -> ID ---
	GetItemRectMin :: proc() -> ImVec2 ---
	GetItemRectMax :: proc() -> ImVec2 ---
	GetItemRectSize :: proc() -> ImVec2 ---
	GetMainViewport :: proc() -> ^Viewport ---
	GetBackgroundDrawList :: proc() -> ^ImDrawList ---
	GetForegroundDrawList :: proc() -> ^ImDrawList ---
	IsRectVisibleBySize :: proc(size: ImVec2) -> b8 ---
	IsRectVisible :: proc(rect_min: ImVec2, rect_max: ImVec2) -> b8 ---
	GetTime :: proc() -> f64 ---
	GetFrameCount :: proc() -> i32 ---
	GetDrawListSharedData :: proc() -> ^ImDrawListSharedData ---
	GetStyleColorName :: proc(idx: Col) -> cstring ---
	SetStateStorage :: proc(storage: ^Storage) ---
	GetStateStorage :: proc() -> ^Storage ---
	CalcTextSize :: proc(text: cstring) -> ImVec2 ---
	CalcTextSizeEx :: proc(text: cstring, text_end: cstring, hide_text_after_double_hash: b8, wrap_width: f32) -> ImVec2 ---
	ColorConvertU32ToFloat4 :: proc(_in: ImU32) -> ImVec4 ---
	ColorConvertFloat4ToU32 :: proc(_in: ImVec4) -> ImU32 ---
	ColorConvertRGBtoHSV :: proc(r: f32, g: f32, b: f32, out_h: ^f32, out_s: ^f32, out_v: ^f32) ---
	ColorConvertHSVtoRGB :: proc(h: f32, s: f32, v: f32, out_r: ^f32, out_g: ^f32, out_b: ^f32) ---
	IsKeyDown :: proc(key: Key) -> b8 ---
	IsKeyPressed :: proc(key: Key) -> b8 ---
	IsKeyPressedEx :: proc(key: Key, repeat: b8) -> b8 ---
	IsKeyReleased :: proc(key: Key) -> b8 ---
	IsKeyChordPressed :: proc(key_chord: KeyChord) -> b8 ---
	GetKeyPressedAmount :: proc(key: Key, repeat_delay: f32, rate: f32) -> i32 ---
	GetKeyName :: proc(key: Key) -> cstring ---
	SetNextFrameWantCaptureKeyboard :: proc(want_capture_keyboard: b8) ---
	Shortcut :: proc(key_chord: KeyChord, flags: InputFlags) -> b8 ---
	SetNextItemShortcut :: proc(key_chord: KeyChord, flags: InputFlags) ---
	SetItemKeyOwner :: proc(key: Key) ---
	IsMouseDown :: proc(button: MouseButton) -> b8 ---
	IsMouseClicked :: proc(button: MouseButton) -> b8 ---
	IsMouseClickedEx :: proc(button: MouseButton, repeat: b8) -> b8 ---
	IsMouseReleased :: proc(button: MouseButton) -> b8 ---
	IsMouseDoubleClicked :: proc(button: MouseButton) -> b8 ---
	GetMouseClickedCount :: proc(button: MouseButton) -> i32 ---
	IsMouseHoveringRect :: proc(r_min: ImVec2, r_max: ImVec2) -> b8 ---
	IsMouseHoveringRectEx :: proc(r_min: ImVec2, r_max: ImVec2, clip: b8) -> b8 ---
	IsMousePosValid :: proc(mouse_pos: ^ImVec2) -> b8 ---
	IsAnyMouseDown :: proc() -> b8 ---
	GetMousePos :: proc() -> ImVec2 ---
	GetMousePosOnOpeningCurrentPopup :: proc() -> ImVec2 ---
	IsMouseDragging :: proc(button: MouseButton, lock_threshold: f32) -> b8 ---
	GetMouseDragDelta :: proc(button: MouseButton, lock_threshold: f32) -> ImVec2 ---
	ResetMouseDragDelta :: proc() ---
	ResetMouseDragDeltaEx :: proc(button: MouseButton) ---
	GetMouseCursor :: proc() -> MouseCursor ---
	SetMouseCursor :: proc(cursor_type: MouseCursor) ---
	SetNextFrameWantCaptureMouse :: proc(want_capture_mouse: b8) ---
	GetClipboardText :: proc() -> cstring ---
	SetClipboardText :: proc(text: cstring) ---
	LoadIniSettingsFromDisk :: proc(ini_filename: cstring) ---
	LoadIniSettingsFromMemory :: proc(ini_data: cstring, ini_size: u32) ---
	SaveIniSettingsToDisk :: proc(ini_filename: cstring) ---
	SaveIniSettingsToMemory :: proc(out_ini_size: ^u32) -> cstring ---
	DebugTextEncoding :: proc(text: cstring) ---
	DebugFlashStyleColor :: proc(idx: Col) ---
	DebugStartItemPicker :: proc() ---
	DebugCheckVersionAndDataLayout :: proc(version_str: cstring, sz_io: u32, sz_style: u32, sz_vec2: u32, sz_vec4: u32, sz_drawvert: u32, sz_drawidx: u32) -> b8 ---
	DebugLog :: proc(fmt: cstring, #c_vararg __unnamed_arg1__: ..any) ---
	DebugLogV :: proc(fmt: cstring, args: va_list) ---
	SetAllocatorFunctions :: proc(alloc_func: MemAllocFunc, free_func: MemFreeFunc, user_data: rawptr) ---
	GetAllocatorFunctions :: proc(p_alloc_func: ^MemAllocFunc, p_free_func: ^MemFreeFunc, p_user_data: [^]rawptr) ---
	MemAlloc :: proc(size: u32) -> rawptr ---
	MemFree :: proc(ptr: rawptr) ---
}
@(default_calling_convention = "cdecl")
foreign imgui {
	ImVector_Construct :: proc(vector: rawptr) ---
	ImVector_Destruct :: proc(vector: rawptr) ---
	// ImStr_FromCharStr :: proc(b: cstring) -> ImStr ---
	ImGuiStyle_ScaleAllSizes :: proc(self: ^Style, scale_factor: f32) ---
	ImGuiIO_AddKeyEvent :: proc(self: ^IO, key: Key, down: b8) ---
	ImGuiIO_AddKeyAnalogEvent :: proc(self: ^IO, key: Key, down: b8, v: f32) ---
	ImGuiIO_AddMousePosEvent :: proc(self: ^IO, x: f32, y: f32) ---
	ImGuiIO_AddMouseButtonEvent :: proc(self: ^IO, button: i32, down: b8) ---
	ImGuiIO_AddMouseWheelEvent :: proc(self: ^IO, wheel_x: f32, wheel_y: f32) ---
	ImGuiIO_AddMouseSourceEvent :: proc(self: ^IO, source: MouseSource) ---
	ImGuiIO_AddFocusEvent :: proc(self: ^IO, focused: b8) ---
	ImGuiIO_AddInputCharacter :: proc(self: ^IO, c: u32) ---
	ImGuiIO_AddInputCharacterUTF16 :: proc(self: ^IO, c: ImWchar16) ---
	ImGuiIO_AddInputCharactersUTF8 :: proc(self: ^IO, str: cstring) ---
	ImGuiIO_SetKeyEventNativeData :: proc(self: ^IO, key: Key, native_keycode: i32, native_scancode: i32) ---
	ImGuiIO_SetKeyEventNativeDataEx :: proc(self: ^IO, key: Key, native_keycode: i32, native_scancode: i32, native_legacy_index: i32) ---
	ImGuiIO_SetAppAcceptingEvents :: proc(self: ^IO, accepting_events: b8) ---
	ImGuiIO_ClearEventsQueue :: proc(self: ^IO) ---
	ImGuiIO_ClearInputKeys :: proc(self: ^IO) ---
	ImGuiIO_ClearInputMouse :: proc(self: ^IO) ---
	ImGuiIO_ClearInputCharacters :: proc(self: ^IO) ---
	ImGuiInputTextCallbackData_DeleteChars :: proc(self: ^InputTextCallbackData, pos: i32, bytes_count: i32) ---
	ImGuiInputTextCallbackData_InsertChars :: proc(self: ^InputTextCallbackData, pos: i32, text: cstring, text_end: cstring) ---
	ImGuiInputTextCallbackData_SelectAll :: proc(self: ^InputTextCallbackData) ---
	ImGuiInputTextCallbackData_ClearSelection :: proc(self: ^InputTextCallbackData) ---
	ImGuiInputTextCallbackData_HasSelection :: proc(self: ^InputTextCallbackData) -> b8 ---
	ImGuiPayload_Clear :: proc(self: ^Payload) ---
	ImGuiPayload_IsDataType :: proc(self: ^Payload, type: cstring) -> b8 ---
	ImGuiPayload_IsPreview :: proc(self: ^Payload) -> b8 ---
	ImGuiPayload_IsDelivery :: proc(self: ^Payload) -> b8 ---
	ImGuiTextFilter_ImGuiTextRange_empty :: proc(self: ^TextFilter_ImGuiTextRange) -> b8 ---
	ImGuiTextFilter_ImGuiTextRange_split :: proc(self: ^TextFilter_ImGuiTextRange, separator: cstring, out: ^ImVector_ImGuiTextFilter_ImGuiTextRange) ---
	ImGuiTextFilter_Draw :: proc(self: ^TextFilter, label: cstring, width: f32) -> b8 ---
	ImGuiTextFilter_PassFilter :: proc(self: ^TextFilter, text: cstring, text_end: cstring) -> b8 ---
	ImGuiTextFilter_Build :: proc(self: ^TextFilter) ---
	ImGuiTextFilter_Clear :: proc(self: ^TextFilter) ---
	ImGuiTextFilter_IsActive :: proc(self: ^TextFilter) -> b8 ---
	ImGuiTextBuffer_begin :: proc(self: ^TextBuffer) -> cstring ---
	ImGuiTextBuffer_end :: proc(self: ^TextBuffer) -> cstring ---
	ImGuiTextBuffer_size :: proc(self: ^TextBuffer) -> i32 ---
	ImGuiTextBuffer_empty :: proc(self: ^TextBuffer) -> b8 ---
	ImGuiTextBuffer_clear :: proc(self: ^TextBuffer) ---
	ImGuiTextBuffer_reserve :: proc(self: ^TextBuffer, capacity: i32) ---
	ImGuiTextBuffer_c_str :: proc(self: ^TextBuffer) -> cstring ---
	ImGuiTextBuffer_append :: proc(self: ^TextBuffer, str: cstring, str_end: cstring) ---
	ImGuiTextBuffer_appendf :: proc(self: ^TextBuffer, fmt: cstring, #c_vararg __unnamed_arg2__: ..any) ---
	ImGuiTextBuffer_appendfv :: proc(self: ^TextBuffer, fmt: cstring, args: va_list) ---
	ImGuiStorage_Clear :: proc(self: ^Storage) ---
	ImGuiStorage_GetInt :: proc(self: ^Storage, key: ID, default_val: i32) -> i32 ---
	ImGuiStorage_SetInt :: proc(self: ^Storage, key: ID, val: i32) ---
	ImGuiStorage_GetBool :: proc(self: ^Storage, key: ID, default_val: b8) -> b8 ---
	ImGuiStorage_SetBool :: proc(self: ^Storage, key: ID, val: b8) ---
	ImGuiStorage_GetFloat :: proc(self: ^Storage, key: ID, default_val: f32) -> f32 ---
	ImGuiStorage_SetFloat :: proc(self: ^Storage, key: ID, val: f32) ---
	ImGuiStorage_GetVoidPtr :: proc(self: ^Storage, key: ID) -> rawptr ---
	ImGuiStorage_SetVoidPtr :: proc(self: ^Storage, key: ID, val: rawptr) ---
	ImGuiStorage_GetIntRef :: proc(self: ^Storage, key: ID, default_val: i32) -> ^i32 ---
	ImGuiStorage_GetBoolRef :: proc(self: ^Storage, key: ID, default_val: b8) -> ^b8 ---
	ImGuiStorage_GetFloatRef :: proc(self: ^Storage, key: ID, default_val: f32) -> ^f32 ---
	ImGuiStorage_GetVoidPtrRef :: proc(self: ^Storage, key: ID, default_val: rawptr) -> [^]rawptr ---
	ImGuiStorage_BuildSortByKey :: proc(self: ^Storage) ---
	ImGuiStorage_SetAllInt :: proc(self: ^Storage, val: i32) ---
	ImGuiListClipper_Begin :: proc(self: ^ListClipper, items_count: i32, items_height: f32) ---
	ImGuiListClipper_End :: proc(self: ^ListClipper) ---
	ImGuiListClipper_Step :: proc(self: ^ListClipper) -> b8 ---
	ImGuiListClipper_IncludeItemByIndex :: proc(self: ^ListClipper, item_index: i32) ---
	ImGuiListClipper_IncludeItemsByIndex :: proc(self: ^ListClipper, item_begin: i32, item_end: i32) ---
	ImGuiListClipper_SeekCursorForItem :: proc(self: ^ListClipper, item_index: i32) ---
	ImGuiListClipper_IncludeRangeByIndices :: proc(self: ^ListClipper, item_begin: i32, item_end: i32) ---
	ImGuiListClipper_ForceDisplayRangeByIndices :: proc(self: ^ListClipper, item_begin: i32, item_end: i32) ---
	ImColor_SetHSV :: proc(self: ^ImColor, h: f32, s: f32, v: f32, a: f32) ---
	ImColor_HSV :: proc(h: f32, s: f32, v: f32, a: f32) -> ImColor ---
	ImGuiSelectionBasicStorage_ApplyRequests :: proc(self: ^SelectionBasicStorage, ms_io: ^MultiSelectIO) ---
	ImGuiSelectionBasicStorage_Contains :: proc(self: ^SelectionBasicStorage, id: ID) -> b8 ---
	ImGuiSelectionBasicStorage_Clear :: proc(self: ^SelectionBasicStorage) ---
	ImGuiSelectionBasicStorage_Swap :: proc(self: ^SelectionBasicStorage, r: ^SelectionBasicStorage) ---
	ImGuiSelectionBasicStorage_SetItemSelected :: proc(self: ^SelectionBasicStorage, id: ID, selected: b8) ---
	ImGuiSelectionBasicStorage_GetNextSelectedItem :: proc(self: ^SelectionBasicStorage, opaque_it: [^]rawptr, out_id: ^ID) -> b8 ---
	ImGuiSelectionBasicStorage_GetStorageIdFromIndex :: proc(self: ^SelectionBasicStorage, idx: i32) -> ID ---
	ImGuiSelectionExternalStorage_ApplyRequests :: proc(self: ^SelectionExternalStorage, ms_io: ^MultiSelectIO) ---
	ImDrawCmd_GetTexID :: proc(self: ^ImDrawCmd) -> ImTextureID ---
	ImDrawListSplitter_Clear :: proc(self: ^ImDrawListSplitter) ---
	ImDrawListSplitter_ClearFreeMemory :: proc(self: ^ImDrawListSplitter) ---
	ImDrawListSplitter_Split :: proc(self: ^ImDrawListSplitter, draw_list: ^ImDrawList, count: i32) ---
	ImDrawListSplitter_Merge :: proc(self: ^ImDrawListSplitter, draw_list: ^ImDrawList) ---
	ImDrawListSplitter_SetCurrentChannel :: proc(self: ^ImDrawListSplitter, draw_list: ^ImDrawList, channel_idx: i32) ---
	ImDrawList_PushClipRect :: proc(self: ^ImDrawList, clip_rect_min: ImVec2, clip_rect_max: ImVec2, intersect_with_current_clip_rect: b8) ---
	ImDrawList_PushClipRectFullScreen :: proc(self: ^ImDrawList) ---
	ImDrawList_PopClipRect :: proc(self: ^ImDrawList) ---
	ImDrawList_PushTextureID :: proc(self: ^ImDrawList, texture_id: ImTextureID) ---
	ImDrawList_PopTextureID :: proc(self: ^ImDrawList) ---
	ImDrawList_GetClipRectMin :: proc(self: ^ImDrawList) -> ImVec2 ---
	ImDrawList_GetClipRectMax :: proc(self: ^ImDrawList) -> ImVec2 ---
	ImDrawList_AddLine :: proc(self: ^ImDrawList, p1: ImVec2, p2: ImVec2, col: ImU32) ---
	ImDrawList_AddLineEx :: proc(self: ^ImDrawList, p1: ImVec2, p2: ImVec2, col: ImU32, thickness: f32) ---
	ImDrawList_AddRect :: proc(self: ^ImDrawList, p_min: ImVec2, p_max: ImVec2, col: ImU32) ---
	ImDrawList_AddRectEx :: proc(self: ^ImDrawList, p_min: ImVec2, p_max: ImVec2, col: ImU32, rounding: f32, flags: ImDrawFlags, thickness: f32) ---
	ImDrawList_AddRectFilled :: proc(self: ^ImDrawList, p_min: ImVec2, p_max: ImVec2, col: ImU32) ---
	ImDrawList_AddRectFilledEx :: proc(self: ^ImDrawList, p_min: ImVec2, p_max: ImVec2, col: ImU32, rounding: f32, flags: ImDrawFlags) ---
	ImDrawList_AddRectFilledMultiColor :: proc(self: ^ImDrawList, p_min: ImVec2, p_max: ImVec2, col_upr_left: ImU32, col_upr_right: ImU32, col_bot_right: ImU32, col_bot_left: ImU32) ---
	ImDrawList_AddQuad :: proc(self: ^ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32) ---
	ImDrawList_AddQuadEx :: proc(self: ^ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: f32) ---
	ImDrawList_AddQuadFilled :: proc(self: ^ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32) ---
	ImDrawList_AddTriangle :: proc(self: ^ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32) ---
	ImDrawList_AddTriangleEx :: proc(self: ^ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32, thickness: f32) ---
	ImDrawList_AddTriangleFilled :: proc(self: ^ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32) ---
	ImDrawList_AddCircle :: proc(self: ^ImDrawList, center: ImVec2, radius: f32, col: ImU32) ---
	ImDrawList_AddCircleEx :: proc(self: ^ImDrawList, center: ImVec2, radius: f32, col: ImU32, num_segments: i32, thickness: f32) ---
	ImDrawList_AddCircleFilled :: proc(self: ^ImDrawList, center: ImVec2, radius: f32, col: ImU32, num_segments: i32) ---
	ImDrawList_AddNgon :: proc(self: ^ImDrawList, center: ImVec2, radius: f32, col: ImU32, num_segments: i32) ---
	ImDrawList_AddNgonEx :: proc(self: ^ImDrawList, center: ImVec2, radius: f32, col: ImU32, num_segments: i32, thickness: f32) ---
	ImDrawList_AddNgonFilled :: proc(self: ^ImDrawList, center: ImVec2, radius: f32, col: ImU32, num_segments: i32) ---
	ImDrawList_AddEllipse :: proc(self: ^ImDrawList, center: ImVec2, radius: ImVec2, col: ImU32) ---
	ImDrawList_AddEllipseEx :: proc(self: ^ImDrawList, center: ImVec2, radius: ImVec2, col: ImU32, rot: f32, num_segments: i32, thickness: f32) ---
	ImDrawList_AddEllipseFilled :: proc(self: ^ImDrawList, center: ImVec2, radius: ImVec2, col: ImU32) ---
	ImDrawList_AddEllipseFilledEx :: proc(self: ^ImDrawList, center: ImVec2, radius: ImVec2, col: ImU32, rot: f32, num_segments: i32) ---
	ImDrawList_AddText :: proc(self: ^ImDrawList, pos: ImVec2, col: ImU32, text_begin: cstring) ---
	ImDrawList_AddTextEx :: proc(self: ^ImDrawList, pos: ImVec2, col: ImU32, text_begin: cstring, text_end: cstring) ---
	ImDrawList_AddTextImFontPtr :: proc(self: ^ImDrawList, font: ^ImFont, font_size: f32, pos: ImVec2, col: ImU32, text_begin: cstring) ---
	ImDrawList_AddTextImFontPtrEx :: proc(self: ^ImDrawList, font: ^ImFont, font_size: f32, pos: ImVec2, col: ImU32, text_begin: cstring, text_end: cstring, wrap_width: f32, cpu_fine_clip_rect: ^ImVec4) ---
	ImDrawList_AddBezierCubic :: proc(self: ^ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: f32, num_segments: i32) ---
	ImDrawList_AddBezierQuadratic :: proc(self: ^ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32, thickness: f32, num_segments: i32) ---
	ImDrawList_AddPolyline :: proc(self: ^ImDrawList, points: ^ImVec2, num_points: i32, col: ImU32, flags: ImDrawFlags, thickness: f32) ---
	ImDrawList_AddConvexPolyFilled :: proc(self: ^ImDrawList, points: ^ImVec2, num_points: i32, col: ImU32) ---
	ImDrawList_AddConcavePolyFilled :: proc(self: ^ImDrawList, points: ^ImVec2, num_points: i32, col: ImU32) ---
	ImDrawList_AddImage :: proc(self: ^ImDrawList, user_texture_id: ImTextureID, p_min: ImVec2, p_max: ImVec2) ---
	ImDrawList_AddImageEx :: proc(self: ^ImDrawList, user_texture_id: ImTextureID, p_min: ImVec2, p_max: ImVec2, uv_min: ImVec2, uv_max: ImVec2, col: ImU32) ---
	ImDrawList_AddImageQuad :: proc(self: ^ImDrawList, user_texture_id: ImTextureID, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2) ---
	ImDrawList_AddImageQuadEx :: proc(self: ^ImDrawList, user_texture_id: ImTextureID, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, uv1: ImVec2, uv2: ImVec2, uv3: ImVec2, uv4: ImVec2, col: ImU32) ---
	ImDrawList_AddImageRounded :: proc(self: ^ImDrawList, user_texture_id: ImTextureID, p_min: ImVec2, p_max: ImVec2, uv_min: ImVec2, uv_max: ImVec2, col: ImU32, rounding: f32, flags: ImDrawFlags) ---
	ImDrawList_PathClear :: proc(self: ^ImDrawList) ---
	ImDrawList_PathLineTo :: proc(self: ^ImDrawList, pos: ImVec2) ---
	ImDrawList_PathLineToMergeDuplicate :: proc(self: ^ImDrawList, pos: ImVec2) ---
	ImDrawList_PathFillConvex :: proc(self: ^ImDrawList, col: ImU32) ---
	ImDrawList_PathFillConcave :: proc(self: ^ImDrawList, col: ImU32) ---
	ImDrawList_PathStroke :: proc(self: ^ImDrawList, col: ImU32, flags: ImDrawFlags, thickness: f32) ---
	ImDrawList_PathArcTo :: proc(self: ^ImDrawList, center: ImVec2, radius: f32, a_min: f32, a_max: f32, num_segments: i32) ---
	ImDrawList_PathArcToFast :: proc(self: ^ImDrawList, center: ImVec2, radius: f32, a_min_of_12: i32, a_max_of_12: i32) ---
	ImDrawList_PathEllipticalArcTo :: proc(self: ^ImDrawList, center: ImVec2, radius: ImVec2, rot: f32, a_min: f32, a_max: f32) ---
	ImDrawList_PathEllipticalArcToEx :: proc(self: ^ImDrawList, center: ImVec2, radius: ImVec2, rot: f32, a_min: f32, a_max: f32, num_segments: i32) ---
	ImDrawList_PathBezierCubicCurveTo :: proc(self: ^ImDrawList, p2: ImVec2, p3: ImVec2, p4: ImVec2, num_segments: i32) ---
	ImDrawList_PathBezierQuadraticCurveTo :: proc(self: ^ImDrawList, p2: ImVec2, p3: ImVec2, num_segments: i32) ---
	ImDrawList_PathRect :: proc(self: ^ImDrawList, rect_min: ImVec2, rect_max: ImVec2, rounding: f32, flags: ImDrawFlags) ---
	ImDrawList_AddCallback :: proc(self: ^ImDrawList, callback: ImDrawCallback, userdata: rawptr) ---
	ImDrawList_AddCallbackEx :: proc(self: ^ImDrawList, callback: ImDrawCallback, userdata: rawptr, userdata_size: u32) ---
	ImDrawList_AddDrawCmd :: proc(self: ^ImDrawList) ---
	ImDrawList_CloneOutput :: proc(self: ^ImDrawList) -> ^ImDrawList ---
	ImDrawList_ChannelsSplit :: proc(self: ^ImDrawList, count: i32) ---
	ImDrawList_ChannelsMerge :: proc(self: ^ImDrawList) ---
	ImDrawList_ChannelsSetCurrent :: proc(self: ^ImDrawList, n: i32) ---
	ImDrawList_PrimReserve :: proc(self: ^ImDrawList, idx_count: i32, vtx_count: i32) ---
	ImDrawList_PrimUnreserve :: proc(self: ^ImDrawList, idx_count: i32, vtx_count: i32) ---
	ImDrawList_PrimRect :: proc(self: ^ImDrawList, a: ImVec2, b: ImVec2, col: ImU32) ---
	ImDrawList_PrimRectUV :: proc(self: ^ImDrawList, a: ImVec2, b: ImVec2, uv_a: ImVec2, uv_b: ImVec2, col: ImU32) ---
	ImDrawList_PrimQuadUV :: proc(self: ^ImDrawList, a: ImVec2, b: ImVec2, c: ImVec2, d: ImVec2, uv_a: ImVec2, uv_b: ImVec2, uv_c: ImVec2, uv_d: ImVec2, col: ImU32) ---
	ImDrawList_PrimWriteVtx :: proc(self: ^ImDrawList, pos: ImVec2, uv: ImVec2, col: ImU32) ---
	ImDrawList_PrimWriteIdx :: proc(self: ^ImDrawList, idx: ImDrawIdx) ---
	ImDrawList_PrimVtx :: proc(self: ^ImDrawList, pos: ImVec2, uv: ImVec2, col: ImU32) ---
	ImDrawList__ResetForNewFrame :: proc(self: ^ImDrawList) ---
	ImDrawList__ClearFreeMemory :: proc(self: ^ImDrawList) ---
	ImDrawList__PopUnusedDrawCmd :: proc(self: ^ImDrawList) ---
	ImDrawList__TryMergeDrawCmds :: proc(self: ^ImDrawList) ---
	ImDrawList__OnChangedClipRect :: proc(self: ^ImDrawList) ---
	ImDrawList__OnChangedTextureID :: proc(self: ^ImDrawList) ---
	ImDrawList__OnChangedVtxOffset :: proc(self: ^ImDrawList) ---
	ImDrawList__SetTextureID :: proc(self: ^ImDrawList, texture_id: ImTextureID) ---
	ImDrawList__CalcCircleAutoSegmentCount :: proc(self: ^ImDrawList, radius: f32) -> i32 ---
	ImDrawList__PathArcToFastEx :: proc(self: ^ImDrawList, center: ImVec2, radius: f32, a_min_sample: i32, a_max_sample: i32, a_step: i32) ---
	ImDrawList__PathArcToN :: proc(self: ^ImDrawList, center: ImVec2, radius: f32, a_min: f32, a_max: f32, num_segments: i32) ---
	ImDrawData_Clear :: proc(self: ^ImDrawData) ---
	ImDrawData_AddDrawList :: proc(self: ^ImDrawData, draw_list: ^ImDrawList) ---
	ImDrawData_DeIndexAllBuffers :: proc(self: ^ImDrawData) ---
	ImDrawData_ScaleClipRects :: proc(self: ^ImDrawData, fb_scale: ImVec2) ---
	ImFontGlyphRangesBuilder_Clear :: proc(self: ^ImFontGlyphRangesBuilder) ---
	ImFontGlyphRangesBuilder_GetBit :: proc(self: ^ImFontGlyphRangesBuilder, n: u32) -> b8 ---
	ImFontGlyphRangesBuilder_SetBit :: proc(self: ^ImFontGlyphRangesBuilder, n: u32) ---
	ImFontGlyphRangesBuilder_AddChar :: proc(self: ^ImFontGlyphRangesBuilder, c: ImWchar) ---
	ImFontGlyphRangesBuilder_AddText :: proc(self: ^ImFontGlyphRangesBuilder, text: cstring, text_end: cstring) ---
	ImFontGlyphRangesBuilder_AddRanges :: proc(self: ^ImFontGlyphRangesBuilder, ranges: ^ImWchar) ---
	ImFontGlyphRangesBuilder_BuildRanges :: proc(self: ^ImFontGlyphRangesBuilder, out_ranges: ^ImVector_ImWchar) ---
	ImFontAtlasCustomRect_IsPacked :: proc(self: ^ImFontAtlasCustomRect) -> b8 ---
	ImFontAtlas_AddFont :: proc(self: ^ImFontAtlas, font_cfg: ^ImFontConfig) -> ^ImFont ---
	ImFontAtlas_AddFontDefault :: proc(self: ^ImFontAtlas, font_cfg: ^ImFontConfig) -> ^ImFont ---
	ImFontAtlas_AddFontFromFileTTF :: proc(self: ^ImFontAtlas, filename: cstring, size_pixels: f32, font_cfg: ^ImFontConfig, glyph_ranges: ^ImWchar) -> ^ImFont ---
	ImFontAtlas_AddFontFromMemoryTTF :: proc(self: ^ImFontAtlas, font_data: rawptr, font_data_size: i32, size_pixels: f32, font_cfg: ^ImFontConfig, glyph_ranges: ^ImWchar) -> ^ImFont ---
	ImFontAtlas_AddFontFromMemoryCompressedTTF :: proc(self: ^ImFontAtlas, compressed_font_data: rawptr, compressed_font_data_size: i32, size_pixels: f32, font_cfg: ^ImFontConfig, glyph_ranges: ^ImWchar) -> ^ImFont ---
	ImFontAtlas_AddFontFromMemoryCompressedBase85TTF :: proc(self: ^ImFontAtlas, compressed_font_data_base85: cstring, size_pixels: f32, font_cfg: ^ImFontConfig, glyph_ranges: ^ImWchar) -> ^ImFont ---
	ImFontAtlas_ClearInputData :: proc(self: ^ImFontAtlas) ---
	ImFontAtlas_ClearTexData :: proc(self: ^ImFontAtlas) ---
	ImFontAtlas_ClearFonts :: proc(self: ^ImFontAtlas) ---
	ImFontAtlas_Clear :: proc(self: ^ImFontAtlas) ---
	ImFontAtlas_Build :: proc(self: ^ImFontAtlas) -> b8 ---
	ImFontAtlas_GetTexDataAsAlpha8 :: proc(self: ^ImFontAtlas, out_pixels: [^]cstring, out_width: ^i32, out_height: ^i32, out_bytes_per_pixel: ^i32) ---
	ImFontAtlas_GetTexDataAsRGBA32 :: proc(self: ^ImFontAtlas, out_pixels: [^]cstring, out_width: ^i32, out_height: ^i32, out_bytes_per_pixel: ^i32) ---
	ImFontAtlas_IsBuilt :: proc(self: ^ImFontAtlas) -> b8 ---
	ImFontAtlas_SetTexID :: proc(self: ^ImFontAtlas, id: ImTextureID) ---
	ImFontAtlas_GetGlyphRangesDefault :: proc(self: ^ImFontAtlas) -> ^ImWchar ---
	ImFontAtlas_GetGlyphRangesGreek :: proc(self: ^ImFontAtlas) -> ^ImWchar ---
	ImFontAtlas_GetGlyphRangesKorean :: proc(self: ^ImFontAtlas) -> ^ImWchar ---
	ImFontAtlas_GetGlyphRangesJapanese :: proc(self: ^ImFontAtlas) -> ^ImWchar ---
	ImFontAtlas_GetGlyphRangesChineseFull :: proc(self: ^ImFontAtlas) -> ^ImWchar ---
	ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon :: proc(self: ^ImFontAtlas) -> ^ImWchar ---
	ImFontAtlas_GetGlyphRangesCyrillic :: proc(self: ^ImFontAtlas) -> ^ImWchar ---
	ImFontAtlas_GetGlyphRangesThai :: proc(self: ^ImFontAtlas) -> ^ImWchar ---
	ImFontAtlas_GetGlyphRangesVietnamese :: proc(self: ^ImFontAtlas) -> ^ImWchar ---
	ImFontAtlas_AddCustomRectRegular :: proc(self: ^ImFontAtlas, width: i32, height: i32) -> i32 ---
	ImFontAtlas_AddCustomRectFontGlyph :: proc(self: ^ImFontAtlas, font: ^ImFont, id: ImWchar, width: i32, height: i32, advance_x: f32, offset: ImVec2) -> i32 ---
	ImFontAtlas_GetCustomRectByIndex :: proc(self: ^ImFontAtlas, index: i32) -> ^ImFontAtlasCustomRect ---
	ImFontAtlas_CalcCustomRectUV :: proc(self: ^ImFontAtlas, rect: ^ImFontAtlasCustomRect, out_uv_min: ^ImVec2, out_uv_max: ^ImVec2) ---
	ImFontAtlas_GetMouseCursorTexData :: proc(self: ^ImFontAtlas, cursor: MouseCursor, out_offset: ^ImVec2, out_size: ^ImVec2, out_uv_border: ^[2]ImVec2, out_uv_fill: ^[2]ImVec2) -> b8 ---
	ImFont_FindGlyph :: proc(self: ^ImFont, c: ImWchar) -> ^ImFontGlyph ---
	ImFont_FindGlyphNoFallback :: proc(self: ^ImFont, c: ImWchar) -> ^ImFontGlyph ---
	ImFont_GetCharAdvance :: proc(self: ^ImFont, c: ImWchar) -> f32 ---
	ImFont_IsLoaded :: proc(self: ^ImFont) -> b8 ---
	ImFont_GetDebugName :: proc(self: ^ImFont) -> cstring ---
	ImFont_CalcTextSizeA :: proc(self: ^ImFont, size: f32, max_width: f32, wrap_width: f32, text_begin: cstring) -> ImVec2 ---
	ImFont_CalcTextSizeAEx :: proc(self: ^ImFont, size: f32, max_width: f32, wrap_width: f32, text_begin: cstring, text_end: cstring, remaining: [^]cstring) -> ImVec2 ---
	ImFont_CalcWordWrapPositionA :: proc(self: ^ImFont, scale: f32, text: cstring, text_end: cstring, wrap_width: f32) -> cstring ---
	ImFont_RenderChar :: proc(self: ^ImFont, draw_list: ^ImDrawList, size: f32, pos: ImVec2, col: ImU32, c: ImWchar) ---
	ImFont_RenderText :: proc(self: ^ImFont, draw_list: ^ImDrawList, size: f32, pos: ImVec2, col: ImU32, clip_rect: ImVec4, text_begin: cstring, text_end: cstring, wrap_width: f32, cpu_fine_clip: b8) ---
	ImFont_BuildLookupTable :: proc(self: ^ImFont) ---
	ImFont_ClearOutputData :: proc(self: ^ImFont) ---
	ImFont_GrowIndex :: proc(self: ^ImFont, new_size: i32) ---
	ImFont_AddGlyph :: proc(self: ^ImFont, src_cfg: ^ImFontConfig, c: ImWchar, x0: f32, y0: f32, x1: f32, y1: f32, u0: f32, v0: f32, u1: f32, v1: f32, advance_x: f32) ---
	ImFont_AddRemapChar :: proc(self: ^ImFont, dst: ImWchar, src: ImWchar, overwrite_dst: b8) ---
	ImFont_SetGlyphVisible :: proc(self: ^ImFont, c: ImWchar, visible: b8) ---
	ImFont_IsGlyphRangeUnused :: proc(self: ^ImFont, c_begin: u32, c_last: u32) -> b8 ---
	ImGuiViewport_GetCenter :: proc(self: ^Viewport) -> ImVec2 ---
	ImGuiViewport_GetWorkCenter :: proc(self: ^Viewport) -> ImVec2 ---
}
@(default_calling_convention = "cdecl", link_prefix = "ImGui_")
foreign imgui {
	PushButtonRepeat :: proc(repeat: b8) ---
	PopButtonRepeat :: proc() ---
	PushTabStop :: proc(tab_stop: b8) ---
	PopTabStop :: proc() ---
	GetContentRegionMax :: proc() -> ImVec2 ---
	GetWindowContentRegionMin :: proc() -> ImVec2 ---
	GetWindowContentRegionMax :: proc() -> ImVec2 ---
	BeginChildFrame :: proc(id: ID, size: ImVec2) -> b8 ---
	BeginChildFrameEx :: proc(id: ID, size: ImVec2, window_flags: WindowFlags) -> b8 ---
	EndChildFrame :: proc() ---
	ShowStackToolWindow :: proc(p_open: ^b8) ---
	ComboObsolete :: proc(label: cstring, current_item: ^i32, old_callback: proc(user_data: rawptr, idx: i32, out_text: [^]cstring) -> b8, user_data: rawptr, items_count: i32) -> b8 ---
	ComboObsoleteEx :: proc(label: cstring, current_item: ^i32, old_callback: proc(user_data: rawptr, idx: i32, out_text: [^]cstring) -> b8, user_data: rawptr, items_count: i32, popup_max_height_in_items: i32) -> b8 ---
	ListBoxObsolete :: proc(label: cstring, current_item: ^i32, old_callback: proc(user_data: rawptr, idx: i32, out_text: [^]cstring) -> b8, user_data: rawptr, items_count: i32) -> b8 ---
	ListBoxObsoleteEx :: proc(label: cstring, current_item: ^i32, old_callback: proc(user_data: rawptr, idx: i32, out_text: [^]cstring) -> b8, user_data: rawptr, items_count: i32, height_in_items: i32) -> b8 ---
	SetItemAllowOverlap :: proc() ---
	PushAllowKeyboardFocus :: proc(tab_stop: b8) ---
	PopAllowKeyboardFocus :: proc() ---
}
ImDrawListSharedData :: struct {}
ImFontBuilderIO :: struct {}
Context :: struct {}

ImVec2 :: struct {
	x: f32,
	y: f32,
}
ImVec4 :: struct {
	x: f32,
	y: f32,
	z: f32,
	w: f32,
}
TableSortSpecs :: struct {
	Specs: ^TableColumnSortSpecs,
	SpecsCount: i32,
	SpecsDirty: b8,
}
TableColumnSortSpecs :: struct {
	ColumnUserID: ID,
	ColumnIndex: ImS16,
	SortOrder: ImS16,
	SortDirection: SortDirection,
}
ImVector_ImWchar :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImWchar,
}
ImVector_ImGuiTextFilter_ImGuiTextRange :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^TextFilter_ImGuiTextRange,
}
ImVector_char :: struct {
	Size: i32,
	Capacity: i32,
	Data: cstring,
}
ImVector_ImGuiStoragePair :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^StoragePair,
}
ImVector_ImGuiSelectionRequest :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^SelectionRequest,
}
ImVector_ImDrawCmd :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImDrawCmd,
}
ImVector_ImDrawIdx :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImDrawIdx,
}
ImVector_ImDrawChannel :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImDrawChannel,
}
ImVector_ImDrawVert :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImDrawVert,
}
ImVector_ImVec2 :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImVec2,
}
ImVector_ImVec4 :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImVec4,
}
ImVector_ImTextureID :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImTextureID,
}
ImVector_ImU8 :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImU8,
}
ImVector_ImDrawListPtr :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^^ImDrawList,
}
ImVector_ImU32 :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImU32,
}
ImVector_ImFontPtr :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^^ImFont,
}
ImVector_ImFontAtlasCustomRect :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImFontAtlasCustomRect,
}
ImVector_ImFontConfig :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImFontConfig,
}
ImVector_float :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^f32,
}
ImVector_ImFontGlyph :: struct {
	Size: i32,
	Capacity: i32,
	Data: ^ImFontGlyph,
}
Style :: struct {
	Alpha: f32,
	DisabledAlpha: f32,
	WindowPadding: ImVec2,
	WindowRounding: f32,
	WindowBorderSize: f32,
	WindowMinSize: ImVec2,
	WindowTitleAlign: ImVec2,
	WindowMenuButtonPosition: Dir,
	ChildRounding: f32,
	ChildBorderSize: f32,
	PopupRounding: f32,
	PopupBorderSize: f32,
	FramePadding: ImVec2,
	FrameRounding: f32,
	FrameBorderSize: f32,
	ItemSpacing: ImVec2,
	ItemInnerSpacing: ImVec2,
	CellPadding: ImVec2,
	TouchExtraPadding: ImVec2,
	IndentSpacing: f32,
	ColumnsMinSpacing: f32,
	ScrollbarSize: f32,
	ScrollbarRounding: f32,
	GrabMinSize: f32,
	GrabRounding: f32,
	LogSliderDeadzone: f32,
	TabRounding: f32,
	TabBorderSize: f32,
	TabMinWidthForCloseButton: f32,
	TabBarBorderSize: f32,
	TabBarOverlineSize: f32,
	TableAngledHeadersAngle: f32,
	TableAngledHeadersTextAlign: ImVec2,
	ColorButtonPosition: Dir,
	ButtonTextAlign: ImVec2,
	SelectableTextAlign: ImVec2,
	SeparatorTextBorderSize: f32,
	SeparatorTextAlign: ImVec2,
	SeparatorTextPadding: ImVec2,
	DisplayWindowPadding: ImVec2,
	DisplaySafeAreaPadding: ImVec2,
	MouseCursorScale: f32,
	AntiAliasedLines: b8,
	AntiAliasedLinesUseTex: b8,
	AntiAliasedFill: b8,
	CurveTessellationTol: f32,
	CircleTessellationMaxError: f32,
	Colors: [Col.COUNT]ImVec4,
	HoverStationaryDelay: f32,
	HoverDelayShort: f32,
	HoverDelayNormal: f32,
	HoverFlagsForTooltipMouse: HoveredFlags,
	HoverFlagsForTooltipNav: HoveredFlags,
}
KeyData :: struct {
	Down: b8,
	DownDuration: f32,
	DownDurationPrev: f32,
	AnalogValue: f32,
}
IO :: struct {
	ConfigFlags: ConfigFlags,
	BackendFlags: BackendFlags,
	DisplaySize: ImVec2,
	DeltaTime: f32,
	IniSavingRate: f32,
	IniFilename: cstring,
	LogFilename: cstring,
	UserData: rawptr,
	Fonts: ^ImFontAtlas,
	FontGlobalScale: f32,
	FontAllowUserScaling: b8,
	FontDefault: ^ImFont,
	DisplayFramebufferScale: ImVec2,
	ConfigNavSwapGamepadButtons: b8,
	ConfigNavMoveSetMousePos: b8,
	ConfigNavCaptureKeyboard: b8,
	ConfigNavEscapeClearFocusItem: b8,
	ConfigNavEscapeClearFocusWindow: b8,
	ConfigNavCursorVisibleAuto: b8,
	ConfigNavCursorVisibleAlways: b8,
	MouseDrawCursor: b8,
	ConfigMacOSXBehaviors: b8,
	ConfigInputTrickleEventQueue: b8,
	ConfigInputTextCursorBlink: b8,
	ConfigInputTextEnterKeepActive: b8,
	ConfigDragClickToInputText: b8,
	ConfigWindowsResizeFromEdges: b8,
	ConfigWindowsMoveFromTitleBarOnly: b8,
	ConfigWindowsCopyContentsWithCtrlC: b8,
	ConfigScrollbarScrollByPage: b8,
	ConfigMemoryCompactTimer: f32,
	MouseDoubleClickTime: f32,
	MouseDoubleClickMaxDist: f32,
	MouseDragThreshold: f32,
	KeyRepeatDelay: f32,
	KeyRepeatRate: f32,
	ConfigErrorRecovery: b8,
	ConfigErrorRecoveryEnableAssert: b8,
	ConfigErrorRecoveryEnableDebugLog: b8,
	ConfigErrorRecoveryEnableTooltip: b8,
	ConfigDebugIsDebuggerPresent: b8,
	ConfigDebugHighlightIdConflicts: b8,
	ConfigDebugBeginReturnValueOnce: b8,
	ConfigDebugBeginReturnValueLoop: b8,
	ConfigDebugIgnoreFocusLoss: b8,
	ConfigDebugIniSettings: b8,
	BackendPlatformName: cstring,
	BackendRendererName: cstring,
	BackendPlatformUserData: rawptr,
	BackendRendererUserData: rawptr,
	BackendLanguageUserData: rawptr,
	WantCaptureMouse: b8,
	WantCaptureKeyboard: b8,
	WantTextInput: b8,
	WantSetMousePos: b8,
	WantSaveIniSettings: b8,
	NavActive: b8,
	NavVisible: b8,
	Framerate: f32,
	MetricsRenderVertices: i32,
	MetricsRenderIndices: i32,
	MetricsRenderWindows: i32,
	MetricsActiveWindows: i32,
	MouseDelta: ImVec2,
	Ctx: ^Context,
	MousePos: ImVec2,
	MouseDown: [5]b8,
	MouseWheel: f32,
	MouseWheelH: f32,
	MouseSource: MouseSource,
	KeyCtrl: b8,
	KeyShift: b8,
	KeyAlt: b8,
	KeySuper: b8,
	KeyMods: KeyChord,
	KeysData: [Key.NamedKey_COUNT]KeyData,
	WantCaptureMouseUnlessPopupClose: b8,
	MousePosPrev: ImVec2,
	MouseClickedPos: [5]ImVec2,
	MouseClickedTime: [5]f64,
	MouseClicked: [5]b8,
	MouseDoubleClicked: [5]b8,
	MouseClickedCount: [5]ImU16,
	MouseClickedLastCount: [5]ImU16,
	MouseReleased: [5]b8,
	MouseDownOwned: [5]b8,
	MouseDownOwnedUnlessPopupClose: [5]b8,
	MouseWheelRequestAxisSwap: b8,
	MouseCtrlLeftAsRightClick: b8,
	MouseDownDuration: [5]f32,
	MouseDownDurationPrev: [5]f32,
	MouseDragMaxDistanceSqr: [5]f32,
	PenPressure: f32,
	AppFocusLost: b8,
	AppAcceptingEvents: b8,
	InputQueueSurrogate: ImWchar16,
	InputQueueCharacters: ImVector_ImWchar,
	// GetClipboardTextFn: proc "c" (user_data: rawptr) -> cstring,
	// SetClipboardTextFn:  proc "c" (user_data: rawptr, text: cstring),
	ClipboardUserData: rawptr,
}
InputTextCallbackData :: struct {
	Ctx: ^Context,
	EventFlag: InputTextFlags,
	Flags: InputTextFlags,
	UserData: rawptr,
	EventChar: ImWchar,
	EventKey: Key,
	Buf: cstring,
	BufTextLen: i32,
	BufSize: i32,
	BufDirty: b8,
	CursorPos: i32,
	SelectionStart: i32,
	SelectionEnd: i32,
}
SizeCallbackData :: struct {
	UserData: rawptr,
	Pos: ImVec2,
	CurrentSize: ImVec2,
	DesiredSize: ImVec2,
}
Payload :: struct {
	Data: rawptr,
	DataSize: i32,
	SourceId: ID,
	SourceParentId: ID,
	DataFrameCount: i32,
	DataType: [32+1]cstring,
	Preview: b8,
	Delivery: b8,
}
TextFilter_ImGuiTextRange :: struct {
	b: cstring,
	e: cstring,
}
TextFilter :: struct {
	InputBuf: [256]cstring,
	Filters: ImVector_ImGuiTextFilter_ImGuiTextRange,
	CountGrep: i32,
}
TextBuffer :: struct {
	Buf: ImVector_char,
}
StoragePair :: struct {
	key: ID,
	__anonymous_type0: __anonymous_type0,
}
__anonymous_type0 :: struct {
	val_i: i32,
	val_f: f32,
	val_p: rawptr,
}
Storage :: struct {
	Data: ImVector_ImGuiStoragePair,
}
ListClipper :: struct {
	Ctx: ^Context,
	DisplayStart: i32,
	DisplayEnd: i32,
	ItemsCount: i32,
	ItemsHeight: f32,
	StartPosY: f32,
	StartSeekOffsetY: f64,
	TempData: rawptr,
}
ImColor :: struct {
	Value: ImVec4,
}
MultiSelectIO :: struct {
	Requests: ImVector_ImGuiSelectionRequest,
	RangeSrcItem: SelectionUserData,
	NavIdItem: SelectionUserData,
	NavIdSelected: b8,
	RangeSrcReset: b8,
	ItemsCount: i32,
}
SelectionRequest :: struct {
	Type: SelectionRequestType,
	Selected: b8,
	RangeDirection: ImS8,
	RangeFirstItem: SelectionUserData,
	RangeLastItem: SelectionUserData,
}
SelectionBasicStorage :: struct {
	Size: i32,
	PreserveOrder: b8,
	UserData: rawptr,
	AdapterIndexToStorageId: proc "c" (self: ^SelectionBasicStorage, idx: i32) -> ID,
	_SelectionOrder: i32,
	_Storage: Storage,
}
SelectionExternalStorage :: struct {
	UserData: rawptr,
	AdapterSetItemSelected: proc "c" (self: ^SelectionExternalStorage, idx: i32, selected: b8),
}
ImDrawCmd :: struct {
	ClipRect: ImVec4,
	TextureId: ImTextureID,
	VtxOffset: u32,
	IdxOffset: u32,
	ElemCount: u32,
	UserCallback: ImDrawCallback,
	UserCallbackData: rawptr,
	UserCallbackDataSize: i32,
	UserCallbackDataOffset: i32,
}
ImDrawVert :: struct {
	pos: ImVec2,
	uv: ImVec2,
	col: ImU32,
}
ImDrawCmdHeader :: struct {
	ClipRect: ImVec4,
	TextureId: ImTextureID,
	VtxOffset: u32,
}
ImDrawChannel :: struct {
	_CmdBuffer: ImVector_ImDrawCmd,
	_IdxBuffer: ImVector_ImDrawIdx,
}
ImDrawListSplitter :: struct {
	_Current: i32,
	_Count: i32,
	_Channels: ImVector_ImDrawChannel,
}
ImDrawList :: struct {
	CmdBuffer: ImVector_ImDrawCmd,
	IdxBuffer: ImVector_ImDrawIdx,
	VtxBuffer: ImVector_ImDrawVert,
	Flags: ImDrawListFlags,
	_VtxCurrentIdx: u32,
	_Data: ^ImDrawListSharedData,
	_VtxWritePtr: ^ImDrawVert,
	_IdxWritePtr: ^ImDrawIdx,
	_Path: ImVector_ImVec2,
	_CmdHeader: ImDrawCmdHeader,
	_Splitter: ImDrawListSplitter,
	_ClipRectStack: ImVector_ImVec4,
	_TextureIdStack: ImVector_ImTextureID,
	_CallbacksDataBuf: ImVector_ImU8,
	_FringeScale: f32,
	_OwnerName: cstring,
}
ImDrawData :: struct {
	Valid: b8,
	CmdListsCount: i32,
	TotalIdxCount: i32,
	TotalVtxCount: i32,
	CmdLists: ImVector_ImDrawListPtr,
	DisplayPos: ImVec2,
	DisplaySize: ImVec2,
	FramebufferScale: ImVec2,
	OwnerViewport: ^Viewport,
}
ImFontConfig :: struct {
	FontData: rawptr,
	FontDataSize: i32,
	FontDataOwnedByAtlas: b8,
	FontNo: i32,
	SizePixels: f32,
	OversampleH: i32,
	OversampleV: i32,
	PixelSnapH: b8,
	GlyphExtraSpacing: ImVec2,
	GlyphOffset: ImVec2,
	GlyphRanges: ^ImWchar,
	GlyphMinAdvanceX: f32,
	GlyphMaxAdvanceX: f32,
	MergeMode: b8,
	FontBuilderFlags: u32,
	RasterizerMultiply: f32,
	RasterizerDensity: f32,
	EllipsisChar: ImWchar,
	Name: [40]cstring,
	DstFont: ^ImFont,
}
ImFontGlyph :: struct {
	Colored: u32,
	Visible: u32,
	Codepoint: u32,
	AdvanceX: f32,
	X0: f32,
	Y0: f32,
	X1: f32,
	Y1: f32,
	U0: f32,
	V0: f32,
	U1: f32,
	V1: f32,
}
ImFontGlyphRangesBuilder :: struct {
	UsedChars: ImVector_ImU32,
}
ImFontAtlasCustomRect :: struct {
	X: u16,
	Y: u16,
	Width: u16,
	Height: u16,
	GlyphID: u32,
	GlyphColored: u32,
	GlyphAdvanceX: f32,
	GlyphOffset: ImVec2,
	Font: ^ImFont,
}
IM_DRAWLIST_TEX_LINES_WIDTH_MAX :: 63
ImFontAtlas :: struct {
	Flags: ImFontAtlasFlags,
	TexID: ImTextureID,
	TexDesiredWidth: i32,
	TexGlyphPadding: i32,
	Locked: b8,
	UserData: rawptr,
	TexReady: b8,
	TexPixelsUseColors: b8,
	TexPixelsAlpha8: cstring,
	TexPixelsRGBA32: [^]u32,
	TexWidth: i32,
	TexHeight: i32,
	TexUvScale: ImVec2,
	TexUvWhitePixel: ImVec2,
	Fonts: ImVector_ImFontPtr,
	CustomRects: ImVector_ImFontAtlasCustomRect,
	ConfigData: ImVector_ImFontConfig,
	TexUvLines: [IM_DRAWLIST_TEX_LINES_WIDTH_MAX+1]ImVec4,
	FontBuilderIO: ^ImFontBuilderIO,
	FontBuilderFlags: u32,
	PackIdMouseCursors: i32,
	PackIdLines: i32,
}
IM_UNICODE_CODEPOINT_MAX :: 0x10FFFF
ImFont :: struct {
	IndexAdvanceX: ImVector_float,
	FallbackAdvanceX: f32,
	FontSize: f32,
	IndexLookup: ImVector_ImWchar,
	Glyphs: ImVector_ImFontGlyph,
	FallbackGlyph: ^ImFontGlyph,
	ContainerAtlas: ^ImFontAtlas,
	ConfigData: ^ImFontConfig,
	ConfigDataCount: i16,
	EllipsisCharCount: i16,
	EllipsisChar: ImWchar,
	FallbackChar: ImWchar,
	EllipsisWidth: f32,
	EllipsisCharStep: f32,
	DirtyLookupTables: b8,
	Scale: f32,
	Ascent: f32,
	Descent: f32,
	MetricsTotalSurface: i32,
	Used4kPagesMap: [(IM_UNICODE_CODEPOINT_MAX +1)/4096/8]ImU8,
}
Viewport :: struct {
	ID: ID,
	Flags: ViewportFlags,
	Pos: ImVec2,
	Size: ImVec2,
	WorkPos: ImVec2,
	WorkSize: ImVec2,
	PlatformHandle: rawptr,
	PlatformHandleRaw: rawptr,
}
PlatformIO :: struct {
	Platform_GetClipboardTextFn: proc "c" (ctx: ^Context) -> cstring,
	Platform_SetClipboardTextFn: proc "c" (ctx: ^Context, text: cstring),
	Platform_ClipboardUserData: rawptr,
	Platform_OpenInShellFn: proc "c" (ctx: ^Context, path: cstring) -> b8,
	Platform_OpenInShellUserData: rawptr,
	Platform_SetImeDataFn: proc "c" (ctx: ^Context, viewport: ^Viewport, data: ^PlatformImeData),
	Platform_ImeUserData: rawptr,
	Platform_LocaleDecimalPoint: ImWchar,
	Renderer_RenderState: rawptr,
}
PlatformImeData :: struct {
	WantVisible: b8,
	InputPos: ImVec2,
	InputLineHeight: f32,
}
