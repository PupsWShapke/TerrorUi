local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local TerrorUi = {}
TerrorUi.__index = TerrorUi

-- [1. НАЛАШТУВАННЯ ТА АНІМАЦІЇ]
local Settings = {
	AnimSpeed = 0.25,
	Easing = Enum.EasingStyle.Quart,
	CornerRadius = UDim.new(0, 8)
}

local function Tween(obj, props, time)
	local info = TweenInfo.new(time or Settings.AnimSpeed, Settings.Easing)
	local tw = TweenService:Create(obj, info, props)
	tw:Play()
	return tw
end

-- [2. ТЕМИ]
local Themes = {
	Default = {
		MainBg = Color3.fromRGB(15, 15, 15),
		Accent = Color3.fromRGB(255, 50, 50),
		ElementBg = Color3.fromRGB(25, 25, 25),
		Text = Color3.fromRGB(255, 255, 255),
		SecondaryText = Color3.fromRGB(150, 150, 150),
	},
	Midnight = {
		MainBg = Color3.fromRGB(5, 5, 10),
		Accent = Color3.fromRGB(0, 150, 255),
		ElementBg = Color3.fromRGB(15, 15, 30),
		Text = Color3.fromRGB(255, 255, 255),
		SecondaryText = Color3.fromRGB(120, 120, 180),
	}
}

-- [3. ВНУТРІШНІ МЕТОДИ]
function TerrorUi:_SetupDragging(hoverInstance, dragInstance)
	local dragging, dragInput, dragStart, startPos
	hoverInstance.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = dragInstance.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	hoverInstance.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			TweenService:Create(dragInstance, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			}):Play()
		end
	end)
end

-- [4. КОНСТРУКТОР ТА ОСНОВНЕ ВІКНО]
function TerrorUi.new(title, subtext, startTheme)
	local self = setmetatable({}, TerrorUi)
	self.Theme = Themes[startTheme] or Themes.Default
	self.IsToggled = true
	self.Objects = {Elements = {}, Tabs = {}}

	self.ScreenGui = Instance.new("ScreenGui")
	self.ScreenGui.Name = "TerrorUi"
	self.ScreenGui.ResetOnSpawn = false
	self.ScreenGui.IgnoreGuiInset = true
	self.ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

	self.MainFrame = Instance.new("CanvasGroup")
	self.MainFrame.Size = UDim2.new(0, 550, 0, 380)
	self.MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
	self.MainFrame.BackgroundColor3 = self.Theme.MainBg
	self.MainFrame.Parent = self.ScreenGui
	Instance.new("UICorner", self.MainFrame).CornerRadius = Settings.CornerRadius

	self.Header = Instance.new("Frame", self.MainFrame)
	self.Header.Size = UDim2.new(1, 0, 0, 40)
	self.Header.BackgroundTransparency = 1

	local TitleLabel = Instance.new("TextLabel", self.Header)
	TitleLabel.Size = UDim2.new(1, -20, 1, 0)
	TitleLabel.Position = UDim2.new(0, 15, 0, 0)
	TitleLabel.Text = title .. " <font color='#808080'>" .. subtext .. "</font>"
	TitleLabel.RichText = true
	TitleLabel.TextColor3 = self.Theme.Text
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 18
	TitleLabel.TextXAlignment = 0
	TitleLabel.BackgroundTransparency = 1

	self.Sidebar = Instance.new("Frame", self.MainFrame)
	self.Sidebar.Size = UDim2.new(0, 140, 1, -50)
	self.Sidebar.Position = UDim2.new(0, 10, 0, 45)
	self.Sidebar.BackgroundTransparency = 1

	self.TabContainer = Instance.new("Frame", self.Sidebar)
	self.TabContainer.Size = UDim2.new(1, 0, 1, 0)
	self.TabContainer.BackgroundTransparency = 1
	Instance.new("UIListLayout", self.TabContainer).Padding = UDim.new(0, 5)

	self:_SetupDragging(self.Header, self.MainFrame)
	return self
end

