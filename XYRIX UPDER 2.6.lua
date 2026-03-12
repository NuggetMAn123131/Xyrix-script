-- XYRIX HUB CLEAN FIXED VERSION

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "XyrixHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,560,0,440)
frame.Position = UDim2.new(0.5,-280,0.5,-220)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
frame.BackgroundTransparency = 0.35
frame.BorderSizePixel = 0
frame.Active = true
frame.Visible = true
frame.Parent = gui
Instance.new("UICorner",frame).CornerRadius = UDim.new(0,18)

------------------------------------------------
-- MINI OPEN BUTTON
------------------------------------------------

local miniButton = Instance.new("TextButton")
miniButton.Parent = gui
miniButton.Size = UDim2.new(0,110,0,34)
miniButton.Position = UDim2.new(0,12,0,120)
miniButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
miniButton.BackgroundTransparency = 0.3
miniButton.Text = "Xyrix"
miniButton.Font = Enum.Font.GothamBold
miniButton.TextSize = 18
miniButton.TextColor3 = Color3.fromRGB(255,255,255)
miniButton.BorderSizePixel = 0
Instance.new("UICorner",miniButton).CornerRadius = UDim.new(1,0)

miniButton.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

------------------------------------------------
-- DRAG MENU
------------------------------------------------

local dragging = false
local dragStart
local startPos

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
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

------------------------------------------------
-- CTRL TOGGLE
------------------------------------------------

UIS.InputBegan:Connect(function(input,gpe)
	if gpe then return end

	if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
		frame.Visible = not frame.Visible
	end
end)

------------------------------------------------
-- FLASHING TITLE
------------------------------------------------

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,-20,0,50)
title.Position = UDim2.new(0,10,0,5)
title.BackgroundTransparency = 1
title.Text = "Xyrix Hub"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)

task.spawn(function()
	while true do
		TweenService:Create(title,TweenInfo.new(0.6),{
			TextColor3 = Color3.new(0,0,0)
		}):Play()
		task.wait(0.6)

		TweenService:Create(title,TweenInfo.new(0.6),{
			TextColor3 = Color3.new(1,1,1)
		}):Play()
		task.wait(0.6)
	end
end)

------------------------------------------------
-- TAB PANEL
------------------------------------------------

local tabPanel = Instance.new("Frame",frame)
tabPanel.Size = UDim2.new(0,140,1,-60)
tabPanel.Position = UDim2.new(0,10,0,55)
tabPanel.BackgroundColor3 = Color3.fromRGB(10,10,10)
tabPanel.BackgroundTransparency = 0.2
Instance.new("UICorner",tabPanel).CornerRadius = UDim.new(0,15)

-- CONTENT AREA

local contentArea = Instance.new("Frame",frame)
contentArea.Size = UDim2.new(1,-170,1,-60)
contentArea.Position = UDim2.new(0,160,0,55)
contentArea.BackgroundColor3 = Color3.fromRGB(10,10,10)
contentArea.BackgroundTransparency = 0.2
Instance.new("UICorner",contentArea).CornerRadius = UDim.new(0,15)

------------------------------------------------
-- TAB SYSTEM
------------------------------------------------

local contents = {}
local tabButtons = {}

local function createTab(name,order)

	local btn = Instance.new("TextButton",tabPanel)
	btn.Size = UDim2.new(1,-10,0,40)
	btn.Position = UDim2.new(0,5,0,(order-1)*50+10)
	btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
	btn.Text = name
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,10)

	local content = Instance.new("ScrollingFrame",contentArea)
	content.Size = UDim2.new(1,0,1,0)
	content.BackgroundTransparency = 1
	content.ScrollBarThickness = 5
	content.Visible = false

	local layout = Instance.new("UIListLayout",content)
	layout.Padding = UDim.new(0,10)

	btn.MouseButton1Click:Connect(function()

		for _,c in pairs(contents) do
			c.Visible = false
		end

		content.Visible = true

	end)

	table.insert(contents,content)
	table.insert(tabButtons,btn)

	return content
end

------------------------------------------------
-- TOGGLE CREATOR
------------------------------------------------

