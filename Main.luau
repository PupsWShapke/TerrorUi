-- AdminMenuModule
local AdminMenu = {}
AdminMenu.__index = AdminMenu

-- НАСТРОЙКИ
AdminMenu.Settings = {
	ToggleKey = Enum.KeyCode.RightShift,
	Gradient = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
	}),
	BackgroundTransparency = 0.2
}


-- СОЗДАНИЕ GUI
function AdminMenu:Create()
	local player = game.Players.LocalPlayer
	local gui = Instance.new("ScreenGui")
	gui.Name = "AdminMenuGUI"
	gui.ResetOnSpawn = false
	gui.Parent = player:WaitForChild("PlayerGui")

	-- ОСНОВНОЙ ФРЕЙМ
	local main = Instance.new("Frame")
	main.Size = UDim2.fromScale(0.35, 0.45)
	main.Position = UDim2.fromScale(0.5, 0.5)
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.BackgroundTransparency = self.Settings.BackgroundTransparency
	main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	main.Visible = false
	main.Parent = gui

	-- СКРУГЛЕНИЕ
	Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

	-- ГРАДИЕНТ
	local gradient = Instance.new("UIGradient")
	gradient.Color = self.Settings.Gradient
	gradient.Parent = main

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -20, 0, 40)
	title.Position = UDim2.fromOffset(10, 10)
	title.BackgroundTransparency = 1
	title.Text = "ADMIN PANEL"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamMedium
	title.TextSize = 20
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextYAlignment = Enum.TextYAlignment.Center
	title.Parent = main


	self.Gui = gui
	self.MainFrame = main
	self.Visible = false

	self:_BindHotkey()
end

-- ГОРЯЧАЯ КЛАВИША
function AdminMenu:_BindHotkey()
	local UIS = game:GetService("UserInputService")

	UIS.InputBegan:Connect(function(input, gp)
		if gp then return end
		if input.KeyCode == self.Settings.ToggleKey then
			self:Toggle()
		end
	end)
end

-- ОТКРЫТИЕ / ЗАКРЫТИЕ
function AdminMenu:Toggle()
	self.Visible = not self.Visible
	self.MainFrame.Visible = self.Visible
end

-- ДОБАВЛЕНИЕ КНОПКИ
function AdminMenu:AddButton(text, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -20, 0, 40)
	button.BackgroundTransparency = 0.3
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	button.Text = text
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.Gotham
	button.TextSize = 16
	button.Parent = self.MainFrame

	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

	button.MouseButton1Click:Connect(function()
		if callback then
			callback()
		end
	end)
end

return AdminMenu
