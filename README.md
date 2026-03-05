# Xyrix-script
script rblx

SCRIPT HERE 

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "XyrixXSLR"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 560, 0, 440)
frame.Position = UDim2.new(0.5,-280,0.5,-220)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui
Instance.new("UICorner",frame).CornerRadius = UDim.new(0,18)

local stroke = Instance.new("UIStroke",frame)
stroke.Color = Color3.fromRGB(200,0,0)
stroke.Thickness = 2

-- DRAGGING
local dragging, dragStart, startPos
frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- CTRL TOGGLE
UIS.InputBegan:Connect(function(input,gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
		frame.Visible = not frame.Visible
	end
end)

-- TITLE
local title = Instance.new("TextLabel",frame)
title.Size = UDim2.new(1,-20,0,45)
title.Position = UDim2.new(0,15,0,5)
title.BackgroundTransparency = 1
title.Text = "Xyrix X SLR"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack

-- TAB PANEL
local tabPanel = Instance.new("Frame",frame)
tabPanel.Size = UDim2.new(0,140,1,-60)
tabPanel.Position = UDim2.new(0,10,0,55)
tabPanel.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner",tabPanel).CornerRadius = UDim.new(0,15)

-- CONTENT AREA
local contentArea = Instance.new("Frame",frame)
contentArea.Size = UDim2.new(1,-170,1,-60)
contentArea.Position = UDim2.new(0,160,0,55)
contentArea.BackgroundColor3 = Color3.fromRGB(22,22,22)
Instance.new("UICorner",contentArea).CornerRadius = UDim.new(0,15)

local contents = {}
local tabButtons = {}

local function createTab(name,order)
	local btn = Instance.new("TextButton",tabPanel)
	btn.Size = UDim2.new(1,-10,0,40)
	btn.Position = UDim2.new(0,5,0,(order-1)*50+10)
	btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
	btn.Text = name
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,10)

	local content = Instance.new("ScrollingFrame",contentArea)
	content.Size = UDim2.new(1,0,1,0)
	content.ScrollBarThickness = 6
	content.ScrollBarImageColor3 = Color3.fromRGB(200,0,0)
	content.BackgroundTransparency = 1
	content.Visible = false

	local layout = Instance.new("UIListLayout",content)
	layout.Padding = UDim.new(0,15)

	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		content.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+20)
	end)

	btn.MouseButton1Click:Connect(function()
		for _,c in pairs(contents) do c.Visible = false end
		for _,b in pairs(tabButtons) do b.BackgroundColor3 = Color3.fromRGB(40,40,40) end
		content.Visible = true
		btn.BackgroundColor3 = Color3.fromRGB(150,0,0)
	end)

	table.insert(contents,content)
	table.insert(tabButtons,btn)
	return content
end

-- TABS
local mainTab = createTab("Main",1)
local playerTab = createTab("Player",2)
createTab("Visuals",3)
createTab("Help",4)
createTab("Server",5)
createTab("Stealer",6)
createTab("Discord",7)

contents[1].Visible = true
tabButtons[1].BackgroundColor3 = Color3.fromRGB(150,0,0)

------------------------------------------------
-- SWITCH TOGGLE CREATOR
------------------------------------------------
local function createToggle(parent,text,callback)
	local holder = Instance.new("Frame",parent)
	holder.Size = UDim2.new(1,-20,0,60)
	holder.BackgroundColor3 = Color3.fromRGB(35,35,35)
	Instance.new("UICorner",holder).CornerRadius = UDim.new(0,12)

	local label = Instance.new("TextLabel",holder)
	label.Size = UDim2.new(0.6,0,1,0)
	label.Position = UDim2.new(0,15,0,0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.new(1,1,1)
	label.TextScaled = true
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left

	local switch = Instance.new("Frame",holder)
	switch.Size = UDim2.new(0,60,0,28)
	switch.Position = UDim2.new(1,-80,0.5,-14)
	switch.BackgroundColor3 = Color3.fromRGB(60,0,0)
	Instance.new("UICorner",switch).CornerRadius = UDim.new(1,0)

	local knob = Instance.new("Frame",switch)
	knob.Size = UDim2.new(0,24,0,24)
	knob.Position = UDim2.new(0,2,0,2)
	knob.BackgroundColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)

	local enabled = false

	holder.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			enabled = not enabled

			if enabled then
				switch.BackgroundColor3 = Color3.fromRGB(200,0,0)
				knob.Position = UDim2.new(1,-26,0,2)
			else
				switch.BackgroundColor3 = Color3.fromRGB(60,0,0)
				knob.Position = UDim2.new(0,2,0,2)
			end

			if callback then
				callback(enabled)
			end
		end
	end)
end

------------------------------------------------
-- FLY
------------------------------------------------
local flying = false
local bodyVel
local flyConn