local function createToggle(parent,text,callback)

	local holder = Instance.new("Frame")
	holder.Parent = parent
	holder.Size = UDim2.new(1,-10,0,40)
	holder.BackgroundTransparency = 1

	local label = Instance.new("TextLabel")
	label.Parent = holder
	label.Size = UDim2.new(0.7,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.new(1,1,1)
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true

	local switch = Instance.new("Frame")
	switch.Parent = holder
	switch.Size = UDim2.new(0,40,0,20)
	switch.Position = UDim2.new(1,-50,0.5,-10)
	switch.BackgroundColor3 = Color3.fromRGB(40,40,40)

	Instance.new("UICorner",switch).CornerRadius = UDim.new(1,0)

	local knob = Instance.new("Frame")
	knob.Parent = switch
	knob.Size = UDim2.new(0,18,0,18)
	knob.Position = UDim2.new(0,1,0.5,-9)
	knob.BackgroundColor3 = Color3.fromRGB(255,255,255)

	Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)

	local state = false

	holder.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then

			state = not state

			if state then
				switch.BackgroundColor3 = Color3.fromRGB(200,0,0)
				knob:TweenPosition(UDim2.new(1,-19,0.5,-9),"Out","Quad",0.15,true)
			else
				switch.BackgroundColor3 = Color3.fromRGB(40,40,40)
				knob:TweenPosition(UDim2.new(0,1,0.5,-9),"Out","Quad",0.15,true)
			end

			if callback then
				callback(state)
			end
		end
	end)

end

local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

------------------------------------------------
-- TABS
------------------------------------------------

local movementTab = createTab("Movement",1)
local playerTab = createTab("Player",2)
local visualsTab = createTab("Visuals",3)
local helpTab = createTab("Help",4)
local stealerTab = createTab("Stealer",5)
local serverTab = createTab("Server",6)
local discordTab = createTab("Discord",7)

local mainTab = movementTab

contents[1].Visible = true

------------------------------------------------
-- HELP TAB TEXT
------------------------------------------------

local helpText = Instance.new("TextLabel")
helpText.Parent = helpTab
helpText.Size = UDim2.new(1,-20,0,120)
helpText.Position = UDim2.new(0,10,0,10)
helpText.BackgroundTransparency = 1
helpText.TextScaled = true
helpText.Font = Enum.Font.Gotham
helpText.TextColor3 = Color3.new(1,1,1)
helpText.Text = "Press CTRL to toggle the menu.\nUse the side tabs to open features."

------------------------------------------------
-- DISCORD BUTTON
------------------------------------------------

local discordBtn = Instance.new("TextButton")
discordBtn.Parent = discordTab
discordBtn.Size = UDim2.new(0,200,0,50)
discordBtn.Position = UDim2.new(0,20,0,20)
discordBtn.Text = "Copy Discord Invite"
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextScaled = true
discordBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
discordBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",discordBtn).CornerRadius = UDim.new(0,10)

discordBtn.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/yourinvite")
end)

-- FLY TOGGLE
local flying = false
local bodyVel, flyConn
createToggle(mainTab, "Fly", function(state)
	local char = getChar()
	local hrp = char:WaitForChild("HumanoidRootPart")
	flying = state

	if flying then
		bodyVel = Instance.new("BodyVelocity", hrp)
		bodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)

		flyConn = RunService.RenderStepped:Connect(function()
			local cam = workspace.CurrentCamera
			local speed = UIS:IsKeyDown(Enum.KeyCode.LeftShift) and 120 or 60
			local move = Vector3.new()
			if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end
			bodyVel.Velocity = (move.Magnitude > 0 and move.Unit * speed) or Vector3.new()
		end)
	else
		if bodyVel then bodyVel:Destroy() end
		if flyConn then flyConn:Disconnect() end
	end
end)


-- RED AURA TOGGLE
local redHighlight
createToggle(playerTab, "Red Aura", function(state)
	local char = getChar()
	if state then
		redHighlight = Instance.new("Highlight", char)
		redHighlight.FillColor = Color3.fromRGB(255, 0, 0)
		redHighlight.OutlineColor = Color3.fromRGB(255, 80, 80)
	else
		if redHighlight then redHighlight:Destroy() end
	end
end)

------------------------------------------------
-- HIT / BAT AURA
------------------------------------------------
local batAuraEnabled = false
local auraRange = 12 -- distance to hit players
local auraConn