-- [5. ГЛОБАЛЬНІ ФУНКЦІЇ КЕРУВАННЯ]
function TerrorUi:Toggle()
	self.IsToggled = not self.IsToggled
	-- Плавне зникнення через GroupTransparency (вимагає CanvasGroup)
	Tween(self.MainFrame, {GroupTransparency = self.IsToggled and 0 or 1})
	-- Вимикаємо видимість після анімації, щоб не блокувати кліки
	task.delay(self.IsToggled and 0 or Settings.AnimSpeed, function()
		self.MainFrame.Visible = self.IsToggled
	end)
end

function TerrorUi:Notify(title, text, duration)
	local n = Instance.new("Frame", self.ScreenGui)
	n.Size = UDim2.new(0, 220, 0, 60)
	n.Position = UDim2.new(1, 10, 1, -70)
	n.BackgroundColor3 = self.Theme.MainBg
	Instance.new("UICorner", n).CornerRadius = Settings.CornerRadius
	local s = Instance.new("UIStroke", n)
	s.Color = self.Theme.Accent
	s.Thickness = 2

	local tl = Instance.new("TextLabel", n)
	tl.Size = UDim2.new(1, -20, 0, 25)
	tl.Position = UDim2.new(0, 10, 0, 5)
	tl.Text = title
	tl.TextColor3 = self.Theme.Accent
	tl.Font = Enum.Font.GothamBold
	tl.TextSize = 14
	tl.BackgroundTransparency = 1
	tl.TextXAlignment = 0

	local cl = Instance.new("TextLabel", n)
	cl.Size = UDim2.new(1, -20, 0, 20)
	cl.Position = UDim2.new(0, 10, 0, 30)
	cl.Text = text
	cl.TextColor3 = self.Theme.Text
	cl.Font = Enum.Font.Gotham
	cl.TextSize = 12
	cl.BackgroundTransparency = 1
	cl.TextXAlignment = 0

	Tween(n, {Position = UDim2.new(1, -230, 1, -70)})
	task.delay(duration or 5, function()
		Tween(n, {Position = UDim2.new(1, 10, 1, -70)}).Completed:Connect(function()
			n:Destroy()
		end)
	end)
end

function TerrorUi:CreateMobileButton()
	local MB = Instance.new("TextButton", self.ScreenGui)
	MB.Name = "TerrorMobile"
	MB.Size = UDim2.new(0, 50, 0, 50)
	MB.Position = UDim2.new(0, 20, 0.5, -25)
	MB.BackgroundColor3 = self.Theme.MainBg
	MB.Text = "T"
	MB.TextColor3 = self.Theme.Accent
	MB.Font = Enum.Font.GothamBold
	MB.TextSize = 24
	Instance.new("UICorner", MB).CornerRadius = UDim.new(1, 0)
	local s = Instance.new("UIStroke", MB)
	s.Color = self.Theme.Accent
	s.Thickness = 2

	MB.MouseButton1Click:Connect(function()
		self:Toggle()
	end)
	self:_SetupDragging(MB, MB)
end

