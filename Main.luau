local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local AdminAPI = {}
AdminAPI.__index = AdminAPI

function AdminAPI.new(title: string)
	local self = setmetatable({}, AdminAPI)
	
	-- Основной контейнер (ScreenGui)
	self.ScreenGui = Instance.new("ScreenGui")
	self.ScreenGui.Name = "AdminMenu"
	self.ScreenGui.ResetOnSpawn = false
	self.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	
	-- Главное окно (CanvasGroup для плавной прозрачности всего меню)
	self.MainFrame = Instance.new("CanvasGroup")
	self.MainFrame.Size = UDim2.new(0, 400, 0, 500)
	self.MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
	self.MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	self.MainFrame.BackgroundTransparency = 0.2
	self.MainFrame.BorderSizePixel = 0
	self.MainFrame.Visible = true
	self.MainFrame.Parent = self.ScreenGui
	
	-- Скругление углов
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = self.MainFrame
	
	-- Градиент
	local UIGradient = Instance.new("UIGradient")
	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
	})
	UIGradient.Rotation = 45
	UIGradient.Parent = self.MainFrame
	
	-- Заголовок
	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, -20, 0, 40)
	Title.Position = UDim2.new(0, 10, 0, 5)
	Title.BackgroundTransparency = 1
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 18
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = self.MainFrame
	
	-- Контейнер для кнопок
	self.Container = Instance.new("ScrollingFrame")
	self.Container.Size = UDim2.new(1, -20, 1, -60)
	self.Container.Position = UDim2.new(0, 10, 0, 50)
	self.Container.BackgroundTransparency = 1
	self.Container.BorderSizePixel = 0
	self.Container.ScrollBarThickness = 2
	self.Container.Parent = self.MainFrame
	
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.Parent = self.Container
	
	-- Настройка горячих клавиш (По умолчанию 'M')
	self:SetupToggle(Enum.KeyCode.M)
	
	return self
end

-- Метод для добавления кнопки
function AdminAPI:AddButton(text: string, callback: () -> ())
	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, -10, 0, 35)
	Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Button.BackgroundTransparency = 0.9
	Button.Text = text
	Button.TextColor3 = Color3.fromRGB(220, 220, 220)
	Button.Font = Enum.Font.Gotham
	Button.TextSize = 14
	Button.AutoButtonColor = true
	Button.Parent = self.Container
	
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Button
	
	Button.MouseButton1Click:Connect(callback)
end

-- Логика переключения видимости
function AdminAPI:SetupToggle(keyCode)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == keyCode then
			self.MainFrame.Visible = not self.MainFrame.Visible
			-- Небольшая анимация появления
			if self.MainFrame.Visible then
				self.MainFrame.GroupTransparency = 1
				TweenService:Create(self.MainFrame, TweenInfo.new(0.3), {GroupTransparency = 0}):Play()
			end
		end
	end)
end

return AdminAPI
