local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Players          = game:GetService("Players")

local lp = Players.LocalPlayer

local function tw(o, p, d, s, e)
	local t = TweenService:Create(o, TweenInfo.new(d or 0.22, s or Enum.EasingStyle.Quart, e or Enum.EasingDirection.Out), p)
	t:Play()
	return t
end

local function draggable(handle, frame)
	local on, o, sp = false, nil, nil
	handle.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			on = true; o = i.Position; sp = frame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if on and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local d = i.Position - o
			frame.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then on = false end
	end)
end

local function mkCorner(r, p)  local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,r); c.Parent = p; return c end
local function mkStroke(c,t,p) local s = Instance.new("UIStroke"); s.Color=c; s.Thickness=t; s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border; s.Parent=p; return s end
local function mkPad(t,b,l,r,p) local u=Instance.new("UIPadding"); u.PaddingTop=UDim.new(0,t); u.PaddingBottom=UDim.new(0,b); u.PaddingLeft=UDim.new(0,l); u.PaddingRight=UDim.new(0,r); u.Parent=p; return u end
local function mkGrad(a,b,rot,p) local g=Instance.new("UIGradient"); g.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,a),ColorSequenceKeypoint.new(1,b)}; g.Rotation=rot; g.Parent=p; return g end

local C = {
	BG         = Color3.fromRGB(10, 11, 15),
	SURFACE    = Color3.fromRGB(15, 17, 23),
	PANEL      = Color3.fromRGB(18, 21, 29),
	ELEVATED   = Color3.fromRGB(22, 26, 36),
	CARD       = Color3.fromRGB(24, 28, 40),
	CARD2      = Color3.fromRGB(27, 32, 46),
	HOVER      = Color3.fromRGB(31, 37, 54),
	ACCENT     = Color3.fromRGB(59, 130, 246),
	ACCENT_B   = Color3.fromRGB(37,  99, 235),
	ACCENT_LT  = Color3.fromRGB(147, 197, 253),
	ACCENT_DIM = Color3.fromRGB(30,  64, 175),
	GREEN      = Color3.fromRGB(52, 211, 153),
	GREEN_B    = Color3.fromRGB(16, 185, 129),
	GREEN_DIM  = Color3.fromRGB(6,  120,  80),
	RED        = Color3.fromRGB(248, 113, 113),
	TEXT       = Color3.fromRGB(236, 240, 255),
	TEXT_DIM   = Color3.fromRGB(148, 160, 196),
	TEXT_MUTED = Color3.fromRGB(72,   82, 112),
	STROKE     = Color3.fromRGB(34,   40,  58),
	STROKE_MED = Color3.fromRGB(48,   58,  84),
	STROKE_HI  = Color3.fromRGB(59,  130, 246),
	KNOB       = Color3.fromRGB(248, 250, 255),
	TRACK_OFF  = Color3.fromRGB(34,   40,  58),
}

local Nexo = {}
Nexo.__index = Nexo

local Tab = {}
Tab.__index = Tab

