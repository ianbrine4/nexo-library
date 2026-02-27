local RiftUI = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function Create(instanceType, properties)
   local instance = Instance.new(instanceType)
   for prop, value in pairs(properties) do
   	instance[prop] = value
   end
   return instance
end

local function Tween(instance, properties, duration, easingStyle, easingDirection)
   local tweenInfo = TweenInfo.new(
   	duration or 0.3,
   	easingStyle or Enum.EasingStyle.Quart,
   	easingDirection or Enum.EasingDirection.Out
   )
   local tween = TweenService:Create(instance, tweenInfo, properties)
   tween:Play()
   return tween
end

local function MakeDraggable(frame, handle)
   handle = handle or frame
   local dragging = false
   local dragStart
   local startPos

   handle.InputBegan:Connect(function(input)
   	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
   		dragging = true
   		dragStart = input.Position
   		startPos = frame.Position
   		Tween(handle, {BackgroundTransparency = 0.1}, 0.1)
   	end
   end)

   handle.InputChanged:Connect(function(input)
   	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
   		local delta = input.Position - dragStart
   		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
   	end
   end)

   UserInputService.InputEnded:Connect(function(input)
   	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
   		if dragging then
   			dragging = false
   			Tween(handle, {BackgroundTransparency = 0}, 0.1)
   		end
   	end
   end)
end