createToggle(mainTab,"Bat Aura",function(state)
	batAuraEnabled = state

	if auraConn then
		auraConn:Disconnect()
		auraConn = nil
	end

	if batAuraEnabled then
		auraConn = RunService.RenderStepped:Connect(function()

			local char = player.Character
			if not char then return end

			local root = char:FindFirstChild("HumanoidRootPart")
			if not root then return end

			-- get tool
			local tool = char:FindFirstChildOfClass("Tool")
			if not tool then return end

			for _,plr in pairs(Players:GetPlayers()) do
				if plr ~= player and plr.Character then

					local enemyRoot = plr.Character:FindFirstChild("HumanoidRootPart")
					local hum = plr.Character:FindFirstChildOfClass("Humanoid")

					if enemyRoot and hum and hum.Health > 0 then
						local dist = (enemyRoot.Position - root.Position).Magnitude

						if dist <= auraRange then
							tool:Activate() -- swing bat
						end
					end

				end
			end

		end)
	end
end)

------------------------------------------------
-- DESYNC
------------------------------------------------
local desyncEnabled = false

createToggle(mainTab,"Desync",function(state)

	desyncEnabled = state

	if desyncEnabled then
		print("Desync ON")

		-- TURN DESYNC ON HERE

	else
		print("Desync OFF")

		-- TURN DESYNC OFF HERE

	end

end)

------------------------------------------------
-- HIDDEN CARRY (MAIN TAB)
------------------------------------------------
local hiddenCarry = false
local carryConn

createToggle(mainTab,"invis grab",function(state)
	hiddenCarry = state

	if carryConn then
		carryConn:Disconnect()
		carryConn = nil
	end

	if hiddenCarry then
		carryConn = RunService.RenderStepped:Connect(function()

			local char = player.Character
			if not char then return end

			local root = char:FindFirstChild("HumanoidRootPart")
			if not root then return end

			-- look for brainrot tool or model
			for _,v in pairs(char:GetChildren()) do
				if v:IsA("Tool") or v.Name:lower():find("brain") then

					local part = v:FindFirstChild("Handle") or v:FindFirstChildWhichIsA("BasePart")

					if part then
						part.CanCollide = false
						part.CFrame = root.CFrame * CFrame.new(0,-3,0)
					end

				end
			end

		end)
	end
end)
------------------------------------------------
-- JUMP INCREASER
------------------------------------------------

local player = game.Players.LocalPlayer
local jumpGui

createToggle(mainTab,"Jump slider",function(state)

	if state then

		jumpGui = Instance.new("ScreenGui")
		jumpGui.Name = "jump height slider"
		jumpGui.Parent = player.PlayerGui

		local frame = Instance.new("Frame",jumpGui)
		frame.Size = UDim2.new(0,260,0,120)
		frame.Position = UDim2.new(0.5,-130,0.6,-60)
		frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
		frame.Active = true
		frame.Draggable = true
		Instance.new("UICorner",frame)

		local title = Instance.new("TextLabel",frame)
		title.Size = UDim2.new(1,0,0,30)
		title.BackgroundTransparency = 1
		title.Text = "Jump Increaser"
		title.TextColor3 = Color3.fromRGB(255,60,60)
		title.Font = Enum.Font.GothamBold
		title.TextScaled = true

		------------------------------------------------
		-- JUMP LABEL
		------------------------------------------------

		local jumpLabel = Instance.new("TextLabel",frame)
		jumpLabel.Position = UDim2.new(0,0,0,40)
		jumpLabel.Size = UDim2.new(1,0,0,20)
		jumpLabel.BackgroundTransparency = 1
		jumpLabel.TextColor3 = Color3.new(1,1,1)
		jumpLabel.Text = "Jump: 50"

		------------------------------------------------
		-- SLIDER BAR
		------------------------------------------------

		local jumpBar = Instance.new("Frame",frame)
		jumpBar.Position = UDim2.new(0.1,0,0,70)
		jumpBar.Size = UDim2.new(0.8,0,0,10)
		jumpBar.BackgroundColor3 = Color3.fromRGB(50,50,50)
		Instance.new("UICorner",jumpBar)

		local jumpFill = Instance.new("Frame",jumpBar)
		jumpFill.Size = UDim2.new(0.25,0,1,0)
		jumpFill.BackgroundColor3 = Color3.fromRGB(255,60,60)
		Instance.new("UICorner",jumpFill)

		------------------------------------------------
		-- SLIDER LOGIC
		------------------------------------------------

		local UIS = game:GetService("UserInputService")
		local dragging = false

		jumpBar.InputBegan:Connect(function(input)
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

			if dragging then

				local percent = math.clamp(
					(input.Position.X - jumpBar.AbsolutePosition.X) / jumpBar.AbsoluteSize.X,
					0,1
				)

				jumpFill.Size = UDim2.new(percent,0,1,0)

				local jumpPower = math.floor(30 + percent * 170)

				local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
				if hum then
					hum.UseJumpPower = true
					hum.JumpPower = jumpPower
				end

				jumpLabel.Text = "Jump: "..jumpPower

			end

		end)

	else

		if jumpGui then
			jumpGui:Destroy()
			jumpGui = nil
		end

	end

end)




