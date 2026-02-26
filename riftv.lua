local UILibrary = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Icons = {
	Home = "rbxassetid://7733960981",
	Settings = "rbxassetid://7734053495",
	User = "rbxassetid://7733955740",
	Gamepad = "rbxassetid://7733954760",
	Eye = "rbxassetid://7734022108",
	EyeOff = "rbxassetid://7734022054",
	Check = "rbxassetid://7733710700",
	X = "rbxassetid://7733715403",
	ChevronDown = "rbxassetid://7733717447",
	ChevronRight = "rbxassetid://7733717651",
	ChevronLeft = "rbxassetid://7733717549",
	Minus = "rbxassetid://7733764331",
	Plus = "rbxassetid://7733764271",
	Search = "rbxassetid://7733764328",
	Bell = "rbxassetid://7733919333",
	Info = "rbxassetid://7733954058",
	AlertCircle = "rbxassetid://7733658504",
	AlertTriangle = "rbxassetid://7733658278",
	CheckCircle = "rbxassetid://7733710700",
	Type = "rbxassetid://7734022108",
	Palette = "rbxassetid://7733764083",
	Image = "rbxassetid://7733954058",
	MousePointer = "rbxassetid://7733764331",
	Zap = "rbxassetid://7734020554",
	Menu = "rbxassetid://7733764147",
	MoreHorizontal = "rbxassetid://7733764331",
	Copy = "rbxassetid://7733717447",
	Trash = "rbxassetid://7734021595",
	Edit = "rbxassetid://7734022108",
	Save = "rbxassetid://7733764328",
	Refresh = "rbxassetid://7733764271",
	Play = "rbxassetid://7733764271",
	Pause = "rbxassetid://7733764331",
	Stop = "rbxassetid://7734021595",
	Volume = "rbxassetid://7734020554",
	VolumeMute = "rbxassetid://7734020554",
	Maximize = "rbxassetid://7733764147",
	Minimize = "rbxassetid://7733764331",
	ExternalLink = "rbxassetid://7734022108",
	Link = "rbxassetid://7733764083",
	Unlock = "rbxassetid://7734020554",
	Lock = "rbxassetid://7733764147",
	Star = "rbxassetid://7733764328",
	Heart = "rbxassetid://7733954058",
	Moon = "rbxassetid://7733764331",
	Sun = "rbxassetid://7733764271",
	Cloud = "rbxassetid://7733717447",
	Wifi = "rbxassetid://7734020554",
	WifiOff = "rbxassetid://7734020554",
	Battery = "rbxassetid://7733919333",
	BatteryCharging = "rbxassetid://7733919333",
	Power = "rbxassetid://7733764271",
	Activity = "rbxassetid://7733658504",
	TrendingUp = "rbxassetid://7734021595",
	TrendingDown = "rbxassetid://7734020554",
	BarChart = "rbxassetid://7733919333",
	PieChart = "rbxassetid://7733764083",
	Grid = "rbxassetid://7733954058",
	List = "rbxassetid://7733764147",
	Layers = "rbxassetid://7733764083",
	Box = "rbxassetid://7733710700",
	Package = "rbxassetid://7733764271",
	ShoppingCart = "rbxassetid://7733764328",
	CreditCard = "rbxassetid://7733717447",
	DollarSign = "rbxassetid://7734022108",
	Percent = "rbxassetid://7733764271",
	Tag = "rbxassetid://7733764331",
	Bookmark = "rbxassetid://7733919333",
	Flag = "rbxassetid://7734020554",
	MapPin = "rbxassetid://7733764147",
	Navigation = "rbxassetid://7733764331",
	Compass = "rbxassetid://7733717447",
	Globe = "rbxassetid://7733954058",
	Code = "rbxassetid://7733710700",
	Terminal = "rbxassetid://7734021595",
	Database = "rbxassetid://7734022108",
	Server = "rbxassetid://7733764328",
	Cpu = "rbxassetid://7733717447",
	Monitor = "rbxassetid://7733764147",
	Smartphone = "rbxassetid://7733764331",
	Tablet = "rbxassetid://7734020554",
	Watch = "rbxassetid://7734021595",
	Clock = "rbxassetid://7733717447",
	Calendar = "rbxassetid://7733710700",
	Mail = "rbxassetid://7733764083",
	MessageSquare = "rbxassetid://7733764147",
	MessageCircle = "rbxassetid://7733764331",
	Phone = "rbxassetid://7733764271",
	PhoneCall = "rbxassetid://7733764328",
	Video = "rbxassetid://7734020554",
	Camera = "rbxassetid://7733919333",
	Mic = "rbxassetid://7733764147",
	MicOff = "rbxassetid://7733764331",
	Music = "rbxassetid://7733764271",
	Film = "rbxassetid://7734022108",
	Tv = "rbxassetid://7734021595",
	Radio = "rbxassetid://7733764328",
	Rss = "rbxassetid://7733764083",
	Share = "rbxassetid://7733764331",
	Share2 = "rbxassetid://7733764271",
	Send = "rbxassetid://7733764328",
	Upload = "rbxassetid://7734020554",
	Download = "rbxassetid://7734021595",
	CloudDownload = "rbxassetid://7733717447",
	CloudUpload = "rbxassetid://7733710700",
	Folder = "rbxassetid://7734022108",
	File = "rbxassetid://7733764083",
	FileText = "rbxassetid://7733764147",
	FilePlus = "rbxassetid://7733764331",
	FileMinus = "rbxassetid://7733764271",
	Scissors = "rbxassetid://7733764328",
	Clipboard = "rbxassetid://7733717447",
	Filter = "rbxassetid://7734020554",
	Sliders = "rbxassetid://7734021595",
	ToggleLeft = "rbxassetid://7733764083",
	ToggleRight = "rbxassetid://7733764147",
	Aperture = "rbxassetid://7733658504",
	Target = "rbxassetid://7733764331",
	Crosshair = "rbxassetid://7733764271",
	Shield = "rbxassetid://7733764328",
	ShieldOff = "rbxassetid://7733764083",
	Security = "rbxassetid://7733764147",
	Key = "rbxassetid://7733764331",
	Hash = "rbxassetid://7733764271",
	AtSign = "rbxassetid://7733764328",
	Paperclip = "rbxassetid://7733717447",
	AlignLeft = "rbxassetid://7734020554",
	AlignCenter = "rbxassetid://7734021595",
	AlignRight = "rbxassetid://7733764083",
	Bold = "rbxassetid://7733919333",
	Italic = "rbxassetid://7733764147",
	Underline = "rbxassetid://7733764331",
	Strikethrough = "rbxassetid://7733764271",
	Superscript = "rbxassetid://7733764328",
	Subscript = "rbxassetid://7733717447",
	Quote = "rbxassetid://7734020554",
	BookOpen = "rbxassetid://7734021595",
	Book = "rbxassetid://7733764083",
	Library = "rbxassetid://7733764147",
	GraduationCap = "rbxassetid://7733764331",
	Award = "rbxassetid://7733764271",
	Trophy = "rbxassetid://7733764328",
	Medal = "rbxassetid://7733717447",
	Gift = "rbxassetid://7734020554",
	Coffee = "rbxassetid://7734021595",
	Briefcase = "rbxassetid://7733764083",
	Building = "rbxassetid://7733764147",
	Home2 = "rbxassetid://7733955740",
	Truck = "rbxassetid://7733764331",
	Car = "rbxassetid://7733764271",
	Plane = "rbxassetid://7733764328",
	Train = "rbxassetid://7733717447",
	Ship = "rbxassetid://7734020554",
	Anchor = "rbxassetid://7734021595",
	LifeBuoy = "rbxassetid://7733764083",
	Umbrella = "rbxassetid://7733764147",
	Thermometer = "rbxassetid://7733764331",
	Wind = "rbxassetid://7733764271",
	Droplet = "rbxassetid://7733764328",
	Flame = "rbxassetid://7733717447",
	Flashlight = "rbxassetid://7734020554",
	Bulb = "rbxassetid://7734021595",
	Plug = "rbxassetid://7733764083",
	BatteryFull = "rbxassetid://7733919333",
	BatteryLow = "rbxassetid://7733919333",
	BatteryMedium = "rbxassetid://7733919333",
	Tool = "rbxassetid://7733764147",
	Wrench = "rbxassetid://7733764331",
	Hammer = "rbxassetid://7733764271",
	Screwdriver = "rbxassetid://7733764328",
	Construction = "rbxassetid://7733717447",
	Factory = "rbxassetid://7734020554",
	Store = "rbxassetid://7734021595",
	ShoppingBag = "rbxassetid://7733764083",
	Tag2 = "rbxassetid://7733764147",
	Ticket = "rbxassetid://7733764331",
	DollarBill = "rbxassetid://7733764271",
	Coins = "rbxassetid://7733764328",
	Wallet = "rbxassetid://7733717447",
	Bank = "rbxassetid://7734020554",
	Landmark = "rbxassetid://7734021595",
	Hospital = "rbxassetid://7733764083",
	School = "rbxassetid://7733764147",
	Church = "rbxassetid://7733764331",
	Mosque = "rbxassetid://7733764271",
	Synagogue = "rbxassetid://7733764328",
	Temple = "rbxassetid://7733717447",
	Castle = "rbxassetid://7734020554",
	TreePine = "rbxassetid://7734021595",
	TreeDeciduous = "rbxassetid://7733764083",
	Flower = "rbxassetid://7733764147",
	Leaf = "rbxassetid://7733764331",
	Sprout = "rbxassetid://7733764271",
	Seedling = "rbxassetid://7733764328",
	Recycle = "rbxassetid://7733717447",
	Trash2 = "rbxassetid://7734021595",
	Delete = "rbxassetid://7734020554",
	Eraser = "rbxassetid://7733764083",
	Paintbrush = "rbxassetid://7733764147",
	Pencil = "rbxassetid://7733764331",
	Pen = "rbxassetid://7733764271",
	Highlighter = "rbxassetid://7733764328",
	Marker = "rbxassetid://7733717447",
	Ruler = "rbxassetid://7734020554",
	Scale = "rbxassetid://7734021595",
	Gauge = "rbxassetid://7733764083",
	Speedometer = "rbxassetid://7733764147",
	Odometer = "rbxassetid://7733764331",
	Tachometer = "rbxassetid://7733764271",
	Timer = "rbxassetid://7733764328",
	Stopwatch = "rbxassetid://7733717447",
	Hourglass = "rbxassetid://7734020554",
	History = "rbxassetid://7734021595",
	RotateCcw = "rbxassetid://7733764083",
	RotateCw = "rbxassetid://7733764147",
	Undo = "rbxassetid://7733764331",
	Redo = "rbxassetid://7733764271",
	Repeat2 = "rbxassetid://7733764328",
	Shuffle = "rbxassetid://7733717447",
	Random = "rbxassetid://7734020554",
	Dice = "rbxassetid://7734021595",
	Puzzle = "rbxassetid://7733764083",
	Extension = "rbxassetid://7733764147",
	Plugin = "rbxassetid://7733764331",
	Apps = "rbxassetid://7733764271",
	Dashboard = "rbxassetid://7733764328",
	Layout = "rbxassetid://7733717447",
	Sidebar = "rbxassetid://7734020554",
	PanelLeft = "rbxassetid://7734021595",
	PanelRight = "rbxassetid://7733764083",
	PanelTop = "rbxassetid://7733764147",
	PanelBottom = "rbxassetid://7733764331",
	Split = "rbxassetid://7733764271",
	Columns = "rbxassetid://7733764328",
	Rows = "rbxassetid://7733717447",
	GripVertical = "rbxassetid://7734020554",
	GripHorizontal = "rbxassetid://7734021595",
	Move = "rbxassetid://7733764083",
	ArrowUp = "rbxassetid://7733764147",
	ArrowDown = "rbxassetid://7733764331",
	ArrowLeft = "rbxassetid://7733764271",
	ArrowRight = "rbxassetid://7733764328",
	ArrowUpLeft = "rbxassetid://7733717447",
	ArrowUpRight = "rbxassetid://7734020554",
	ArrowDownLeft = "rbxassetid://7734021595",
	ArrowDownRight = "rbxassetid://7733764083",
	ChevronsUp = "rbxassetid://7733764147",
	ChevronsDown = "rbxassetid://7733764331",
	ChevronsLeft = "rbxassetid://7733764271",
	ChevronsRight = "rbxassetid://7733764328",
	CornerUpLeft = "rbxassetid://7733717447",
	CornerUpRight = "rbxassetid://7734020554",
	CornerDownLeft = "rbxassetid://7734021595",
	CornerDownRight = "rbxassetid://7733764083",
	Fold = "rbxassetid://7733764147",
	Unfold = "rbxassetid://7733764331",
	Maximize2 = "rbxassetid://7733764271",
	Minimize2 = "rbxassetid://7733764328",
	Fullscreen = "rbxassetid://7733717447",
	ExitFullscreen = "rbxassetid://7734020554",
	PictureInPicture = "rbxassetid://7734021595",
	Cast = "rbxassetid://7733764083",
	Airplay = "rbxassetid://7733764147",
	Chromecast = "rbxassetid://7733764331",
	Bluetooth = "rbxassetid://7733764271",
	BluetoothConnected = "rbxassetid://7733764328",
	BluetoothOff = "rbxassetid://7733717447",
	Nfc = "rbxassetid://7734020554",
	Qrcode = "rbxassetid://7734021595",
	Barcode = "rbxassetid://7733764083",
	Scan = "rbxassetid://7733764147",
	Fingerprint = "rbxassetid://7733764331",
	FaceId = "rbxassetid://7733764271",
	TouchId = "rbxassetid://7733764328",
}

