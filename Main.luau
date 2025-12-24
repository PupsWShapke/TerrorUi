local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local TerrorUi = {}
TerrorUi.__index = TerrorUi

-- [1. СИСТЕМА ТЕМ]
-- Мы выносим темы в отдельную таблицу, чтобы их было легко дополнять.
local Themes = {
	Default = {
		MainBg = Color3.fromRGB(15, 15, 15),
		Accent = Color3.fromRGB(255, 50, 50),
		Sidebar = Color3.fromRGB(12, 12, 12),
		ElementBg = Color3.fromRGB(25, 25, 25),
		Text = Color3.fromRGB(255, 255, 255),
		SecondaryText = Color3.fromRGB(150, 150, 150),
		Rounding = UDim.new(0, 8),
		Transparency = 0.1
	},
	Midnight = {
		MainBg = Color3.fromRGB(5, 5, 10),
		Accent = Color3.fromRGB(0, 150, 255),
		Sidebar = Color3.fromRGB(2, 2, 5),
		ElementBg = Color3.fromRGB(15, 15, 30),
		Text = Color3.fromRGB(255, 255, 255),
		SecondaryText = Color3.fromRGB(120, 120, 180),
		Rounding = UDim.new(0, 12),
		Transparency = 0.05
	}
}

-- [2. ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ]
-- Функция для плавного перетаскивания (Lerp Dragging)
function TerrorUi:_MakeDraggable(obj)
	local dragging = false
	local dragInput, dragStart, startPos

	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			-- Если перетаскиваем за хедер, двигаем все окно
			startPos = (obj.Name == "Header" and self.MainFrame.Position or obj.Position)

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	obj.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			local targetPos = UDim2.new(
				startPos.X.Scale, 
				startPos.X.Offset + delta.X, 
				startPos.Y.Scale, 
				startPos.Y.Offset + delta.Y
			)

			if obj.Name == "Header" then
				self.MainFrame.Position = targetPos
			else
				obj.Position = targetPos
			end
		end
	end)
end