function Nexo.new(cfg)
	local self     = setmetatable({}, Nexo)
	self.cfg       = cfg
	self.tabs      = {}
	self.active    = nil
	self.visible   = true

	local sg = Instance.new("ScreenGui")
	sg.Name           = "NexoUI"
	sg.ResetOnSpawn   = false
	sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	sg.IgnoreGuiInset = true
	sg.DisplayOrder   = 1000
	sg.Parent         = lp:WaitForChild("PlayerGui")
	self.sg = sg

	local sz   = cfg.size or UDim2.fromOffset(520, 400)
	local W, H = sz.X.Offset, sz.Y.Offset

	local shadow = Instance.new("Frame")
	shadow.Size             = UDim2.fromOffset(W + 40, H + 40)
	shadow.Position         = UDim2.new(0.5, -math.floor((W+40)/2), 0.5, -math.floor((H+40)/2))
	shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	shadow.BackgroundTransparency = 0.5
	shadow.BorderSizePixel  = 0
	shadow.ZIndex           = 0
	shadow.Parent           = sg
	self.shadow = shadow
	mkCorner(22, shadow)

	local mf = Instance.new("Frame")
	mf.Name             = "NexoWindow"
	mf.Size             = UDim2.fromOffset(W, H)
	mf.Position         = UDim2.new(0.5, -math.floor(W/2), 0.5, -math.floor(H/2))
	mf.BackgroundColor3 = C.BG
	mf.BorderSizePixel  = 0
	mf.ClipsDescendants = true
	mf.ZIndex           = 1
	mf.Parent           = sg
	self.mf = mf
	mkCorner(16, mf)
	mkStroke(C.STROKE_MED, 1, mf)

	local accentBar = Instance.new("Frame")
	accentBar.Size            = UDim2.new(1, 0, 0, 2)
	accentBar.BackgroundColor3 = C.ACCENT
	accentBar.BorderSizePixel = 0
	accentBar.ZIndex          = 10
	accentBar.Parent          = mf
	mkGrad(C.ACCENT_LT, C.ACCENT_B, 90, accentBar)

	local hdr = Instance.new("Frame")
	hdr.Name             = "Header"
	hdr.Size             = UDim2.new(1, 0, 0, 58)
	hdr.Position         = UDim2.new(0, 0, 0, 2)
	hdr.BackgroundColor3 = C.SURFACE
	hdr.BorderSizePixel  = 0
	hdr.ZIndex           = 2
	hdr.Parent           = mf
	self.hdr = hdr
	mkCorner(16, hdr)

	local hdrFix = Instance.new("Frame")
	hdrFix.Size             = UDim2.new(1, 0, 0, 16)
	hdrFix.Position         = UDim2.new(0, 0, 1, -16)
	hdrFix.BackgroundColor3 = C.SURFACE
	hdrFix.BorderSizePixel  = 0
	hdrFix.ZIndex           = 2
	hdrFix.Parent           = hdr

	local hdrLine = Instance.new("Frame")
	hdrLine.Size             = UDim2.new(1, 0, 0, 1)
	hdrLine.Position         = UDim2.new(0, 0, 1, 0)
	hdrLine.BackgroundColor3 = C.STROKE
	hdrLine.BorderSizePixel  = 0
	hdrLine.ZIndex           = 3
	hdrLine.Parent           = hdr

	draggable(hdr, mf)

	local logoWrap = Instance.new("Frame")
	logoWrap.Size             = UDim2.fromOffset(36, 36)
	logoWrap.Position         = UDim2.new(0, 14, 0.5, -18)
	logoWrap.BackgroundColor3 = C.ACCENT_B
	logoWrap.BorderSizePixel  = 0
	logoWrap.ZIndex           = 4
	logoWrap.Parent           = hdr
	mkCorner(10, logoWrap)
	mkGrad(C.ACCENT_LT, C.ACCENT_B, 135, logoWrap)

	local logoImg = Instance.new("ImageLabel")
	logoImg.Size               = UDim2.fromOffset(22, 22)
	logoImg.Position           = UDim2.new(0.5, -11, 0.5, -11)
	logoImg.BackgroundTransparency = 1
	logoImg.Image              = cfg.icon or ""
	logoImg.ImageColor3        = Color3.fromRGB(255, 255, 255)
	logoImg.ZIndex             = 5
	logoImg.Parent             = logoWrap

	local titleLbl = Instance.new("TextLabel")
	titleLbl.Size             = UDim2.new(0, 220, 0, 22)
	titleLbl.Position         = UDim2.new(0, 58, 0, 9)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Text             = cfg.title or "Nexo Library"
	titleLbl.TextColor3       = C.TEXT
	titleLbl.Font             = Enum.Font.GothamBold
	titleLbl.TextSize         = 15
	titleLbl.TextXAlignment   = Enum.TextXAlignment.Left
	titleLbl.ZIndex           = 4
	titleLbl.Parent           = hdr

	local subLbl = Instance.new("TextLabel")
	subLbl.Size             = UDim2.new(0, 220, 0, 14)
	subLbl.Position         = UDim2.new(0, 58, 0, 33)
	subLbl.BackgroundTransparency = 1
	subLbl.Text             = cfg.subtitle or ""
	subLbl.TextColor3       = C.TEXT_MUTED
	subLbl.Font             = Enum.Font.Gotham
	subLbl.TextSize         = 11
	subLbl.TextXAlignment   = Enum.TextXAlignment.Left
	subLbl.ZIndex           = 4
	subLbl.Parent           = hdr

	local verBadge = Instance.new("Frame")
	verBadge.Size             = UDim2.fromOffset(46, 20)
	verBadge.Position         = UDim2.new(1, -124, 0.5, -10)
	verBadge.BackgroundColor3 = Color3.fromRGB(15, 30, 60)
	verBadge.BorderSizePixel  = 0
	verBadge.ZIndex           = 4
	verBadge.Parent           = hdr
	mkCorner(10, verBadge)
	mkStroke(C.ACCENT, 1, verBadge)

	local verTxt = Instance.new("TextLabel")
	verTxt.Size               = UDim2.fromScale(1, 1)
	verTxt.BackgroundTransparency = 1
	verTxt.Text               = "v3.0"
	verTxt.TextColor3         = C.ACCENT_LT
	verTxt.Font               = Enum.Font.GothamBold
	verTxt.TextSize           = 10
	verTxt.ZIndex             = 5
	verTxt.Parent             = verBadge

	local closeBtn = Instance.new("TextButton")
	closeBtn.Size             = UDim2.fromOffset(30, 30)
	closeBtn.Position         = UDim2.new(1, -46, 0.5, -15)
	closeBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
	closeBtn.Text             = ""
	closeBtn.AutoButtonColor  = false
	closeBtn.ZIndex           = 4
	closeBtn.Parent           = hdr
	mkCorner(8, closeBtn)
	mkStroke(Color3.fromRGB(80, 40, 50), 1, closeBtn)

	local closeX = Instance.new("TextLabel")
	closeX.Size               = UDim2.fromScale(1, 1)
	closeX.BackgroundTransparency = 1
	closeX.Text               = "✕"
	closeX.TextColor3         = C.RED
	closeX.Font               = Enum.Font.GothamBold
	closeX.TextSize           = 12
	closeX.ZIndex             = 5
	closeX.Parent             = closeBtn

	local body = Instance.new("Frame")
	body.Size                 = UDim2.new(1, 0, 1, -60)
	body.Position             = UDim2.new(0, 0, 0, 60)
	body.BackgroundTransparency = 1
	body.Parent               = mf

	local tabCol = Instance.new("Frame")
	tabCol.Name               = "TabColumn"
	tabCol.Size               = UDim2.new(0, 118, 1, 0)
	tabCol.BackgroundColor3   = C.PANEL
	tabCol.BorderSizePixel    = 0
	tabCol.Parent             = body
	self.tlist = tabCol

	local tabColSep = Instance.new("Frame")
	tabColSep.Size            = UDim2.new(0, 1, 1, 0)
	tabColSep.Position        = UDim2.new(1, -1, 0, 0)
	tabColSep.BackgroundColor3 = C.STROKE
	tabColSep.BorderSizePixel = 0
	tabColSep.Parent          = tabCol

	local tabLayout = Instance.new("UIListLayout")
	tabLayout.FillDirection         = Enum.FillDirection.Vertical
	tabLayout.HorizontalAlignment   = Enum.HorizontalAlignment.Left
	tabLayout.Padding               = UDim.new(0, 3)
	tabLayout.Parent                = tabCol
	mkPad(12, 8, 0, 0, tabCol)

	local contentCol = Instance.new("Frame")
	contentCol.Name               = "ContentColumn"
	contentCol.Size               = UDim2.new(1, -118, 1, 0)
	contentCol.Position           = UDim2.new(0, 118, 0, 0)
	contentCol.BackgroundColor3   = C.BG
	contentCol.BorderSizePixel    = 0
	contentCol.ClipsDescendants   = true
	contentCol.Parent             = body
	self.ca = contentCol

	local flt = Instance.new("ImageButton")
	flt.Name                  = "NexoFloatBtn"
	flt.Size                  = UDim2.fromOffset(52, 52)
	flt.Position              = UDim2.new(0, 18, 1, -74)
	flt.BackgroundColor3      = C.ACCENT_B
	flt.Image                 = cfg.icon or ""
	flt.ImageColor3           = Color3.fromRGB(255, 255, 255)
	flt.AutoButtonColor       = false
	flt.ZIndex                = 6
	flt.Parent                = sg
	mkCorner(14, flt)
	mkStroke(C.ACCENT_LT, 1.5, flt)
	mkGrad(C.ACCENT_LT, C.ACCENT_B, 135, flt)

	draggable(flt, flt)

	local fltCS
	flt.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			fltCS = i.Position
		end
	end)
	flt.InputEnded:Connect(function(i)
		if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and fltCS then
			if (i.Position - fltCS).Magnitude < 8 then self:Toggle() end
		end
	end)
	flt.MouseEnter:Connect(function()
		tw(flt, {Size = UDim2.fromOffset(56, 56), Position = UDim2.new(0, 16, 1, -76)}, 0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	end)
	flt.MouseLeave:Connect(function()
		tw(flt, {Size = UDim2.fromOffset(52, 52), Position = UDim2.new(0, 18, 1, -74)}, 0.18)
	end)

	closeBtn.MouseButton1Click:Connect(function() self:Toggle() end)
	closeBtn.MouseEnter:Connect(function() tw(closeBtn, {BackgroundColor3 = Color3.fromRGB(65, 30, 38)}, 0.15) end)
	closeBtn.MouseLeave:Connect(function() tw(closeBtn, {BackgroundColor3 = Color3.fromRGB(40, 25, 30)}, 0.15) end)

	return self
end

function Nexo:Toggle()
	self.visible = not self.visible
	if self.visible then
		self.mf.GroupTransparency     = 1
		self.shadow.BackgroundTransparency = 1
		self.mf.Visible     = true
		self.shadow.Visible = true
		tw(self.mf,     {GroupTransparency = 0},   0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		tw(self.shadow, {BackgroundTransparency = 0.5}, 0.3)
	else
		local t = tw(self.mf, {GroupTransparency = 1}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
		tw(self.shadow, {BackgroundTransparency = 1}, 0.22)
		t.Completed:Connect(function()
			if not self.visible then
				self.mf.Visible     = false
				self.shadow.Visible = false
			end
		end)
	end
end

function Nexo:CreateTab(name)
	local lib = self

	local tbtn = Instance.new("TextButton")
	tbtn.Name             = "NTab_" .. name
	tbtn.Size             = UDim2.new(1, 0, 0, 38)
	tbtn.BackgroundColor3 = C.PANEL
	tbtn.Text             = ""
	tbtn.AutoButtonColor  = false
	tbtn.BorderSizePixel  = 0
	tbtn.Parent           = self.tlist

	local ind = Instance.new("Frame")
	ind.Size                 = UDim2.new(0, 3, 1, -12)
	ind.AnchorPoint          = Vector2.new(0, 0.5)
	ind.Position             = UDim2.new(0, 0, 0.5, 0)
	ind.BackgroundColor3     = C.ACCENT
	ind.BorderSizePixel      = 0
	ind.BackgroundTransparency = 1
	ind.Parent               = tbtn
	mkCorner(2, ind)

	local indGlow = Instance.new("Frame")
	indGlow.Size                 = UDim2.new(0, 16, 1, -12)
	indGlow.AnchorPoint          = Vector2.new(0, 0.5)
	indGlow.Position             = UDim2.new(0, 0, 0.5, 0)
	indGlow.BackgroundColor3     = C.ACCENT
	indGlow.BackgroundTransparency = 1
	indGlow.BorderSizePixel      = 0
	indGlow.Parent               = tbtn
	mkGrad(C.ACCENT, Color3.fromRGB(0,0,0), 90, indGlow)

	local activeBg = Instance.new("Frame")
	activeBg.Size                 = UDim2.fromScale(1, 1)
	activeBg.BackgroundColor3     = C.ELEVATED
	activeBg.BackgroundTransparency = 1
	activeBg.BorderSizePixel      = 0
	activeBg.ZIndex               = 0
	activeBg.Parent               = tbtn

	local ttxt = Instance.new("TextLabel")
	ttxt.Size             = UDim2.new(1, -20, 1, 0)
	ttxt.Position         = UDim2.new(0, 18, 0, 0)
	ttxt.BackgroundTransparency = 1
	ttxt.Text             = name
	ttxt.TextColor3       = C.TEXT_MUTED
	ttxt.Font             = Enum.Font.Gotham
	ttxt.TextSize         = 12
	ttxt.TextXAlignment   = Enum.TextXAlignment.Left
	ttxt.ZIndex           = 2
	ttxt.Parent           = tbtn

	local cf = Instance.new("ScrollingFrame")
	cf.Name                = "NContent_" .. name
	cf.Size                = UDim2.fromScale(1, 1)
	cf.BackgroundTransparency = 1
	cf.BorderSizePixel     = 0
	cf.ScrollBarThickness  = 3
	cf.ScrollBarImageColor3 = C.ACCENT
	cf.CanvasSize          = UDim2.new(0, 0, 0, 0)
	cf.AutomaticCanvasSize = Enum.AutomaticSize.Y
	cf.ScrollingDirection  = Enum.ScrollingDirection.Y
	cf.Visible             = false
	cf.ClipsDescendants    = true
	cf.Parent              = self.ca

	local cfl = Instance.new("UIListLayout")
	cfl.FillDirection       = Enum.FillDirection.Vertical
	cfl.HorizontalAlignment = Enum.HorizontalAlignment.Center
	cfl.Padding             = UDim.new(0, 7)
	cfl.Parent              = cf
	mkPad(12, 12, 12, 12, cf)

	local tab = setmetatable({
		button        = tbtn,
		content       = cf,
		indicator     = ind,
		indicatorGlow = indGlow,
		activeBg      = activeBg,
		text          = ttxt,
		name          = name,
	}, Tab)

	table.insert(self.tabs, tab)
	if #self.tabs == 1 then self:_select(tab) end

	tbtn.MouseButton1Click:Connect(function() lib:_select(tab) end)
	tbtn.MouseEnter:Connect(function()
		if lib.active ~= tab then
			tw(ttxt,     {TextColor3 = C.TEXT_DIM}, 0.15)
			tw(activeBg, {BackgroundTransparency = 0.8}, 0.15)
		end
	end)
	tbtn.MouseLeave:Connect(function()
		if lib.active ~= tab then
			tw(ttxt,     {TextColor3 = C.TEXT_MUTED}, 0.15)
			tw(activeBg, {BackgroundTransparency = 1}, 0.15)
		end
	end)

	return tab
end

function Nexo:_select(tab)
	if self.active then
		local p = self.active
		tw(p.indicator,     {BackgroundTransparency = 1},  0.2)
		tw(p.indicatorGlow, {BackgroundTransparency = 1},  0.2)
		tw(p.text,          {TextColor3 = C.TEXT_MUTED, Font = Enum.Font.Gotham}, 0.2)
		tw(p.activeBg,      {BackgroundTransparency = 1},  0.2)
		p.content.Visible = false
	end
	self.active = tab
	tw(tab.indicator,     {BackgroundTransparency = 0},    0.25)
	tw(tab.indicatorGlow, {BackgroundTransparency = 0.88}, 0.25)
	tw(tab.text,          {TextColor3 = C.TEXT, Font = Enum.Font.GothamBold}, 0.2)
	tw(tab.activeBg,      {BackgroundTransparency = 0.65}, 0.2)
	tab.content.GroupTransparency = 1
	tab.content.Visible           = true
	tw(tab.content, {GroupTransparency = 0}, 0.25)
end

function Tab:AddButton(cfg)
	local row = Instance.new("Frame")
	row.Size             = UDim2.new(1, 0, 0, 42)
	row.BackgroundColor3 = C.CARD
	row.BorderSizePixel  = 0
	row.Parent           = self.content
	mkCorner(10, row)
	local rowS = mkStroke(C.STROKE, 1, row)

	local accentLine = Instance.new("Frame")
	accentLine.Size                 = UDim2.new(0, 3, 1, -14)
	accentLine.Position             = UDim2.new(0, 0, 0.5, 0)
	accentLine.AnchorPoint          = Vector2.new(0, 0.5)
	accentLine.BackgroundColor3     = C.ACCENT
	accentLine.BackgroundTransparency = 0.6
	accentLine.BorderSizePixel      = 0
	accentLine.Parent               = row
	mkCorner(2, accentLine)

	local btn = Instance.new("TextButton")
	btn.Size             = UDim2.fromScale(1, 1)
	btn.BackgroundTransparency = 1
	btn.Text             = ""
	btn.AutoButtonColor  = false
	btn.Parent           = row

	local lbl = Instance.new("TextLabel")
	lbl.Size             = UDim2.new(1, -52, 1, 0)
	lbl.Position         = UDim2.new(0, 16, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text             = cfg.name
	lbl.TextColor3       = C.TEXT
	lbl.Font             = Enum.Font.GothamBold
	lbl.TextSize         = 13
	lbl.TextXAlignment   = Enum.TextXAlignment.Left
	lbl.Parent           = row

	local arrowBox = Instance.new("Frame")
	arrowBox.Size             = UDim2.fromOffset(26, 26)
	arrowBox.Position         = UDim2.new(1, -38, 0.5, -13)
	arrowBox.BackgroundColor3 = C.ELEVATED
	arrowBox.BorderSizePixel  = 0
	arrowBox.Parent           = row
	mkCorner(7, arrowBox)
	mkStroke(C.STROKE_MED, 1, arrowBox)

	local arrTxt = Instance.new("TextLabel")
	arrTxt.Size               = UDim2.fromScale(1, 1)
	arrTxt.BackgroundTransparency = 1
	arrTxt.Text               = "›"
	arrTxt.TextColor3         = C.ACCENT
	arrTxt.Font               = Enum.Font.GothamBold
	arrTxt.TextSize           = 16
	arrTxt.Parent             = arrowBox

	btn.MouseEnter:Connect(function()
		tw(row,       {BackgroundColor3 = C.HOVER}, 0.15)
		tw(rowS,      {Color = C.STROKE_HI}, 0.15)
		tw(arrowBox,  {BackgroundColor3 = C.ACCENT_DIM}, 0.15)
		tw(accentLine,{BackgroundTransparency = 0}, 0.15)
	end)
	btn.MouseLeave:Connect(function()
		tw(row,       {BackgroundColor3 = C.CARD}, 0.15)
		tw(rowS,      {Color = C.STROKE}, 0.15)
		tw(arrowBox,  {BackgroundColor3 = C.ELEVATED}, 0.15)
		tw(accentLine,{BackgroundTransparency = 0.6}, 0.15)
	end)
	btn.MouseButton1Down:Connect(function()
		tw(row, {Size = UDim2.new(1, -4, 0, 40)}, 0.08)
		tw(row, {BackgroundColor3 = C.ELEVATED}, 0.08)
	end)
	btn.MouseButton1Up:Connect(function()
		tw(row, {Size = UDim2.new(1, 0, 0, 42)}, 0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		tw(row, {BackgroundColor3 = C.HOVER}, 0.1)
	end)
	btn.MouseButton1Click:Connect(function()
		if cfg.callback then cfg.callback() end
	end)
end

function Tab:AddToggle(cfg)
	local state = cfg.default == true
	local PW, PH = 56, 30
	local KS     = 22
	local KOff   = 4
	local KOn    = PW - KS - 4

	local row = Instance.new("Frame")
	row.Size             = UDim2.new(1, 0, 0, 52)
	row.BackgroundColor3 = C.CARD
	row.BorderSizePixel  = 0
	row.Parent           = self.content
	mkCorner(10, row)
	local rowS = mkStroke(C.STROKE, 1, row)

	local nameLbl = Instance.new("TextLabel")
	nameLbl.Size             = UDim2.new(1, -(PW + 32), 0, 22)
	nameLbl.Position         = UDim2.new(0, 16, 0, 8)
	nameLbl.BackgroundTransparency = 1
	nameLbl.Text             = cfg.name
	nameLbl.TextColor3       = C.TEXT
	nameLbl.Font             = Enum.Font.GothamBold
	nameLbl.TextSize         = 13
	nameLbl.TextXAlignment   = Enum.TextXAlignment.Left
	nameLbl.Parent           = row

	local statusLbl = Instance.new("TextLabel")
	statusLbl.Size             = UDim2.new(1, -(PW + 32), 0, 14)
	statusLbl.Position         = UDim2.new(0, 16, 0, 30)
	statusLbl.BackgroundTransparency = 1
	statusLbl.Text             = state and "Enabled" or "Disabled"
	statusLbl.TextColor3       = state and C.GREEN or C.TEXT_MUTED
	statusLbl.Font             = Enum.Font.Gotham
	statusLbl.TextSize         = 11
	statusLbl.TextXAlignment   = Enum.TextXAlignment.Left
	statusLbl.Parent           = row

	local pill = Instance.new("Frame")
	pill.Size             = UDim2.fromOffset(PW, PH)
	pill.Position         = UDim2.new(1, -(PW + 14), 0.5, -math.floor(PH / 2))
	pill.BackgroundColor3 = state and C.GREEN_B or C.TRACK_OFF
	pill.BorderSizePixel  = 0
	pill.ClipsDescendants = false
	pill.Parent           = row
	mkCorner(PH, pill)
	local pillS = mkStroke(state and C.GREEN or C.STROKE_MED, 1.5, pill)

	local pillShine = Instance.new("Frame")
	pillShine.Size                 = UDim2.new(1, 0, 0.5, 0)
	pillShine.BackgroundColor3     = Color3.fromRGB(255, 255, 255)
	pillShine.BackgroundTransparency = 0.92
	pillShine.BorderSizePixel      = 0
	pillShine.ZIndex               = 2
	pillShine.Parent               = pill
	mkCorner(PH, pillShine)

	local glowRing = Instance.new("Frame")
	glowRing.Size                 = UDim2.fromOffset(KS + 10, KS + 10)
	glowRing.AnchorPoint          = Vector2.new(0.5, 0.5)
	glowRing.Position             = UDim2.new(0, (state and KOn or KOff) + math.floor(KS/2), 0.5, 0)
	glowRing.BackgroundColor3     = state and C.GREEN or C.ACCENT
	glowRing.BackgroundTransparency = state and 0.5 or 1
	glowRing.BorderSizePixel      = 0
	glowRing.ZIndex               = 1
	glowRing.Parent               = pill
	mkCorner(100, glowRing)

	local knob = Instance.new("Frame")
	knob.Size             = UDim2.fromOffset(KS, KS)
	knob.AnchorPoint      = Vector2.new(0, 0.5)
	knob.Position         = UDim2.new(0, state and KOn or KOff, 0.5, 0)
	knob.BackgroundColor3 = C.KNOB
	knob.BorderSizePixel  = 0
	knob.ZIndex           = 3
	knob.Parent           = pill
	mkCorner(100, knob)
	mkStroke(Color3.fromRGB(200, 210, 240), 1, knob)

	local knobShine = Instance.new("Frame")
	knobShine.Size                 = UDim2.fromOffset(8, 8)
	knobShine.Position             = UDim2.new(0, 4, 0, 4)
	knobShine.BackgroundColor3     = Color3.fromRGB(255, 255, 255)
	knobShine.BackgroundTransparency = 0.3
	knobShine.BorderSizePixel      = 0
	knobShine.ZIndex               = 4
	knobShine.Parent               = knob
	mkCorner(100, knobShine)

	local function applyState(on, anim)
		local d    = anim and 0.24 or 0
		local eBk  = Enum.EasingStyle.Back
		local eOut = Enum.EasingDirection.Out
		if on then
			tw(pill,      {BackgroundColor3 = C.GREEN_B}, d)
			tw(pillS,     {Color = C.GREEN}, d)
			tw(knob,      {Position = UDim2.new(0, KOn, 0.5, 0), BackgroundColor3 = Color3.fromRGB(240, 255, 245)}, d, eBk, eOut)
			tw(glowRing,  {Position = UDim2.new(0, KOn + math.floor(KS/2), 0.5, 0), BackgroundColor3 = C.GREEN, BackgroundTransparency = 0.5}, d, eBk, eOut)
			tw(statusLbl, {TextColor3 = C.GREEN}, d)
			tw(rowS,      {Color = C.GREEN_DIM}, d)
			statusLbl.Text = "Enabled"
		else
			tw(pill,      {BackgroundColor3 = C.TRACK_OFF}, d)
			tw(pillS,     {Color = C.STROKE_MED}, d)
			tw(knob,      {Position = UDim2.new(0, KOff, 0.5, 0), BackgroundColor3 = C.KNOB}, d, eBk, eOut)
			tw(glowRing,  {Position = UDim2.new(0, KOff + math.floor(KS/2), 0.5, 0), BackgroundTransparency = 1}, d, eBk, eOut)
			tw(statusLbl, {TextColor3 = C.TEXT_MUTED}, d)
			tw(rowS,      {Color = C.STROKE}, d)
			statusLbl.Text = "Disabled"
		end
	end

	applyState(state, false)

	local clickArea = Instance.new("TextButton")
	clickArea.Size             = UDim2.fromScale(1, 1)
	clickArea.BackgroundTransparency = 1
	clickArea.Text             = ""
	clickArea.AutoButtonColor  = false
	clickArea.Parent           = row

	clickArea.MouseButton1Down:Connect(function()
		tw(knob, {Size = UDim2.fromOffset(KS - 3, KS + 5)}, 0.1)
	end)
	clickArea.MouseButton1Up:Connect(function()
		tw(knob, {Size = UDim2.fromOffset(KS, KS)}, 0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	end)
	clickArea.MouseButton1Click:Connect(function()
		state = not state
		applyState(state, true)
		if cfg.callback then cfg.callback(state) end
	end)
	clickArea.MouseEnter:Connect(function() tw(row, {BackgroundColor3 = C.HOVER}, 0.15) end)
	clickArea.MouseLeave:Connect(function() tw(row, {BackgroundColor3 = C.CARD},  0.15) end)

	return {
		Set = function(v)
			state = v == true
			applyState(state, true)
			if cfg.callback then cfg.callback(state) end
		end,
		Get = function() return state end,
	}
end

function Tab:AddSlider(cfg)
	local mn, mx   = cfg.min or 0, cfg.max or 100
	local val      = math.clamp(cfg.default or mn, mn, mx)
	local dragging = false

	local row = Instance.new("Frame")
	row.Size             = UDim2.new(1, 0, 0, 62)
	row.BackgroundColor3 = C.CARD
	row.BorderSizePixel  = 0
	row.Parent           = self.content
	mkCorner(10, row)
	mkStroke(C.STROKE, 1, row)

	local nml = Instance.new("TextLabel")
	nml.Size             = UDim2.new(0.65, 0, 0, 22)
	nml.Position         = UDim2.new(0, 14, 0, 10)
	nml.BackgroundTransparency = 1
	nml.Text             = cfg.name
	nml.TextColor3       = C.TEXT
	nml.Font             = Enum.Font.GothamBold
	nml.TextSize         = 13
	nml.TextXAlignment   = Enum.TextXAlignment.Left
	nml.Parent           = row

	local valBox = Instance.new("Frame")
	valBox.Size             = UDim2.fromOffset(52, 22)
	valBox.Position         = UDim2.new(1, -66, 0, 10)
	valBox.BackgroundColor3 = C.ELEVATED
	valBox.BorderSizePixel  = 0
	valBox.Parent           = row
	mkCorner(6, valBox)
	mkStroke(C.STROKE_MED, 1, valBox)

	local valLbl = Instance.new("TextLabel")
	valLbl.Size               = UDim2.fromScale(1, 1)
	valLbl.BackgroundTransparency = 1
	valLbl.Text               = tostring(math.floor(val))
	valLbl.TextColor3         = C.ACCENT_LT
	valLbl.Font               = Enum.Font.GothamBold
	valLbl.TextSize           = 12
	valLbl.Parent             = valBox

	local minLbl = Instance.new("TextLabel")
	minLbl.Size             = UDim2.new(0, 28, 0, 12)
	minLbl.Position         = UDim2.new(0, 14, 0, 40)
	minLbl.BackgroundTransparency = 1
	minLbl.Text             = tostring(mn)
	minLbl.TextColor3       = C.TEXT_MUTED
	minLbl.Font             = Enum.Font.Gotham
	minLbl.TextSize         = 9
	minLbl.TextXAlignment   = Enum.TextXAlignment.Left
	minLbl.Parent           = row

	local maxLbl = Instance.new("TextLabel")
	maxLbl.Size             = UDim2.new(0, 28, 0, 12)
	maxLbl.Position         = UDim2.new(1, -42, 0, 40)
	maxLbl.BackgroundTransparency = 1
	maxLbl.Text             = tostring(mx)
	maxLbl.TextColor3       = C.TEXT_MUTED
	maxLbl.Font             = Enum.Font.Gotham
	maxLbl.TextSize         = 9
	maxLbl.TextXAlignment   = Enum.TextXAlignment.Right
	maxLbl.Parent           = row

	local track = Instance.new("Frame")
	track.Size             = UDim2.new(1, -28, 0, 6)
	track.Position         = UDim2.new(0, 14, 0, 46)
	track.BackgroundColor3 = C.TRACK_OFF
	track.BorderSizePixel  = 0
	track.Parent           = row
	mkCorner(100, track)

	local pct = (val - mn) / (mx - mn)

	local fill = Instance.new("Frame")
	fill.Size             = UDim2.new(pct, 0, 1, 0)
	fill.BackgroundColor3 = C.ACCENT
	fill.BorderSizePixel  = 0
	fill.Parent           = track
	mkCorner(100, fill)
	mkGrad(C.ACCENT_LT, C.ACCENT_B, 90, fill)

	local knob = Instance.new("Frame")
	knob.Size             = UDim2.fromOffset(18, 18)
	knob.AnchorPoint      = Vector2.new(0.5, 0.5)
	knob.Position         = UDim2.new(pct, 0, 0.5, 0)
	knob.BackgroundColor3 = C.KNOB
	knob.BorderSizePixel  = 0
	knob.ZIndex           = 2
	knob.Parent           = track
	mkCorner(100, knob)
	mkStroke(C.ACCENT, 2, knob)

	local knobDot = Instance.new("Frame")
	knobDot.Size             = UDim2.fromOffset(6, 6)
	knobDot.AnchorPoint      = Vector2.new(0.5, 0.5)
	knobDot.Position         = UDim2.new(0.5, 0, 0.5, 0)
	knobDot.BackgroundColor3 = C.ACCENT
	knobDot.BorderSizePixel  = 0
	knobDot.ZIndex           = 3
	knobDot.Parent           = knob
	mkCorner(100, knobDot)

	local function updateSlider(xpos)
		local ap = track.AbsolutePosition
		local as = track.AbsoluteSize
		local r  = math.clamp((xpos - ap.X) / as.X, 0, 1)
		val = math.floor(mn + (mx - mn) * r)
		local p2 = (val - mn) / (mx - mn)
		fill.Size     = UDim2.new(p2, 0, 1, 0)
		knob.Position = UDim2.new(p2, 0, 0.5, 0)
		valLbl.Text   = tostring(val)
		if cfg.callback then cfg.callback(val) end
	end

	local ib = Instance.new("TextButton")
	ib.Size             = UDim2.new(1, 0, 0, 30)
	ib.Position         = UDim2.new(0, 0, 0, -12)
	ib.BackgroundTransparency = 1
	ib.Text             = ""
	ib.AutoButtonColor  = false
	ib.ZIndex           = 3
	ib.Parent           = track

	ib.MouseButton1Down:Connect(function(x) dragging = true; updateSlider(x) end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			updateSlider(i.Position.X)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			tw(knob, {Size = UDim2.fromOffset(18, 18)}, 0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		end
	end)
	ib.MouseEnter:Connect(function()
		tw(row,  {BackgroundColor3 = C.HOVER}, 0.15)
		tw(knob, {Size = UDim2.fromOffset(22, 22)}, 0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	end)
	ib.MouseLeave:Connect(function()
		if not dragging then
			tw(row,  {BackgroundColor3 = C.CARD}, 0.15)
			tw(knob, {Size = UDim2.fromOffset(18, 18)}, 0.15)
		end
	end)
end

function Tab:AddDropdown(cfg)
	local opts     = cfg.options or {}
	local sel, open = opts[1] or "", false

	local wrap = Instance.new("Frame")
	wrap.Name             = "NexoDrop"
	wrap.Size             = UDim2.new(1, 0, 0, 42)
	wrap.BackgroundTransparency = 1
	wrap.ClipsDescendants = false
	wrap.Parent           = self.content

	local con = Instance.new("Frame")
	con.Size             = UDim2.new(1, 0, 0, 42)
	con.BackgroundColor3 = C.CARD
	con.BorderSizePixel  = 0
	con.ZIndex           = 2
	con.Parent           = wrap
	mkCorner(10, con)
	local conS = mkStroke(C.STROKE, 1, con)

	local nml = Instance.new("TextLabel")
	nml.Size             = UDim2.new(0.5, 0, 1, 0)
	nml.Position         = UDim2.new(0, 16, 0, 0)
	nml.BackgroundTransparency = 1
	nml.Text             = cfg.name
	nml.TextColor3       = C.TEXT
	nml.Font             = Enum.Font.GothamBold
	nml.TextSize         = 13
	nml.TextXAlignment   = Enum.TextXAlignment.Left
	nml.ZIndex           = 3
	nml.Parent           = con

	local selLbl = Instance.new("TextLabel")
	selLbl.Size             = UDim2.new(0.5, -42, 1, 0)
	selLbl.Position         = UDim2.new(0.5, 0, 0, 0)
	selLbl.BackgroundTransparency = 1
	selLbl.Text             = sel
	selLbl.TextColor3       = C.ACCENT_LT
	selLbl.Font             = Enum.Font.Gotham
	selLbl.TextSize         = 12
	selLbl.TextXAlignment   = Enum.TextXAlignment.Right
	selLbl.ZIndex           = 3
	selLbl.Parent           = con

	local chevBox = Instance.new("Frame")
	chevBox.Size             = UDim2.fromOffset(26, 26)
	chevBox.Position         = UDim2.new(1, -36, 0.5, -13)
	chevBox.BackgroundColor3 = C.ELEVATED
	chevBox.BorderSizePixel  = 0
	chevBox.ZIndex           = 3
	chevBox.Parent           = con
	mkCorner(7, chevBox)
	mkStroke(C.STROKE_MED, 1, chevBox)

	local chev = Instance.new("TextLabel")
	chev.Size               = UDim2.fromScale(1, 1)
	chev.BackgroundTransparency = 1
	chev.Text               = "⌄"
	chev.TextColor3         = C.TEXT_DIM
	chev.Font               = Enum.Font.GothamBold
	chev.TextSize           = 13
	chev.ZIndex             = 4
	chev.Parent             = chevBox

	local dlist = Instance.new("Frame")
	dlist.Size             = UDim2.new(1, 0, 0, 0)
	dlist.Position         = UDim2.new(0, 0, 1, 5)
	dlist.BackgroundColor3 = C.ELEVATED
	dlist.BorderSizePixel  = 0
	dlist.ClipsDescendants = true
	dlist.ZIndex           = 12
	dlist.Visible          = false
	dlist.Parent           = wrap
	mkCorner(10, dlist)
	mkStroke(C.STROKE_HI, 1, dlist)

	local dlL = Instance.new("UIListLayout")
	dlL.FillDirection       = Enum.FillDirection.Vertical
	dlL.HorizontalAlignment = Enum.HorizontalAlignment.Center
	dlL.Padding             = UDim.new(0, 3)
	dlL.Parent              = dlist
	mkPad(5, 5, 5, 5, dlist)

	local totalH = 10
	for _, opt in ipairs(opts) do
		local ob = Instance.new("TextButton")
		ob.Size             = UDim2.new(1, 0, 0, 34)
		ob.BackgroundColor3 = C.CARD
		ob.Text             = opt
		ob.TextColor3       = C.TEXT_DIM
		ob.Font             = Enum.Font.Gotham
		ob.TextSize         = 12
		ob.AutoButtonColor  = false
		ob.BorderSizePixel  = 0
		ob.ZIndex           = 13
		ob.Parent           = dlist
		mkCorner(7, ob)
		totalH = totalH + 37

		ob.MouseEnter:Connect(function()  tw(ob, {BackgroundColor3 = C.HOVER, TextColor3 = C.TEXT},     0.12) end)
		ob.MouseLeave:Connect(function()  tw(ob, {BackgroundColor3 = C.CARD,  TextColor3 = C.TEXT_DIM}, 0.12) end)
		ob.MouseButton1Click:Connect(function()
			sel      = opt
			selLbl.Text = opt
			open     = false
			tw(dlist, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
			tw(chev,  {Rotation = 0}, 0.2)
			task.delay(0.2, function()
				dlist.Visible = false
				wrap.Size     = UDim2.new(1, 0, 0, 42)
			end)
			if cfg.callback then cfg.callback(opt) end
		end)
	end

	local tbtn = Instance.new("TextButton")
	tbtn.Size             = UDim2.fromScale(1, 1)
	tbtn.BackgroundTransparency = 1
	tbtn.Text             = ""
	tbtn.AutoButtonColor  = false
	tbtn.ZIndex           = 4
	tbtn.Parent           = con

	tbtn.MouseEnter:Connect(function()
		tw(con,  {BackgroundColor3 = C.HOVER},     0.15)
		tw(conS, {Color = C.STROKE_MED},           0.15)
	end)
	tbtn.MouseLeave:Connect(function()
		tw(con,  {BackgroundColor3 = C.CARD},      0.15)
		tw(conS, {Color = C.STROKE},               0.15)
	end)
	tbtn.MouseButton1Click:Connect(function()
		open = not open
		if open then
			dlist.Visible = true
			dlist.Size    = UDim2.new(1, 0, 0, 0)
			tw(dlist, {Size = UDim2.new(1, 0, 0, totalH)}, 0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			tw(chev,  {Rotation = 180}, 0.2)
			wrap.Size = UDim2.new(1, 0, 0, 42 + totalH + 8)
		else
			tw(dlist, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
			tw(chev,  {Rotation = 0}, 0.2)
			task.delay(0.2, function()
				dlist.Visible = false
				wrap.Size     = UDim2.new(1, 0, 0, 42)
			end)
		end
	end)
end

function Tab:AddTextbox(cfg)
	local row = Instance.new("Frame")
	row.Size             = UDim2.new(1, 0, 0, 58)
	row.BackgroundColor3 = C.CARD
	row.BorderSizePixel  = 0
	row.Parent           = self.content
	mkCorner(10, row)
	local rowS = mkStroke(C.STROKE, 1, row)

	local accent = Instance.new("Frame")
	accent.Size                 = UDim2.fromOffset(4, 20)
	accent.Position             = UDim2.new(0, 12, 0, 8)
	accent.BackgroundColor3     = C.ACCENT
	accent.BackgroundTransparency = 0.5
	accent.BorderSizePixel      = 0
	accent.Parent               = row
	mkCorner(2, accent)

	local nml = Instance.new("TextLabel")
	nml.Size             = UDim2.new(1, -30, 0, 18)
	nml.Position         = UDim2.new(0, 24, 0, 7)
	nml.BackgroundTransparency = 1
	nml.Text             = cfg.name
	nml.TextColor3       = C.TEXT_DIM
	nml.Font             = Enum.Font.Gotham
	nml.TextSize         = 11
	nml.TextXAlignment   = Enum.TextXAlignment.Left
	nml.Parent           = row

	local inputBg = Instance.new("Frame")
	inputBg.Size             = UDim2.new(1, -24, 0, 26)
	inputBg.Position         = UDim2.new(0, 12, 0, 26)
	inputBg.BackgroundColor3 = C.ELEVATED
	inputBg.BorderSizePixel  = 0
	inputBg.Parent           = row
	mkCorner(7, inputBg)
	mkStroke(C.STROKE_MED, 1, inputBg)

	local inp = Instance.new("TextBox")
	inp.Size             = UDim2.new(1, -16, 1, 0)
	inp.Position         = UDim2.new(0, 8, 0, 0)
	inp.BackgroundTransparency = 1
	inp.Text             = ""
	inp.PlaceholderText  = cfg.placeholder or ""
	inp.TextColor3       = C.TEXT
	inp.PlaceholderColor3 = C.TEXT_MUTED
	inp.Font             = Enum.Font.Gotham
	inp.TextSize         = 13
	inp.TextXAlignment   = Enum.TextXAlignment.Left
	inp.ClearTextOnFocus = false
	inp.Parent           = inputBg

	inp.Focused:Connect(function()
		tw(rowS,   {Color = C.STROKE_HI}, 0.2)
		tw(row,    {BackgroundColor3 = C.HOVER}, 0.2)
		tw(accent, {BackgroundTransparency = 0}, 0.2)
	end)
	inp.FocusLost:Connect(function()
		tw(rowS,   {Color = C.STROKE}, 0.2)
		tw(row,    {BackgroundColor3 = C.CARD}, 0.2)
		tw(accent, {BackgroundTransparency = 0.5}, 0.2)
		if cfg.callback then cfg.callback(inp.Text) end
	end)
end

function Tab:AddLabel(text)
	local row = Instance.new("Frame")
	row.Size             = UDim2.new(1, 0, 0, 32)
	row.BackgroundColor3 = C.CARD2
	row.BorderSizePixel  = 0
	row.Parent           = self.content
	mkCorner(8, row)
	mkStroke(C.STROKE, 1, row)

	local dot = Instance.new("Frame")
	dot.Size                 = UDim2.fromOffset(5, 5)
	dot.Position             = UDim2.new(0, 12, 0.5, -2)
	dot.BackgroundColor3     = C.ACCENT
	dot.BackgroundTransparency = 0.4
	dot.BorderSizePixel      = 0
	dot.Parent               = row
	mkCorner(100, dot)

	local lbl = Instance.new("TextLabel")
	lbl.Size             = UDim2.new(1, -32, 1, 0)
	lbl.Position         = UDim2.new(0, 24, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text             = text
	lbl.TextColor3       = C.TEXT_DIM
	lbl.Font             = Enum.Font.Gotham
	lbl.TextSize         = 12
	lbl.TextXAlignment   = Enum.TextXAlignment.Left
	lbl.TextWrapped      = true
	lbl.Parent           = row
end

function Tab:AddSection(title)
	local row = Instance.new("Frame")
	row.Size                 = UDim2.new(1, 0, 0, 28)
	row.BackgroundTransparency = 1
	row.Parent               = self.content

	local leftBar = Instance.new("Frame")
	leftBar.Size             = UDim2.fromOffset(3, 14)
	leftBar.Position         = UDim2.new(0, 0, 0.5, -7)
	leftBar.BackgroundColor3 = C.ACCENT
	leftBar.BorderSizePixel  = 0
	leftBar.Parent           = row
	mkCorner(2, leftBar)

	local lbl = Instance.new("TextLabel")
	lbl.Size             = UDim2.new(1, -60, 1, 0)
	lbl.Position         = UDim2.new(0, 10, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text             = string.upper(title)
	lbl.TextColor3       = C.ACCENT
	lbl.Font             = Enum.Font.GothamBold
	lbl.TextSize         = 10
	lbl.TextXAlignment   = Enum.TextXAlignment.Left
	lbl.Parent           = row

	local line = Instance.new("Frame")
	line.Size             = UDim2.new(1, -10, 0, 1)
	line.Position         = UDim2.new(0, 10, 1, -1)
	line.BackgroundColor3 = C.STROKE
	line.BorderSizePixel  = 0
	line.Parent           = row
end

return Nexo