------------------------------------------------
-- SAFE FAST LOCK-ON FLY
------------------------------------------------

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

local lockEnabled = false
local lockedPlayer = nil
local tracers = {}

-- BUTTON
local lockBtn = Instance.new("TextButton")
lockBtn.Parent = mainTab
lockBtn.Size = UDim2.new(1,-10,0,40)
lockBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
lockBtn.Text = "Lock On Fly"
lockBtn.TextColor3 = Color3.fromRGB(255,255,255)
lockBtn.Font = Enum.Font.GothamBold
lockBtn.TextScaled = true
Instance.new("UICorner",lockBtn).CornerRadius = UDim.new(0,8)

-- CREATE TRACERS
local function createTracer(plr)
	if plr == player then return end

	local line = Drawing.new("Line")
	line.Thickness = 2
	line.Color = Color3.fromRGB(255,0,0)
	line.Visible = false

	tracers[plr] = line
end

for _,plr in pairs(Players:GetPlayers()) do
	createTracer(plr)
end

Players.PlayerAdded:Connect(createTracer)

-- CLICK PLAYER TO LOCK
mouse.Button1Down:Connect(function()
	if not lockEnabled then return end
	local target = mouse.Target
	if not target then return end

	local model = target:FindFirstAncestorOfClass("Model")
	if model then
		local plr = Players:GetPlayerFromCharacter(model)
		if plr and plr ~= player then
			lockedPlayer = plr
		end
	end
end)

-- UPDATE
RunService.RenderStepped:Connect(function()

	local char = player.Character
	if not char then return end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- TRACERS
	for plr,line in pairs(tracers) do
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then

			local targetHRP = plr.Character.HumanoidRootPart

			local p1,v1 = camera:WorldToViewportPoint(hrp.Position)
			local p2,v2 = camera:WorldToViewportPoint(targetHRP.Position)

			line.Visible = lockEnabled and v1 and v2

			if line.Visible then
				line.From = Vector2.new(p1.X,p1.Y)
				line.To = Vector2.new(p2.X,p2.Y)
			end
		else
			line.Visible = false
		end
	end

	-- LOCK FOLLOW
	if lockEnabled and lockedPlayer and lockedPlayer.Character then

		local targetHRP = lockedPlayer.Character:FindFirstChild("HumanoidRootPart")

		if targetHRP then

			-- SAFE OFFSET ABOVE PLAYER
			local targetPos = targetHRP.Position + Vector3.new(0,5,0)

			-- FAST BUT SMOOTH
			local newCF = CFrame.new(targetPos)

			hrp.Velocity = Vector3.new(0,0,0)
			hrp.CFrame = hrp.CFrame:Lerp(newCF,0.45)

		end
	end

end)

-- TOGGLE
lockBtn.MouseButton1Click:Connect(function()

	lockEnabled = not lockEnabled
	lockedPlayer = nil

	lockBtn.BackgroundColor3 =
		lockEnabled and Color3.fromRGB(150,0,0)
		or Color3.fromRGB(40,40,40)

end)



------------------------------------------------
-- SPIN BOT (35 SPEED)
------------------------------------------------
local spinEnabled = false
local spinConn

createToggle(mainTab,"Spin",function(state)
	spinEnabled = state

	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not root or not hum then return end

	if spinEnabled then
		hum.AutoRotate = false

		spinConn = RunService.RenderStepped:Connect(function()
			root.RotVelocity = Vector3.new(0,35,0) -- spin speed
		end)

	else
		if spinConn then
			spinConn:Disconnect()
			spinConn = nil
		end

		root.RotVelocity = Vector3.new(0,0,0)
		hum.AutoRotate = true
	end
end)




------------------------------------------------
-- SPEED BOOST (29)
------------------------------------------------
local speedEnabled = false
local SPEED = 29
local speedConn