local function Create(instanceType, properties)
	local instance = Instance.new(instanceType)
	for property, value in pairs(properties or {}) do
		instance[property] = value
	end
	return instance
end

local function Tween(instance, properties, duration, easingStyle, easingDirection)
	duration = duration or 0.3
	easingStyle = easingStyle or Enum.EasingStyle.Quad
	easingDirection = easingDirection or Enum.EasingDirection.Out
	
	local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
	local tween = TweenService:Create(instance, tweenInfo, properties)
	tween:Play()
	return tween
end

local function MakeDraggable(frame, handle)
	handle = handle or frame
	local dragging = false
	local dragStart = nil
	local startPos = nil
	
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

local Theme = {
	Background = Color3.fromRGB(22, 22, 26),
	Header = Color3.fromRGB(28, 28, 32),
	TabBackground = Color3.fromRGB(18, 18, 22),
	TabActive = Color3.fromRGB(255, 255, 255),
	TabInactive = Color3.fromRGB(130, 130, 140),
	Text = Color3.fromRGB(255, 255, 255),
	TextDark = Color3.fromRGB(160, 160, 170),
	Accent = Color3.fromRGB(88, 101, 242),
	Separator = Color3.fromRGB(45, 45, 52),
	Button = Color3.fromRGB(45, 48, 58),
	ButtonHover = Color3.fromRGB(55, 58, 70),
	ButtonActive = Color3.fromRGB(65, 68, 82),
	ToggleOff = Color3.fromRGB(55, 58, 68),
	ToggleOn = Color3.fromRGB(88, 101, 242),
	InputBackground = Color3.fromRGB(15, 15, 18),
	Success = Color3.fromRGB(60, 200, 100),
	Error = Color3.fromRGB(255, 85, 85),
	Warning = Color3.fromRGB(255, 180, 60),
	Info = Color3.fromRGB(88, 165, 255)
}