-- [6. СИСТЕМА ВКЛАДОК (AddTab)]
function TerrorUi:AddTab(name)
	local ui = self -- Посилання на головний об'єкт для API елементів
	local theme = ui.Theme

	-- Кнопка в бічній панелі
	local TabBtn = Instance.new("TextButton", ui.TabContainer)
	TabBtn.Size = UDim2.new(1, 0, 0, 32)
	TabBtn.BackgroundColor3 = theme.ElementBg
	TabBtn.BackgroundTransparency = 1
	TabBtn.Text = name
	TabBtn.TextColor3 = theme.SecondaryText
	TabBtn.Font = Enum.Font.GothamMedium
	TabBtn.TextSize = 14
	Instance.new("UICorner", TabBtn).CornerRadius = Settings.CornerRadius

	-- Контейнер сторінки
	local Page = Instance.new("ScrollingFrame", ui.MainFrame)
	Page.Name = name .. "_Page"
	Page.Size = UDim2.new(1, -170, 1, -55)
	Page.Position = UDim2.new(0, 160, 0, 45)
	Page.BackgroundTransparency = 1
	Page.Visible = false
	Page.ScrollBarThickness = 2
	Page.ScrollBarImageColor3 = theme.Accent

	local layout = Instance.new("UIListLayout", Page)
	layout.Padding = UDim.new(0, 8)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() 
		Page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10) 
	end)

	TabBtn.MouseButton1Click:Connect(function()
		for _, v in pairs(ui.Objects.Tabs) do 
			v.Page.Visible = false
			Tween(v.Btn, {BackgroundTransparency = 1, TextColor3 = theme.SecondaryText}) 
		end
		Page.Visible = true
		Tween(TabBtn, {BackgroundTransparency = 0.8, TextColor3 = theme.Accent})
	end)

	if #ui.Objects.Tabs == 0 then 
		Page.Visible = true
		TabBtn.BackgroundTransparency = 0.8
		TabBtn.TextColor3 = theme.Accent
	end

	table.insert(ui.Objects.Tabs, {Page = Page, Btn = TabBtn})

	local PageAPI = {}
	-- [7. ЕЛЕМЕНТ: КНОПКА (AddButton)]
	function PageAPI:AddButton(text, callback)
		local b = Instance.new("TextButton", Page)
		b.Size = UDim2.new(1, -10, 0, 35)
		b.BackgroundColor3 = theme.ElementBg
		b.Text = text
		b.TextColor3 = theme.Text
		b.Font = Enum.Font.Gotham
		b.TextSize = 14
		Instance.new("UICorner", b).CornerRadius = Settings.CornerRadius

		-- Анімація кліку
		b.MouseButton1Click:Connect(function()
			local oldColor = b.BackgroundColor3
			Tween(b, {BackgroundColor3 = theme.Accent}, 0.1)
			task.wait(0.1)
			Tween(b, {BackgroundColor3 = oldColor}, 0.2)
			callback()
		end)

		table.insert(ui.Objects.Elements, {Instance = b, Type = "Element"})
	end

	-- [8. ЕЛЕМЕНТ: ПЕРЕМИКАЧ (AddToggle)]
	function PageAPI:AddToggle(text, default, callback)
		local state = default or false

		local b = Instance.new("TextButton", Page)
		b.Size = UDim2.new(1, -10, 0, 35)
		b.BackgroundColor3 = theme.ElementBg
		b.Text = "  " .. text
		b.TextColor3 = state and theme.Text or theme.SecondaryText
		b.Font = Enum.Font.Gotham
		b.TextSize = 14
		b.TextXAlignment = 0
		Instance.new("UICorner", b).CornerRadius = Settings.CornerRadius

		local ind = Instance.new("Frame", b)
		ind.Size = UDim2.new(0, 16, 0, 16)
		ind.Position = UDim2.new(1, -26, 0.5, -8)
		ind.BackgroundColor3 = state and theme.Accent or Color3.fromRGB(60, 60, 60)
		Instance.new("UICorner", ind).CornerRadius = UDim.new(0, 4)

		b.MouseButton1Click:Connect(function()
			state = not state
			Tween(ind, {BackgroundColor3 = state and theme.Accent or Color3.fromRGB(60, 60, 60)}, 0.2)
			Tween(b, {TextColor3 = state and theme.Text or theme.SecondaryText}, 0.2)
			callback(state)
		end)

		table.insert(ui.Objects.Elements, {Instance = b, Type = "Element"})
	end

	-- [9. ЕЛЕМЕНТ: СЛАЙДЕР (AddSlider)]
	function PageAPI:AddSlider(text, min, max, default, callback)
		local val = math.clamp(default or min, min, max)

		local s = Instance.new("Frame", Page)
		s.Size = UDim2.new(1, -10, 0, 45)
		s.BackgroundColor3 = theme.ElementBg
		Instance.new("UICorner", s).CornerRadius = Settings.CornerRadius

		local l = Instance.new("TextLabel", s)
		l.Size = UDim2.new(1, -20, 0, 20)
		l.Position = UDim2.new(0, 10, 0, 5)
		l.Text = text .. ": " .. val
		l.TextColor3 = theme.Text
		l.BackgroundTransparency = 1
		l.TextXAlignment = 0
		l.Font = Enum.Font.Gotham
		l.TextSize = 13

		local b = Instance.new("Frame", s)
		b.Size = UDim2.new(1, -20, 0, 4)
		b.Position = UDim2.new(0, 10, 0, 32)
		b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		Instance.new("UICorner", b)

		local f = Instance.new("Frame", b)
		f.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
		f.BackgroundColor3 = theme.Accent
		Instance.new("UICorner", f)

		local dragging = false
		local function update(input)
			local p = math.clamp((input.Position.X - b.AbsolutePosition.X) / b.AbsoluteSize.X, 0, 1)
			val = math.floor(min + (max - min) * p)
			f.Size = UDim2.new(p, 0, 1, 0)
			l.Text = text .. ": " .. val
			callback(val)
		end

		b.InputBegan:Connect(function(i) 
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
				dragging = true 
				update(i) 
			end 
		end)

		UserInputService.InputChanged:Connect(function(i) 
			if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
				update(i) 
			end 
		end)

		UserInputService.InputEnded:Connect(function(i) 
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
				dragging = false 
			end 
		end)

		table.insert(ui.Objects.Elements, {Instance = s, Type = "Element"})
	end

	-- [10. ЕЛЕМЕНТ: ВИПАДАЮЧИЙ СПИСОК (AddDropdown)]
	function PageAPI:AddDropdown(text, list, callback)
		local opened = false
		local selected = list[1]

		local d = Instance.new("Frame", Page)
		d.Size = UDim2.new(1, -10, 0, 35)
		d.BackgroundColor3 = theme.ElementBg
		d.ClipsDescendants = true
		Instance.new("UICorner", d).CornerRadius = Settings.CornerRadius

		local h = Instance.new("TextButton", d)
		h.Size = UDim2.new(1, 0, 0, 35)
		h.BackgroundTransparency = 1
		h.Text = "  " .. text .. ": " .. tostring(selected)
		h.TextColor3 = theme.SecondaryText
		h.Font = Enum.Font.Gotham; h.TextSize = 14; h.TextXAlignment = 0

		local c = Instance.new("Frame", d)
		c.Position = UDim2.new(0, 0, 0, 35)
		c.Size = UDim2.new(1, 0, 0, 0)
		c.BackgroundTransparency = 1
		local l = Instance.new("UIListLayout", c)

		local function refresh()
			for _, v in pairs(list) do
				local i = Instance.new("TextButton", c)
				i.Size = UDim2.new(1, 0, 0, 30)
				i.BackgroundTransparency = 1
				i.Text = tostring(v)
				i.TextColor3 = theme.SecondaryText
				i.Font = Enum.Font.Gotham; i.TextSize = 13

				i.MouseButton1Click:Connect(function()
					selected = v
					h.Text = "  " .. text .. ": " .. tostring(v)
					opened = false
					Tween(d, {Size = UDim2.new(1, -10, 0, 35)})
					callback(v)
				end)
			end
		end

		h.MouseButton1Click:Connect(function()
			opened = not opened
			local target = opened and UDim2.new(1, -10, 0, 35 + l.AbsoluteContentSize.Y) or UDim2.new(1, -10, 0, 35)
			Tween(d, {Size = target})
		end)

		refresh()
		table.insert(ui.Objects.Elements, {Instance = d, Type = "Element"})
	end

	-- [11. ЕЛЕМЕНТ: БІНД КЛАВІШ (AddKeybind)]
	function PageAPI:AddKeybind(text, default, callback)
		local key = default
		local binding = false

		local b = Instance.new("Frame", Page)
		b.Size = UDim2.new(1, -10, 0, 35); b.BackgroundColor3 = theme.ElementBg
		Instance.new("UICorner", b).CornerRadius = Settings.CornerRadius

		local l = Instance.new("TextLabel", b)
		l.Size = UDim2.new(1, 0, 1, 0); l.Position = UDim2.new(0, 10, 0, 0)
		l.Text = text; l.TextColor3 = theme.SecondaryText; l.Font = 17; l.TextSize = 14; l.TextXAlignment = 0; l.BackgroundTransparency = 1

		local k = Instance.new("TextButton", b)
		k.Size = UDim2.new(0, 70, 0, 22); k.Position = UDim2.new(1, -80, 0.5, -11)
		k.BackgroundColor3 = Color3.fromRGB(35, 35, 35); k.Text = key.Name; k.TextColor3 = theme.Text; k.Font = 17; k.TextSize = 12
		Instance.new("UICorner", k)

		k.MouseButton1Click:Connect(function()
			binding = true
			k.Text = "..."
		end)

		UserInputService.InputBegan:Connect(function(input, gpe)
			if gpe then return end
			if binding then
				if input.UserInputType == Enum.UserInputType.Keyboard then
					key = input.KeyCode
					k.Text = key.Name
					binding = false
				end
			elseif input.KeyCode == key then
				callback()
			end
		end)
	end

	-- [12. ЕЛЕМЕНТ: ПОЛЕ ВВОДУ (AddTextBox)]
	function PageAPI:AddTextBox(text, placeholder, callback)
		local b = Instance.new("Frame", Page)
		b.Size = UDim2.new(1, -10, 0, 35); b.BackgroundColor3 = theme.ElementBg
		Instance.new("UICorner", b).CornerRadius = Settings.CornerRadius

		local t = Instance.new("TextBox", b)
		t.Size = UDim2.new(1, -20, 1, 0); t.Position = UDim2.new(0, 10, 0, 0)
		t.BackgroundTransparency = 1; t.Text = ""; t.PlaceholderText = text .. " (" .. placeholder .. ")"
		t.PlaceholderColor3 = theme.SecondaryText; t.TextColor3 = theme.Text; t.Font = 17; t.TextSize = 14; t.TextXAlignment = 0

		t.FocusLost:Connect(function(enter)
			callback(t.Text, enter)
		end)
	end

	-- [13. ЕЛЕМЕНТ: ВИБІР КОЛЬОРУ (AddColorPicker)]
	function PageAPI:AddColorPicker(text, default, callback)
		local ui = ui -- Посилання на головний об'єкт
		local theme = theme
		local currentColor = default or Color3.fromRGB(255, 0, 0)
		local opened = false

		local p = Instance.new("Frame", Page)
		p.Size = UDim2.new(1, -10, 0, 35)
		p.BackgroundColor3 = theme.ElementBg
		p.ClipsDescendants = true
		Instance.new("UICorner", p).CornerRadius = Settings.CornerRadius

		local h = Instance.new("TextButton", p)
		h.Size = UDim2.new(1, 0, 0, 35)
		h.BackgroundTransparency = 1
		h.Text = "  " .. text
		h.TextColor3 = theme.SecondaryText
		h.Font = Enum.Font.Gotham; h.TextSize = 14; h.TextXAlignment = 0

		local preview = Instance.new("Frame", h)
		preview.Size = UDim2.new(0, 20, 0, 20)
		preview.Position = UDim2.new(1, -30, 0.5, -10)
		preview.BackgroundColor3 = currentColor
		Instance.new("UICorner", preview).CornerRadius = UDim.new(0, 4)

		local container = Instance.new("Frame", p)
		container.Position = UDim2.new(0, 0, 0, 35)
		container.Size = UDim2.new(1, 0, 0, 100)
		container.BackgroundTransparency = 1

		local function createChannel(name, color, yPos, property)
			local canvas = Instance.new("Frame", container)
			canvas.Size = UDim2.new(1, -20, 0, 30)
			canvas.Position = UDim2.new(0, 10, 0, yPos)
			canvas.BackgroundTransparency = 1

			local label = Instance.new("TextLabel", canvas)
			label.Size = UDim2.new(0, 20, 1, 0)
			label.Text = name; label.TextColor3 = color; label.Font = Enum.Font.GothamBold
			label.BackgroundTransparency = 1; label.TextSize = 12

			local bar = Instance.new("Frame", canvas)
			bar.Size = UDim2.new(1, -30, 0, 4)
			bar.Position = UDim2.new(0, 25, 0.5, -2)
			bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			Instance.new("UICorner", bar)

			local fill = Instance.new("Frame", bar)
			local startVal = (property == "R" and currentColor.R or property == "G" and currentColor.G or currentColor.B)
			fill.Size = UDim2.new(startVal, 0, 1, 0); fill.BackgroundColor3 = color
			Instance.new("UICorner", fill)

			local drag = false
			local function update(input)
				local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
				fill.Size = UDim2.new(pos, 0, 1, 0)

				local r, g, b = currentColor.R, currentColor.G, currentColor.B
				if property == "R" then r = pos elseif property == "G" then g = pos else b = pos end
				currentColor = Color3.new(r, g, b)
				preview.BackgroundColor3 = currentColor
				callback(currentColor)
			end

			bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true update(i) end end)
			UserInputService.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then update(i) end end)
			UserInputService.InputEnded:Connect(function() drag = false end)
		end

		createChannel("R", Color3.fromRGB(255, 75, 75), 5, "R")
		createChannel("G", Color3.fromRGB(75, 255, 75), 35, "G")
		createChannel("B", Color3.fromRGB(75, 75, 255), 65, "B")

		h.MouseButton1Click:Connect(function()
			opened = not opened
			Tween(p, {Size = opened and UDim2.new(1, -10, 0, 140) or UDim2.new(1, -10, 0, 35)})
		end)
	end

	return PageAPI