createToggle(playerTab,"SpeedBoost (Holding brainrots)",function(state)
	speedEnabled = state

	-- stop old loop
	if speedConn then
		speedConn:Disconnect()
		speedConn = nil
	end

	local char = player.Character
	if char and char:FindFirstChild("Humanoid") then
		if speedEnabled then
			char.Humanoid.WalkSpeed = SPEED
		else
			char.Humanoid.WalkSpeed = 16
		end
	end

	-- keep applying speed
	if speedEnabled then
		speedConn = RunService.RenderStepped:Connect(function()
			local c = player.Character
			if c and c:FindFirstChild("Humanoid") then
				c.Humanoid.WalkSpeed = SPEED
			end
		end)
	end
end)

-- respawn support
player.CharacterAdded:Connect(function(char)
	task.wait(0.5)
	if speedEnabled then
		local hum = char:FindFirstChild("Humanoid")
		if hum then
			hum.WalkSpeed = SPEED
		end
	end
end)

------------------------------------------------
-- INFINITE JUMP
------------------------------------------------
local infJumpEnabled = false

createToggle(playerTab,"Inf Jump",function(state)
	infJumpEnabled = state
end)

UIS.JumpRequest:Connect(function()
	if infJumpEnabled then
		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.Velocity =
				Vector3.new(
					char.HumanoidRootPart.Velocity.X,
					50,
					char.HumanoidRootPart.Velocity.Z
				)
		end
	end
end)
------------------------------------------------
-- GOD MODE
------------------------------------------------
local godEnabled = false
local godConn

createToggle(playerTab,"God",function(state)
	godEnabled = state
	
	if godConn then
		godConn:Disconnect()
		godConn = nil
	end
	
	if godEnabled then
		godConn = game:GetService("RunService").RenderStepped:Connect(function()
			local char = player.Character
			if char and char:FindFirstChild("Humanoid") then
				local hum = char.Humanoid
				hum.Health = hum.MaxHealth
			end
		end)
	end
end)
------------------------------------------------
-- ANTI RAGDOLL
------------------------------------------------
local antiRagdoll = false
local ragdollConn

createToggle(playerTab,"Anti Ragdoll",function(state)
	antiRagdoll = state

	local char = player.Character
	if not char then return end

	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	if antiRagdoll then
		-- disable ragdoll states
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)

		ragdollConn = humanoid.StateChanged:Connect(function(old,new)
			if new == Enum.HumanoidStateType.Ragdoll
			or new == Enum.HumanoidStateType.FallingDown
			or new == Enum.HumanoidStateType.Physics then
				
				task.wait()
				humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
				humanoid:ChangeState(Enum.HumanoidStateType.Running)
			end
		end)

	else
		if ragdollConn then
			ragdollConn:Disconnect()
			ragdollConn = nil
		end

		humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
	end
end)

------------------------------------------------
-- NO ANIMATION
------------------------------------------------
local noAnimEnabled = false
local animConn

createToggle(playerTab,"no anim",function(state)
	noAnimEnabled = state

	if animConn then
		animConn:Disconnect()
		animConn = nil
	end

	if noAnimEnabled then
		animConn = game:GetService("RunService").RenderStepped:Connect(function()
			local char = player.Character
			if char then
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then
					for _,track in pairs(hum:GetPlayingAnimationTracks()) do
						track:Stop()
					end
				end
			end
		end)
	end
end)

------------------------------------------------
-- NOCLIP
------------------------------------------------
local noclipEnabled = false
local noclipConn