function RiftUI:CreateWindow(config)
   config = config or {}
   local window = {}
   
   local screenGui = Create("ScreenGui", {
   	Name = "RiftUI_" .. HttpService:GenerateGUID(false),
   	Parent = PlayerGui,
   	ResetOnSpawn = false,
   	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   })

   local mainFrame = Create("Frame", {
   	Name = "MainFrame",
   	Parent = screenGui,
   	BackgroundColor3 = Color3.fromRGB(30, 30, 30),
   	BorderSizePixel = 0,
   	Position = UDim2.new(0.5, -250, 0.5, -175),
   	Size = UDim2.new(0, config.size and config.size.X or 500, 0, config.size and config.size.Y or 350),
   	ClipsDescendants = true
   })

   local uiStroke = Create("UIStroke", {
   	Parent = mainFrame,
   	Color = Color3.fromRGB(255, 255, 255),
   	Thickness = 1
   })

   local uiCorner = Create("UICorner", {
   	Parent = mainFrame,
   	CornerRadius = UDim.new(0, 8)
   })

   local shadow = Create("ImageLabel", {
   	Name = "Shadow",
   	Parent = mainFrame,
   	BackgroundTransparency = 1,
   	Position = UDim2.new(0, -15, 0, -15),
   	Size = UDim2.new(1, 30, 1, 30),
   	Image = "rbxassetid://1316045217",
   	ImageColor3 = Color3.fromRGB(0, 0, 0),
   	ImageTransparency = 0.6,
   	ScaleType = Enum.ScaleType.Slice,
   	SliceCenter = Rect.new(10, 10, 118, 118),
   	ZIndex = -1
   })

   local header = Create("Frame", {
   	Name = "Header",
   	Parent = mainFrame,
   	BackgroundColor3 = Color3.fromRGB(35, 35, 35),
   	BorderSizePixel = 0,
   	Size = UDim2.new(1, 0, 0, 50)
   })

   local headerCorner = Create("UICorner", {
   	Parent = header,
   	CornerRadius = UDim.new(0, 8)
   })

   local headerFix = Create("Frame", {
   	Name = "Fix",
   	Parent = header,
   	BackgroundColor3 = Color3.fromRGB(35, 35, 35),
   	BorderSizePixel = 0,
   	Position = UDim2.new(0, 0, 1, -8),
   	Size = UDim2.new(1, 0, 0, 8)
   })

   local titleLabel = Create("TextLabel", {
   	Name = "Title",
   	Parent = header,
   	BackgroundTransparency = 1,
   	Position = UDim2.new(0, 15, 0, 5),
   	Size = UDim2.new(0, 200, 0, 20),
   	Font = Enum.Font.GothamBold,
   	Text = config.title or "Rift UI Library",
   	TextColor3 = Color3.fromRGB(255, 255, 255),
   	TextSize = 16,
   	TextXAlignment = Enum.TextXAlignment.Left
   })

   local subtitleLabel = Create("TextLabel", {
   	Name = "Subtitle",
   	Parent = header,
   	BackgroundTransparency = 1,
   	Position = UDim2.new(0, 15, 0, 25),
   	Size = UDim2.new(0, 200, 0, 16),
   	Font = Enum.Font.Gotham,
   	Text = config.subtitle or "Clean modern Roblox UI",
   	TextColor3 = Color3.fromRGB(150, 150, 150),
   	TextSize = 12,
   	TextXAlignment = Enum.TextXAlignment.Left
   })

   local pingLabel = Create("TextLabel", {
   	Name = "Ping",
   	Parent = header,
   	BackgroundTransparency = 1,
   	Position = UDim2.new(1, -150, 0, 17),
   	Size = UDim2.new(0, 60, 0, 16),
   	Font = Enum.Font.Gotham,
   	Text = "0 ms",
   	TextColor3 = Color3.fromRGB(100, 255, 100),
   	TextSize = 12,
   	TextXAlignment = Enum.TextXAlignment.Right
   })

   RunService.Heartbeat:Connect(function()
   	local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
   	pingLabel.Text = ping .. " ms"
   	if ping < 50 then
   		pingLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
   	elseif ping < 100 then
   		pingLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
   	else
   		pingLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
   	end
   end)

   local hideButton = Create("TextButton", {
   	Name = "HideButton",
   	Parent = header,
   	BackgroundColor3 = Color3.fromRGB(45, 45, 45),
   	Position = UDim2.new(1, -75, 0, 12),
   	Size = UDim2.new(0, 28, 0, 28),
   	Font = Enum.Font.GothamBold,
   	Text = "-",
   	TextColor3 = Color3.fromRGB(255, 255, 255),
   	TextSize = 18,
   	AutoButtonColor = false
   })

   local hideCorner = Create("UICorner", {
   	Parent = hideButton,
   	CornerRadius = UDim.new(0, 6)
   })

   hideButton.MouseEnter:Connect(function()
   	Tween(hideButton, {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}, 0.2)
   end)

   hideButton.MouseLeave:Connect(function()
   	Tween(hideButton, {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}, 0.2)
   end)

   local closeButton = Create("TextButton", {
   	Name = "CloseButton",
   	Parent = header,
   	BackgroundColor3 = Color3.fromRGB(45, 45, 45),
   	Position = UDim2.new(1, -40, 0, 12),
   	Size = UDim2.new(0, 28, 0, 28),
   	Font = Enum.Font.GothamBold,
   	Text = "X",
   	TextColor3 = Color3.fromRGB(255, 255, 255),
   	TextSize = 14,
   	AutoButtonColor = false
   })

   local closeCorner = Create("UICorner", {
   	Parent = closeButton,
   	CornerRadius = UDim.new(0, 6)
   })

   closeButton.MouseEnter:Connect(function()
   	Tween(closeButton, {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}, 0.2)
   end)

   closeButton.MouseLeave:Connect(function()
   	Tween(closeButton, {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}, 0.2)
   end)

   local modalOverlay = Create("Frame", {
   	Name = "ModalOverlay",
   	Parent = mainFrame,
   	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
   	BackgroundTransparency = 1,
   	BorderSizePixel = 0,
   	Size = UDim2.new(1, 0, 1, 0),
   	ZIndex = 100,
   	Visible = false
   })

   local modalFrame = Create("Frame", {
   	Name = "ModalFrame",
   	Parent = modalOverlay,
   	BackgroundColor3 = Color3.fromRGB(40, 40, 40),
   	Position = UDim2.new(0.5, -150, 0.5, -75),
   	Size = UDim2.new(0, 300, 0, 150),
   	ZIndex = 101
   })

   local modalCorner = Create("UICorner", {
   	Parent = modalFrame,
   	CornerRadius = UDim.new(0, 8)
   })

   local modalStroke = Create("UIStroke", {
   	Parent = modalFrame,
   	Color = Color3.fromRGB(255, 255, 255),
   	Thickness = 1
   })

   local modalTitle = Create("TextLabel", {
   	Name = "Title",
   	Parent = modalFrame,
   	BackgroundTransparency = 1,
   	Position = UDim2.new(0, 0, 0, 20),
   	Size = UDim2.new(1, 0, 0, 20),
   	Font = Enum.Font.GothamBold,
   	Text = "Confirm Close",
   	TextColor3 = Color3.fromRGB(255, 255, 255),
   	TextSize = 16,
   	ZIndex = 102
   })

   local modalText = Create("TextLabel", {
   	Name = "Text",
   	Parent = modalFrame,
   	BackgroundTransparency = 1,
   	Position = UDim2.new(0, 0, 0, 50),
   	Size = UDim2.new(1, 0, 0, 40),
   	Font = Enum.Font.Gotham,
   	Text = "Are you sure you want to close?",
   	TextColor3 = Color3.fromRGB(200, 200, 200),
   	TextSize = 14,
   	ZIndex = 102
   })

   local confirmButton = Create("TextButton", {
   	Name = "Confirm",
   	Parent = modalFrame,
   	BackgroundColor3 = Color3.fromRGB(50, 150, 50),
   	Position = UDim2.new(0, 30, 1, -50),
   	Size = UDim2.new(0, 100, 0, 35),
   	Font = Enum.Font.GothamBold,
   	Text = "Confirm",
   	TextColor3 = Color3.fromRGB(255, 255, 255),
   	TextSize = 14,
   	ZIndex = 102,
   	AutoButtonColor = false
   })

   local confirmCorner = Create("UICorner", {
   	Parent = confirmButton,
   	CornerRadius = UDim.new(0, 6)
   })

   local declineButton = Create("TextButton", {
   	Name = "Decline",
   	Parent = modalFrame,
   	BackgroundColor3 = Color3.fromRGB(150, 50, 50),
   	Position = UDim2.new(1, -130, 1, -50),
   	Size = UDim2.new(0, 100, 0, 35),
   	Font = Enum.Font.GothamBold,
   	Text = "Decline",
   	TextColor3 = Color3.fromRGB(255, 255, 255),
   	TextSize = 14,
   	ZIndex = 102,
   	AutoButtonColor = false
   })

   local declineCorner = Create("UICorner", {
   	Parent = declineButton,
   	CornerRadius = UDim.new(0, 6)
   })

   confirmButton.MouseEnter:Connect(function()
   	Tween(confirmButton, {BackgroundColor3 = Color3.fromRGB(60, 180, 60)}, 0.2)
   end)

   confirmButton.MouseLeave:Connect(function()
   	Tween(confirmButton, {BackgroundColor3 = Color3.fromRGB(50, 150, 50)}, 0.2)
   end)

   declineButton.MouseEnter:Connect(function()
   	Tween(declineButton, {BackgroundColor3 = Color3.fromRGB(180, 60, 60)}, 0.2)
   end)

   declineButton.MouseLeave:Connect(function()
   	Tween(declineButton, {BackgroundColor3 = Color3.fromRGB(150, 50, 50)}, 0.2)
   end)

   local tabContainer = Create("Frame", {
   	Name = "TabContainer",
   	Parent = mainFrame,
   	BackgroundColor3 = Color3.fromRGB(25, 25, 25),
   	BorderSizePixel = 0,
   	Position = UDim2.new(0, 0, 0, 50),
   	Size = UDim2.new(0, 50, 1, -50)
   })

   local contentContainer = Create("Frame", {
   	Name = "ContentContainer",
   	Parent = mainFrame,
   	BackgroundTransparency = 1,
   	Position = UDim2.new(0, 50, 0, 50),
   	Size = UDim2.new(1, -50, 1, -50)
   })

   local contentLayout = Create("UIListLayout", {
   	Parent = contentContainer,
   	SortOrder = Enum.SortOrder.LayoutOrder,
   	Padding = UDim.new(0, 0)
   })

   local profileSection = Create("Frame", {
   	Name = "ProfileSection",
   	Parent = mainFrame,
   	BackgroundColor3 = Color3.fromRGB(35, 35, 35),
   	BorderSizePixel = 0,
   	Position = UDim2.new(0, 50, 1, -60),
   	Size = UDim2.new(1, -50, 0, 60)
   })

   local profileCorner = Create("UICorner", {
   	Parent = profileSection,
   	CornerRadius = UDim.new(0, 0)
   })

   local avatarImage = Create("ImageLabel", {
   	Name = "Avatar",
   	Parent = profileSection,
   	BackgroundColor3 = Color3.fromRGB(40, 40, 40),
   	Position = UDim2.new(0, 10, 0, 10),
   	Size = UDim2.new(0, 40, 0, 40),
   	Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=420&height=420&format=png"
   })

   local avatarCorner = Create("UICorner", {
   	Parent = avatarImage,
   	CornerRadius = UDim.new(0, 20)
   })

   local usernameLabel = Create("TextLabel", {
   	Name = "Username",
   	Parent = profileSection,
   	BackgroundTransparency = 1,
   	Position = UDim2.new(0, 60, 0, 10),
   	Size = UDim2.new(0, 200, 0, 20),
   	Font = Enum.Font.GothamBold,
   	Text = LocalPlayer.DisplayName,
   	TextColor3 = Color3.fromRGB(255, 255, 255),
   	TextSize = 14,
   	TextXAlignment = Enum.TextXAlignment.Left
   })

   local displayLabel = Create("TextLabel", {
   	Name = "DisplayName",
   	Parent = profileSection,
   	BackgroundTransparency = 1,
   	Position = UDim2.new(0, 60, 0, 32),
   	Size = UDim2.new(0, 200, 0, 16),
   	Font = Enum.Font.Gotham,
   	Text = "@" .. LocalPlayer.Name,
   	TextColor3 = Color3.fromRGB(150, 150, 150),
   	TextSize = 12,
   	TextXAlignment = Enum.TextXAlignment.Left
   })

   local draggableIcon = Create("TextButton", {
   	Name = "DraggableIcon",
   	Parent = screenGui,
   	BackgroundColor3 = Color3.fromRGB(40, 40, 40),
   	Position = UDim2.new(0, 100, 0, 100),
   	Size = UDim2.new(0, 50, 0, 50),
   	Font = Enum.Font.GothamBold,
   	Text = config.text or "Rift",
   	TextColor3 = Color3.fromRGB(255, 255, 255),
   	TextSize = 12,
   	Visible = false,
   	AutoButtonColor = false
   })

   local iconCorner = Create("UICorner", {
   	Parent = draggableIcon,
   	CornerRadius = UDim.new(0.5, 0)
   })

   local iconStroke = Create("UIStroke", {
   	Parent = draggableIcon,
   	Color = Color3.fromRGB(255, 255, 255),
   	Thickness = 1
   })

   local iconShadow = Create("ImageLabel", {
   	Name = "Shadow",
   	Parent = draggableIcon,
   	BackgroundTransparency = 1,
   	Position = UDim2.new(0, -5, 0, -5),
   	Size = UDim2.new(1, 10, 1, 10),
   	Image = "rbxassetid://1316045217",
   	ImageColor3 = Color3.fromRGB(0, 0, 0),
   	ImageTransparency = 0.7,
   	ScaleType = Enum.ScaleType.Slice,
   	SliceCenter = Rect.new(10, 10, 118, 118),
   	ZIndex = -1
   })

   draggableIcon.MouseEnter:Connect(function()
   	Tween(draggableIcon, {Size = UDim2.new(0, 55, 0, 55), Position = UDim2.new(draggableIcon.Position.X.Scale, draggableIcon.Position.X.Offset - 2.5, draggableIcon.Position.Y.Scale, draggableIcon.Position.Y.Offset - 2.5)}, 0.2)
   end)

   draggableIcon.MouseLeave:Connect(function()
   	Tween(draggableIcon, {Size = UDim2.new(0, 50, 0, 50), Position = UDim2.new(draggableIcon.Position.X.Scale, draggableIcon.Position.X.Offset + 2.5, draggableIcon.Position.Y.Scale, draggableIcon.Position.Y.Offset + 2.5)}, 0.2)
   end)

   MakeDraggable(draggableIcon)

   local isOpen = true
   local savedPosition = mainFrame.Position

   local function OpenUI()
   	isOpen = true
   	draggableIcon.Visible = false
   	mainFrame.Visible = true
   	mainFrame.Size = UDim2.new(0, 0, 0, 0)
   	mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
   	Tween(mainFrame, {Size = UDim2.new(0, config.size and config.size.X or 500, 0, config.size and config.size.Y or 350), Position = savedPosition}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
   end

   local function CloseUI()
   	isOpen = false
   	savedPosition = mainFrame.Position
   	Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In).Completed:Connect(function()
   		mainFrame.Visible = false
   		draggableIcon.Visible = true
   	end)
   end

   hideButton.MouseButton1Click:Connect(CloseUI)

   closeButton.MouseButton1Click:Connect(function()
   	modalOverlay.Visible = true
   	modalOverlay.BackgroundTransparency = 1
   	modalFrame.Size = UDim2.new(0, 0, 0, 0)
   	Tween(modalOverlay, {BackgroundTransparency = 0.7}, 0.2)
   	Tween(modalFrame, {Size = UDim2.new(0, 300, 0, 150)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
   end)

   confirmButton.MouseButton1Click:Connect(function()
   	Tween(modalOverlay, {BackgroundTransparency = 1}, 0.2)
   	Tween(modalFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In).Completed:Connect(function()
   		modalOverlay.Visible = false
   		screenGui:Destroy()
   	end)
   end)

   declineButton.MouseButton1Click:Connect(function()
   	Tween(modalOverlay, {BackgroundTransparency = 1}, 0.2)
   	Tween(modalFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In).Completed:Connect(function()
   		modalOverlay.Visible = false
   	end)
   end)

   draggableIcon.MouseButton1Click:Connect(OpenUI)

   MakeDraggable(mainFrame, header)

   window.ScreenGui = screenGui
   window.MainFrame = mainFrame
   window.TabContainer = tabContainer
   window.ContentContainer = contentContainer
   window.Tabs = {}
   window.CurrentTab = nil

   function window:CreateTab(iconId)
   	local tab = {}
   	local tabIndex = #self.Tabs + 1

   	local tabButton = Create("TextButton", {
   		Name = "Tab_" .. tabIndex,
   		Parent = self.TabContainer,
   		BackgroundColor3 = Color3.fromRGB(25, 25, 25),
   		BorderSizePixel = 0,
   		Position = UDim2.new(0, 0, 0, (tabIndex - 1) * 50),
   		Size = UDim2.new(1, 0, 0, 50),
   		Font = Enum.Font.Gotham,
   		Text = "",
   		AutoButtonColor = false
   	})

   	local tabIcon = Create("ImageLabel", {
   		Name = "Icon",
   		Parent = tabButton,
   		BackgroundTransparency = 1,
   		Position = UDim2.new(0.5, -12, 0.5, -12),
   		Size = UDim2.new(0, 24, 0, 24),
   		Image = iconId or "",
   		ImageColor3 = Color3.fromRGB(150, 150, 150)
   	})

   	local indicator = Create("Frame", {
   		Name = "Indicator",
   		Parent = tabButton,
   		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
   		BorderSizePixel = 0,
   		Position = UDim2.new(0, 0, 0, 0),
   		Size = UDim2.new(0, 3, 1, 0),
   		Visible = false
   	})

   	local contentFrame = Create("ScrollingFrame", {
   		Name = "Content_" .. tabIndex,
   		Parent = self.ContentContainer,
   		BackgroundTransparency = 1,
   		BorderSizePixel = 0,
   		Size = UDim2.new(1, 0, 1, 0),
   		ScrollBarThickness = 4,
   		ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100),
   		CanvasSize = UDim2.new(0, 0, 0, 0),
   		Visible = false
   	})

   	local contentList = Create("UIListLayout", {
   		Parent = contentFrame,
   		SortOrder = Enum.SortOrder.LayoutOrder,
   		Padding = UDim.new(0, 10)
   	})

   	local contentPadding = Create("UIPadding", {
   		Parent = contentFrame,
   		PaddingLeft = UDim.new(0, 15),
   		PaddingRight = UDim.new(0, 15),
   		PaddingTop = UDim.new(0, 15),
   		PaddingBottom = UDim.new(0, 15)
   	})

   	contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
   		contentFrame.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 30)
   	end)

   	tabButton.MouseEnter:Connect(function()
   		if self.CurrentTab ~= tab then
   			Tween(tabIcon, {ImageColor3 = Color3.fromRGB(200, 200, 200)}, 0.2)
   		end
   	end)

   	tabButton.MouseLeave:Connect(function()
   		if self.CurrentTab ~= tab then
   			Tween(tabIcon, {ImageColor3 = Color3.fromRGB(150, 150, 150)}, 0.2)
   		end
   	end)

   	tabButton.MouseButton1Click:Connect(function()
   		self:SwitchTab(tab)
   	end)

   	tab.Button = tabButton
   	tab.Content = contentFrame
   	tab.Indicator = indicator
   	tab.Icon = tabIcon

   	table.insert(self.Tabs, tab)

   	if #self.Tabs == 1 then
   		self:SwitchTab(tab)
   	end

   	function tab:AddSeparator()
   		local separator = Create("Frame", {
   			Parent = self.Content,
   			BackgroundColor3 = Color3.fromRGB(60, 60, 60),
   			BorderSizePixel = 0,
   			Size = UDim2.new(1, 0, 0, 1)
   		})
   		return separator
   	end

   	function tab:AddLabel(text)
   		local label = Create("TextLabel", {
   			Parent = self.Content,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 20),
   			Font = Enum.Font.Gotham,
   			Text = text or "Label",
   			TextColor3 = Color3.fromRGB(255, 255, 255),
   			TextSize = 14,
   			TextXAlignment = Enum.TextXAlignment.Left
   		})
   		return label
   	end

   	function tab:AddParagraph(text)
   		local paragraph = Create("TextLabel", {
   			Parent = self.Content,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 40),
   			Font = Enum.Font.Gotham,
   			Text = text or "Paragraph text",
   			TextColor3 = Color3.fromRGB(180, 180, 180),
   			TextSize = 12,
   			TextXAlignment = Enum.TextXAlignment.Left,
   			TextWrapped = true
   		})
   		return paragraph
   	end

   	function tab:AddButton(config)
   		config = config or {}
   		local buttonFrame = Create("Frame", {
   			Parent = self.Content,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 35)
   		})

   		local button = Create("TextButton", {
   			Parent = buttonFrame,
   			BackgroundColor3 = config.color or Color3.fromRGB(45, 45, 45),
   			Size = UDim2.new(1, 0, 1, 0),
   			Font = Enum.Font.GothamBold,
   			Text = config.text or "Button",
   			TextColor3 = Color3.fromRGB(255, 255, 255),
   			TextSize = 13,
   			AutoButtonColor = false
   		})

   		local corner = Create("UICorner", {
   			Parent = button,
   			CornerRadius = UDim.new(0, 6)
   		})

   		button.MouseEnter:Connect(function()
   			Tween(button, {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}, 0.2)
   		end)

   		button.MouseLeave:Connect(function()
   			Tween(button, {BackgroundColor3 = config.color or Color3.fromRGB(45, 45, 45)}, 0.2)
   		end)

   		button.MouseButton1Down:Connect(function()
   			Tween(button, {Size = UDim2.new(0.98, 0, 0.9, 0), Position = UDim2.new(0.01, 0, 0.05, 0)}, 0.1)
   		end)

   		button.MouseButton1Up:Connect(function()
   			Tween(button, {Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0)}, 0.1)
   		end)

   		button.MouseButton1Click:Connect(function()
   			if config.callback then
   				config.callback()
   			end
   		end)

   		return button
   	end

   	function tab:AddToggle(config)
   		config = config or {}
   		local toggleFrame = Create("Frame", {
   			Parent = self.Content,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 35)
   		})

   		local label = Create("TextLabel", {
   			Parent = toggleFrame,
   			BackgroundTransparency = 1,
   			Position = UDim2.new(0, 0, 0, 7),
   			Size = UDim2.new(0.7, 0, 0, 20),
   			Font = Enum.Font.Gotham,
   			Text = config.text or "Toggle",
   			TextColor3 = Color3.fromRGB(255, 255, 255),
   			TextSize = 14,
   			TextXAlignment = Enum.TextXAlignment.Left
   		})

   		local toggleBg = Create("Frame", {
   			Parent = toggleFrame,
   			BackgroundColor3 = Color3.fromRGB(60, 60, 60),
   			Position = UDim2.new(1, -50, 0.5, -10),
   			Size = UDim2.new(0, 44, 0, 22),
   			ClipsDescendants = true
   		})

   		local toggleCorner = Create("UICorner", {
   			Parent = toggleBg,
   			CornerRadius = UDim.new(1, 0)
   		})

   		local toggleCircle = Create("Frame", {
   			Parent = toggleBg,
   			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
   			Position = UDim2.new(0, 2, 0.5, -9),
   			Size = UDim2.new(0, 18, 0, 18)
   		})

   		local circleCorner = Create("UICorner", {
   			Parent = toggleCircle,
   			CornerRadius = UDim.new(1, 0)
   		})

   		local enabled = false

   		local function UpdateToggle()
   			if enabled then
   				Tween(toggleBg, {BackgroundColor3 = Color3.fromRGB(50, 200, 100)}, 0.2)
   				Tween(toggleCircle, {Position = UDim2.new(0, 24, 0.5, -9)}, 0.2)
   			else
   				Tween(toggleBg, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.2)
   				Tween(toggleCircle, {Position = UDim2.new(0, 2, 0.5, -9)}, 0.2)
   			end
   			if config.callback then
   				config.callback(enabled)
   			end
   		end

   		toggleBg.InputBegan:Connect(function(input)
   			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
   				enabled = not enabled
   				UpdateToggle()
   			end
   		end)

   		return {
   			Set = function(value)
   				enabled = value
   				UpdateToggle()
   			end,
   			Get = function()
   				return enabled
   			end
   		}
   	end

   	function tab:AddSlider(config)
   		config = config or {}
   		local sliderFrame = Create("Frame", {
   			Parent = self.Content,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 50)
   		})

   		local label = Create("TextLabel", {
   			Parent = sliderFrame,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 20),
   			Font = Enum.Font.Gotham,
   			Text = config.text or "Slider",
   			TextColor3 = Color3.fromRGB(255, 255, 255),
   			TextSize = 14,
   			TextXAlignment = Enum.TextXAlignment.Left
   		})

   		local valueLabel = Create("TextLabel", {
   			Parent = sliderFrame,
   			BackgroundTransparency = 1,
   			Position = UDim2.new(1, -50, 0, 0),
   			Size = UDim2.new(0, 50, 0, 20),
   			Font = Enum.Font.Gotham,
   			Text = tostring(config.default or config.min or 0),
   			TextColor3 = Color3.fromRGB(150, 150, 150),
   			TextSize = 12,
   			TextXAlignment = Enum.TextXAlignment.Right
   		})

   		local track = Create("Frame", {
   			Parent = sliderFrame,
   			BackgroundColor3 = Color3.fromRGB(60, 60, 60),
   			Position = UDim2.new(0, 0, 0, 30),
   			Size = UDim2.new(1, 0, 0, 4)
   		})

   		local trackCorner = Create("UICorner", {
   			Parent = track,
   			CornerRadius = UDim.new(0, 2)
   		})

   		local fill = Create("Frame", {
   			Parent = track,
   			BackgroundColor3 = config.color or Color3.fromRGB(100, 100, 255),
   			Size = UDim2.new(0, 0, 1, 0)
   		})

   		local fillCorner = Create("UICorner", {
   			Parent = fill,
   			CornerRadius = UDim.new(0, 2)
   		})

   		local handle = Create("Frame", {
   			Parent = track,
   			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
   			Position = UDim2.new(0, -6, 0.5, -6),
   			Size = UDim2.new(0, 12, 0, 12)
   		})

   		local handleCorner = Create("UICorner", {
   			Parent = handle,
   			CornerRadius = UDim.new(1, 0)
   		})

   		local min = config.min or 0
   		local max = config.max or 100
   		local value = config.default or min

   		local function UpdateSlider(input)
   			local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
   			value = min + (max - min) * pos
   			Tween(fill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.1)
   			Tween(handle, {Position = UDim2.new(pos, -6, 0.5, -6)}, 0.1)
   			valueLabel.Text = string.format("%.0f", value)
   			if config.callback then
   				config.callback(value)
   			end
   		end

   		local dragging = false

   		track.InputBegan:Connect(function(input)
   			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
   				dragging = true
   				UpdateSlider(input)
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

   		return {
   			Set = function(val)
   				value = math.clamp(val, min, max)
   				local pos = (value - min) / (max - min)
   				Tween(fill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.2)
   				Tween(handle, {Position = UDim2.new(pos, -6, 0.5, -6)}, 0.2)
   				valueLabel.Text = string.format("%.0f", value)
   			end,
   			Get = function()
   				return value
   			end
   		}
   	end

   	function tab:AddDropdown(config)
   		config = config or {}
   		local dropdownFrame = Create("Frame", {
   			Parent = self.Content,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 35),
   			ClipsDescendants = true
   		})

   		local label = Create("TextLabel", {
   			Parent = dropdownFrame,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 20),
   			Font = Enum.Font.Gotham,
   			Text = config.text or "Dropdown",
   			TextColor3 = Color3.fromRGB(255, 255, 255),
   			TextSize = 14,
   			TextXAlignment = Enum.TextXAlignment.Left
   		})

   		local dropdownButton = Create("TextButton", {
   			Parent = dropdownFrame,
   			BackgroundColor3 = Color3.fromRGB(45, 45, 45),
   			Position = UDim2.new(0, 0, 0, 22),
   			Size = UDim2.new(1, 0, 0, 35),
   			Font = Enum.Font.Gotham,
   			Text = "Select...",
   			TextColor3 = Color3.fromRGB(200, 200, 200),
   			TextSize = 13,
   			AutoButtonColor = false
   		})

   		local buttonCorner = Create("UICorner", {
   			Parent = dropdownButton,
   			CornerRadius = UDim.new(0, 6)
   		})

   		local arrow = Create("ImageLabel", {
   			Parent = dropdownButton,
   			BackgroundTransparency = 1,
   			Position = UDim2.new(1, -25, 0.5, -8),
   			Size = UDim2.new(0, 16, 0, 16),
   			Image = "rbxassetid://3926305904",
   			ImageRectOffset = Vector2.new(564, 284),
   			ImageRectSize = Vector2.new(36, 36),
   			ImageColor3 = Color3.fromRGB(150, 150, 150),
   			Rotation = 0
   		})

   		local listFrame = Create("Frame", {
   			Parent = dropdownFrame,
   			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
   			Position = UDim2.new(0, 0, 0, 60),
   			Size = UDim2.new(1, 0, 0, 0),
   			ClipsDescendants = true,
   			Visible = false
   		})

   		local listStroke = Create("UIStroke", {
   			Parent = listFrame,
   			Color = Color3.fromRGB(255, 255, 255),
   			Thickness = 1
   		})

   		local listCorner = Create("UICorner", {
   			Parent = listFrame,
   			CornerRadius = UDim.new(0, 6)
   		})

   		local searchBox = Create("TextBox", {
   			Parent = listFrame,
   			BackgroundColor3 = Color3.fromRGB(50, 50, 50),
   			Position = UDim2.new(0, 5, 0, 5),
   			Size = UDim2.new(1, -10, 0, 30),
   			Font = Enum.Font.Gotham,
   			PlaceholderText = "Search...",
   			Text = "",
   			TextColor3 = Color3.fromRGB(255, 255, 255),
   			TextSize = 12
   		})

   		local searchCorner = Create("UICorner", {
   			Parent = searchBox,
   			CornerRadius = UDim.new(0, 4)
   		})

   		local scrollFrame = Create("ScrollingFrame", {
   			Parent = listFrame,
   			BackgroundTransparency = 1,
   			Position = UDim2.new(0, 5, 0, 40),
   			Size = UDim2.new(1, -10, 1, -45),
   			ScrollBarThickness = 4,
   			ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
   		})

   		local listLayout = Create("UIListLayout", {
   			Parent = scrollFrame,
   			SortOrder = Enum.SortOrder.LayoutOrder,
   			Padding = UDim.new(0, 2)
   		})

   		local isOpen = false
   		local selected = nil
   		local options = config.options or {}

   		local function UpdateList()
   			for _, child in pairs(scrollFrame:GetChildren()) do
   				if child:IsA("TextButton") then
   					child:Destroy()
   				end
   			end

   			local searchText = searchBox.Text:lower()
   			local visibleCount = 0

   			for _, option in pairs(options) do
   				if option:lower():find(searchText) then
   					local optionButton = Create("TextButton", {
   						Parent = scrollFrame,
   						BackgroundColor3 = Color3.fromRGB(40, 40, 40),
   						Size = UDim2.new(1, 0, 0, 30),
   						Font = Enum.Font.Gotham,
   						Text = option,
   						TextColor3 = Color3.fromRGB(200, 200, 200),
   						TextSize = 12,
   						AutoButtonColor = false
   					})

   					optionButton.MouseEnter:Connect(function()
   						Tween(optionButton, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.2)
   					end)

   					optionButton.MouseLeave:Connect(function()
   						Tween(optionButton, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.2)
   					end)

   					optionButton.MouseButton1Click:Connect(function()
   						selected = option
   						dropdownButton.Text = option
   						Tween(listFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
   						Tween(arrow, {Rotation = 0}, 0.2)
   						isOpen = false
   						listFrame.Visible = false
   						if config.callback then
   							config.callback(option)
   						end
   					end)

   					visibleCount = visibleCount + 1
   				end
   			end

   			scrollFrame.CanvasSize = UDim2.new(0, 0, 0, visibleCount * 32)
   		end

   		searchBox:GetPropertyChangedSignal("Text"):Connect(UpdateList)

   		dropdownButton.MouseButton1Click:Connect(function()
   			isOpen = not isOpen
   			if isOpen then
   				listFrame.Visible = true
   				Tween(listFrame, {Size = UDim2.new(1, 0, 0, 150)}, 0.2)
   				Tween(arrow, {Rotation = 180}, 0.2)
   				UpdateList()
   			else
   				Tween(listFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
   				Tween(arrow, {Rotation = 0}, 0.2).Completed:Connect(function()
   					listFrame.Visible = false
   				end)
   			end
   		end)

   		return {
   			Set = function(value)
   				selected = value
   				dropdownButton.Text = value
   			end,
   			Get = function()
   				return selected
   			end,
   			Refresh = function(newOptions)
   				options = newOptions
   				if isOpen then
   					UpdateList()
   				end
   			end
   		}
   	end

   	function tab:AddInput(config)
   		config = config or {}
   		local inputFrame = Create("Frame", {
   			Parent = self.Content,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 60)
   		})

   		local label = Create("TextLabel", {
   			Parent = inputFrame,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 20),
   			Font = Enum.Font.Gotham,
   			Text = config.text or "Input",
   			TextColor3 = Color3.fromRGB(255, 255, 255),
   			TextSize = 14,
   			TextXAlignment = Enum.TextXAlignment.Left
   		})

   		local textBox = Create("TextBox", {
   			Parent = inputFrame,
   			BackgroundColor3 = Color3.fromRGB(35, 35, 35),
   			Position = UDim2.new(0, 0, 0, 22),
   			Size = UDim2.new(1, 0, 0, 35),
   			Font = Enum.Font.Code,
   			PlaceholderText = config.placeholder or "Enter text...",
   			Text = "",
   			TextColor3 = Color3.fromRGB(255, 255, 255),
   			TextSize = 13,
   			ClearTextOnFocus = false
   		})

   		local boxCorner = Create("UICorner", {
   			Parent = textBox,
   			CornerRadius = UDim.new(0, 6)
   		})

   		local boxStroke = Create("UIStroke", {
   			Parent = textBox,
   			Color = Color3.fromRGB(60, 60, 60),
   			Thickness = 1
   		})

   		textBox.Focused:Connect(function()
   			Tween(boxStroke, {Color = Color3.fromRGB(100, 100, 255)}, 0.2)
   		end)

   		textBox.FocusLost:Connect(function()
   			Tween(boxStroke, {Color = Color3.fromRGB(60, 60, 60)}, 0.2)
   			if config.callback then
   				config.callback(textBox.Text)
   			end
   		end)

   		return {
   			Set = function(text)
   				textBox.Text = text
   			end,
   			Get = function()
   				return textBox.Text
   			end
   		}
   	end

   	function tab:AddKeybind(config)
   		config = config or {}
   		local keybindFrame = Create("Frame", {
   			Parent = self.Content,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 35)
   		})

   		local label = Create("TextLabel", {
   			Parent = keybindFrame,
   			BackgroundTransparency = 1,
   			Position = UDim2.new(0, 0, 0, 7),
   			Size = UDim2.new(0.6, 0, 0, 20),
   			Font = Enum.Font.Gotham,
   			Text = config.text or "Keybind",
   			TextColor3 = Color3.fromRGB(255, 255, 255),
   			TextSize = 14,
   			TextXAlignment = Enum.TextXAlignment.Left
   		})

   		local keyButton = Create("TextButton", {
   			Parent = keybindFrame,
   			BackgroundColor3 = Color3.fromRGB(45, 45, 45),
   			Position = UDim2.new(1, -80, 0, 0),
   			Size = UDim2.new(0, 80, 1, 0),
   			Font = Enum.Font.GothamBold,
   			Text = config.default and config.default.Name or "None",
   			TextColor3 = Color3.fromRGB(200, 200, 200),
   			TextSize = 12,
   			AutoButtonColor = false
   		})

   		local keyCorner = Create("UICorner", {
   			Parent = keyButton,
   			CornerRadius = UDim.new(0, 6)
   		})

   		local listening = false
   		local currentKey = config.default

   		keyButton.MouseButton1Click:Connect(function()
   			listening = true
   			keyButton.Text = "..."
   			Tween(keyButton, {BackgroundColor3 = Color3.fromRGB(60, 60, 100)}, 0.2)
   		end)

   		UserInputService.InputBegan:Connect(function(input, gameProcessed)
   			if listening and not gameProcessed then
   				if input.UserInputType == Enum.UserInputType.Keyboard then
   					currentKey = input.KeyCode
   					keyButton.Text = input.KeyCode.Name
   					listening = false
   					Tween(keyButton, {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}, 0.2)
   					if config.callback then
   						config.callback(input.KeyCode)
   					end
   				end
   			elseif currentKey and input.KeyCode == currentKey and not gameProcessed then
   				if config.onPress then
   					config.onPress()
   				end
   			end
   		end)

   		return {
   			Set = function(key)
   				currentKey = key
   				keyButton.Text = key.Name
   			end,
   			Get = function()
   				return currentKey
   			end
   		}
   	end

   	function tab:AddColorPicker(config)
   		config = config or {}
   		local pickerFrame = Create("Frame", {
   			Parent = self.Content,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, 40)
   		})

   		local label = Create("TextLabel", {
   			Parent = pickerFrame,
   			BackgroundTransparency = 1,
   			Position = UDim2.new(0, 0, 0, 10),
   			Size = UDim2.new(0.7, 0, 0, 20),
   			Font = Enum.Font.Gotham,
   			Text = config.text or "Color",
   			TextColor3 = Color3.fromRGB(255, 255, 255),
   			TextSize = 14,
   			TextXAlignment = Enum.TextXAlignment.Left
   		})

   		local preview = Create("TextButton", {
   			Parent = pickerFrame,
   			BackgroundColor3 = config.default or Color3.fromRGB(255, 255, 255),
   			Position = UDim2.new(1, -40, 0, 5),
   			Size = UDim2.new(0, 40, 0, 30),
   			Text = "",
   			AutoButtonColor = false
   		})

   		local previewCorner = Create("UICorner", {
   			Parent = preview,
   			CornerRadius = UDim.new(0, 6)
   		})

   		local pickerContainer = Create("Frame", {
   			Parent = pickerFrame,
   			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
   			Position = UDim2.new(0, 0, 0, 45),
   			Size = UDim2.new(1, 0, 0, 0),
   			ClipsDescendants = true,
   			Visible = false,
   			ZIndex = 10
   		})

   		local containerStroke = Create("UIStroke", {
   			Parent = pickerContainer,
   			Color = Color3.fromRGB(255, 255, 255),
   			Thickness = 1
   		})

   		local containerCorner = Create("UICorner", {
   			Parent = pickerContainer,
   			CornerRadius = UDim.new(0, 6)
   		})

   		local hueFrame = Create("Frame", {
   			Parent = pickerContainer,
   			BackgroundColor3 = Color3.fromRGB(255, 0, 0),
   			Position = UDim2.new(0, 10, 0, 10),
   			Size = UDim2.new(1, -80, 0, 100),
   			ZIndex = 11
   		})

   		local hueCorner = Create("UICorner", {
   			Parent = hueFrame,
   			CornerRadius = UDim.new(0, 4)
   		})

   		local saturationFrame = Create("Frame", {
   			Parent = hueFrame,
   			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
   			BackgroundTransparency = 0,
   			Size = UDim2.new(1, 0, 1, 0),
   			ZIndex = 12
   		})

   		local saturationGradient = Create("UIGradient", {
   			Parent = saturationFrame,
   			Color = ColorSequence.new{
   				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
   				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
   			},
   			Transparency = NumberSequence.new{
   				NumberSequenceKeypoint.new(0, 0),
   				NumberSequenceKeypoint.new(1, 1)
   			}
   		})

   		local valueFrame = Create("Frame", {
   			Parent = hueFrame,
   			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
   			BackgroundTransparency = 0,
   			Size = UDim2.new(1, 0, 1, 0),
   			ZIndex = 13
   		})

   		local valueGradient = Create("UIGradient", {
   			Parent = valueFrame,
   			Color = ColorSequence.new{
   				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
   				ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
   			},
   			Transparency = NumberSequence.new{
   				NumberSequenceKeypoint.new(0, 1),
   				NumberSequenceKeypoint.new(1, 0)
   			}
   		})

   		local selector = Create("Frame", {
   			Parent = hueFrame,
   			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
   			BorderSizePixel = 0,
   			Position = UDim2.new(0, -5, 0, -5),
   			Size = UDim2.new(0, 10, 0, 10),
   			ZIndex = 14
   		})

   		local selectorCorner = Create("UICorner", {
   			Parent = selector,
   			CornerRadius = UDim.new(1, 0)
   		})

   		local selectorStroke = Create("UIStroke", {
   			Parent = selector,
   			Color = Color3.fromRGB(0, 0, 0),
   			Thickness = 1
   		})

   		local hueSlider = Create("Frame", {
   			Parent = pickerContainer,
   			BackgroundColor3 = Color3.fromRGB(60, 60, 60),
   			Position = UDim2.new(1, -60, 0, 10),
   			Size = UDim2.new(0, 20, 0, 100),
   			ZIndex = 11
   		})

   		local hueSliderCorner = Create("UICorner", {
   			Parent = hueSlider,
   			CornerRadius = UDim.new(0, 4)
   		})

   		local hueGradient = Create("UIGradient", {
   			Parent = hueSlider,
   			Color = ColorSequence.new{
   				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
   				ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
   				ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
   				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
   				ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
   				ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
   				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
   			},
   			Rotation = 90
   		})

   		local hueSelector = Create("Frame", {
   			Parent = hueSlider,
   			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
   			BorderSizePixel = 0,
   			Position = UDim2.new(-0.2, 0, 0, -2),
   			Size = UDim2.new(1.4, 0, 0, 4),
   			ZIndex = 12
   		})

   		local hueSelectorCorner = Create("UICorner", {
   			Parent = hueSelector,
   			CornerRadius = UDim.new(0, 2)
   		})

   		local isOpen = false
   		local hue = 0
   		local sat = 1
   		local val = 1

   		local function UpdateColor()
   			local color = Color3.fromHSV(hue, sat, val)
   			preview.BackgroundColor3 = color
   			hueFrame.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
   			if config.callback then
   				config.callback(color)
   			end
   		end

   		local function UpdateFromPosition(x, y)
   			sat = math.clamp(x / hueFrame.AbsoluteSize.X, 0, 1)
   			val = 1 - math.clamp(y / hueFrame.AbsoluteSize.Y, 0, 1)
   			Tween(selector, {Position = UDim2.new(0, x - 5, 0, y - 5)}, 0.1)
   			UpdateColor()
   		end

   		local hueDragging = false
   		local svDragging = false

   		hueSlider.InputBegan:Connect(function(input)
   			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
   				hueDragging = true
   				local y = math.clamp(input.Position.Y - hueSlider.AbsolutePosition.Y, 0, hueSlider.AbsoluteSize.Y)
   				hue = 1 - (y / hueSlider.AbsoluteSize.Y)
   				Tween(hueSelector, {Position = UDim2.new(-0.2, 0, 0, y - 2)}, 0.1)
   				UpdateColor()
   			end
   		end)

   		hueFrame.InputBegan:Connect(function(input)
   			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
   				svDragging = true
   				local x = math.clamp(input.Position.X - hueFrame.AbsolutePosition.X, 0, hueFrame.AbsoluteSize.X)
   				local y = math.clamp(input.Position.Y - hueFrame.AbsolutePosition.Y, 0, hueFrame.AbsoluteSize.Y)
   				UpdateFromPosition(x, y)
   			end
   		end)

   		UserInputService.InputChanged:Connect(function(input)
   			if hueDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
   				local y = math.clamp(input.Position.Y - hueSlider.AbsolutePosition.Y, 0, hueSlider.AbsoluteSize.Y)
   				hue = 1 - (y / hueSlider.AbsoluteSize.Y)
   				Tween(hueSelector, {Position = UDim2.new(-0.2, 0, 0, y - 2)}, 0.1)
   				UpdateColor()
   			elseif svDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
   				local x = math.clamp(input.Position.X - hueFrame.AbsolutePosition.X, 0, hueFrame.AbsoluteSize.X)
   				local y = math.clamp(input.Position.Y - hueFrame.AbsolutePosition.Y, 0, hueFrame.AbsoluteSize.Y)
   				UpdateFromPosition(x, y)
   			end
   		end)

   		UserInputService.InputEnded:Connect(function(input)
   			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
   				hueDragging = false
   				svDragging = false
   			end
   		end)

   		preview.MouseButton1Click:Connect(function()
   			isOpen = not isOpen
   			if isOpen then
   				pickerContainer.Visible = true
   				Tween(pickerContainer, {Size = UDim2.new(1, 0, 0, 120)}, 0.2)
   				Tween(pickerFrame, {Size = UDim2.new(1, 0, 0, 165)}, 0.2)
   			else
   				Tween(pickerContainer, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
   				Tween(pickerFrame, {Size = UDim2.new(1, 0, 0, 40)}, 0.2).Completed:Connect(function()
   					pickerContainer.Visible = false
   				end)
   			end
   		end)

   		return {
   			Set = function(color)
   				local h, s, v = color:ToHSV()
   				hue, sat, val = h, s, v
   				preview.BackgroundColor3 = color
   				Tween(hueSelector, {Position = UDim2.new(-0.2, 0, 0, (1 - h) * 100 - 2)}, 0.2)
   				Tween(selector, {Position = UDim2.new(0, s * hueFrame.AbsoluteSize.X - 5, 0, (1 - v) * hueFrame.AbsoluteSize.Y - 5)}, 0.2)
   				hueFrame.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
   			end,
   			Get = function()
   				return Color3.fromHSV(hue, sat, val)
   			end
   		}
   	end

   	function tab:AddImage(config)
   		config = config or {}
   		local imageFrame = Create("Frame", {
   			Parent = self.Content,
   			BackgroundTransparency = 1,
   			Size = UDim2.new(1, 0, 0, config.height or 150)
   		})

   		local imageLabel = Create("ImageLabel", {
   			Parent = imageFrame,
   			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
   			Size = UDim2.new(1, 0, 1, 0),
   			Image = config.image or "",
   			ScaleType = Enum.ScaleType.Fit
   		})

   		local imageCorner = Create("UICorner", {
   			Parent = imageLabel,
   			CornerRadius = UDim.new(0, 8)
   		})

   		if config.clickable then
   			local clickButton = Create("TextButton", {
   				Parent = imageLabel,
   				BackgroundTransparency = 1,
   				Size = UDim2.new(1, 0, 1, 0),
   				Text = ""
   			})

   			clickButton.MouseButton1Click:Connect(function()
   				Tween(imageLabel, {Size = UDim2.new(0.95, 0, 0.95, 0), Position = UDim2.new(0.025, 0, 0.025, 0)}, 0.1).Completed:Connect(function()
   					Tween(imageLabel, {Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0)}, 0.1)
   				end)
   				if config.callback then
   					config.callback()
   				end
   			end)
   		end

   		return imageLabel
   	end

   	return tab
   end

   function window:SwitchTab(tab)
   	if self.CurrentTab == tab then return end
   	
   	if self.CurrentTab then
   		Tween(self.CurrentTab.Indicator, {BackgroundTransparency = 1}, 0.2)
   		Tween(self.CurrentTab.Icon, {ImageColor3 = Color3.fromRGB(150, 150, 150)}, 0.2)
   		Tween(self.CurrentTab.Content, {Position = UDim2.new(0, 20, 0, 0), BackgroundTransparency = 1}, 0.2).Completed:Connect(function()
   			self.CurrentTab.Content.Visible = false
   		end)
   	end

   	self.CurrentTab = tab
   	tab.Content.Position = UDim2.new(0, -20, 0, 0)
   	tab.Content.Visible = true
   	Tween(tab.Indicator, {BackgroundTransparency = 0}, 0.2)
   	Tween(tab.Icon, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
   	Tween(tab.Content, {Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.3)
   end

   function window:Notify(config)
   	config = config or {}
   	local notification = Create("Frame", {
   		Parent = self.ScreenGui,
   		BackgroundColor3 = Color3.fromRGB(40, 40, 40),
   		Size = UDim2.new(0, 250, 0, 80),
   		Position = UDim2.new(0, -300, 0, 0),
   		ZIndex = 1000
   	})

   	local notifCorner = Create("UICorner", {
   		Parent = notification,
   		CornerRadius = UDim.new(0, 8)
   	})

   	local notifStroke = Create("UIStroke", {
   		Parent = notification,
   		Color = Color3.fromRGB(255, 255, 255),
   		Thickness = 1
   	})

   	local notifShadow = Create("ImageLabel", {
   		Name = "Shadow",
   		Parent = notification,
   		BackgroundTransparency = 1,
   		Position = UDim2.new(0, -10, 0, -10),
   		Size = UDim2.new(1, 20, 1, 20),
   		Image = "rbxassetid://1316045217",
   		ImageColor3 = Color3.fromRGB(0, 0, 0),
   		ImageTransparency = 0.7,
   		ScaleType = Enum.ScaleType.Slice,
   		SliceCenter = Rect.new(10, 10, 118, 118),
   		ZIndex = -1
   	})

   	local icon = Create("ImageLabel", {
   		Parent = notification,
   		BackgroundTransparency = 1,
   		Position = UDim2.new(0, 15, 0, 15),
   		Size = UDim2.new(0, 50, 0, 50),
   		Image = config.icon or "rbxassetid://3926305904",
   		ImageRectOffset = Vector2.new(364, 324),
   		ImageRectSize = Vector2.new(36, 36),
   		ImageColor3 = config.color or Color3.fromRGB(100, 100, 255)
   	})

   	local title = Create("TextLabel", {
   		Parent = notification,
   		BackgroundTransparency = 1,
   		Position = UDim2.new(0, 75, 0, 15),
   		Size = UDim2.new(1, -90, 0, 20),
   		Font = Enum.Font.GothamBold,
   		Text = config.title or "Notification",
   		TextColor3 = Color3.fromRGB(255, 255, 255),
   		TextSize = 14,
   		TextXAlignment = Enum.TextXAlignment.Left
   	})

   	local message = Create("TextLabel", {
   		Parent = notification,
   		BackgroundTransparency = 1,
   		Position = UDim2.new(0, 75, 0, 38),
   		Size = UDim2.new(1, -90, 0, 30),
   		Font = Enum.Font.Gotham,
   		Text = config.text or "This is a notification",
   		TextColor3 = Color3.fromRGB(200, 200, 200),
   		TextSize = 12,
   		TextWrapped = true,
   		TextXAlignment = Enum.TextXAlignment.Left
   	})

   	local closeButton = Create("TextButton", {
   		Parent = notification,
   		BackgroundTransparency = 1,
   		Position = UDim2.new(1, -25, 0, 5),
   		Size = UDim2.new(0, 20, 0, 20),
   		Font = Enum.Font.GothamBold,
   		Text = "X",
   		TextColor3 = Color3.fromRGB(150, 150, 150),
   		TextSize = 14
   	})

   	closeButton.MouseEnter:Connect(function()
   		Tween(closeButton, {TextColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
   	end)

   	closeButton.MouseLeave:Connect(function()
   		Tween(closeButton, {TextColor3 = Color3.fromRGB(150, 150, 150)}, 0.2)
   	end)

   	local position = config.position or "top-right"
   	local posX, posY

   	if position == "top-right" then
   		posX, posY = 1, 0
   	elseif position == "top-left" then
   		posX, posY = 0, 0
   	elseif position == "bottom-right" then
   		posX, posY = 1, 1
   	elseif position == "bottom-left" then
   		posX, posY = 0, 1
   	end

   	notification.Position = UDim2.new(posX, position:find("right") and 20 or -270, posY, position:find("bottom") and -90 or 20)

   	Tween(notification, {Position = UDim2.new(posX, position:find("right") and -270 or 20, posY, position:find("bottom") and -90 or 20)}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

   	local function CloseNotification()
   		Tween(notification, {Position = UDim2.new(posX, position:find("right") and 20 or -270, posY, notification.Position.Y.Offset)}, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In).Completed:Connect(function()
   			notification:Destroy()
   		end)
   	end

   	closeButton.MouseButton1Click:Connect(CloseNotification)

   	if config.duration then
   		task.delay(config.duration, CloseNotification)
   	end
   end

   return window
end

return RiftUI