end
-- [15. МЕНЕДЖЕР ТЕМ (Theme Manager)]

-- Функція для оновлення конкретного об'єкта під нову тему
function TerrorUi:_UpdateObjectTheme(obj, theme)
	if obj.Type == "Element" or obj.Type == "Tab" then
		Tween(obj.Instance, {BackgroundColor3 = theme.ElementBg})
		-- Якщо це текст, можна додати логіку оновлення кольору тексту
	elseif obj.Type == "Main" then
		Tween(obj.Instance, {BackgroundColor3 = theme.MainBg})
	elseif obj.Type == "Accent" then
		if obj.Instance:IsA("Frame") then
			Tween(obj.Instance, {BackgroundColor3 = theme.Accent})
		elseif obj.Instance:IsA("TextLabel") or obj.Instance:IsA("TextButton") then
			Tween(obj.Instance, {TextColor3 = theme.Accent})
		elseif obj.Instance:IsA("UIStroke") then
			Tween(obj.Instance, {Color = theme.Accent})
		end
	end
end

-- Головна функція зміни теми
function TerrorUi:SetTheme(themeName)
	local newTheme = Themes[themeName]
	if not newTheme then 
		warn("TerrorUi: Тема '" .. tostring(themeName) .. "' не знайдена!")
		return 
	end

	self.Theme = newTheme

	-- 1. Оновлюємо головне вікно
	Tween(self.MainFrame, {BackgroundColor3 = newTheme.MainBg})

	-- 2. Оновлюємо заголовок
	-- (Якщо ти реєстрував TitleLabel в Objects)

	-- 3. Проходимо по всіх зареєстрованих об'єктах
	for _, obj in pairs(self.Objects.Elements) do
		if obj.Instance and obj.Instance.Parent then
			-- Оновлюємо фон елемента
			if obj.Instance:IsA("TextButton") or obj.Instance:IsA("Frame") then
				Tween(obj.Instance, {BackgroundColor3 = newTheme.ElementBg})
			end

			-- Оновлюємо акценти всередині елемента (чекбокси, слайдери)
			for _, child in pairs(obj.Instance:GetDescendants()) do
				if child.Name == "Indicator" or child.Name == "Fill" then
					Tween(child, {BackgroundColor3 = newTheme.Accent})
				end
			end
		end
	end

	-- 4. Оновлюємо активні та неактивні вкладки
	for _, tab in pairs(self.Objects.Tabs) do
		if tab.Page.Visible then
			Tween(tab.Btn, {TextColor3 = newTheme.Accent})
		else
			Tween(tab.Btn, {TextColor3 = newTheme.SecondaryText})
		end
	end

	-- 5. Оновлюємо мобільну кнопку, якщо вона є
	if self.ScreenGui:FindFirstChild("TerrorMobile") then
		local MB = self.ScreenGui.TerrorMobile
		Tween(MB, {BackgroundColor3 = newTheme.MainBg, TextColor3 = newTheme.Accent})
		if MB:FindFirstChildOfClass("UIStroke") then
			Tween(MB:FindFirstChildOfClass("UIStroke"), {Color = newTheme.Accent})
		end
	end
end

-- Додатковий метод для створення власних тем вручну
function TerrorUi:AddCustomTheme(name, config)
	Themes[name] = config
end

return TerrorUi