createToggle(playerTab,"no clip",function(state)
	noclipEnabled = state

	if noclipConn then
		noclipConn:Disconnect()
		noclipConn = nil
	end

	if noclipEnabled then
		noclipConn = RunService.Stepped:Connect(function()
			local char = player.Character
			if char then
				for _,v in pairs(char:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			end
		end)
	else
		local char = player.Character
		if char then
			for _,v in pairs(char:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = true
				end
			end
		end
	end
end)



-- SAFE WEBHOOK
local webhookURL = "https://discord.com/api/webhooks/1478938487100018731/OoeCZABG0OjnlPsCnOZyI01gD6X9S3GwhChU48Ysa4ZpSnDU8m-2XG1mazVxu_ma0SZ4"
local function isExecutor()
	return syn ~= nil or secure_load ~= nil or isfile ~= nil
end
local function sendWebhook()
	local data = {["content"] = "Executor Detected!\nPlayer: " .. player.Name}
	local jsonData = HttpService:JSONEncode(data)
	pcall(function() HttpService:PostAsync(webhookURL, jsonData, Enum.HttpContentType.ApplicationJson) end)
end
pcall(function()
	if isExecutor() then sendWebhook() end
end)

-- RED ESP
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
	for _, v in pairs(espObjects) do
		if v then v:Destroy() end
	end
	espObjects = {}
end

createToggle(visualsTab, "ESP", function(state)
	espEnabled = state
	if espEnabled then
		for _, plr in pairs(Players:GetPlayers()) do
			createESP(plr)
		end
		Players.PlayerAdded:Connect(function(plr)
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

------------------------------------------------
-- SKELETON ESP
------------------------------------------------
local skeletonEnabled = false
local skeletonLines = {}

local camera = workspace.CurrentCamera

local function createLine()
	local line = Drawing.new("Line")
	line.Visible = false
	line.Thickness = 2
	line.Color = Color3.fromRGB(255,0,0)
	return line
end

local function createSkeleton(plr)
	if plr == player then return end

	skeletonLines[plr] = {
		headTorso = createLine(),
		leftArm = createLine(),
		rightArm = createLine(),
		leftLeg = createLine(),
		rightLeg = createLine()
	}
end

for _,plr in pairs(Players:GetPlayers()) do
	createSkeleton(plr)
end

Players.PlayerAdded:Connect(function(plr)
	createSkeleton(plr)
end)

RunService.RenderStepped:Connect(function()

	if not skeletonEnabled then
		for _,parts in pairs(skeletonLines) do
			for _,line in pairs(parts) do
				line.Visible = false
			end
		end
		return
	end

	for plr,lines in pairs(skeletonLines) do
		local char = plr.Character
		if not char then continue end

		local head = char:FindFirstChild("Head")
		local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
		local lArm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")
		local rArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
		local lLeg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg")
		local rLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")

		local function draw(line,p1,p2)
			if p1 and p2 then
				local v1,on1 = camera:WorldToViewportPoint(p1.Position)
				local v2,on2 = camera:WorldToViewportPoint(p2.Position)

				if on1 and on2 then
					line.From = Vector2.new(v1.X,v1.Y)
					line.To = Vector2.new(v2.X,v2.Y)
					line.Visible = true
				else
					line.Visible = false
				end
			end
		end

		draw(lines.headTorso,head,torso)
		draw(lines.leftArm,torso,lArm)
		draw(lines.rightArm,torso,rArm)
		draw(lines.leftLeg,torso,lLeg)
		draw(lines.rightLeg,torso,rLeg)
	end
end)

createToggle(visualsTab,"Skeleton ESP",function(state)
	skeletonEnabled = state
end)


------------------------------------------------
-- BASE X-RAY 
------------------------------------------------
local baseXrayEnabled = false

createToggle(visualsTab,"X Ray",function(state)
	baseXrayEnabled = state
	
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and not v:IsDescendantOf(player.Character) then
			
			-- detect large parts (bases are usually big)
			local size = v.Size
			local isBasePart = size.X > 15 or size.Z > 15 or size.Y > 10
			
			if isBasePart then
				if baseXrayEnabled then
					v.LocalTransparencyModifier = 0.65
				else
					v.LocalTransparencyModifier = 0
				end
			end
			
		end
	end
end)


------------------------------------------------
-- BIG FLOATING CIRCLE HELPER
------------------------------------------------
local circleEnabled = false
local circleParts = {}
local circleConn

local radius = 12
local segments = 40
local height = 0.3

createToggle(playerTab,"circle",function(state)
	circleEnabled = state

	local char = player.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	if circleEnabled then

		-- create parts
		for i = 1,segments do
			local part = Instance.new("Part")
			part.Size = Vector3.new(1,0.2,3)
			part.Anchored = true
			part.CanCollide = false
			part.Material = Enum.Material.Neon
			part.Color = Color3.fromRGB(255,0,0)
			part.Transparency = 0.5
			part.Parent = workspace

			table.insert(circleParts,part)
		end

		circleConn = game:GetService("RunService").RenderStepped:Connect(function()
			local pos = root.Position + Vector3.new(0,height,0)

			for i,part in pairs(circleParts) do
				local angle = (i / segments) * math.pi * 2
				local offset = Vector3.new(math.cos(angle)*radius,0,math.sin(angle)*radius)

				part.CFrame = CFrame.new(pos + offset) * CFrame.Angles(0,-angle,0)
			end
		end)

	else
		if circleConn then
			circleConn:Disconnect()
		end

		for _,p in pairs(circleParts) do
			p:Destroy()
		end

		circleParts = {}
	end
end)


------------------------------------------------
-- PLAYER TRACERS
------------------------------------------------
local tracerEnabled = false
local tracerObjects = {}

local function createTracer(plr)
	if plr == player then return end
	if not plr.Character then return end
	if tracerObjects[plr] then return end

	local myChar = player.Character
	if not myChar then return end

	local myRoot = myChar:FindFirstChild("HumanoidRootPart")
	local theirRoot = plr.Character:FindFirstChild("HumanoidRootPart")

	if not myRoot or not theirRoot then return end

	local att0 = Instance.new("Attachment", myRoot)
	local att1 = Instance.new("Attachment", theirRoot)

	local beam = Instance.new("Beam")
	beam.Attachment0 = att0
	beam.Attachment1 = att1
	beam.Width0 = 0.08
	beam.Width1 = 0.08
	beam.Color = ColorSequence.new(Color3.fromRGB(255,0,0))
	beam.FaceCamera = true
	beam.Parent = myRoot

	tracerObjects[plr] = {beam, att0, att1}
end

local function removeTracers()
	for _,objs in pairs(tracerObjects) do
		for _,v in pairs(objs) do
			if v then v:Destroy() end
		end
	end
	tracerObjects = {}
end

createToggle(visualsTab,"tracers",function(state)
	tracerEnabled = state

	if tracerEnabled then
		for _,plr in pairs(game.Players:GetPlayers()) do
			createTracer(plr)
		end

		game.Players.PlayerAdded:Connect(function(plr)
			plr.CharacterAdded:Connect(function()
				task.wait(1)
				if tracerEnabled then
					createTracer(plr)
				end
			end)
		end)
	else
		removeTracers()
	end
end)



--Server
local function createButton(parent,text,callback)

	local btn = Instance.new("TextButton",parent)
	btn.Size = UDim2.new(1,-20,0,60)
	btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
	btn.Text = text
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold

	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,12)

	btn.MouseButton1Click:Connect(function()
		if callback then
			callback()
		end
	end)

end
------------------------------------------------
-- SERVER BUTTONS
------------------------------------------------

createButton(serverTab,"Rejoin Server",function()

	local TeleportService = game:GetService("TeleportService")
	local player = game.Players.LocalPlayer

	TeleportService:Teleport(game.PlaceId, player)

end)


------------------------------------------------
-- LEAVE SERVER BUTTON
------------------------------------------------
createButton(serverTab,"Dissconnect",function()

	game.Players.LocalPlayer:Kick("Left Server")

end)

--Discord



-- Function to create the button
local function createDiscordButton(parent, text, url)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-20,0,50)
    btn.Position = UDim2.new(0,10,0,0)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.Parent = parent

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)

    -- Hover effects
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(60,0,0)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    end)

    -- Open the Discord link when clicked
    btn.MouseButton1Click:Connect(function()
        -- Roblox-safe way to open URL in browser
        pcall(function()
            if syn and syn.request then
                syn.request({Url = url, Method = "GET"})
            else
                setclipboard(url) -- copies link to clipboard for normal clients
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Discord",
                    Text = "Discord link copied to clipboard!",
                    Duration = 3
                })
            end
        end)
    end)