function UILibrary:CreateWindow(config)
	config = config or {}
	local title = config.title or "UI Library"
	local subtitle = config.subtitle or ""
	local iconText = config.text or "UI"
	local size = config.size or Vector2.new(520, 380)
	local accentColor = config.color or Theme.Accent
	
	local savedPosition = nil
	local isOpen = true
	local currentTab = nil
	local tabs = {}
	local notifications = {}
	
	local ScreenGui = Create("ScreenGui", {
		Name = "UILibrary_" .. HttpService:GenerateGUID(false),
		Parent = PlayerGui,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	})
	
	local MainFrame = Create("Frame", {
		Name = "MainFrame",
		Parent = ScreenGui,
		BackgroundColor3 = Theme.Background,
		BorderSizePixel = 0,
		Size = UDim2.new(0, size.X, 0, size.Y),
		Position = UDim2.new(0.5, -size.X/2, 0.5, -size.Y/2),
		ClipsDescendants = true
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 12),
		Parent = MainFrame
	})
	
	Create("UIStroke", {
		Color = Color3.fromRGB(255, 255, 255),
		Thickness = 1.5,
		Transparency = 0.8,
		Parent = MainFrame
	})
	
	Create("UIScale", {
		Scale = 1,
		Parent = MainFrame
	})
	
	local Shadow = Create("ImageLabel", {
		Name = "Shadow",
		Parent = MainFrame,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, -20, 0, -20),
		Size = UDim2.new(1, 40, 1, 40),
		ZIndex = -1,
		Image = "rbxassetid://6015897843",
		ImageColor3 = Color3.fromRGB(0, 0, 0),
		ImageTransparency = 0.4,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450)
	})
	
	local Header = Create("Frame", {
		Name = "Header",
		Parent = MainFrame,
		BackgroundColor3 = Theme.Header,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 65)
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 12),
		Parent = Header
	})
	
	local HeaderFix = Create("Frame", {
		Name = "HeaderFix",
		Parent = Header,
		BackgroundColor3 = Theme.Header,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, -10),
		Size = UDim2.new(1, 0, 0, 10)
	})
	
	local TitleLabel = Create("TextLabel", {
		Name = "Title",
		Parent = Header,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 18, 0, 12),
		Size = UDim2.new(1, -140, 0, 22),
		Font = Enum.Font.GothamBold,
		Text = title,
		TextColor3 = Theme.Text,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	
	local SubtitleLabel = Create("TextLabel", {
		Name = "Subtitle",
		Parent = Header,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 18, 0, 36),
		Size = UDim2.new(1, -140, 0, 16),
		Font = Enum.Font.Gotham,
		Text = subtitle,
		TextColor3 = Theme.TextDark,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	
	local PingContainer = Create("Frame", {
		Name = "PingContainer",
		Parent = Header,
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -130, 0, 10),
		Size = UDim2.new(0, 60, 0, 22)
	})
	
	local PingIcon = Create("ImageLabel", {
		Name = "PingIcon",
		Parent = PingContainer,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0.5, -6),
		Size = UDim2.new(0, 12, 0, 12),
		Image = Icons.Activity,
		ImageColor3 = Theme.Success
	})
	
	local PingLabel = Create("TextLabel", {
		Name = "Ping",
		Parent = PingContainer,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 16, 0, 0),
		Size = UDim2.new(1, -16, 1, 0),
		Font = Enum.Font.GothamMedium,
		Text = "0 ms",
		TextColor3 = Theme.TextDark,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	
	local HideButton = Create("ImageButton", {
		Name = "HideButton",
		Parent = Header,
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -70, 0, 8),
		Size = UDim2.new(0, 28, 0, 28),
		Image = Icons.Minus,
		ImageColor3 = Theme.TextDark,
		AutoButtonColor = false
	})
	
	local CloseButton = Create("ImageButton", {
		Name = "CloseButton",
		Parent = Header,
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -40, 0, 8),
		Size = UDim2.new(0, 28, 0, 28),
		Image = Icons.X,
		ImageColor3 = Theme.Error,
		AutoButtonColor = false
	})
	
	local ModalOverlay = Create("Frame", {
		Name = "ModalOverlay",
		Parent = ScreenGui,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 100,
		Visible = false
	})
	
	local ConfirmModal = Create("Frame", {
		Name = "ConfirmModal",
		Parent = ModalOverlay,
		BackgroundColor3 = Theme.Background,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, -160, 0.5, -80),
		Size = UDim2.new(0, 320, 0, 160),
		ZIndex = 101,
		BackgroundTransparency = 1
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 12),
		Parent = ConfirmModal
	})
	
	Create("UIStroke", {
		Color = Theme.Separator,
		Thickness = 1,
		Parent = ConfirmModal
	})
	
	local ModalIcon = Create("ImageLabel", {
		Name = "Icon",
		Parent = ConfirmModal,
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, -20, 0, 15),
		Size = UDim2.new(0, 40, 0, 40),
		Image = Icons.AlertCircle,
		ImageColor3 = Theme.Warning,
		ZIndex = 102
	})
	
	local ModalTitle = Create("TextLabel", {
		Name = "Title",
		Parent = ConfirmModal,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 60),
		Size = UDim2.new(1, 0, 0, 22),
		Font = Enum.Font.GothamBold,
		Text = "Close UI?",
		TextColor3 = Theme.Text,
		TextSize = 16,
		ZIndex = 102
	})
	
	local ModalText = Create("TextLabel", {
		Name = "Text",
		Parent = ConfirmModal,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 20, 0, 85),
		Size = UDim2.new(1, -40, 0, 30),
		Font = Enum.Font.Gotham,
		Text = "Are you sure you want to close the UI?",
		TextColor3 = Theme.TextDark,
		TextSize = 12,
		TextWrapped = true,
		ZIndex = 102
	})
	
	local ConfirmButton = Create("TextButton", {
		Name = "Confirm",
		Parent = ConfirmModal,
		BackgroundColor3 = Theme.Error,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 25, 1, -50),
		Size = UDim2.new(0.5, -35, 0, 32),
		Font = Enum.Font.GothamBold,
		Text = "Confirm",
		TextColor3 = Theme.Text,
		TextSize = 13,
		ZIndex = 102
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = ConfirmButton
	})
	
	local DeclineButton = Create("TextButton", {
		Name = "Decline",
		Parent = ConfirmModal,
		BackgroundColor3 = Theme.Button,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 10, 1, -50),
		Size = UDim2.new(0.5, -35, 0, 32),
		Font = Enum.Font.GothamBold,
		Text = "Decline",
		TextColor3 = Theme.Text,
		TextSize = 13,
		ZIndex = 102
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = DeclineButton
	})
	
	local DraggableIcon = Create("Frame", {
		Name = "DraggableIcon",
		Parent = ScreenGui,
		BackgroundColor3 = Theme.Background,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 55, 0, 55),
		Position = UDim2.new(0.5, -27, 0.9, 0),
		Visible = false,
		ZIndex = 50
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = DraggableIcon
	})
	
	local IconShadow = Create("ImageLabel", {
		Name = "Shadow",
		Parent = DraggableIcon,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, -8, 0, -8),
		Size = UDim2.new(1, 16, 1, 16),
		ZIndex = 49,
		Image = "rbxassetid://6015897843",
		ImageColor3 = Color3.fromRGB(0, 0, 0),
		ImageTransparency = 0.5,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450)
	})
	
	local IconImage = Create("ImageLabel", {
		Name = "IconImage",
		Parent = DraggableIcon,
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, -12, 0.5, -12),
		Size = UDim2.new(0, 24, 0, 24),
		Image = Icons.Zap,
		ImageColor3 = accentColor,
		ZIndex = 51
	})
	
	local IconStroke = Create("UIStroke", {
		Color = accentColor,
		Thickness = 2.5,
		Parent = DraggableIcon
	})
	
	local ContentFrame = Create("Frame", {
		Name = "Content",
		Parent = MainFrame,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 65),
		Size = UDim2.new(1, 0, 1, -65)
	})
	
	local TabContainer = Create("Frame", {
		Name = "TabContainer",
		Parent = ContentFrame,
		BackgroundColor3 = Theme.TabBackground,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 130, 1, 0)
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 0),
		Parent = TabContainer
	})
	
	local TabList = Create("ScrollingFrame", {
		Name = "TabList",
		Parent = TabContainer,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 8, 0, 8),
		Size = UDim2.new(1, -16, 1, -80),
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = Theme.Separator,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y
	})
	
	Create("UIListLayout", {
		Parent = TabList,
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	
	local TabContent = Create("Frame", {
		Name = "TabContent",
		Parent = ContentFrame,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 130, 0, 0),
		Size = UDim2.new(1, -130, 1, 0)
	})
	
	local ProfileSection = Create("Frame", {
		Name = "ProfileSection",
		Parent = TabContainer,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 8, 1, -65),
		Size = UDim2.new(1, -16, 0, 55)
	})
	
	local ProfileSeparator = Create("Frame", {
		Name = "Separator",
		Parent = ProfileSection,
		BackgroundColor3 = Theme.Separator,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 0, 1)
	})
	
	local AvatarImage = Create("ImageLabel", {
		Name = "Avatar",
		Parent = ProfileSection,
		BackgroundColor3 = Theme.Button,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 5, 0, 12),
		Size = UDim2.new(0, 32, 0, 32),
		Image = ""
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = AvatarImage
	})
	
	local UsernameLabel = Create("TextLabel", {
		Name = "Username",
		Parent = ProfileSection,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 45, 0, 14),
		Size = UDim2.new(1, -50, 0, 28),
		Font = Enum.Font.GothamBold,
		Text = LocalPlayer.Name,
		TextColor3 = Theme.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd
	})
	
	MakeDraggable(MainFrame, Header)
	MakeDraggable(DraggableIcon, DraggableIcon)
	
	local userId = LocalPlayer.UserId
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size48x48
	local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
	AvatarImage.Image = content
	
	local function UpdatePing()
		while true do
			local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
			PingLabel.Text = ping .. " ms"
			
			if ping < 100 then
				PingIcon.ImageColor3 = Theme.Success
			elseif ping < 200 then
				PingIcon.ImageColor3 = Theme.Warning
			else
				PingIcon.ImageColor3 = Theme.Error
			end
			
			task.wait(1)
		end
	end
	task.spawn(UpdatePing)
	
	HideButton.MouseEnter:Connect(function()
		Tween(HideButton, {ImageColor3 = Theme.Text}, 0.2)
	end)
	
	HideButton.MouseLeave:Connect(function()
		Tween(HideButton, {ImageColor3 = Theme.TextDark}, 0.2)
	end)
	
	CloseButton.MouseEnter:Connect(function()
		Tween(CloseButton, {ImageColor3 = Color3.fromRGB(255, 120, 120)}, 0.2)
	end)
	
	CloseButton.MouseLeave:Connect(function()
		Tween(CloseButton, {ImageColor3 = Theme.Error}, 0.2)
	end)
	
	local function OpenModal()
		ModalOverlay.Visible = true
		Tween(ModalOverlay, {BackgroundTransparency = 0.6}, 0.2)
		ConfirmModal.Position = UDim2.new(0.5, -160, 0.5, -60)
		ConfirmModal.BackgroundTransparency = 1
		ModalIcon.ImageTransparency = 1
		ModalTitle.TextTransparency = 1
		ModalText.TextTransparency = 1
		ConfirmButton.BackgroundTransparency = 1
		ConfirmButton.TextTransparency = 1
		DeclineButton.BackgroundTransparency = 1
		DeclineButton.TextTransparency = 1
		
		Tween(ConfirmModal, {Position = UDim2.new(0.5, -160, 0.5, -80), BackgroundTransparency = 0}, 0.3)
		task.wait(0.1)
		Tween(ModalIcon, {ImageTransparency = 0}, 0.2)
		task.wait(0.05)
		Tween(ModalTitle, {TextTransparency = 0}, 0.2)
		Tween(ModalText, {TextTransparency = 0}, 0.2)
		task.wait(0.05)
		Tween(ConfirmButton, {BackgroundTransparency = 0, TextTransparency = 0}, 0.2)
		Tween(DeclineButton, {BackgroundTransparency = 0, TextTransparency = 0}, 0.2)
	end
	
	local function CloseModal()
		Tween(ModalOverlay, {BackgroundTransparency = 1}, 0.2)
		Tween(ConfirmModal, {Position = UDim2.new(0.5, -160, 0.5, -60), BackgroundTransparency = 1}, 0.2)
		Tween(ModalIcon, {ImageTransparency = 1}, 0.2)
		Tween(ModalTitle, {TextTransparency = 1}, 0.2)
		Tween(ModalText, {TextTransparency = 1}, 0.2)
		Tween(ConfirmButton, {BackgroundTransparency = 1, TextTransparency = 1}, 0.2)
		Tween(DeclineButton, {BackgroundTransparency = 1, TextTransparency = 1}, 0.2)
		
		task.wait(0.2)
		ModalOverlay.Visible = false
	end
	
	ConfirmButton.MouseEnter:Connect(function()
		Tween(ConfirmButton, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
	end)
	
	ConfirmButton.MouseLeave:Connect(function()
		Tween(ConfirmButton, {BackgroundColor3 = Theme.Error}, 0.2)
	end)
	
	DeclineButton.MouseEnter:Connect(function()
		Tween(DeclineButton, {BackgroundColor3 = Theme.ButtonHover}, 0.2)
	end)
	
	DeclineButton.MouseLeave:Connect(function()
		Tween(DeclineButton, {BackgroundColor3 = Theme.Button}, 0.2)
	end)
	
	ConfirmButton.MouseButton1Click:Connect(function()
		Tween(ConfirmButton, {Size = UDim2.new(0.5, -37, 0, 30)}, 0.05).Completed:Connect(function()
			Tween(ConfirmButton, {Size = UDim2.new(0.5, -35, 0, 32)}, 0.05)
		end)
		CloseModal()
		task.wait(0.2)
		ScreenGui:Destroy()
	end)
	
	DeclineButton.MouseButton1Click:Connect(function()
		Tween(DeclineButton, {Size = UDim2.new(0.5, -37, 0, 30)}, 0.05).Completed:Connect(function()
			Tween(DeclineButton, {Size = UDim2.new(0.5, -35, 0, 32)}, 0.05)
		end)
		CloseModal()
	end)
	
	CloseButton.MouseButton1Click:Connect(function()
		Tween(CloseButton, {Size = UDim2.new(0, 26, 0, 26), Position = UDim2.new(1, -39, 0, 9)}, 0.05).Completed:Connect(function()
			Tween(CloseButton, {Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(1, -40, 0, 8)}, 0.05)
		end)
		OpenModal()
	end)
	
	local function ToggleUI()
		isOpen = not isOpen
		
		if isOpen then
			DraggableIcon.Visible = false
			MainFrame.Visible = true
			MainFrame.Size = UDim2.new(0, size.X * 0.92, 0, size.Y * 0.92)
			MainFrame.BackgroundTransparency = 1
			Tween(MainFrame, {Size = UDim2.new(0, size.X, 0, size.Y), BackgroundTransparency = 0}, 0.35, Enum.EasingStyle.Back)
			
			if savedPosition then
				MainFrame.Position = savedPosition
			end
		else
			savedPosition = MainFrame.Position
			Tween(MainFrame, {Size = UDim2.new(0, size.X * 0.92, 0, size.Y * 0.92), BackgroundTransparency = 1}, 0.3).Completed:Connect(function()
				MainFrame.Visible = false
				DraggableIcon.Visible = true
				DraggableIcon.BackgroundTransparency = 1
				IconImage.ImageTransparency = 1
				Tween(DraggableIcon, {BackgroundTransparency = 0}, 0.25)
				Tween(IconImage, {ImageTransparency = 0}, 0.25)
			end)
		end
	end
	
	HideButton.MouseButton1Click:Connect(function()
		Tween(HideButton, {Size = UDim2.new(0, 26, 0, 26), Position = UDim2.new(1, -69, 0, 9)}, 0.05).Completed:Connect(function()
			Tween(HideButton, {Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(1, -70, 0, 8)}, 0.05)
		end)
		ToggleUI()
	end)
	
	DraggableIcon.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if not isOpen then
				ToggleUI()
			end
		end
	end)
	
	DraggableIcon.MouseEnter:Connect(function()
		Tween(DraggableIcon, {Size = UDim2.new(0, 60, 0, 60)}, 0.2)
		Tween(IconStroke, {Thickness = 3.5}, 0.2)
	end)
	
	DraggableIcon.MouseLeave:Connect(function()
		Tween(DraggableIcon, {Size = UDim2.new(0, 55, 0, 55)}, 0.2)
		Tween(IconStroke, {Thickness = 2.5}, 0.2)
	end)
	
	local WindowAPI = {}
	
	function WindowAPI:CreateTab(tabName, tabIcon)
		local TabButton = Create("TextButton", {
			Name = tabName .. "Tab",
			Parent = TabList,
			BackgroundColor3 = Theme.TabBackground,
			BorderSizePixel = 0,
			Size = UDim2.new(1, -5, 0, 36),
			Font = Enum.Font.GothamMedium,
			Text = "",
			AutoButtonColor = false
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 8),
			Parent = TabButton
		})
		
		local TabIconImage = Create("ImageLabel", {
			Name = "Icon",
			Parent = TabButton,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 10, 0.5, -8),
			Size = UDim2.new(0, 16, 0, 16),
			Image = tabIcon or Icons.Circle,
			ImageColor3 = Theme.TabInactive
		})
		
		local TabText = Create("TextLabel", {
			Name = "Text",
			Parent = TabButton,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 32, 0, 0),
			Size = UDim2.new(1, -40, 1, 0),
			Font = Enum.Font.GothamMedium,
			Text = tabName,
			TextColor3 = Theme.TabInactive,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left
		})
		
		local ActiveIndicator = Create("Frame", {
			Name = "Indicator",
			Parent = TabButton,
			BackgroundColor3 = accentColor,
			BorderSizePixel = 0,
			Position = UDim2.new(0, -3, 0.5, -10),
			Size = UDim2.new(0, 3, 0, 20),
			Visible = false
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 2),
			Parent = ActiveIndicator
		})
		
		local TabFrame = Create("ScrollingFrame", {
			Name = tabName .. "Content",
			Parent = TabContent,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = Theme.Separator,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			Visible = false
		})
		
		local ContentPadding = Create("UIPadding", {
			Parent = TabFrame,
			PaddingLeft = UDim.new(0, 18),
			PaddingRight = UDim.new(0, 18),
			PaddingTop = UDim.new(0, 18),
			PaddingBottom = UDim.new(0, 18)
		})
		
		local ContentList = Create("UIListLayout", {
			Parent = TabFrame,
			Padding = UDim.new(0, 0),
			SortOrder = Enum.SortOrder.LayoutOrder
		})
		
		local tab = {
			Button = TabButton,
			Frame = TabFrame,
			Name = tabName
		}
		
		table.insert(tabs, tab)
		
		local function SelectTab()
			if currentTab then
				currentTab.Frame.Visible = false
				Tween(currentTab.Button, {BackgroundColor3 = Theme.TabBackground}, 0.2)
				currentTab.Button.Icon.ImageColor3 = Theme.TabInactive
				currentTab.Button.Text.TextColor3 = Theme.TabInactive
				currentTab.Button.Indicator.Visible = false
			end
			
			currentTab = tab
			TabFrame.Visible = true
			Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(40, 40, 48)}, 0.2)
			TabIconImage.ImageColor3 = Theme.TabActive
			TabText.TextColor3 = Theme.TabActive
			ActiveIndicator.Visible = true
		end
		
		TabButton.MouseButton1Click:Connect(function()
			Tween(TabButton, {Size = UDim2.new(1, -8, 0, 34)}, 0.05).Completed:Connect(function()
				Tween(TabButton, {Size = UDim2.new(1, -5, 0, 36)}, 0.05)
			end)
			SelectTab()
		end)
		
		TabButton.MouseEnter:Connect(function()
			if currentTab ~= tab then
				Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}, 0.2)
			end
		end)
		
		TabButton.MouseLeave:Connect(function()
			if currentTab ~= tab then
				Tween(TabButton, {BackgroundColor3 = Theme.TabBackground}, 0.2)
			end
		end)
		
		if #tabs == 1 then
			SelectTab()
		end
		
		local TabAPI = {}
		
		local function AddSeparator()
			local Separator = Create("Frame", {
				Parent = TabFrame,
				BackgroundColor3 = Theme.Separator,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 1),
				LayoutOrder = #TabFrame:GetChildren()
			})
			return Separator
		end
		
		function TabAPI:AddSection(sectionName, sectionIcon)
			AddSeparator()
			
			local SectionFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 38),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local SectionIcon = Create("ImageLabel", {
				Name = "Icon",
				Parent = SectionFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 5, 0, 10),
				Size = UDim2.new(0, 14, 0, 14),
				Image = sectionIcon or Icons.Zap,
				ImageColor3 = accentColor
			})
			
			local SectionLabel = Create("TextLabel", {
				Name = "SectionLabel",
				Parent = SectionFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 24, 0, 9),
				Size = UDim2.new(1, -30, 0, 20),
				Font = Enum.Font.GothamBold,
				Text = sectionName,
				TextColor3 = accentColor,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			return SectionFrame
		end
		
		function TabAPI:AddLabel(text, labelIcon)
			AddSeparator()
			
			local LabelFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 32),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			if labelIcon then
				local Icon = Create("ImageLabel", {
					Name = "Icon",
					Parent = LabelFrame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0.5, -7),
					Size = UDim2.new(0, 14, 0, 14),
					Image = labelIcon,
					ImageColor3 = Theme.TextDark
				})
			end
			
			local Label = Create("TextLabel", {
				Name = "Label",
				Parent = LabelFrame,
				BackgroundTransparency = 1,
				Position = labelIcon and UDim2.new(0, 28, 0, 7) or UDim2.new(0, 8, 0, 7),
				Size = labelIcon and UDim2.new(1, -36, 0, 18) or UDim2.new(1, -16, 0, 18),
				Font = Enum.Font.Gotham,
				Text = text,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextWrapped = true
			})
			
			local LabelAPI = {}
			
			function LabelAPI:SetText(newText)
				Label.Text = newText
			end
			
			function LabelAPI:GetText()
				return Label.Text
			end
			
			return LabelAPI
		end
		
		function TabAPI:AddParagraph(text, paragraphIcon)
			AddSeparator()
			
			local ParagraphFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 70),
				LayoutOrder = #TabFrame:GetChildren(),
				ClipsDescendants = true
			})
			
			if paragraphIcon then
				local Icon = Create("ImageLabel", {
					Name = "Icon",
					Parent = ParagraphFrame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 8),
					Size = UDim2.new(0, 14, 0, 14),
					Image = paragraphIcon,
					ImageColor3 = Theme.TextDark
				})
			end
			
			local ParagraphBox = Create("TextBox", {
				Name = "Paragraph",
				Parent = ParagraphFrame,
				BackgroundTransparency = 1,
				Position = paragraphIcon and UDim2.new(0, 28, 0, 5) or UDim2.new(0, 8, 0, 5),
				Size = paragraphIcon and UDim2.new(1, -36, 1, -10) or UDim2.new(1, -16, 1, -10),
				Font = Enum.Font.Gotham,
				Text = text,
				TextColor3 = Theme.TextDark,
				TextSize = 11,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				TextWrapped = true,
				ClearTextOnFocus = false,
				MultiLine = true,
				TextEditable = false
			})
			
			local ParagraphAPI = {}
			
			function ParagraphAPI:SetText(newText)
				ParagraphBox.Text = newText
			end
			
			function ParagraphAPI:GetText()
				return ParagraphBox.Text
			end
			
			return ParagraphAPI
		end
		
		function TabAPI:AddButton(config)
			config = config or {}
			local buttonText = config.text or "Button"
			local buttonIcon = config.icon or Icons.MousePointer
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local ButtonFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 45),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local Button = Create("TextButton", {
				Name = "Button",
				Parent = ButtonFrame,
				BackgroundColor3 = Theme.Button,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 6),
				Size = UDim2.new(1, 0, 0, 34),
				Font = Enum.Font.GothamBold,
				Text = "",
				AutoButtonColor = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 8),
				Parent = Button
			})
			
			local ButtonIcon = Create("ImageLabel", {
				Name = "Icon",
				Parent = Button,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 12, 0.5, -8),
				Size = UDim2.new(0, 16, 0, 16),
				Image = buttonIcon,
				ImageColor3 = accentColor
			})
			
			local ButtonText = Create("TextLabel", {
				Name = "Text",
				Parent = Button,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 36, 0, 0),
				Size = UDim2.new(1, -48, 1, 0),
				Font = Enum.Font.GothamBold,
				Text = buttonText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			local Arrow = Create("ImageLabel", {
				Name = "Arrow",
				Parent = Button,
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -26, 0.5, -6),
				Size = UDim2.new(0, 12, 0, 12),
				Image = Icons.ChevronRight,
				ImageColor3 = Theme.TextDark
			})
			
			Button.MouseEnter:Connect(function()
				Tween(Button, {BackgroundColor3 = Theme.ButtonHover}, 0.2)
				Tween(Arrow, {Position = UDim2.new(1, -22, 0.5, -6)}, 0.2)
			end)
			
			Button.MouseLeave:Connect(function()
				Tween(Button, {BackgroundColor3 = Theme.Button}, 0.2)
				Tween(Arrow, {Position = UDim2.new(1, -26, 0.5, -6)}, 0.2)
			end)
			
			Button.MouseButton1Down:Connect(function()
				Tween(Button, {Size = UDim2.new(1, -4, 0, 32), Position = UDim2.new(0, 2, 0, 7)}, 0.05)
				Tween(ButtonIcon, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, 0.05)
			end)
			
			Button.MouseButton1Up:Connect(function()
				Tween(Button, {Size = UDim2.new(1, 0, 0, 34), Position = UDim2.new(0, 0, 0, 6)}, 0.05)
				Tween(ButtonIcon, {ImageColor3 = accentColor}, 0.05)
			end)
			
			Button.MouseButton1Click:Connect(function()
				callback()
			end)
			
			local ButtonAPI = {}
			
			function ButtonAPI:SetText(newText)
				ButtonText.Text = newText
			end
			
			function ButtonAPI:SetIcon(newIcon)
				ButtonIcon.Image = newIcon
			end
			
			function ButtonAPI:Fire()
				callback()
			end
			
			return ButtonAPI
		end
		
		function TabAPI:AddToggle(config)
			config = config or {}
			local toggleText = config.text or "Toggle"
			local toggleIcon = config.icon
			local default = config.default or false
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local ToggleFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 45),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local ToggleLabel = Create("TextLabel", {
				Name = "Label",
				Parent = ToggleFrame,
				BackgroundTransparency = 1,
				Position = toggleIcon and UDim2.new(0, 28, 0, 13) or UDim2.new(0, 8, 0, 13),
				Size = toggleIcon and UDim2.new(1, -100, 0, 20) or UDim2.new(1, -80, 0, 20),
				Font = Enum.Font.Gotham,
				Text = toggleText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			if toggleIcon then
				local Icon = Create("ImageLabel", {
					Name = "Icon",
					Parent = ToggleFrame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0.5, -7),
					Size = UDim2.new(0, 14, 0, 14),
					Image = toggleIcon,
					ImageColor3 = Theme.TextDark
				})
			end
			
			local ToggleBackground = Create("Frame", {
				Name = "Background",
				Parent = ToggleFrame,
				BackgroundColor3 = default and Theme.ToggleOn or Theme.ToggleOff,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -55, 0, 10),
				Size = UDim2.new(0, 50, 0, 26)
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(1, 0),
				Parent = ToggleBackground
			})
			
			local ToggleCircle = Create("Frame", {
				Name = "Circle",
				Parent = ToggleBackground,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = default and UDim2.new(1, -24, 0, 2) or UDim2.new(0, 2, 0, 2),
				Size = UDim2.new(0, 22, 0, 22)
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(1, 0),
				Parent = ToggleCircle
			})
			
			local CheckIcon = Create("ImageLabel", {
				Name = "Check",
				Parent = ToggleCircle,
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, -5, 0.5, -5),
				Size = UDim2.new(0, 10, 0, 10),
				Image = Icons.Check,
				ImageColor3 = Theme.ToggleOn,
				ImageTransparency = default and 0 or 1
			})
			
			local enabled = default
			
			local function Toggle()
				enabled = not enabled
				
				Tween(ToggleBackground, {BackgroundColor3 = enabled and Theme.ToggleOn or Theme.ToggleOff}, 0.25, Enum.EasingStyle.Quad)
				Tween(ToggleCircle, {Position = enabled and UDim2.new(1, -24, 0, 2) or UDim2.new(0, 2, 0, 2)}, 0.25, Enum.EasingStyle.Back)
				Tween(CheckIcon, {ImageTransparency = enabled and 0 or 1}, 0.2)
				
				callback(enabled)
			end
			
			ToggleBackground.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					Toggle()
				end
			end)
			
			callback(enabled)
			
			local ToggleAPI = {}
			
			function ToggleAPI:SetState(state)
				if enabled ~= state then
					Toggle()
				end
			end
			
			function ToggleAPI:GetState()
				return enabled
			end
			
			function ToggleAPI:Toggle()
				Toggle()
			end
			
			return ToggleAPI
		end
		
		function TabAPI:AddSlider(config)
			config = config or {}
			local sliderText = config.text or "Slider"
			local sliderIcon = config.icon
			local min = config.min or 0
			local max = config.max or 100
			local default = config.default or min
			local suffix = config.suffix or ""
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local SliderFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 60),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local SliderLabel = Create("TextLabel", {
				Name = "Label",
				Parent = SliderFrame,
				BackgroundTransparency = 1,
				Position = sliderIcon and UDim2.new(0, 28, 0, 5) or UDim2.new(0, 8, 0, 5),
				Size = sliderIcon and UDim2.new(1, -90, 0, 18) or UDim2.new(1, -70, 0, 18),
				Font = Enum.Font.Gotham,
				Text = sliderText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			if sliderIcon then
				local Icon = Create("ImageLabel", {
					Name = "Icon",
					Parent = SliderFrame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 4),
					Size = UDim2.new(0, 14, 0, 14),
					Image = sliderIcon,
					ImageColor3 = Theme.TextDark
				})
			end
			
			local ValueContainer = Create("Frame", {
				Name = "ValueContainer",
				Parent = SliderFrame,
				BackgroundColor3 = Theme.InputBackground,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -65, 0, 2),
				Size = UDim2.new(0, 60, 0, 24)
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = ValueContainer
			})
			
			local ValueLabel = Create("TextLabel", {
				Name = "Value",
				Parent = ValueContainer,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Font = Enum.Font.GothamBold,
				Text = tostring(default) .. suffix,
				TextColor3 = accentColor,
				TextSize = 11
			})
			
			local SliderBackground = Create("Frame", {
				Name = "Background",
				Parent = SliderFrame,
				BackgroundColor3 = Theme.Separator,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 8, 0, 35),
				Size = UDim2.new(1, -16, 0, 8)
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(1, 0),
				Parent = SliderBackground
			})
			
			local SliderFill = Create("Frame", {
				Name = "Fill",
				Parent = SliderBackground,
				BackgroundColor3 = accentColor,
				BorderSizePixel = 0,
				Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(1, 0),
				Parent = SliderFill
			})
			
			local SliderHandle = Create("Frame", {
				Name = "Handle",
				Parent = SliderBackground,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new((default - min) / (max - min), -9, 0.5, -9),
				Size = UDim2.new(0, 18, 0, 18),
				ZIndex = 2
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(1, 0),
				Parent = SliderHandle
			})
			
			Create("UIStroke", {
				Color = accentColor,
				Thickness = 2,
				Parent = SliderHandle
			})
			
			local dragging = false
			
			local function UpdateSlider(input)
				local pos = math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1)
				local value = math.floor(min + (max - min) * pos)
				
				SliderFill.Size = UDim2.new(pos, 0, 1, 0)
				SliderHandle.Position = UDim2.new(pos, -9, 0.5, -9)
				ValueLabel.Text = tostring(value) .. suffix
				
				callback(value)
			end
			
			SliderHandle.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					Tween(SliderHandle, {Size = UDim2.new(0, 22, 0, 22)}, 0.1)
				end
			end)
			
			SliderBackground.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					UpdateSlider(input)
					dragging = true
				end
			end)
			
			UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					UpdateSlider(input)
				end
			end)
			
			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					if dragging then
						Tween(SliderHandle, {Size = UDim2.new(0, 18, 0, 18)}, 0.1)
					end
					dragging = false
				end
			end)
			
			callback(default)
			
			local SliderAPI = {}
			
			function SliderAPI:SetValue(value)
				value = math.clamp(value, min, max)
				local pos = (value - min) / (max - min)
				SliderFill.Size = UDim2.new(pos, 0, 1, 0)
				SliderHandle.Position = UDim2.new(pos, -9, 0.5, -9)
				ValueLabel.Text = tostring(value) .. suffix
				callback(value)
			end
			
			function SliderAPI:GetValue()
				return tonumber(ValueLabel.Text:gsub(suffix, ""))
			end
			
			return SliderAPI
		end
		
		function TabAPI:AddDropdown(config)
			config = config or {}
			local dropdownText = config.text or "Dropdown"
			local dropdownIcon = config.icon
			local options = config.options or {}
			local default = config.default
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local DropdownFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 42),
				LayoutOrder = #TabFrame:GetChildren(),
				ClipsDescendants = true
			})
			
			local DropdownLabel = Create("TextLabel", {
				Name = "Label",
				Parent = DropdownFrame,
				BackgroundTransparency = 1,
				Position = dropdownIcon and UDim2.new(0, 28, 0, 5) or UDim2.new(0, 8, 0, 5),
				Size = dropdownIcon and UDim2.new(1, -20, 0, 16) or UDim2.new(1, -10, 0, 16),
				Font = Enum.Font.Gotham,
				Text = dropdownText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			if dropdownIcon then
				local Icon = Create("ImageLabel", {
					Name = "Icon",
					Parent = DropdownFrame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 4),
					Size = UDim2.new(0, 14, 0, 14),
					Image = dropdownIcon,
					ImageColor3 = Theme.TextDark
				})
			end
			
			local DropdownButton = Create("TextButton", {
				Name = "DropdownButton",
				Parent = DropdownFrame,
				BackgroundColor3 = Theme.Button,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 26),
				Size = UDim2.new(1, 0, 0, 32),
				Font = Enum.Font.Gotham,
				Text = default or "Select option...",
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextTruncate = Enum.TextTruncate.AtEnd,
				AutoButtonColor = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 8),
				Parent = DropdownButton
			})
			
			local ArrowIcon = Create("ImageLabel", {
				Name = "Arrow",
				Parent = DropdownButton,
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -28, 0.5, -7),
				Size = UDim2.new(0, 14, 0, 14),
				Image = Icons.ChevronDown,
				ImageColor3 = Theme.TextDark
			})
			
			local OptionsFrame = Create("Frame", {
				Name = "Options",
				Parent = DropdownFrame,
				BackgroundColor3 = Theme.Button,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 62),
				Size = UDim2.new(1, 0, 0, 0),
				ClipsDescendants = true,
				Visible = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 8),
				Parent = OptionsFrame
			})
			
			local OptionsList = Create("UIListLayout", {
				Parent = OptionsFrame,
				Padding = UDim.new(0, 2),
				SortOrder = Enum.SortOrder.LayoutOrder
			})
			
			local expanded = false
			local selectedOption = default
			
			local function CreateOption(optionText)
				local OptionButton = Create("TextButton", {
					Name = optionText,
					Parent = OptionsFrame,
					BackgroundColor3 = Theme.Button,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 30),
					Font = Enum.Font.Gotham,
					Text = optionText,
					TextColor3 = optionText == selectedOption and accentColor or Theme.Text,
					TextSize = 11,
					AutoButtonColor = false
				})
				
				local CheckMark = Create("ImageLabel", {
					Name = "Check",
					Parent = OptionButton,
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -26, 0.5, -6),
					Size = UDim2.new(0, 12, 0, 12),
					Image = Icons.Check,
					ImageColor3 = accentColor,
					ImageTransparency = optionText == selectedOption and 0 or 1
				})
				
				OptionButton.MouseEnter:Connect(function()
					Tween(OptionButton, {BackgroundColor3 = Theme.ButtonHover}, 0.15)
				end)
				
				OptionButton.MouseLeave:Connect(function()
					Tween(OptionButton, {BackgroundColor3 = Theme.Button}, 0.15)
				end)
				
				OptionButton.MouseButton1Click:Connect(function()
					selectedOption = optionText
					DropdownButton.Text = optionText
					
					for _, child in pairs(OptionsFrame:GetChildren()) do
						if child:IsA("TextButton") then
							child.TextColor3 = child.Name == optionText and accentColor or Theme.Text
							child.Check.ImageTransparency = child.Name == optionText and 0 or 1
						end
					end
					
					expanded = false
					Tween(OptionsFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
					Tween(ArrowIcon, {Rotation = 0}, 0.2)
					task.wait(0.2)
					OptionsFrame.Visible = false
					DropdownFrame.Size = UDim2.new(1, 0, 0, 42)
					
					callback(optionText)
				end)
			end
			
			for _, option in ipairs(options) do
				CreateOption(option)
			end
			
			DropdownButton.MouseButton1Click:Connect(function()
				expanded = not expanded
				
				if expanded then
					OptionsFrame.Visible = true
					local optionsHeight = math.min(#options * 32 + 8, 160)
					Tween(OptionsFrame, {Size = UDim2.new(1, 0, 0, optionsHeight)}, 0.25, Enum.EasingStyle.Back)
					Tween(ArrowIcon, {Rotation = 180}, 0.2)
					DropdownFrame.Size = UDim2.new(1, 0, 0, 68 + optionsHeight)
				else
					Tween(OptionsFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
					Tween(ArrowIcon, {Rotation = 0}, 0.2)
					task.wait(0.2)
					OptionsFrame.Visible = false
					DropdownFrame.Size = UDim2.new(1, 0, 0, 42)
				end
			end)
			
			DropdownButton.MouseEnter:Connect(function()
				Tween(DropdownButton, {BackgroundColor3 = Theme.ButtonHover}, 0.2)
			end)
			
			DropdownButton.MouseLeave:Connect(function()
				Tween(DropdownButton, {BackgroundColor3 = Theme.Button}, 0.2)
			end)
			
			local DropdownAPI = {}
			
			function DropdownAPI:SetValue(value)
				if table.find(options, value) then
					selectedOption = value
					DropdownButton.Text = value
					
					for _, child in pairs(OptionsFrame:GetChildren()) do
						if child:IsA("TextButton") then
							child.TextColor3 = child.Name == value and accentColor or Theme.Text
							child.Check.ImageTransparency = child.Name == value and 0 or 1
						end
					end
					
					callback(value)
				end
			end
			
			function DropdownAPI:GetValue()
				return selectedOption
			end
			
			function DropdownAPI:Refresh(newOptions, keepSelected)
				options = newOptions
				
				for _, child in pairs(OptionsFrame:GetChildren()) do
					if child:IsA("TextButton") then
						child:Destroy()
					end
				end
				
				for _, option in ipairs(options) do
					CreateOption(option)
				end
				
				if not keepSelected or not table.find(options, selectedOption) then
					selectedOption = nil
					DropdownButton.Text = "Select option..."
				end
			end
			
			return DropdownAPI
		end
		
		function TabAPI:AddInput(config)
			config = config or {}
			local inputText = config.text or "Input"
			local inputIcon = config.icon
			local placeholder = config.placeholder or "Type here..."
			local default = config.default or ""
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local InputFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 70),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local InputLabel = Create("TextLabel", {
				Name = "Label",
				Parent = InputFrame,
				BackgroundTransparency = 1,
				Position = inputIcon and UDim2.new(0, 28, 0, 5) or UDim2.new(0, 8, 0, 5),
				Size = inputIcon and UDim2.new(1, -20, 0, 16) or UDim2.new(1, -10, 0, 16),
				Font = Enum.Font.Gotham,
				Text = inputText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			if inputIcon then
				local Icon = Create("ImageLabel", {
					Name = "Icon",
					Parent = InputFrame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 4),
					Size = UDim2.new(0, 14, 0, 14),
					Image = inputIcon,
					ImageColor3 = Theme.TextDark
				})
			end
			
			local InputBox = Create("TextBox", {
				Name = "InputBox",
				Parent = InputFrame,
				BackgroundColor3 = Theme.InputBackground,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 26),
				Size = UDim2.new(1, 0, 0, 36),
				Font = Enum.Font.Code,
				Text = default,
				PlaceholderText = placeholder,
				TextColor3 = Theme.Text,
				PlaceholderColor3 = Theme.TextDark,
				TextSize = 12,
				ClearTextOnFocus = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 8),
				Parent = InputBox
			})
			
			Create("UIPadding", {
				Parent = InputBox,
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12)
			})
			
			local Cursor = Create("Frame", {
				Name = "Cursor",
				Parent = InputBox,
				BackgroundColor3 = accentColor,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0.25, 0),
				Size = UDim2.new(0, 2, 0.5, 0),
				Visible = false
			})
			
			local cursorBlinking = false
			
			local function BlinkCursor()
				while cursorBlinking do
					Cursor.Visible = not Cursor.Visible
					task.wait(0.5)
				end
				Cursor.Visible = false
			end
			
			InputBox.Focused:Connect(function()
				Tween(InputBox, {BackgroundColor3 = Color3.fromRGB(28, 28, 32)}, 0.2)
				cursorBlinking = true
				task.spawn(BlinkCursor)
			end)
			
			InputBox.FocusLost:Connect(function(enterPressed)
				Tween(InputBox, {BackgroundColor3 = Theme.InputBackground}, 0.2)
				cursorBlinking = false
				callback(InputBox.Text, enterPressed)
			end)
			
			InputBox:GetPropertyChangedSignal("CursorPosition"):Connect(function()
				local textSize = game:GetService("TextService"):GetTextSize(
					InputBox.Text:sub(1, InputBox.CursorPosition - 1),
					InputBox.TextSize,
					InputBox.Font,
					Vector2.new(InputBox.AbsoluteSize.X, 1000)
				)
				Cursor.Position = UDim2.new(0, math.min(textSize.X + 12, InputBox.AbsoluteSize.X - 18), 0.25, 0)
			end)
			
			local InputAPI = {}
			
			function InputAPI:SetText(text)
				InputBox.Text = text
				callback(text, false)
			end
			
			function InputAPI:GetText()
				return InputBox.Text
			end
			
			function InputAPI:Focus()
				InputBox:CaptureFocus()
			end
			
			return InputAPI
		end
		
		function TabAPI:AddKeybind(config)
			config = config or {}
			local keybindText = config.text or "Keybind"
			local keybindIcon = config.icon
			local defaultKey = config.default
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local KeybindFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 45),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local KeybindLabel = Create("TextLabel", {
				Name = "Label",
				Parent = KeybindFrame,
				BackgroundTransparency = 1,
				Position = keybindIcon and UDim2.new(0, 28, 0, 13) or UDim2.new(0, 8, 0, 13),
				Size = keybindIcon and UDim2.new(1, -95, 0, 20) or UDim2.new(1, -75, 0, 20),
				Font = Enum.Font.Gotham,
				Text = keybindText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			if keybindIcon then
				local Icon = Create("ImageLabel", {
					Name = "Icon",
					Parent = KeybindFrame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0.5, -7),
					Size = UDim2.new(0, 14, 0, 14),
					Image = keybindIcon,
					ImageColor3 = Theme.TextDark
				})
			end
			
			local KeybindButton = Create("TextButton", {
				Name = "KeybindButton",
				Parent = KeybindFrame,
				BackgroundColor3 = Theme.Button,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -80, 0, 7),
				Size = UDim2.new(0, 80, 0, 32),
				Font = Enum.Font.GothamBold,
				Text = defaultKey and defaultKey.Name or "None",
				TextColor3 = Theme.Text,
				TextSize = 11,
				AutoButtonColor = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 8),
				Parent = KeybindButton
			})
			
			local KeyIcon = Create("ImageLabel", {
				Name = "KeyIcon",
				Parent = KeybindButton,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 8, 0.5, -6),
				Size = UDim2.new(0, 12, 0, 12),
				Image = Icons.Key,
				ImageColor3 = accentColor
			})
			
			local currentKey = defaultKey
			local listening = false
			
			KeybindButton.MouseButton1Click:Connect(function()
				if listening then return end
				
				listening = true
				KeybindButton.Text = "..."
				KeyIcon.Visible = false
				Tween(KeybindButton, {BackgroundColor3 = accentColor}, 0.2)
				
				local connection
				connection = UserInputService.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode == Enum.KeyCode.Escape then
							currentKey = nil
							KeybindButton.Text = "None"
						else
							currentKey = input.KeyCode
							KeybindButton.Text = ""
							task.wait(0.05)
							KeybindButton.Text = input.KeyCode.Name
						end
						
						listening = false
						KeyIcon.Visible = true
						Tween(KeybindButton, {BackgroundColor3 = Theme.Button}, 0.2)
						connection:Disconnect()
						callback(currentKey)
					end
				end)
			end)
			
			KeybindButton.MouseEnter:Connect(function()
				if not listening then
					Tween(KeybindButton, {BackgroundColor3 = Theme.ButtonHover}, 0.2)
				end
			end)
			
			KeybindButton.MouseLeave:Connect(function()
				if not listening then
					Tween(KeybindButton, {BackgroundColor3 = Theme.Button}, 0.2)
				end
			end)
			
			UserInputService.InputBegan:Connect(function(input)
				if currentKey and input.KeyCode == currentKey and not listening then
					Tween(KeybindButton, {BackgroundColor3 = accentColor}, 0.1).Completed:Connect(function()
						Tween(KeybindButton, {BackgroundColor3 = Theme.Button}, 0.1)
					end)
					callback(currentKey)
				end
			end)
			
			local KeybindAPI = {}
			
			function KeybindAPI:SetKey(key)
				currentKey = key
				KeybindButton.Text = key and key.Name or "None"
			end
			
			function KeybindAPI:GetKey()
				return currentKey
			end
			
			return KeybindAPI
		end
		
		function TabAPI:AddColorPicker(config)
			config = config or {}
			local pickerText = config.text or "Color Picker"
			local pickerIcon = config.icon
			local default = config.default or Color3.fromRGB(255, 255, 255)
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local ColorPickerFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 50),
				LayoutOrder = #TabFrame:GetChildren(),
				ClipsDescendants = true
			})
			
			local ColorPickerLabel = Create("TextLabel", {
				Name = "Label",
				Parent = ColorPickerFrame,
				BackgroundTransparency = 1,
				Position = pickerIcon and UDim2.new(0, 28, 0, 16) or UDim2.new(0, 8, 0, 16),
				Size = pickerIcon and UDim2.new(1, -70, 0, 18) or UDim2.new(1, -50, 0, 18),
				Font = Enum.Font.Gotham,
				Text = pickerText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			if pickerIcon then
				local Icon = Create("ImageLabel", {
					Name = "Icon",
					Parent = ColorPickerFrame,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0.5, -7),
					Size = UDim2.new(0, 14, 0, 14),
					Image = pickerIcon,
					ImageColor3 = Theme.TextDark
				})
			end
			
			local ColorPreview = Create("TextButton", {
				Name = "Preview",
				Parent = ColorPickerFrame,
				BackgroundColor3 = default,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -50, 0, 10),
				Size = UDim2.new(0, 45, 0, 32),
				Text = "",
				AutoButtonColor = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 8),
				Parent = ColorPreview
			})
			
			Create("UIStroke", {
				Color = Theme.Separator,
				Thickness = 1,
				Parent = ColorPreview
			})
			
			local PickerPanel = Create("Frame", {
				Name = "PickerPanel",
				Parent = ColorPickerFrame,
				BackgroundColor3 = Theme.Header,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 50),
				Size = UDim2.new(1, 0, 0, 0),
				ClipsDescendants = true,
				Visible = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 10),
				Parent = PickerPanel
			})
			
			local HueSlider = Create("Frame", {
				Name = "HueSlider",
				Parent = PickerPanel,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 12, 0, 12),
				Size = UDim2.new(1, -24, 0, 110)
			})
			
			local HueGradient = Create("UIGradient", {
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
					ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
					ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
					ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
					ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
				}),
				Parent = HueSlider
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 8),
				Parent = HueSlider
			})
			
			local HueHandle = Create("Frame", {
				Name = "Handle",
				Parent = HueSlider,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new(0, -7, 0, 0),
				Size = UDim2.new(0, 14, 1, 0),
				ZIndex = 2
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 4),
				Parent = HueHandle
			})
			
			Create("UIStroke", {
				Color = Color3.fromRGB(0, 0, 0),
				Thickness = 1,
				Parent = HueHandle
			})
			
			local SaturationSlider = Create("Frame", {
				Name = "SaturationSlider",
				Parent = PickerPanel,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 12, 0, 132),
				Size = UDim2.new(1, -24, 0, 14)
			})
			
			local SatGradient = Create("UIGradient", {
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(128, 128, 128)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
				}),
				Parent = SaturationSlider
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(1, 0),
				Parent = SaturationSlider
			})
			
			local SatHandle = Create("Frame", {
				Name = "Handle",
				Parent = SaturationSlider,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new(0.5, -7, 0, -4),
				Size = UDim2.new(0, 14, 0, 22),
				ZIndex = 2
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 4),
				Parent = SatHandle
			})
			
			Create("UIStroke", {
				Color = Color3.fromRGB(0, 0, 0),
				Thickness = 1,
				Parent = SatHandle
			})
			
			local ValueSlider = Create("Frame", {
				Name = "ValueSlider",
				Parent = PickerPanel,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 12, 0, 156),
				Size = UDim2.new(1, -24, 0, 14)
			})
			
			local ValGradient = Create("UIGradient", {
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
				}),
				Parent = ValueSlider
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(1, 0),
				Parent = ValueSlider
			})
			
			local ValHandle = Create("Frame", {
				Name = "Handle",
				Parent = ValueSlider,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new(1, -7, 0, -4),
				Size = UDim2.new(0, 14, 0, 22),
				ZIndex = 2
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 4),
				Parent = ValHandle
			})
			
			Create("UIStroke", {
				Color = Color3.fromRGB(0, 0, 0),
				Thickness = 1,
				Parent = ValHandle
			})
			
			local RGBLabel = Create("TextLabel", {
				Name = "RGB",
				Parent = PickerPanel,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 12, 0, 180),
				Size = UDim2.new(1, -24, 0, 20),
				Font = Enum.Font.Code,
				Text = "RGB: 255, 255, 255",
				TextColor3 = Theme.TextDark,
				TextSize = 11
			})
			
			local expanded = false
			local hue, sat, val = 0, 1, 1
			
			local function UpdateColor()
				local color = Color3.fromHSV(hue, sat, val)
				ColorPreview.BackgroundColor3 = color
				RGBLabel.Text = string.format("RGB: %d, %d, %d", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
				callback(color)
			end
			
			local function UpdateFromColor(color)
				hue, sat, val = color:ToHSV()
				HueHandle.Position = UDim2.new(hue, -7, 0, 0)
				SatHandle.Position = UDim2.new(sat, -7, 0, -4)
				ValHandle.Position = UDim2.new(val, -7, 0, -4)
				ColorPreview.BackgroundColor3 = color
				RGBLabel.Text = string.format("RGB: %d, %d, %d", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
			end
			
			local hueDragging, satDragging, valDragging = false, false, false
			
			HueSlider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					hueDragging = true
					local pos = math.clamp((input.Position.X - HueSlider.AbsolutePosition.X) / HueSlider.AbsoluteSize.X, 0, 1)
					hue = pos
					HueHandle.Position = UDim2.new(pos, -7, 0, 0)
					UpdateColor()
				end
			end)
			
			SaturationSlider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					satDragging = true
					local pos = math.clamp((input.Position.X - SaturationSlider.AbsolutePosition.X) / SaturationSlider.AbsoluteSize.X, 0, 1)
					sat = pos
					SatHandle.Position = UDim2.new(pos, -7, 0, -4)
					UpdateColor()
				end
			end)
			
			ValueSlider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					valDragging = true
					local pos = math.clamp((input.Position.X - ValueSlider.AbsolutePosition.X) / ValueSlider.AbsoluteSize.X, 0, 1)
					val = pos
					ValHandle.Position = UDim2.new(pos, -7, 0, -4)
					UpdateColor()
				end
			end)
			
			UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					if hueDragging then
						local pos = math.clamp((input.Position.X - HueSlider.AbsolutePosition.X) / HueSlider.AbsoluteSize.X, 0, 1)
						hue = pos
						HueHandle.Position = UDim2.new(pos, -7, 0, 0)
						UpdateColor()
					elseif satDragging then
						local pos = math.clamp((input.Position.X - SaturationSlider.AbsolutePosition.X) / SaturationSlider.AbsoluteSize.X, 0, 1)
						sat = pos
						SatHandle.Position = UDim2.new(pos, -7, 0, -4)
						UpdateColor()
					elseif valDragging then
						local pos = math.clamp((input.Position.X - ValueSlider.AbsolutePosition.X) / ValueSlider.AbsoluteSize.X, 0, 1)
						val = pos
						ValHandle.Position = UDim2.new(pos, -7, 0, -4)
						UpdateColor()
					end
				end
			end)
			
			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					hueDragging = false
					satDragging = false
					valDragging = false
				end
			end)
			
			ColorPreview.MouseButton1Click:Connect(function()
				expanded = not expanded
				
				if expanded then
					PickerPanel.Visible = true
					Tween(PickerPanel, {Size = UDim2.new(1, 0, 0, 210)}, 0.25, Enum.EasingStyle.Back)
					ColorPickerFrame.Size = UDim2.new(1, 0, 0, 265)
				else
					Tween(PickerPanel, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
					task.wait(0.2)
					PickerPanel.Visible = false
					ColorPickerFrame.Size = UDim2.new(1, 0, 0, 50)
				end
			end)
			
			UpdateFromColor(default)
			
			local ColorPickerAPI = {}
			
			function ColorPickerAPI:SetColor(color)
				UpdateFromColor(color)
				callback(color)
			end
			
			function ColorPickerAPI:GetColor()
				return ColorPreview.BackgroundColor3
			end
			
			return ColorPickerAPI
		end
		
		function TabAPI:AddImage(config)
			config = config or {}
			local imageId = config.image or ""
			local imageSize = config.size or UDim2.new(1, 0, 0, 120)
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local ImageFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, imageSize.Y.Offset + 15),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local ImageButton = Create("ImageButton", {
				Name = "Image",
				Parent = ImageFrame,
				BackgroundColor3 = Theme.Button,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 8),
				Size = imageSize,
				Image = imageId,
				ScaleType = Enum.ScaleType.Fit,
				AutoButtonColor = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 10),
				Parent = ImageButton
			})
			
			Create("UIStroke", {
				Color = Theme.Separator,
				Thickness = 1,
				Parent = ImageButton
			})
			
			ImageButton.MouseEnter:Connect(function()
				Tween(ImageButton, {BackgroundColor3 = Theme.ButtonHover}, 0.2)
			end)
			
			ImageButton.MouseLeave:Connect(function()
				Tween(ImageButton, {BackgroundColor3 = Theme.Button}, 0.2)
			end)
			
			ImageButton.MouseButton1Click:Connect(function()
				Tween(ImageButton, {Size = UDim2.new(imageSize.X.Scale, imageSize.X.Offset - 6, imageSize.Y.Scale, imageSize.Y.Offset - 6), Position = UDim2.new(0, 3, 0, 11)}, 0.05).Completed:Connect(function()
					Tween(ImageButton, {Size = imageSize, Position = UDim2.new(0, 0, 0, 8)}, 0.05)
				end)
				callback()
			end)
			
			local ImageAPI = {}
			
			function ImageAPI:SetImage(newImageId)
				ImageButton.Image = newImageId
			end
			
			function ImageAPI:GetImage()
				return ImageButton.Image
			end
			
			return ImageAPI
		end
		
		return TabAPI
	end
	
	function WindowAPI:Notify(config)
		config = config or {}
		local notifyTitle = config.title or "Notification"
		local notifyText = config.text or ""
		local notifyType = config.type or "info"
		local duration = config.duration or 3
		local notifyIcon = config.icon
		
		local notifyColor = Theme.Accent
		local notifyIconImage = notifyIcon or Icons.Info
		
		if notifyType == "success" then
			notifyColor = Theme.Success
			notifyIconImage = Icons.CheckCircle
		elseif notifyType == "error" then
			notifyColor = Theme.Error
			notifyIconImage = Icons.X
		elseif notifyType == "warning" then
			notifyColor = Theme.Warning
			notifyIconImage = Icons.AlertTriangle
		end
		
		local NotificationFrame = Create("Frame", {
			Name = "Notification",
			Parent = ScreenGui,
			BackgroundColor3 = Theme.Background,
			BorderSizePixel = 0,
			Position = UDim2.new(1, 20, 1, -110 - (#notifications * 100)),
			Size = UDim2.new(0, 300, 0, 90),
			ZIndex = 200
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 12),
			Parent = NotificationFrame
		})
		
		Create("UIStroke", {
			Color = notifyColor,
			Thickness = 2,
			Parent = NotificationFrame
		})
		
		local NotifyShadow = Create("ImageLabel", {
			Name = "Shadow",
			Parent = NotificationFrame,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, -12, 0, -12),
			Size = UDim2.new(1, 24, 1, 24),
			ZIndex = 199,
			Image = "rbxassetid://6015897843",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			ImageTransparency = 0.5,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(49, 49, 450, 450)
		})
		
		local NotifyIcon = Create("ImageLabel", {
			Name = "Icon",
			Parent = NotificationFrame,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 15, 0, 15),
			Size = UDim2.new(0, 24, 0, 24),
			Image = notifyIconImage,
			ImageColor3 = notifyColor,
			ZIndex = 201
		})
		
		local NotifyTitle = Create("TextLabel", {
			Name = "Title",
			Parent = NotificationFrame,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 48, 0, 12),
			Size = UDim2.new(1, -80, 0, 22),
			Font = Enum.Font.GothamBold,
			Text = notifyTitle,
			TextColor3 = notifyColor,
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 201
		})
		
		local NotifyText = Create("TextLabel", {
			Name = "Text",
			Parent = NotificationFrame,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 15, 0, 42),
			Size = UDim2.new(1, -30, 0, 40),
			Font = Enum.Font.Gotham,
			Text = notifyText,
			TextColor3 = Theme.Text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			ZIndex = 201
		})
		
		local CloseNotify = Create("ImageButton", {
			Name = "Close",
			Parent = NotificationFrame,
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -32, 0, 10),
			Size = UDim2.new(0, 22, 0, 22),
			Image = Icons.X,
			ImageColor3 = Theme.TextDark,
			ZIndex = 201
		})
		
		local ProgressBar = Create("Frame", {
			Name = "Progress",
			Parent = NotificationFrame,
			BackgroundColor3 = notifyColor,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 1, -4),
			Size = UDim2.new(1, 0, 0, 4),
			ZIndex = 201
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 2),
			Parent = ProgressBar
		})
		
		table.insert(notifications, NotificationFrame)
		
		local function RemoveNotification()
			local index = table.find(notifications, NotificationFrame)
			if index then
				table.remove(notifications, index)
			end
			
			for i, notif in ipairs(notifications) do
				Tween(notif, {Position = UDim2.new(1, -320, 1, -110 - ((i - 1) * 100))}, 0.3)
			end
		end
		
		local function CloseNotification()
			Tween(NotificationFrame, {Position = UDim2.new(1, 20, 1, -110 - ((table.find(notifications, NotificationFrame) - 1) * 100))}, 0.3)
			Tween(NotificationFrame, {BackgroundTransparency = 1}, 0.3)
			Tween(NotifyIcon, {ImageTransparency = 1}, 0.3)
			Tween(NotifyTitle, {TextTransparency = 1}, 0.3)
			Tween(NotifyText, {TextTransparency = 1}, 0.3)
			Tween(NotifyShadow, {ImageTransparency = 1}, 0.3)
			Tween(ProgressBar, {BackgroundTransparency = 1}, 0.3)
			Tween(CloseNotify, {ImageTransparency = 1}, 0.3)
			
			task.wait(0.3)
			RemoveNotification()
			NotificationFrame:Destroy()
		end
		
		Tween(NotificationFrame, {Position = UDim2.new(1, -320, 1, -110 - ((#notifications - 1) * 100))}, 0.4, Enum.EasingStyle.Back)
		Tween(ProgressBar, {Size = UDim2.new(0, 0, 0, 4)}, duration)
		
		CloseNotify.MouseButton1Click:Connect(CloseNotification)
		CloseNotify.MouseEnter:Connect(function()
			Tween(CloseNotify, {ImageColor3 = Theme.Error}, 0.2)
		end)
		CloseNotify.MouseLeave:Connect(function()
			Tween(CloseNotify, {ImageColor3 = Theme.TextDark}, 0.2)
		end)
		
		task.delay(duration, CloseNotification)
		
		return NotificationFrame
	end
	
	function WindowAPI:Destroy()
		ScreenGui:Destroy()
	end
	
	function WindowAPI:Toggle()
		ToggleUI()
	end
	
	return WindowAPI
end

return UILibrary
