--========================================

-- BASIC GAO MENU (DRAG PC + MOBILE)

-- NO CORNER - NO TOGGLE

--========================================

local Players = game:GetService("Players")

local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local TweenService = game:GetService("TweenService")

-- ScreenGui

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "BasicMenu"

ScreenGui.ResetOnSpawn = false

ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame

local MainFrame = Instance.new("Frame")

MainFrame.Size = UDim2.new(0, 220, 0, 300)

MainFrame.Position = UDim2.new(0, 100, 0, 100)

MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

MainFrame.BorderSizePixel = 0

MainFrame.Active = true

MainFrame.Parent = ScreenGui

-- Header (kéo menu)

local Header = Instance.new("TextLabel")

Header.Size = UDim2.new(1, 0, 0, 40)

Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

Header.BorderSizePixel = 0

Header.Text = "Escape Tsunami"

Header.TextColor3 = Color3.new(1,1,1)

Header.Font = Enum.Font.SourceSansBold

Header.TextSize = 20

Header.Active = true

Header.Parent = MainFrame

-- CollapseBtn

local CollapseBtn = Instance.new("TextButton")

CollapseBtn.Size = UDim2.new(0, 40, 1, 0)

CollapseBtn.Position = UDim2.new(1, -40, 0, 0)

CollapseBtn.BackgroundTransparency = 1

CollapseBtn.Text = "⬆️"

CollapseBtn.TextColor3 = Color3.new(1,1,1)

CollapseBtn.Font = Enum.Font.SourceSansBold

CollapseBtn.TextSize = 20

CollapseBtn.Parent = Header

-- Content

local Content = Instance.new("Frame")

Content.Size = UDim2.new(1, 0, 1, -40)

Content.Position = UDim2.new(0, 0, 0, 40)

Content.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

Content.BorderSizePixel = 0

Content.Parent = MainFrame
--================ GAP UP BUTTON =================

local GapUpBtn = Instance.new("TextButton")

GapUpBtn.Size = UDim2.new(1, -20, 0, 40)

GapUpBtn.Position = UDim2.new(0, 10, 0, 10)

GapUpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

GapUpBtn.BorderSizePixel = 0

GapUpBtn.Text = "GAP UP"

GapUpBtn.TextColor3 = Color3.new(1,1,1)

GapUpBtn.Font = Enum.Font.SourceSansBold

GapUpBtn.TextSize = 18

GapUpBtn.Parent = Content
--========================================

-- DRAG SCRIPT (PC + MOBILE)

--========================================

local dragging = false

local dragInput

local dragStart

local startPos

local function update(input)

	local delta = input.Position - dragStart	MainFrame.Position = UDim2.new(

		startPos.X.Scale,

		startPos.X.Offset + delta.X,

		startPos.Y.Scale,

		startPos.Y.Offset + delta.Y

	)

end

Header.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1

	or input.UserInputType == Enum.UserInputType.Touch then

		

		dragging = true

		dragStart = input.Position

		startPos = MainFrame.Position

		input.Changed:Connect(function()

			if input.UserInputState == Enum.UserInputState.End then

				dragging = false

			end

		end)

	end

end)

Header.InputChanged:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseMovement

	or input.UserInputType == Enum.UserInputType.Touch then

		dragInput = input

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if input == dragInput and dragging then

		update(input)

	end

end)

local collapsed = false

local fullSize = UDim2.new(0, 220, 0, 300)

local miniSize = UDim2.new(0, 220, 0, 40)

local tweenInfo = TweenInfo.new(

	0.25, -- thời gian (giây)

	Enum.EasingStyle.Quad,

	Enum.EasingDirection.Out

)

CollapseBtn.MouseButton1Click:Connect(function()

	collapsed = not collapsed

	if collapsed then

		Content.Visible = false

		local tween = TweenService:Create(

			MainFrame,

			tweenInfo,

			{Size = miniSize}

		)

		tween:Play()

		CollapseBtn.Text = "⬇️"

	else

		local tween = TweenService:Create(

			MainFrame,

			tweenInfo,

			{Size = fullSize}

		)

		tween:Play()

		task.delay(0.05, function()

			Content.Visible = true

		end)

		CollapseBtn.Text = "⬆️"

	end

end)