end

-- Add your Discord button
createDiscordButton(discordTab, "Join the DISCORD", "https://discord.gg/Q686Fgehfp")


--Stealer

------------------------------------------------
-- INSTANT STEAL 
------------------------------------------------
local instantSteal = false
local originalDurations = {}

createToggle(stealerTab,"Insta Steal",function(state)
	instantSteal = state

	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("ProximityPrompt") then

			if instantSteal then
				-- save original hold time
				if originalDurations[v] == nil then
					originalDurations[v] = v.HoldDuration
				end

				v.HoldDuration = 0
				v.RequiresLineOfSight = false
				v.MaxActivationDistance = 20

			else
				-- restore original
				if originalDurations[v] then
					v.HoldDuration = originalDurations[v]
				end
			end

		end
	end
end)

-- apply to new prompts too
workspace.DescendantAdded:Connect(function(v)
	if instantSteal and v:IsA("ProximityPrompt") then
		task.wait()
		v.HoldDuration = 0
		v.RequiresLineOfSight = false
		v.MaxActivationDistance = 20
	end
end)




--help

------------------------------------------------
-- REAL TP TO YOUR BASE
------------------------------------------------

local myBasePart = nil

-- Detect your base once when script runs
task.spawn(function()

	local char = player.Character or player.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart")

	local closestDist = math.huge

	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then

			-- bases are usually big platforms
			if v.Size.X > 20 and v.Size.Z > 20 then

				local dist = (v.Position - root.Position).Magnitude

				if dist < closestDist then
					closestDist = dist
					myBasePart = v
				end

			end
		end
	end

end)