createToggle(mainTab,"Fly",function(state)
	local char = getChar()
	local hrp = char:WaitForChild("HumanoidRootPart")
	flying = state

	if flying then
		bodyVel = Instance.new("BodyVelocity",hrp)
		bodyVel.MaxForce = Vector3.new(1e5,1e5,1e5)

		flyConn = RunService.RenderStepped:Connect(function()
			local cam = workspace.CurrentCamera
			local speed = UIS:IsKeyDown(Enum.KeyCode.LeftShift) and 120 or 60
			local move = Vector3.new()

			if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end

			if move.Magnitude > 0 then
				bodyVel.Velocity = move.Unit * speed
			else
				bodyVel.Velocity = Vector3.new()
			end
		end)
	else
		if bodyVel then bodyVel:Destroy() end
		if flyConn then flyConn:Disconnect() end
	end
end)

------------------------------------------------
-- RED ESP AURA
------------------------------------------------
local highlight

createToggle(playerTab,"Red Aura",function(state)
	local char = getChar()

	if state then
		highlight = Instance.new("Highlight",char)
		highlight.FillColor = Color3.fromRGB(255,0,0)
		highlight.OutlineColor = Color3.fromRGB(255,80,80)
	else
		if highlight then highlight:Destroy() end
	end
end)

------------------------------------------------
-- 🏃 SPEED SLIDER
------------------------------------------------

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local normalSpeed = 16
local selectedSpeed = 16
local speedEnabled = false

local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

-- HOLDER FRAME
local speedHolder = Instance.new("Frame", playerTab)
speedHolder.Size = UDim2.new(1,-20,0,100)
speedHolder.BackgroundColor3 = Color3.fromRGB(35,35,35)
Instance.new("UICorner",speedHolder).CornerRadius = UDim.new(0,12)

-- LABEL
local speedLabel = Instance.new("TextLabel", speedHolder)
speedLabel.Size = UDim2.new(1,-20,0,30)
speedLabel.Position = UDim2.new(0,10,0,5)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: 16"
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.GothamBold

-- SLIDER BAR
local sliderBar = Instance.new("Frame", speedHolder)
sliderBar.Size = UDim2.new(1,-40,0,10)
sliderBar.Position = UDim2.new(0,20,0,45)
sliderBar.BackgroundColor3 = Color3.fromRGB(60,0,0)
Instance.new("UICorner",sliderBar).CornerRadius = UDim.new(1,0)

-- SLIDER KNOB
local knob = Instance.new("Frame", sliderBar)
knob.Size = UDim2.new(0,18,0,18)
knob.Position = UDim2.new(0,0,-0.4,0)
knob.BackgroundColor3 = Color3.fromRGB(255,0,0)
Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)

local dragging = false

knob.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		
		local relativeX = math.clamp(
			(input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X,
			0, 1
		)
		
		knob.Position = UDim2.new(relativeX, -9, -0.4, 0)
		
		selectedSpeed = math.floor(16 + (relativeX * 84)) -- 16 to 100
		speedLabel.Text = "Speed: " .. selectedSpeed
		
		if speedEnabled then
			local char = getChar()
			char:WaitForChild("Humanoid").WalkSpeed = selectedSpeed
		end
	end
end)

------------------------------------------------
-- TOGGLE
------------------------------------------------

createToggle(playerTab,"Enable Speed",function(state)
	speedEnabled = state
	
	local char = getChar()
	local humanoid = char:WaitForChild("Humanoid")
	
	if speedEnabled then
		humanoid.WalkSpeed = selectedSpeed
	else
		humanoid.WalkSpeed = normalSpeed
	end
end)
------------------------------------------------
-- 🔴 RED PLAYER ESP
------------------------------------------------
local visualsTab = contents[3] -- Visuals tab index
local espEnabled = false
local espObjects = {}

local function createESP(plr)
	if plr == player then return end
	if not plr.Character then return end
	if espObjects[plr] then return end
	
	local highlight = Instance.new("Highlight")
	highlight.FillColor = Color3.fromRGB(255, 0, 0)
	highlight.OutlineColor = Color3.fromRGB(150, 0, 0)
	highlight.FillTransparency = 0.4
	highlight.OutlineTransparency = 0
	highlight.Parent = plr.Character
	
	espObjects[plr] = highlight
end

local function removeESP()
	for _,v in pairs(espObjects) do
		if v then
			v:Destroy()
		end
	end
	espObjects = {}
end

createToggle(visualsTab,"Red ESP",function(state)
	espEnabled = state
	
	if espEnabled then
		for _,plr in pairs(game.Players:GetPlayers()) do
			createESP(plr)
		end
		
		game.Players.PlayerAdded:Connect(function(plr)
			plr.CharacterAdded:Connect(function()
				task.wait(1)
				if espEnabled then
					createESP(plr)
				end
			end)
		end)
	else
		removeESP()
	end
end)


