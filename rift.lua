local UILibrary = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

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
	Background = Color3.fromRGB(30, 30, 35),
	Header = Color3.fromRGB(35, 35, 40),
	TabBackground = Color3.fromRGB(25, 25, 30),
	TabActive = Color3.fromRGB(255, 255, 255),
	TabInactive = Color3.fromRGB(120, 120, 120),
	Text = Color3.fromRGB(255, 255, 255),
	TextDark = Color3.fromRGB(180, 180, 180),
	Accent = Color3.fromRGB(60, 120, 255),
	Separator = Color3.fromRGB(50, 50, 55),
	Button = Color3.fromRGB(45, 45, 50),
	ButtonHover = Color3.fromRGB(55, 55, 60),
	ToggleOff = Color3.fromRGB(60, 60, 65),
	ToggleOn = Color3.fromRGB(60, 180, 100),
	InputBackground = Color3.fromRGB(20, 20, 25),
	Success = Color3.fromRGB(60, 180, 100),
	Error = Color3.fromRGB(255, 80, 80),
	Warning = Color3.fromRGB(255, 180, 60)
}

function UILibrary:CreateWindow(config)
	config = config or {}
	local title = config.title or "UI Library"
	local subtitle = config.subtitle or ""
	local iconText = config.text or "UI"
	local size = config.size or Vector2.new(500, 350)
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
		CornerRadius = UDim.new(0, 8),
		Parent = MainFrame
	})
	
	Create("UIStroke", {
		Color = Color3.fromRGB(255, 255, 255),
		Thickness = 1,
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
		Position = UDim2.new(0, -15, 0, -15),
		Size = UDim2.new(1, 30, 1, 30),
		ZIndex = -1,
		Image = "rbxassetid://6015897843",
		ImageColor3 = Color3.fromRGB(0, 0, 0),
		ImageTransparency = 0.5,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450)
	})
	
	local Header = Create("Frame", {
		Name = "Header",
		Parent = MainFrame,
		BackgroundColor3 = Theme.Header,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 70)
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
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
		Position = UDim2.new(0, 15, 0, 10),
		Size = UDim2.new(1, -120, 0, 20),
		Font = Enum.Font.GothamBold,
		Text = title,
		TextColor3 = Theme.Text,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	
	local TitleSeparator = Create("Frame", {
		Name = "TitleSeparator",
		Parent = Header,
		BackgroundColor3 = Theme.Separator,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 15, 0, 35),
		Size = UDim2.new(0, 100, 0, 1)
	})
	
	local SubtitleLabel = Create("TextLabel", {
		Name = "Subtitle",
		Parent = Header,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 15, 0, 42),
		Size = UDim2.new(1, -120, 0, 18),
		Font = Enum.Font.Gotham,
		Text = subtitle,
		TextColor3 = Theme.TextDark,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	
	local PingLabel = Create("TextLabel", {
		Name = "Ping",
		Parent = Header,
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -110, 0, 10),
		Size = UDim2.new(0, 50, 0, 18),
		Font = Enum.Font.Gotham,
		Text = "0 ms",
		TextColor3 = Theme.TextDark,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Right
	})
	
	local PingIndicator = Create("Frame", {
		Name = "PingIndicator",
		Parent = Header,
		BackgroundColor3 = Theme.Success,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -55, 0, 15),
		Size = UDim2.new(0, 8, 0, 8)
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = PingIndicator
	})
	
	local HideButton = Create("TextButton", {
		Name = "HideButton",
		Parent = Header,
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -85, 0, 8),
		Size = UDim2.new(0, 25, 0, 25),
		Font = Enum.Font.GothamBold,
		Text = "-",
		TextColor3 = Theme.TextDark,
		TextSize = 18
	})
	
	local CloseButton = Create("TextButton", {
		Name = "CloseButton",
		Parent = Header,
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -40, 0, 8),
		Size = UDim2.new(0, 25, 0, 25),
		Font = Enum.Font.GothamBold,
		Text = "X",
		TextColor3 = Theme.Error,
		TextSize = 14
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
		Position = UDim2.new(0.5, -150, 0.5, -75),
		Size = UDim2.new(0, 300, 0, 150),
		ZIndex = 101
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = ConfirmModal
	})
	
	Create("UIStroke", {
		Color = Theme.Separator,
		Thickness = 1,
		Parent = ConfirmModal
	})
	
	local ModalTitle = Create("TextLabel", {
		Name = "Title",
		Parent = ConfirmModal,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 15),
		Size = UDim2.new(1, 0, 0, 25),
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
		Position = UDim2.new(0, 20, 0, 45),
		Size = UDim2.new(1, -40, 0, 40),
		Font = Enum.Font.Gotham,
		Text = "Are you sure you want to close the UI?",
		TextColor3 = Theme.TextDark,
		TextSize = 13,
		TextWrapped = true,
		ZIndex = 102
	})
	
	local ConfirmButton = Create("TextButton", {
		Name = "Confirm",
		Parent = ConfirmModal,
		BackgroundColor3 = Theme.Error,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 30, 1, -45),
		Size = UDim2.new(0.5, -40, 0, 30),
		Font = Enum.Font.GothamBold,
		Text = "Confirm",
		TextColor3 = Theme.Text,
		TextSize = 13,
		ZIndex = 102
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = ConfirmButton
	})
	
	local DeclineButton = Create("TextButton", {
		Name = "Decline",
		Parent = ConfirmModal,
		BackgroundColor3 = Theme.Button,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 10, 1, -45),
		Size = UDim2.new(0.5, -40, 0, 30),
		Font = Enum.Font.GothamBold,
		Text = "Decline",
		TextColor3 = Theme.Text,
		TextSize = 13,
		ZIndex = 102
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 6),
		Parent = DeclineButton
	})
	
	local DraggableIcon = Create("Frame", {
		Name = "DraggableIcon",
		Parent = ScreenGui,
		BackgroundColor3 = Theme.Background,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 50, 0, 50),
		Position = UDim2.new(0.5, -25, 0.9, 0),
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
		Position = UDim2.new(0, -5, 0, -5),
		Size = UDim2.new(1, 10, 1, 10),
		ZIndex = 49,
		Image = "rbxassetid://6015897843",
		ImageColor3 = Color3.fromRGB(0, 0, 0),
		ImageTransparency = 0.6,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450)
	})
	
	local IconText = Create("TextLabel", {
		Name = "IconText",
		Parent = DraggableIcon,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Font = Enum.Font.GothamBold,
		Text = iconText,
		TextColor3 = accentColor,
		TextSize = 14,
		ZIndex = 51
	})
	
	local IconStroke = Create("UIStroke", {
		Color = accentColor,
		Thickness = 2,
		Parent = DraggableIcon
	})
	
	local ContentFrame = Create("Frame", {
		Name = "Content",
		Parent = MainFrame,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 70),
		Size = UDim2.new(1, 0, 1, -70)
	})
	
	local TabContainer = Create("Frame", {
		Name = "TabContainer",
		Parent = ContentFrame,
		BackgroundColor3 = Theme.TabBackground,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 120, 1, 0)
	})
	
	Create("UICorner", {
		CornerRadius = UDim.new(0, 0),
		Parent = TabContainer
	})
	
	local TabList = Create("ScrollingFrame", {
		Name = "TabList",
		Parent = TabContainer,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5, 0, 5),
		Size = UDim2.new(1, -10, 1, -10),
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = Theme.Separator,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y
	})
	
	Create("UIListLayout", {
		Parent = TabList,
		Padding = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder
	})
	
	local TabContent = Create("Frame", {
		Name = "TabContent",
		Parent = ContentFrame,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 120, 0, 0),
		Size = UDim2.new(1, -120, 1, 0)
	})
	
	local ProfileSection = Create("Frame", {
		Name = "ProfileSection",
		Parent = TabContainer,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5, 1, -70),
		Size = UDim2.new(1, -10, 0, 65)
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
		Position = UDim2.new(0, 5, 0, 10),
		Size = UDim2.new(0, 35, 0, 35),
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
		Position = UDim2.new(0, 48, 0, 12),
		Size = UDim2.new(1, -53, 0, 16),
		Font = Enum.Font.GothamBold,
		Text = LocalPlayer.Name,
		TextColor3 = Theme.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd
	})
	
	local DateLabel = Create("TextLabel", {
		Name = "Date",
		Parent = ProfileSection,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 48, 0, 30),
		Size = UDim2.new(1, -53, 0, 14),
		Font = Enum.Font.Gotham,
		Text = "",
		TextColor3 = Theme.TextDark,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	
	local function UpdateDate()
		local date = os.date("%B %d, %Y")
		DateLabel.Text = date
	end
	UpdateDate()
	
	local userId = LocalPlayer.UserId
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size48x48
	local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
	AvatarImage.Image = content
	
	MakeDraggable(MainFrame, Header)
	MakeDraggable(DraggableIcon, DraggableIcon)
	
	local function UpdatePing()
		while true do
			local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
			PingLabel.Text = ping .. " ms"
			
			if ping < 100 then
				PingIndicator.BackgroundColor3 = Theme.Success
			elseif ping < 200 then
				PingIndicator.BackgroundColor3 = Theme.Warning
			else
				PingIndicator.BackgroundColor3 = Theme.Error
			end
			
			task.wait(1)
		end
	end
	task.spawn(UpdatePing)
	
	local function OpenModal()
		ModalOverlay.Visible = true
		Tween(ModalOverlay, {BackgroundTransparency = 0.5}, 0.2)
		ConfirmModal.Position = UDim2.new(0.5, -150, 0.5, -50)
		ConfirmModal.BackgroundTransparency = 1
		Tween(ConfirmModal, {Position = UDim2.new(0.5, -150, 0.5, -75), BackgroundTransparency = 0}, 0.3)
	end
	
	local function CloseModal()
		Tween(ModalOverlay, {BackgroundTransparency = 1}, 0.2).Completed:Connect(function()
			ModalOverlay.Visible = false
		end)
		Tween(ConfirmModal, {Position = UDim2.new(0.5, -150, 0.5, -50), BackgroundTransparency = 1}, 0.2)
	end
	
	ConfirmButton.MouseButton1Click:Connect(function()
		Tween(ConfirmButton, {Size = UDim2.new(0.5, -42, 0, 28)}, 0.05).Completed:Connect(function()
			Tween(ConfirmButton, {Size = UDim2.new(0.5, -40, 0, 30)}, 0.05)
		end)
		CloseModal()
		task.wait(0.2)
		ScreenGui:Destroy()
	end)
	
	DeclineButton.MouseButton1Click:Connect(function()
		Tween(DeclineButton, {Size = UDim2.new(0.5, -42, 0, 28)}, 0.05).Completed:Connect(function()
			Tween(DeclineButton, {Size = UDim2.new(0.5, -40, 0, 30)}, 0.05)
		end)
		CloseModal()
	end)
	
	CloseButton.MouseButton1Click:Connect(function()
		Tween(CloseButton, {Size = UDim2.new(0, 23, 0, 23)}, 0.05).Completed:Connect(function()
			Tween(CloseButton, {Size = UDim2.new(0, 25, 0, 25)}, 0.05)
		end)
		OpenModal()
	end)
	
	local function ToggleUI()
		isOpen = not isOpen
		
		if isOpen then
			DraggableIcon.Visible = false
			MainFrame.Visible = true
			MainFrame.Size = UDim2.new(0, size.X * 0.9, 0, size.Y * 0.9)
			MainFrame.BackgroundTransparency = 1
			Tween(MainFrame, {Size = UDim2.new(0, size.X, 0, size.Y), BackgroundTransparency = 0}, 0.3)
			
			if savedPosition then
				MainFrame.Position = savedPosition
			end
		else
			savedPosition = MainFrame.Position
			Tween(MainFrame, {Size = UDim2.new(0, size.X * 0.9, 0, size.Y * 0.9), BackgroundTransparency = 1}, 0.3).Completed:Connect(function()
				MainFrame.Visible = false
				DraggableIcon.Visible = true
				DraggableIcon.BackgroundTransparency = 1
				IconText.TextTransparency = 1
				Tween(DraggableIcon, {BackgroundTransparency = 0}, 0.2)
				Tween(IconText, {TextTransparency = 0}, 0.2)
			end)
		end
	end
	
	HideButton.MouseButton1Click:Connect(function()
		Tween(HideButton, {Size = UDim2.new(0, 23, 0, 23)}, 0.05).Completed:Connect(function()
			Tween(HideButton, {Size = UDim2.new(0, 25, 0, 25)}, 0.05)
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
		Tween(DraggableIcon, {Size = UDim2.new(0, 55, 0, 55)}, 0.2)
		Tween(IconStroke, {Thickness = 3}, 0.2)
	end)
	
	DraggableIcon.MouseLeave:Connect(function()
		Tween(DraggableIcon, {Size = UDim2.new(0, 50, 0, 50)}, 0.2)
		Tween(IconStroke, {Thickness = 2}, 0.2)
	end)
	
	local WindowAPI = {}
	
	function WindowAPI:CreateTab(tabName)
		local TabButton = Create("TextButton", {
			Name = tabName .. "Tab",
			Parent = TabList,
			BackgroundColor3 = Theme.TabBackground,
			BorderSizePixel = 0,
			Size = UDim2.new(1, -5, 0, 32),
			Font = Enum.Font.Gotham,
			Text = tabName,
			TextColor3 = Theme.TabInactive,
			TextSize = 12,
			AutoButtonColor = false
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 4),
			Parent = TabButton
		})
		
		local ActiveIndicator = Create("Frame", {
			Name = "Indicator",
			Parent = TabButton,
			BackgroundColor3 = accentColor,
			BorderSizePixel = 0,
			Position = UDim2.new(0, -5, 0, 8),
			Size = UDim2.new(0, 3, 0, 16),
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
			PaddingLeft = UDim.new(0, 15),
			PaddingRight = UDim.new(0, 15),
			PaddingTop = UDim.new(0, 15),
			PaddingBottom = UDim.new(0, 15)
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
				currentTab.Button.TextColor3 = Theme.TabInactive
				currentTab.Button.BackgroundColor3 = Theme.TabBackground
				currentTab.Button.Indicator.Visible = false
			end
			
			currentTab = tab
			TabFrame.Visible = true
			TabButton.TextColor3 = Theme.TabActive
			TabButton.BackgroundColor3 = Theme.Header
			ActiveIndicator.Visible = true
		end
		
		TabButton.MouseButton1Click:Connect(function()
			Tween(TabButton, {Size = UDim2.new(1, -8, 0, 30)}, 0.05).Completed:Connect(function()
				Tween(TabButton, {Size = UDim2.new(1, -5, 0, 32)}, 0.05)
			end)
			SelectTab()
		end)
		
		TabButton.MouseEnter:Connect(function()
			if currentTab ~= tab then
				Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}, 0.2)
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
		
		function TabAPI:AddSection(sectionName)
			AddSeparator()
			
			local SectionFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 30),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local SectionLabel = Create("TextLabel", {
				Name = "SectionLabel",
				Parent = SectionFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 8),
				Size = UDim2.new(1, 0, 0, 20),
				Font = Enum.Font.GothamBold,
				Text = sectionName,
				TextColor3 = accentColor,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			return SectionFrame
		end
		
		function TabAPI:AddLabel(text)
			AddSeparator()
			
			local LabelFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 28),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local Label = Create("TextLabel", {
				Name = "Label",
				Parent = LabelFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 5, 0, 5),
				Size = UDim2.new(1, -10, 0, 18),
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
		
		function TabAPI:AddParagraph(text)
			AddSeparator()
			
			local ParagraphFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 60),
				LayoutOrder = #TabFrame:GetChildren(),
				ClipsDescendants = true
			})
			
			local ParagraphBox = Create("TextBox", {
				Name = "Paragraph",
				Parent = ParagraphFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 5, 0, 5),
				Size = UDim2.new(1, -10, 1, -10),
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
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local ButtonFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 40),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local Button = Create("TextButton", {
				Name = "Button",
				Parent = ButtonFrame,
				BackgroundColor3 = Theme.Button,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 5),
				Size = UDim2.new(1, 0, 0, 30),
				Font = Enum.Font.GothamBold,
				Text = buttonText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				AutoButtonColor = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = Button
			})
			
			Button.MouseEnter:Connect(function()
				Tween(Button, {BackgroundColor3 = Theme.ButtonHover}, 0.2)
			end)
			
			Button.MouseLeave:Connect(function()
				Tween(Button, {BackgroundColor3 = Theme.Button}, 0.2)
			end)
			
			Button.MouseButton1Down:Connect(function()
				Tween(Button, {Size = UDim2.new(1, -4, 0, 28), Position = UDim2.new(0, 2, 0, 6)}, 0.05)
			end)
			
			Button.MouseButton1Up:Connect(function()
				Tween(Button, {Size = UDim2.new(1, 0, 0, 30), Position = UDim2.new(0, 0, 0, 5)}, 0.05)
			end)
			
			Button.MouseButton1Click:Connect(function()
				callback()
			end)
			
			local ButtonAPI = {}
			
			function ButtonAPI:SetText(newText)
				Button.Text = newText
			end
			
			function ButtonAPI:Fire()
				callback()
			end
			
			return ButtonAPI
		end
		
		function TabAPI:AddToggle(config)
			config = config or {}
			local toggleText = config.text or "Toggle"
			local default = config.default or false
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local ToggleFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 40),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local ToggleLabel = Create("TextLabel", {
				Name = "Label",
				Parent = ToggleFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 5, 0, 10),
				Size = UDim2.new(1, -70, 0, 20),
				Font = Enum.Font.Gotham,
				Text = toggleText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			local ToggleBackground = Create("Frame", {
				Name = "Background",
				Parent = ToggleFrame,
				BackgroundColor3 = default and Theme.ToggleOn or Theme.ToggleOff,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -55, 0, 8),
				Size = UDim2.new(0, 50, 0, 24)
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
				Position = default and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2),
				Size = UDim2.new(0, 20, 0, 20)
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(1, 0),
				Parent = ToggleCircle
			})
			
			local enabled = default
			
			local function Toggle()
				enabled = not enabled
				
				Tween(ToggleBackground, {BackgroundColor3 = enabled and Theme.ToggleOn or Theme.ToggleOff}, 0.2)
				Tween(ToggleCircle, {Position = enabled and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2)}, 0.2)
				
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
			local min = config.min or 0
			local max = config.max or 100
			local default = config.default or min
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local SliderFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 55),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local SliderLabel = Create("TextLabel", {
				Name = "Label",
				Parent = SliderFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 5, 0, 5),
				Size = UDim2.new(1, -70, 0, 18),
				Font = Enum.Font.Gotham,
				Text = sliderText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			local ValueLabel = Create("TextLabel", {
				Name = "Value",
				Parent = SliderFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -60, 0, 5),
				Size = UDim2.new(0, 55, 0, 18),
				Font = Enum.Font.GothamBold,
				Text = tostring(default),
				TextColor3 = accentColor,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Right
			})
			
			local SliderBackground = Create("Frame", {
				Name = "Background",
				Parent = SliderFrame,
				BackgroundColor3 = Theme.Separator,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 5, 0, 30),
				Size = UDim2.new(1, -10, 0, 8)
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
				Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8),
				Size = UDim2.new(0, 16, 0, 16),
				ZIndex = 2
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(1, 0),
				Parent = SliderHandle
			})
			
			local dragging = false
			
			local function UpdateSlider(input)
				local pos = math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1)
				local value = math.floor(min + (max - min) * pos)
				
				SliderFill.Size = UDim2.new(pos, 0, 1, 0)
				SliderHandle.Position = UDim2.new(pos, -8, 0.5, -8)
				ValueLabel.Text = tostring(value)
				
				callback(value)
			end
			
			SliderHandle.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
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
					dragging = false
				end
			end)
			
			callback(default)
			
			local SliderAPI = {}
			
			function SliderAPI:SetValue(value)
				value = math.clamp(value, min, max)
				local pos = (value - min) / (max - min)
				SliderFill.Size = UDim2.new(pos, 0, 1, 0)
				SliderHandle.Position = UDim2.new(pos, -8, 0.5, -8)
				ValueLabel.Text = tostring(value)
				callback(value)
			end
			
			function SliderAPI:GetValue()
				return tonumber(ValueLabel.Text)
			end
			
			return SliderAPI
		end
		
		function TabAPI:AddDropdown(config)
			config = config or {}
			local dropdownText = config.text or "Dropdown"
			local options = config.options or {}
			local default = config.default
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local DropdownFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 40),
				LayoutOrder = #TabFrame:GetChildren(),
				ClipsDescendants = true
			})
			
			local DropdownLabel = Create("TextLabel", {
				Name = "Label",
				Parent = DropdownFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 5, 0, 5),
				Size = UDim2.new(1, -10, 0, 18),
				Font = Enum.Font.Gotham,
				Text = dropdownText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			local DropdownButton = Create("TextButton", {
				Name = "DropdownButton",
				Parent = DropdownFrame,
				BackgroundColor3 = Theme.Button,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 28),
				Size = UDim2.new(1, 0, 0, 30),
				Font = Enum.Font.Gotham,
				Text = default or "Select...",
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextTruncate = Enum.TextTruncate.AtEnd,
				AutoButtonColor = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = DropdownButton
			})
			
			local ArrowIcon = Create("TextLabel", {
				Name = "Arrow",
				Parent = DropdownButton,
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -25, 0, 0),
				Size = UDim2.new(0, 20, 1, 0),
				Font = Enum.Font.GothamBold,
				Text = "V",
				TextColor3 = Theme.TextDark,
				TextSize = 10
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
				CornerRadius = UDim.new(0, 6),
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
					Size = UDim2.new(1, 0, 0, 28),
					Font = Enum.Font.Gotham,
					Text = optionText,
					TextColor3 = optionText == selectedOption and accentColor or Theme.Text,
					TextSize = 11,
					AutoButtonColor = false
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
						end
					end
					
					expanded = false
					Tween(OptionsFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
					Tween(ArrowIcon, {Rotation = 0}, 0.2)
					task.wait(0.2)
					OptionsFrame.Visible = false
					DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
					
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
					local optionsHeight = math.min(#options * 30 + 4, 150)
					Tween(OptionsFrame, {Size = UDim2.new(1, 0, 0, optionsHeight)}, 0.2)
					Tween(ArrowIcon, {Rotation = 180}, 0.2)
					DropdownFrame.Size = UDim2.new(1, 0, 0, 65 + optionsHeight)
				else
					Tween(OptionsFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
					Tween(ArrowIcon, {Rotation = 0}, 0.2)
					task.wait(0.2)
					OptionsFrame.Visible = false
					DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
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
					DropdownButton.Text = "Select..."
				end
			end
			
			return DropdownAPI
		end
		
		function TabAPI:AddInput(config)
			config = config or {}
			local inputText = config.text or "Input"
			local placeholder = config.placeholder or "Enter text..."
			local default = config.default or ""
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local InputFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 65),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local InputLabel = Create("TextLabel", {
				Name = "Label",
				Parent = InputFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 5, 0, 5),
				Size = UDim2.new(1, -10, 0, 18),
				Font = Enum.Font.Gotham,
				Text = inputText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			local InputBox = Create("TextBox", {
				Name = "InputBox",
				Parent = InputFrame,
				BackgroundColor3 = Theme.InputBackground,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 28),
				Size = UDim2.new(1, 0, 0, 32),
				Font = Enum.Font.Code,
				Text = default,
				PlaceholderText = placeholder,
				TextColor3 = Theme.Text,
				PlaceholderColor3 = Theme.TextDark,
				TextSize = 12,
				ClearTextOnFocus = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = InputBox
			})
			
			Create("UIPadding", {
				Parent = InputBox,
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10)
			})
			
			local Cursor = Create("Frame", {
				Name = "Cursor",
				Parent = InputBox,
				BackgroundColor3 = accentColor,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0.2, 0),
				Size = UDim2.new(0, 2, 0.6, 0),
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
				Tween(InputBox, {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}, 0.2)
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
				Cursor.Position = UDim2.new(0, math.min(textSize.X + 10, InputBox.AbsoluteSize.X - 15), 0.2, 0)
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
			local defaultKey = config.default
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local KeybindFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 40),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local KeybindLabel = Create("TextLabel", {
				Name = "Label",
				Parent = KeybindFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 5, 0, 10),
				Size = UDim2.new(1, -80, 0, 20),
				Font = Enum.Font.Gotham,
				Text = keybindText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			local KeybindButton = Create("TextButton", {
				Name = "KeybindButton",
				Parent = KeybindFrame,
				BackgroundColor3 = Theme.Button,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -70, 0, 5),
				Size = UDim2.new(0, 70, 0, 30),
				Font = Enum.Font.GothamBold,
				Text = defaultKey and defaultKey.Name or "None",
				TextColor3 = Theme.Text,
				TextSize = 11,
				AutoButtonColor = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = KeybindButton
			})
			
			local currentKey = defaultKey
			local listening = false
			
			KeybindButton.MouseButton1Click:Connect(function()
				if listening then return end
				
				listening = true
				KeybindButton.Text = "..."
				Tween(KeybindButton, {BackgroundColor3 = accentColor}, 0.2)
				
				local connection
				connection = UserInputService.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode == Enum.KeyCode.Escape then
							currentKey = nil
							KeybindButton.Text = "None"
						else
							currentKey = input.KeyCode
							KeybindButton.Text = input.KeyCode.Name
						end
						
						listening = false
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
			local default = config.default or Color3.fromRGB(255, 255, 255)
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local ColorPickerFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 45),
				LayoutOrder = #TabFrame:GetChildren(),
				ClipsDescendants = true
			})
			
			local ColorPickerLabel = Create("TextLabel", {
				Name = "Label",
				Parent = ColorPickerFrame,
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 5, 0, 12),
				Size = UDim2.new(1, -60, 0, 20),
				Font = Enum.Font.Gotham,
				Text = pickerText,
				TextColor3 = Theme.Text,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			})
			
			local ColorPreview = Create("TextButton", {
				Name = "Preview",
				Parent = ColorPickerFrame,
				BackgroundColor3 = default,
				BorderSizePixel = 0,
				Position = UDim2.new(1, -45, 0, 8),
				Size = UDim2.new(0, 40, 0, 28),
				Text = "",
				AutoButtonColor = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 6),
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
				Position = UDim2.new(0, 0, 0, 45),
				Size = UDim2.new(1, 0, 0, 0),
				ClipsDescendants = true,
				Visible = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 8),
				Parent = PickerPanel
			})
			
			local HueSlider = Create("Frame", {
				Name = "HueSlider",
				Parent = PickerPanel,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 10, 0, 10),
				Size = UDim2.new(1, -20, 0, 100)
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
				CornerRadius = UDim.new(0, 6),
				Parent = HueSlider
			})
			
			local HueHandle = Create("Frame", {
				Name = "Handle",
				Parent = HueSlider,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new(0, -6, 0, 0),
				Size = UDim2.new(0, 12, 1, 0),
				ZIndex = 2
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 3),
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
				Position = UDim2.new(0, 10, 0, 120),
				Size = UDim2.new(1, -20, 0, 12)
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
				Position = UDim2.new(0.5, -6, 0, -3),
				Size = UDim2.new(0, 12, 0, 18),
				ZIndex = 2
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 3),
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
				Position = UDim2.new(0, 10, 0, 142),
				Size = UDim2.new(1, -20, 0, 12)
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
				Position = UDim2.new(1, -6, 0, -3),
				Size = UDim2.new(0, 12, 0, 18),
				ZIndex = 2
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 3),
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
				Position = UDim2.new(0, 10, 0, 165),
				Size = UDim2.new(1, -20, 0, 18),
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
				HueHandle.Position = UDim2.new(hue, -6, 0, 0)
				SatHandle.Position = UDim2.new(sat, -6, 0, -3)
				ValHandle.Position = UDim2.new(val, -6, 0, -3)
				ColorPreview.BackgroundColor3 = color
				RGBLabel.Text = string.format("RGB: %d, %d, %d", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
			end
			
			local hueDragging, satDragging, valDragging = false, false, false
			
			HueSlider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					hueDragging = true
					local pos = math.clamp((input.Position.X - HueSlider.AbsolutePosition.X) / HueSlider.AbsoluteSize.X, 0, 1)
					hue = pos
					HueHandle.Position = UDim2.new(pos, -6, 0, 0)
					UpdateColor()
				end
			end)
			
			SaturationSlider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					satDragging = true
					local pos = math.clamp((input.Position.X - SaturationSlider.AbsolutePosition.X) / SaturationSlider.AbsoluteSize.X, 0, 1)
					sat = pos
					SatHandle.Position = UDim2.new(pos, -6, 0, -3)
					UpdateColor()
				end
			end)
			
			ValueSlider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					valDragging = true
					local pos = math.clamp((input.Position.X - ValueSlider.AbsolutePosition.X) / ValueSlider.AbsoluteSize.X, 0, 1)
					val = pos
					ValHandle.Position = UDim2.new(pos, -6, 0, -3)
					UpdateColor()
				end
			end)
			
			UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					if hueDragging then
						local pos = math.clamp((input.Position.X - HueSlider.AbsolutePosition.X) / HueSlider.AbsoluteSize.X, 0, 1)
						hue = pos
						HueHandle.Position = UDim2.new(pos, -6, 0, 0)
						UpdateColor()
					elseif satDragging then
						local pos = math.clamp((input.Position.X - SaturationSlider.AbsolutePosition.X) / SaturationSlider.AbsoluteSize.X, 0, 1)
						sat = pos
						SatHandle.Position = UDim2.new(pos, -6, 0, -3)
						UpdateColor()
					elseif valDragging then
						local pos = math.clamp((input.Position.X - ValueSlider.AbsolutePosition.X) / ValueSlider.AbsoluteSize.X, 0, 1)
						val = pos
						ValHandle.Position = UDim2.new(pos, -6, 0, -3)
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
					Tween(PickerPanel, {Size = UDim2.new(1, 0, 0, 190)}, 0.2)
					ColorPickerFrame.Size = UDim2.new(1, 0, 0, 240)
				else
					Tween(PickerPanel, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
					task.wait(0.2)
					PickerPanel.Visible = false
					ColorPickerFrame.Size = UDim2.new(1, 0, 0, 45)
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
			local imageSize = config.size or UDim2.new(1, 0, 0, 100)
			local callback = config.callback or function() end
			
			AddSeparator()
			
			local ImageFrame = Create("Frame", {
				Parent = TabFrame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, imageSize.Y.Offset + 10),
				LayoutOrder = #TabFrame:GetChildren()
			})
			
			local ImageButton = Create("ImageButton", {
				Name = "Image",
				Parent = ImageFrame,
				BackgroundColor3 = Theme.Button,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 5),
				Size = imageSize,
				Image = imageId,
				ScaleType = Enum.ScaleType.Fit,
				AutoButtonColor = false
			})
			
			Create("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = ImageButton
			})
			
			ImageButton.MouseButton1Click:Connect(function()
				Tween(ImageButton, {Size = UDim2.new(imageSize.X.Scale, imageSize.X.Offset - 4, imageSize.Y.Scale, imageSize.Y.Offset - 4), Position = UDim2.new(0, 2, 0, 7)}, 0.05).Completed:Connect(function()
					Tween(ImageButton, {Size = imageSize, Position = UDim2.new(0, 0, 0, 5)}, 0.05)
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
		
		local notifyColor = Theme.Accent
		if notifyType == "success" then
			notifyColor = Theme.Success
		elseif notifyType == "error" then
			notifyColor = Theme.Error
		elseif notifyType == "warning" then
			notifyColor = Theme.Warning
		end
		
		local NotificationFrame = Create("Frame", {
			Name = "Notification",
			Parent = ScreenGui,
			BackgroundColor3 = Theme.Background,
			BorderSizePixel = 0,
			Position = UDim2.new(1, 20, 1, -100 - (#notifications * 90)),
			Size = UDim2.new(0, 280, 0, 80),
			ZIndex = 200
		})
		
		Create("UICorner", {
			CornerRadius = UDim.new(0, 8),
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
			Position = UDim2.new(0, -10, 0, -10),
			Size = UDim2.new(1, 20, 1, 20),
			ZIndex = 199,
			Image = "rbxassetid://6015897843",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			ImageTransparency = 0.6,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(49, 49, 450, 450)
		})
		
		local NotifyTitle = Create("TextLabel", {
			Name = "Title",
			Parent = NotificationFrame,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 15, 0, 10),
			Size = UDim2.new(1, -50, 0, 20),
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
			Position = UDim2.new(0, 15, 0, 32),
			Size = UDim2.new(1, -30, 0, 40),
			Font = Enum.Font.Gotham,
			Text = notifyText,
			TextColor3 = Theme.Text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			ZIndex = 201
		})
		
		local CloseNotify = Create("TextButton", {
			Name = "Close",
			Parent = NotificationFrame,
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -30, 0, 5),
			Size = UDim2.new(0, 25, 0, 25),
			Font = Enum.Font.GothamBold,
			Text = "X",
			TextColor3 = Theme.TextDark,
			TextSize = 12,
			ZIndex = 201
		})
		
		local ProgressBar = Create("Frame", {
			Name = "Progress",
			Parent = NotificationFrame,
			BackgroundColor3 = notifyColor,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 1, -3),
			Size = UDim2.new(1, 0, 0, 3),
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
				Tween(notif, {Position = UDim2.new(1, -300, 1, -100 - ((i - 1) * 90))}, 0.3)
			end
		end
		
		local function CloseNotification()
			Tween(NotificationFrame, {Position = UDim2.new(1, 20, 1, -100 - ((table.find(notifications, NotificationFrame) - 1) * 90))}, 0.3)
			Tween(NotificationFrame, {BackgroundTransparency = 1}, 0.3)
			Tween(NotifyTitle, {TextTransparency = 1}, 0.3)
			Tween(NotifyText, {TextTransparency = 1}, 0.3)
			Tween(NotifyShadow, {ImageTransparency = 1}, 0.3)
			Tween(ProgressBar, {BackgroundTransparency = 1}, 0.3)
			Tween(CloseNotify, {TextTransparency = 1}, 0.3)
			
			task.wait(0.3)
			RemoveNotification()
			NotificationFrame:Destroy()
		end
		
		Tween(NotificationFrame, {Position = UDim2.new(1, -300, 1, -100 - ((#notifications - 1) * 90))}, 0.4)
		Tween(ProgressBar, {Size = UDim2.new(0, 0, 0, 3)}, duration)
		
		CloseNotify.MouseButton1Click:Connect(CloseNotification)
		
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