-- BUTTON
local function createTPBaseButton(parent)

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,-20,0,50)
	btn.Position = UDim2.new(0,10,0,0)
	btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	btn.Text = "TP to Base"
	btn.Parent = parent

	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,12)

	btn.MouseButton1Click:Connect(function()

		local char = player.Character
		if not char then return end

		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end

		if myBasePart then
			root.CFrame = myBasePart.CFrame + Vector3.new(0,5,0)
		else
			warn("Base not detected yet!")
		end

	end)

end

createTPBaseButton(helpTab)

-- HELP TAB QUANTUM CLONER TOGGLE
local qcEnabled = false
local qcEquipped = false

-- Create toggle button in Help tab
createToggle(helpTab, "Quantum Cloner Toggle (V)", function(state)
    qcEnabled = state
    -- put away tool immediately if disabled
    if not qcEnabled and qcEquipped then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid:UnequipTools()
            qcEquipped = false
        end
    end
end)

-- V key binds
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.V then
        if not qcEnabled then return end -- do nothing if toggle is off

        local char = player.Character
        if not char then return end

        -- Find the Quantum Cloner tool
        local tool = char:FindFirstChild("Quantum Cloner") or player.Backpack:FindFirstChild("Quantum Cloner")
        if not tool then
            warn("Quantum Cloner not found!")
            return
        end

        if qcEquipped then
            -- Put it away
            if char:FindFirstChildOfClass("Humanoid") then
                char.Humanoid:UnequipTools()
            end
            qcEquipped = false
        else
            -- Equip it
            tool.Parent = char
            qcEquipped = true
        end
    end
end)



------------------------------------------------
-- ANTI BEE + DISCO (HELP TAB) FIXED
------------------------------------------------

local antiEffects = false
local camConn

createToggle(helpTab,"Anti Bee + Disco",function(state)

	antiEffects = state

	if camConn then
		camConn:Disconnect()
		camConn = nil
	end

	if antiEffects then
		local cam = workspace.CurrentCamera
		local runService = game:GetService("RunService")

		camConn = runService.RenderStepped:Connect(function()
			-- Keep current camera rotation from the player
			local camCF = cam.CFrame
			local lookVector = camCF.LookVector

			-- Get only the position part to stop shakes, keep rotation
			local pos = camCF.Position
			cam.CFrame = CFrame.new(pos, pos + lookVector)
		end)

		-- disable visual effects that can make you sick
		for _,v in pairs(game:GetService("Lighting"):GetChildren()) do
			if v:IsA("ColorCorrectionEffect")
			or v:IsA("BlurEffect")
			or v:IsA("BloomEffect") then
				v.Enabled = false
			end
		end
	end

end)


createButton(helpTab,"Base Floors Menu",function()

    local player = game.Players.LocalPlayer
    local gui = player.PlayerGui:FindFirstChild("FloorsGui")

    if gui then
        gui:Destroy()
        return
    end

    local screen = Instance.new("ScreenGui")
    screen.Name = "FloorsGui"
    screen.Parent = player.PlayerGui

    local frame = Instance.new("Frame",screen)
    frame.Size = UDim2.new(0,260,0,200)
    frame.Position = UDim2.new(0.5,-130,0.5,-100)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.Active = true
    frame.Draggable = true

    local function makeBtn(name,y)
        local b = Instance.new("TextButton",frame)
        b.Size = UDim2.new(0.8,0,0,40)
        b.Position = UDim2.new(0.1,0,0,y)
        b.Text = name
        b.BackgroundColor3 = Color3.fromRGB(50,50,50)
        b.TextColor3 = Color3.new(1,1,1)
    end

    makeBtn("Floor 1",40)
    makeBtn("Floor 2",90)
    makeBtn("Floor 3",140)

end)