-- [3. КОНСТРУКТОР ИНТЕРФЕЙСА]
function TerrorUi.new(title, subtext, startTheme)
	local self = setmetatable({}, TerrorUi)

	-- Инициализируем хранилище объектов для ApplyTheme
	self.Objects = {
		Separators = {},
		Elements = {},
		Tabs = {},
		Labels = {}
	}

	self.Theme = Themes[startTheme] or Themes.Default
	self.Pages = {}
	self.IsToggled = false

	-- ScreenGui
	self.ScreenGui = Instance.new("ScreenGui")
	self.ScreenGui.Name = "TerrorUi_" .. math.random(1000, 9999)
	self.ScreenGui.ResetOnSpawn = false
	self.ScreenGui.DisplayOrder = 100
	self.ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	-- Главное окно
	self.MainFrame = Instance.new("CanvasGroup")
	self.MainFrame.Name = "MainFrame"
	self.MainFrame.Size = UDim2.new(0, 550, 0, 380)
	self.MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
	self.MainFrame.BackgroundColor3 = self.Theme.MainBg
	self.MainFrame.BackgroundTransparency = self.Theme.Transparency
	self.MainFrame.BorderSizePixel = 0
	self.MainFrame.GroupTransparency = 1
	self.MainFrame.Visible = false
	self.MainFrame.Parent = self.ScreenGui

	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = self.Theme.Rounding
	MainCorner.Parent = self.MainFrame

	-- Хедер
	self.Header = Instance.new("Frame")
	self.Header.Name = "Header"
	self.Header.Size = UDim2.new(1, 0, 0, 35)
	self.Header.BackgroundTransparency = 1
	self.Header.Parent = self.MainFrame

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(1, -100, 1, 0)
	TitleLabel.Position = UDim2.new(0, 15, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.RichText = true
	TitleLabel.Text = title .. " <font color='rgb(150,150,150)'>" .. subtext .. "</font>"
	TitleLabel.TextColor3 = self.Theme.Text
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 16
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = self.Header

	-- Управление (Закрыть и Свернуть)
	local Controls = Instance.new("Frame")
	Controls.Size = UDim2.new(0, 70, 1, 0)
	Controls.Position = UDim2.new(1, -75, 0, 0)
	Controls.BackgroundTransparency = 1
	Controls.Parent = self.Header

	local function createControl(txt, color, xOffset, callback)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 22, 0, 22)
		btn.Position = UDim2.new(0, xOffset, 0.5, -11)
		btn.BackgroundColor3 = color
		btn.Text = txt
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.Font = Enum.Font.GothamBold
		btn.Parent = Controls
		Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
		btn.MouseButton1Click:Connect(callback)
	end

	createControl("×", Color3.fromRGB(200, 50, 50), 40, function() self.ScreenGui:Destroy() end)
	createControl("-", Color3.fromRGB(60, 60, 60), 10, function() self:Toggle() end)

	-- Разделители
	local Sep1 = Instance.new("Frame")
	Sep1.Size = UDim2.new(1, 0, 0, 1)
	Sep1.Position = UDim2.new(0, 0, 0, 35)
	Sep1.BackgroundColor3 = self.Theme.ElementBg
	Sep1.BorderSizePixel = 0
	Sep1.Parent = self.MainFrame
	table.insert(self.Objects.Separators, Sep1)

	local Sep2 = Instance.new("Frame")
	Sep2.Size = UDim2.new(0, 1, 1, -35)
	Sep2.Position = UDim2.new(0, 140, 0, 35)
	Sep2.BackgroundColor3 = self.Theme.ElementBg
	Sep2.BorderSizePixel = 0
	Sep2.Parent = self.MainFrame
	table.insert(self.Objects.Separators, Sep2)

	-- Контейнер для Табов (Scrolling)
	self.TabList = Instance.new("ScrollingFrame")
	self.TabList.Size = UDim2.new(0, 130, 1, -45)
	self.TabList.Position = UDim2.new(0, 5, 0, 40)
	self.TabList.BackgroundTransparency = 1
	self.TabList.BorderSizePixel = 0
	self.TabList.ScrollBarThickness = 0
	self.TabList.Parent = self.MainFrame

	local TabListLayout = Instance.new("UIListLayout")
	TabListLayout.Padding = UDim.new(0, 5)
	TabListLayout.Parent = self.TabList

	-- Контейнер для Страниц
	self.PageContainer = Instance.new("Frame")
	self.PageContainer.Size = UDim2.new(1, -155, 1, -45)
	self.PageContainer.Position = UDim2.new(0, 150, 0, 40)
	self.PageContainer.BackgroundTransparency = 1
	self.PageContainer.Parent = self.MainFrame

	-- Контейнер уведомлений (NotifContainer)
	self.NotifContainer = Instance.new("Frame")
	self.NotifContainer.Size = UDim2.new(0, 250, 1, -20)
	self.NotifContainer.Position = UDim2.new(1, -260, 0, 10)
	self.NotifContainer.BackgroundTransparency = 1
	self.NotifContainer.Parent = self.ScreenGui

	local NotifLayout = Instance.new("UIListLayout")
	NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	NotifLayout.Padding = UDim.new(0, 8)
	NotifLayout.Parent = self.NotifContainer

	-- Инициализируем мобильную кнопку и драг
	self:_MakeDraggable(self.Header)
	self:CreateMobileButton()

	return self
end

-- [4. УПРАВЛЕНИЕ ВИДИМОСТЬЮ]
function TerrorUi:Toggle()
	self.IsToggled = not self.IsToggled

	if self.IsToggled then
		self.MainFrame.Visible = true
		TweenService:Create(self.MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()
	else
		local tw = TweenService:Create(self.MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {GroupTransparency = 1})
		tw:Play()
		tw.Completed:Connect(function()
			if not self.IsToggled then self.MainFrame.Visible = false end
		end)
	end
end

-- [5. УВЕДОМЛЕНИЯ]
function TerrorUi:Notify(title, text, duration)
	local duration = duration or 5

	local Notif = Instance.new("CanvasGroup")
	Notif.Size = UDim2.new(1, 0, 0, 65)
	Notif.BackgroundColor3 = self.Theme.MainBg
	Notif.GroupTransparency = 1
	Notif.Parent = self.NotifContainer

	Instance.new("UICorner", Notif).CornerRadius = self.Theme.Rounding
	local Stroke = Instance.new("UIStroke", Notif)
	Stroke.Color = self.Theme.Accent
	Stroke.Thickness = 1.5

	local TL = Instance.new("TextLabel", Notif)
	TL.Size = UDim2.new(1, -20, 0, 25); TL.Position = UDim2.new(0, 10, 0, 5)
	TL.Text = title:upper(); TL.TextColor3 = self.Theme.Accent; TL.Font = Enum.Font.GothamBold; TL.BackgroundTransparency = 1; TL.TextXAlignment = 0; TL.TextSize = 13

	local ML = Instance.new("TextLabel", Notif)
	ML.Size = UDim2.new(1, -20, 0, 30); ML.Position = UDim2.new(0, 10, 0, 28)
	ML.Text = text; ML.TextColor3 = self.Theme.SecondaryText; ML.Font = Enum.Font.Gotham; ML.BackgroundTransparency = 1; ML.TextXAlignment = 0; ML.TextWrapped = true; ML.TextSize = 12

	TweenService:Create(Notif, TweenInfo.new(0.4), {GroupTransparency = 0}):Play()

	local TimerBar = Instance.new("Frame", Notif)
	TimerBar.Size = UDim2.new(1, 0, 0, 2); TimerBar.Position = UDim2.new(0, 0, 1, -2); TimerBar.BackgroundColor3 = self.Theme.Accent; TimerBar.BorderSizePixel = 0

	TweenService:Create(TimerBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 2)}):Play()

	task.delay(duration, function()
		local out = TweenService:Create(Notif, TweenInfo.new(0.4), {GroupTransparency = 1})
		out:Play()
		out.Completed:Connect(function() Notif:Destroy() end)
	end)
end

function TerrorUi:CreateMobileButton()
	local MobileBtn = Instance.new("TextButton")
	MobileBtn.Name = "TerrorMobileBtn"
	MobileBtn.Size = UDim2.new(0, 50, 0, 50)
	MobileBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
	MobileBtn.BackgroundColor3 = self.Theme.MainBg
	MobileBtn.Text = "T"
	MobileBtn.TextColor3 = self.Theme.Accent
	MobileBtn.Font = Enum.Font.GothamBold
	MobileBtn.TextSize = 24
	MobileBtn.Parent = self.ScreenGui
	self.MobileButton = MobileBtn

	local Corner = Instance.new("UICorner", MobileBtn)
	Corner.CornerRadius = UDim.new(1, 0)

	local Stroke = Instance.new("UIStroke", MobileBtn)
	Stroke.Color = self.Theme.Accent
	Stroke.Thickness = 2
	Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	MobileBtn.MouseButton1Click:Connect(function()
		self:Toggle()
	end)

	-- Делаем кнопку перетаскиваемой (используем наш метод из части 1)
	self:_MakeDraggable(MobileBtn)
end

-- [7. СИСТЕМА ВКЛАДОК (AddTab)]
function TerrorUi:AddTab(name)
	local Page = Instance.new("ScrollingFrame")
	Page.Name = name .. "_Page"
	Page.Size = UDim2.new(1, 0, 1, 0)
	Page.BackgroundTransparency = 1
	Page.Visible = false
	Page.ScrollBarThickness = 2
	Page.ScrollBarImageColor3 = self.Theme.Accent
	Page.CanvasSize = UDim2.new(0, 0, 0, 0) -- Авто-размер через скрипт ниже
	Page.Parent = self.PageContainer

	local PageLayout = Instance.new("UIListLayout", Page)
	PageLayout.Padding = UDim.new(0, 6)
	PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	-- Автоматическое обновление размера ScrollingFrame
	PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
	end)

	-- Кнопка переключения в сайдбаре
	local TabBtn = Instance.new("TextButton")
	TabBtn.Name = name .. "_TabBtn"
	TabBtn.Size = UDim2.new(1, -10, 0, 32)
	TabBtn.BackgroundTransparency = 1
	TabBtn.Text = name
	TabBtn.TextColor3 = self.Theme.SecondaryText
	TabBtn.Font = Enum.Font.Gotham
	TabBtn.TextSize = 14
	TabBtn.Parent = self.TabList

	TabBtn.MouseButton1Click:Connect(function()
		-- Скрываем все страницы и деактивируем все кнопки вкладок
		for _, p in pairs(self.Pages) do p.Visible = false end
		for _, t in pairs(self.Objects.Tabs) do t.TextColor3 = self.Theme.SecondaryText end

		-- Показываем текущую
		Page.Visible = true
		TabBtn.TextColor3 = self.Theme.Accent
	end)

	-- Если это первая созданная вкладка — делаем её активной
	if #self.Pages == 0 then
		Page.Visible = true
		TabBtn.TextColor3 = self.Theme.Accent
	end

	table.insert(self.Pages, Page)
	table.insert(self.Objects.Tabs, TabBtn)

	-- Внутренний API для элементов внутри вкладки
	local PageAPI = {
		Theme = self.Theme,
		Objects = self.Objects,
		Container = Page
	}

	-- [8. ЭЛЕМЕНТ: КНОПКА (AddButton)]
	function PageAPI:AddButton(text, callback)
		local BtnFrame = Instance.new("TextButton")
		BtnFrame.Name = text .. "_Button"
		BtnFrame.Size = UDim2.new(1, -10, 0, 32)
		BtnFrame.BackgroundColor3 = PageAPI.Theme.ElementBg
		BtnFrame.Text = "  " .. text
		BtnFrame.TextColor3 = PageAPI.Theme.Text
		BtnFrame.Font = Enum.Font.Gotham
		BtnFrame.TextSize = 13
		BtnFrame.TextXAlignment = Enum.TextXAlignment.Left
		BtnFrame.AutoButtonColor = true
		BtnFrame.Parent = Page

		Instance.new("UICorner", BtnFrame).CornerRadius = PageAPI.Theme.Rounding
		table.insert(PageAPI.Objects.Elements, BtnFrame)

		BtnFrame.MouseButton1Click:Connect(function()
			-- Анимация нажатия (вспышка)
			local oldColor = BtnFrame.BackgroundColor3
			BtnFrame.BackgroundColor3 = PageAPI.Theme.Accent
			TweenService:Create(BtnFrame, TweenInfo.new(0.3), {BackgroundColor3 = oldColor}):Play()

			callback()
		end)
	end

	-- [9. ЭЛЕМЕНТ: ПЕРЕКЛЮЧАТЕЛЬ (AddToggle)]
	function PageAPI:AddToggle(text, default, callback)
		local enabled = default or false

		local ToggleFrame = Instance.new("TextButton")
		ToggleFrame.Name = text .. "_Toggle"
		ToggleFrame.Size = UDim2.new(1, -10, 0, 38)
		ToggleFrame.BackgroundColor3 = PageAPI.Theme.ElementBg
		ToggleFrame.Text = ""
		ToggleFrame.Parent = Page
		Instance.new("UICorner", ToggleFrame).CornerRadius = PageAPI.Theme.Rounding

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -50, 1, 0)
		Label.Position = UDim2.new(0, 12, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Text = text
		Label.TextColor3 = PageAPI.Theme.SecondaryText
		Label.Font = Enum.Font.Gotham
		Label.TextSize = 14
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = ToggleFrame

		-- Внешний бокс индикатора
		local Box = Instance.new("Frame")
		Box.Size = UDim2.new(0, 34, 0, 18)
		Box.Position = UDim2.new(1, -44, 0.5, -9)
		Box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		Box.Parent = ToggleFrame
		Instance.new("UICorner", Box).CornerRadius = UDim.new(1, 0)

		-- Движущийся кружок
		local Dot = Instance.new("Frame")
		Dot.Size = UDim2.new(0, 14, 0, 14)
		Dot.Position = enabled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
		Dot.BackgroundColor3 = enabled and PageAPI.Theme.Accent or Color3.fromRGB(200, 200, 200)
		Dot.Parent = Box
		Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

		local function update()
			local targetPos = enabled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
			local targetColor = enabled and PageAPI.Theme.Accent or Color3.fromRGB(200, 200, 200)

			TweenService:Create(Dot, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {Position = targetPos, BackgroundColor3 = targetColor}):Play()
			callback(enabled)
		end

		ToggleFrame.MouseButton1Click:Connect(function()
			enabled = not enabled
			update()
		end)

		table.insert(PageAPI.Objects.Elements, ToggleFrame)
	end
	
	-- [10. ЭЛЕМЕНТ: СЛАЙДЕР (AddSlider)]
	function PageAPI:AddSlider(text, min, max, default, callback)
		local dragging = false
		local value = math.clamp(default, min, max)

		local SliderFrame = Instance.new("Frame")
		SliderFrame.Name = text .. "_Slider"
		SliderFrame.Size = UDim2.new(1, -10, 0, 45)
		SliderFrame.BackgroundColor3 = PageAPI.Theme.ElementBg
		SliderFrame.Parent = Page
		Instance.new("UICorner", SliderFrame).CornerRadius = PageAPI.Theme.Rounding

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -20, 0, 20)
		Label.Position = UDim2.new(0, 12, 0, 5)
		Label.BackgroundTransparency = 1
		Label.Text = text .. ": " .. tostring(value)
		Label.TextColor3 = PageAPI.Theme.SecondaryText
		Label.Font = Enum.Font.Gotham
		Label.TextSize = 13
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = SliderFrame

		local BarBg = Instance.new("Frame")
		BarBg.Size = UDim2.new(1, -24, 0, 6)
		BarBg.Position = UDim2.new(0, 12, 0, 32)
		BarBg.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		BarBg.Parent = SliderFrame
		Instance.new("UICorner", BarBg)

		local BarFill = Instance.new("Frame")
		BarFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
		BarFill.BackgroundColor3 = PageAPI.Theme.Accent
		BarFill.BorderSizePixel = 0
		BarFill.Parent = BarBg
		Instance.new("UICorner", BarFill)

		local function update(input)
			local pos = math.clamp((input.Position.X - BarBg.AbsolutePosition.X) / BarBg.AbsoluteSize.X, 0, 1)
			value = math.floor(min + (max - min) * pos)

			TweenService:Create(BarFill, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
			Label.Text = text .. ": " .. tostring(value)
			callback(value)
		end

		BarBg.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				update(input)
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				update(input)
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)

		table.insert(PageAPI.Objects.Elements, SliderFrame)
	end

	-- [11. ЭЛЕМЕНТ: ВЫБОР ЦВЕТА (AddColorPicker)]
	function PageAPI:AddColorPicker(text, default, callback)
		local currentColor = default
		local open = false

		local PickerFrame = Instance.new("Frame")
		PickerFrame.Name = text .. "_Picker"
		PickerFrame.Size = UDim2.new(1, -10, 0, 35)
		PickerFrame.BackgroundColor3 = PageAPI.Theme.ElementBg
		PickerFrame.ClipsDescendants = true
		PickerFrame.Parent = Page
		Instance.new("UICorner", PickerFrame).CornerRadius = PageAPI.Theme.Rounding

		local HeaderBtn = Instance.new("TextButton", PickerFrame)
		HeaderBtn.Size = UDim2.new(1, 0, 0, 35)
		HeaderBtn.BackgroundTransparency = 1
		HeaderBtn.Text = "  " .. text
		HeaderBtn.TextColor3 = PageAPI.Theme.SecondaryText
		HeaderBtn.Font = Enum.Font.Gotham
		HeaderBtn.TextSize = 14
		HeaderBtn.TextXAlignment = Enum.TextXAlignment.Left

		local Preview = Instance.new("Frame", HeaderBtn)
		Preview.Size = UDim2.new(0, 22, 0, 22)
		Preview.Position = UDim2.new(1, -32, 0, 6.5)
		Preview.BackgroundColor3 = default
		Instance.new("UICorner", Preview).CornerRadius = UDim.new(0, 4)

		-- Скрытый контейнер для каналов RGB
		local RGBContainer = Instance.new("Frame", PickerFrame)
		RGBContainer.Size = UDim2.new(1, -20, 0, 90)
		RGBContainer.Position = UDim2.new(0, 10, 0, 40)
		RGBContainer.BackgroundTransparency = 1

		local function updateColor()
			Preview.BackgroundColor3 = currentColor
			callback(currentColor)
		end

		local function createChannel(name, color, yPos, property)
			local ChannelFrame = Instance.new("Frame", RGBContainer)
			ChannelFrame.Size = UDim2.new(1, 0, 0, 25)
			ChannelFrame.Position = UDim2.new(0, 0, 0, yPos)
			ChannelFrame.BackgroundTransparency = 1

			local Title = Instance.new("TextLabel", ChannelFrame)
			Title.Size = UDim2.new(0, 20, 1, 0)
			Title.Text = name
			Title.TextColor3 = color
			Title.Font = Enum.Font.GothamBold
			Title.BackgroundTransparency = 1

			local Bar = Instance.new("Frame", ChannelFrame)
			Bar.Size = UDim2.new(1, -30, 0, 4)
			Bar.Position = UDim2.new(0, 25, 0.5, -2)
			Bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			Instance.new("UICorner", Bar)

			local Fill = Instance.new("Frame", Bar)
			local startValue = (property == "R" and currentColor.R or property == "G" and currentColor.G or currentColor.B)
			Fill.Size = UDim2.new(startValue, 0, 1, 0)
			Fill.BackgroundColor3 = color
			Instance.new("UICorner", Fill)

			local draggingChannel = false
			local function moveChannel(input)
				local p = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
				Fill.Size = UDim2.new(p, 0, 1, 0)

				local r, g, b = currentColor.R, currentColor.G, currentColor.B
				if property == "R" then r = p elseif property == "G" then g = p else b = p end
				currentColor = Color3.new(r, g, b)
				updateColor()
			end

			Bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingChannel = true moveChannel(i) end end)
			UserInputService.InputChanged:Connect(function(i) if draggingChannel and i.UserInputType == Enum.UserInputType.MouseMovement then moveChannel(i) end end)
			UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingChannel = false end end)
		end

		createChannel("R", Color3.fromRGB(255, 75, 75), 0, "R")
		createChannel("G", Color3.fromRGB(75, 255, 75), 30, "G")
		createChannel("B", Color3.fromRGB(75, 75, 255), 60, "B")

		HeaderBtn.MouseButton1Click:Connect(function()
			open = not open
			local targetSize = open and UDim2.new(1, -10, 0, 140) or UDim2.new(1, -10, 0, 35)
			TweenService:Create(PickerFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {Size = targetSize}):Play()
		end)

		table.insert(PageAPI.Objects.Elements, PickerFrame)
	end
	-- [12. ЭЛЕМЕНТ: НАЗНАЧЕНИЕ КЛАВИШ (AddKeybind)]
	function PageAPI:AddKeybind(text, default, callback)
		local currentKey = default or Enum.KeyCode.F
		local binding = false

		local BindFrame = Instance.new("Frame")
		BindFrame.Name = text .. "_Bind"
		BindFrame.Size = UDim2.new(1, -10, 0, 35)
		BindFrame.BackgroundColor3 = PageAPI.Theme.ElementBg
		BindFrame.Parent = Page
		Instance.new("UICorner", BindFrame).CornerRadius = PageAPI.Theme.Rounding

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -70, 1, 0)
		Label.Position = UDim2.new(0, 12, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Text = text
		Label.TextColor3 = PageAPI.Theme.SecondaryText
		Label.Font = Enum.Font.Gotham
		Label.TextSize = 14
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = BindFrame

		local BindBtn = Instance.new("TextButton")
		BindBtn.Size = UDim2.new(0, 65, 0, 25)
		BindBtn.Position = UDim2.new(1, -75, 0.5, -12)
		BindBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		BindBtn.Text = currentKey.Name
		BindBtn.TextColor3 = PageAPI.Theme.Text
		BindBtn.Font = Enum.Font.GothamBold
		BindBtn.TextSize = 12
		BindBtn.Parent = BindFrame
		Instance.new("UICorner", BindBtn).CornerRadius = UDim.new(0, 4)

		BindBtn.MouseButton1Click:Connect(function()
			binding = true
			BindBtn.Text = "..."
			BindBtn.TextColor3 = PageAPI.Theme.Accent
		end)

		UserInputService.InputBegan:Connect(function(input, gpe)
			if gpe then return end

			if binding then
				if input.UserInputType == Enum.UserInputType.Keyboard then
					currentKey = input.KeyCode
					binding = false
					BindBtn.Text = currentKey.Name
					BindBtn.TextColor3 = PageAPI.Theme.Text
				end
			else
				if input.KeyCode == currentKey then
					callback()
				end
			end
		end)

		table.insert(PageAPI.Objects.Elements, BindFrame)
	end

	-- [13. ЭЛЕМЕНТ: ПОЛЕ ВВОДА (AddTextBox)]
	function PageAPI:AddTextBox(text, placeholder, callback)
		local BoxFrame = Instance.new("Frame")
		BoxFrame.Name = text .. "_TextBox"
		BoxFrame.Size = UDim2.new(1, -10, 0, 35)
		BoxFrame.BackgroundColor3 = PageAPI.Theme.ElementBg
		BoxFrame.Parent = Page
		Instance.new("UICorner", BoxFrame).CornerRadius = PageAPI.Theme.Rounding

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(0, 100, 1, 0)
		Label.Position = UDim2.new(0, 12, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Text = text
		Label.TextColor3 = PageAPI.Theme.SecondaryText
		Label.Font = Enum.Font.Gotham
		Label.TextSize = 14
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = BoxFrame

		local Input = Instance.new("TextBox")
		Input.Size = UDim2.new(1, -125, 0, 25)
		Input.Position = UDim2.new(0, 115, 0.5, -12)
		Input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Input.Text = ""
		Input.PlaceholderText = placeholder or "..."
		Input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
		Input.TextColor3 = PageAPI.Theme.Text
		Input.Font = Enum.Font.Gotham
		Input.TextSize = 12
		Input.ClearTextOnFocus = false
		Input.Parent = BoxFrame
		Instance.new("UICorner", Input).CornerRadius = UDim.new(0, 4)

		Input.FocusLost:Connect(function(enterPressed)
			callback(Input.Text, enterPressed)
		end)

		table.insert(PageAPI.Objects.Elements, BoxFrame)
	end

	return PageAPI
end

-- [14. ГЛОБАЛЬНАЯ СМЕНА ТЕМЫ]
function TerrorUi:ApplyTheme(themeName)
	local theme = (type(themeName) == "table") and themeName or Themes[themeName]
	if not theme then return end

	self.Theme = theme

	-- Обновляем главный фрейм
	if self.MainFrame then
		self.MainFrame.BackgroundColor3 = theme.MainBg
		self.MainFrame.BackgroundTransparency = theme.Transparency
		self.MainFrame.UICorner.CornerRadius = theme.Rounding
	end

	-- Обновляем мобильную кнопку
	if self.MobileButton then
		self.MobileButton.BackgroundColor3 = theme.MainBg
		self.MobileButton.TextColor3 = theme.Accent
		self.MobileButton.UIStroke.Color = theme.Accent
	end

	-- Обновляем разделители
	for _, sep in pairs(self.Objects.Separators) do
		sep.BackgroundColor3 = theme.ElementBg
	end

	-- Обновляем элементы
	for _, el in pairs(self.Objects.Elements) do
		if el:IsA("Frame") or el:IsA("TextButton") then
			el.BackgroundColor3 = theme.ElementBg
		end
		-- Дочерние тексты
		for _, child in pairs(el:GetDescendants()) do
			if child:IsA("TextLabel") and child.Name ~= "Indicator" then
				child.TextColor3 = theme.SecondaryText
			end
		end
	end
end

return TerrorUi

