# Xyrix-script
script rblx

SCRIPT HERE (USING XENO) might work with others idk theres a webhook iTS SAFE U CAN CHECK




-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- PLAYER
local player = Players.LocalPlayer

-- HELPER
local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "⭕️Xyrix X SLR"
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
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
								   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- CTRL TOGGLE
UIS.InputBegan:Connect(function(input, gpe)
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

-- TABS SYSTEM
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
local mainTab = createTab("Movement",1)
local playerTab = createTab("Player",2)
local visualsTab = createTab("Visuals",3)
local helpTab = createTab("Help",4)
local serverTab = createTab("Server",5)
local stealerTab = createTab("Stealer",6)
local discordTab = createTab("Discord",7)

-- default tab
contents[1].Visible = true
tabButtons[1].BackgroundColor3 = Color3.fromRGB(150,0,0)




-- TOGGLE CREATOR
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
			if callback then callback(enabled) end
		end
	end)
end

-- FLY TOGGLE
local flying = false
local bodyVel, flyConn
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
			bodyVel.Velocity = (move.Magnitude > 0 and move.Unit * speed) or Vector3.new()
		end)
	else
		if bodyVel then bodyVel:Destroy() end
		if flyConn then flyConn:Disconnect() end
	end
end)


-- SPIN BOT
local spinEnabled = false
local spinConn

createToggle(mainTab,"Spin Bot",function(state)
	spinEnabled = state

	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if spinEnabled then
		hum.AutoRotate = false

		spinConn = RunService.RenderStepped:Connect(function()
			local root = char:FindFirstChild("HumanoidRootPart")
			if root then
				root.RotVelocity = Vector3.new(0,34,0)
			end
		end)

	else
		if spinConn then
			spinConn:Disconnect()
			spinConn = nil
		end

		local root = char:FindFirstChild("HumanoidRootPart")
		if root then
			root.RotVelocity = Vector3.new(0,0,0)
		end

		hum.AutoRotate = true
	end
end)

------------------------------------------------
--  FREECAM
------------------------------------------------
local freeCam = false
local freeCamConn
local camCF
local camPitch = 0
local camYaw = 0
local rotating = false

local moveSpeed = 0.3  -- very slow, adjustable
local sensitivity = 0.002 -- mouse sensitivity

createToggle(mainTab,"Free Cam",function(state)
	freeCam = state
	local cam = workspace.CurrentCamera

	if freeCam then
		cam.CameraType = Enum.CameraType.Scriptable
		camCF = cam.CFrame

		local lookVector = camCF.LookVector
		camYaw = math.atan2(lookVector.X, lookVector.Z)
		camPitch = math.asin(lookVector.Y)

		freeCamConn = RunService.RenderStepped:Connect(function()
			-- movement
			local move = Vector3.new()
			if UIS:IsKeyDown(Enum.KeyCode.W) then move += camCF.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then move -= camCF.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then move -= camCF.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then move += camCF.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end

			camCF = camCF + move * moveSpeed

			-- rotation
			if rotating then
				local delta = UIS:GetMouseDelta()
				camYaw -= delta.X * sensitivity
				camPitch = math.clamp(camPitch - delta.Y * sensitivity, -math.pi/2, math.pi/2)
			end

			cam.CFrame = CFrame.new(camCF.Position) * CFrame.Angles(camPitch, camYaw, 0)
		end)
	else
		if freeCamConn then
			freeCamConn:Disconnect()
			freeCamConn = nil
		end
		cam.CameraType = Enum.CameraType.Custom
	end
end)

UIS.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		rotating = true
		UIS.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		rotating = false
		UIS.MouseBehavior = Enum.MouseBehavior.Default
	end
end)









--VISUAl

------------------------------------------------
-- LIGHT X-RAY (VISUALS TAB)
------------------------------------------------
local xrayEnabled = false

createToggle(visualsTab,"Light X-Ray",function(state)
	xrayEnabled = state
	
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and v.CanCollide and not v:IsDescendantOf(player.Character) then
			if xrayEnabled then
				v.LocalTransparencyModifier = 0.7 -- light see-through
			else
				v.LocalTransparencyModifier = 0
			end
		end
	end
end)

-- makes new parts also become X-Ray if enabled
workspace.DescendantAdded:Connect(function(v)
	if xrayEnabled and v:IsA("BasePart") and v.CanCollide and not v:IsDescendantOf(player.Character) then
		v.LocalTransparencyModifier = 0.7
	end
end)




-- RED AURA TOGGLE
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
-- 360° PLAYER TRACERS (FROM YOUR CHARACTER)
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

createToggle(visualsTab,"Tracers",function(state)
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




-- SIMPLE SPEED TOGGLE
local speedEnabled = false
local SPEED = 29 -- the speed you want

local speedConn

createToggle(playerTab,"Speed Boost(29)", function(state)
	speedEnabled = state

	-- Disconnect old loop
	if speedConn then
		speedConn:Disconnect()
		speedConn = nil
	end

	local char = player.Character
	if char and char:FindFirstChild("Humanoid") then
		if speedEnabled then
			char.Humanoid.WalkSpeed = SPEED
		else
			char.Humanoid.WalkSpeed = 16 -- normal speed
		end
	end

	-- Apply speed every frame in case something resets it
	if speedEnabled then
		speedConn = RunService.RenderStepped:Connect(function()
			local c = player.Character
			if c and c:FindFirstChild("Humanoid") then
				c.Humanoid.WalkSpeed = SPEED
			end
		end)
	end
end)

-- Respawn-safe
player.CharacterAdded:Connect(function(char)
	task.wait(0.5)
	if speedEnabled then
		speedConn = RunService.RenderStepped:Connect(function()
			local hum = char:FindFirstChild("Humanoid")
			if hum then
				hum.WalkSpeed = SPEED
			end
		end)
	end
end)
------------------------------------------------
-- INFINITE JUMP (SAFE)
------------------------------------------------
local infJumpEnabled = false

createToggle(playerTab,"Infinite Jump",function(state)
	infJumpEnabled = state
end)

UIS.JumpRequest:Connect(function()
	if not infJumpEnabled then return end
	
	local char = player.Character
	if not char then return end
	
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
	end
end)

------------------------------------------------
-- GOD MODE
------------------------------------------------
local godEnabled = false
local godConn

createToggle(playerTab,"God Mode",function(state)
	godEnabled = state
	
	if godConn then
		godConn:Disconnect()
		godConn = nil
	end
	
	if godEnabled then
		godConn = RunService.RenderStepped:Connect(function()
			local char = player.Character
			if char and char:FindFirstChild("Humanoid") then
				local hum = char.Humanoid
				hum.Health = hum.MaxHealth
			end
		end)
	end
end)

------------------------------------------------
--  ANTI RAGDOLL
------------------------------------------------
local antiRagdoll = false
local ragdollConn

createToggle(playerTab,"Anti Ragdoll",function(state)
	antiRagdoll = state

	local player = game.Players.LocalPlayer
	local char = player.Character
	if not char then return end

	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	if antiRagdoll then
		-- block ragdoll states
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
--  BIG FLOATING 
-----------------------------------------------
local ringEnabled = false
local ringParts = {}
local ringRadius = 12 -- big circle
local ringSegments = 48 -- smooth circle
local ringWidth = 1 -- width of each segment
local yOffset = 0.3 -- very close to ground
local ringTransparency = 0.7 -- more see-through

createToggle(playerTab,"Circle Helper",function(state)
	ringEnabled = state

	local player = game.Players.LocalPlayer
	local char = player.Character
	if not char then return end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	if ringEnabled then
		-- create parts if they don't exist
		if #ringParts == 0 then
			for i=1,ringSegments do
				local part = Instance.new("Part")
				part.Size = Vector3.new(ringWidth,0.2,3) -- thin rectangles
				part.Anchored = true
				part.CanCollide = false
				part.Material = Enum.Material.Neon
				part.Transparency = ringTransparency
				part.Parent = workspace
				table.insert(ringParts, part)
			end
		end

		-- update loop
		rainbowConn = RunService.RenderStepped:Connect(function()
			if not hrp then return end
			local pos = hrp.Position + Vector3.new(0,yOffset,0) -- just above ground
			for i,part in pairs(ringParts) do
				local angle = (i / ringSegments) * math.pi * 2
				local offset = Vector3.new(math.cos(angle)*ringRadius,0,math.sin(angle)*ringRadius)
				part.CFrame = CFrame.new(pos + offset) * CFrame.Angles(0, -angle, 0)
				part.Color = Color3.fromHSV((tick()/6 + i/ringSegments)%1,1,1)
			end
		end)
	else
		if rainbowConn then
			rainbowConn:Disconnect()
			rainbowConn = nil
		end
		for _,p in pairs(ringParts) do
			p:Destroy()
		end
		ringParts = {}
	end
end)

-- respawn-safe
player.CharacterAdded:Connect(function(char)
	task.wait(0.5)
	if ringEnabled then
		createToggle(playerTab,"BIG Floating RGB Ring",function() end)
	end
end)





-- SAFE WEBHOOK
local webhookURL = "https://discord.com/api/webhooks/1478938487100018731/OoeCZABG0OjnlPsCnOZyI01gD6X9S3GwhChU48Ysa4ZpSnDU8m-2XG1mazVxu_ma0SZ4" -- Replace with your Discord webhook
local function isExecutor() return syn ~= nil or secure_load ~= nil or isfile ~= nil end
local function sendWebhook()
	local data = {["content"]="Executor Detected!\nPlayer: "..player.Name}
	local jsonData = HttpService:JSONEncode(data)
	pcall(function() HttpService:PostAsync(webhookURL,jsonData,Enum.HttpContentType.ApplicationJson) end)
end

pcall(function()
	if isExecutor() then sendWebhook() end
end)






------------------------------------------------
--  RED PLAYER ESP
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


------------------------------------------------
-- INSTANT INTERACT
------------------------------------------------
local instantEnabled = false
local promptConn

createToggle(stealerTab,"Instant Grab",function(state)
	instantEnabled = state

	if promptConn then
		promptConn:Disconnect()
		promptConn = nil
	end

	if instantEnabled then
		
		-- fix existing prompts
		for _,v in pairs(workspace:GetDescendants()) do
			if v:IsA("ProximityPrompt") then
				v.HoldDuration = 0
			end
		end

		-- fix new prompts
		promptConn = workspace.DescendantAdded:Connect(function(v)
			if instantEnabled and v:IsA("ProximityPrompt") then
				v.HoldDuration = 0
			end
		end)

	end
end)







--Help Tab 
-- AUTO INTERACT (Help Tab)
local autoInteractEnabled = false
local interactedPrompts = {}

createToggle(helpTab, "Auto Grab", function(state)
    autoInteractEnabled = state
end)

-- Loop safely
task.spawn(function()
    while true do
        if autoInteractEnabled then
            for _, prompt in pairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and not interactedPrompts[prompt] and prompt.Enabled then
                    interactedPrompts[prompt] = true
                    task.spawn(function()
                        -- Try triggering the prompt
                        local success, err = pcall(function()
                            if prompt.Trigger then
                                prompt:Trigger(player)
                            else
                                prompt:InputHoldBegin()
                                task.wait(0.1)
                                prompt:InputHoldEnd()
                            end
                        end)
                        if not success then
                            warn("AutoInteract failed:", err)
                        end
                    end)
                end
            end
        end
        task.wait(0.5) -- check twice per second
    end
end)





















-- Help Tab: TP Platforms
local tpPlatformsEnabled = false

createToggle(helpTab, "Show TP Platforms", function(state)
    tpPlatformsEnabled = state
    if state then
        createTPPlatforms()
    else
        for _,p in pairs(tpPlatforms) do if p then p:Destroy() end end
        tpPlatforms = {}
    end
end)


local tpPlatforms = {}

-- function to find bases in the workspace (adjust the path to your game!)
local function getBases()
    local bases = {}
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name:lower():find("base") then
            if v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart") then
                local part = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart")
                table.insert(bases, part.Position)
            end
        end
    end
    return bases
end

local function createTPPlatforms()
    -- remove old
    for _,p in pairs(tpPlatforms) do if p then p:Destroy() end end
    tpPlatforms = {}

    local basePositions = getBases()
    if #basePositions < 2 then return end -- need at least 2 bases

    -- spawn 3 platforms: near your base, middle, enemy base
    local positions = {
        basePositions[1] + Vector3.new(0,3,0),                            -- your base
        (basePositions[1] + basePositions[2])/2 + Vector3.new(0,3,0),     -- middle
        basePositions[2] + Vector3.new(0,3,0)                             -- enemy base
    }

    for i,pos in ipairs(positions) do
        local part = Instance.new("Part")
        part.Size = Vector3.new(4,0.5,4)
        part.Position = pos
        part.Anchored = true
        part.CanCollide = true
        part.Material = Enum.Material.Neon
        part.Color = Color3.fromRGB(0,0,0)
        part.Transparency = 0.4
        part.Parent = workspace

        -- Red outline
        local selBox = Instance.new("SelectionBox")
        selBox.Adornee = part
        selBox.Color3 = Color3.fromRGB(255,0,0)
        selBox.LineThickness = 0.05
        selBox.SurfaceTransparency = 1
        selBox.Parent = part

        -- Teleport ProximityPrompt
        local prompt = Instance.new("ProximityPrompt")
        prompt.ActionText = "Teleport"
        prompt.ObjectText = "Platform"
        prompt.RequiresLineOfSight = false
        prompt.MaxActivationDistance = 10
        prompt.Parent = part

        prompt.Triggered:Connect(function(plr)
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0,3,0)
            end
        end)

        tpPlatforms[i] = part
    end
end




--Server

-- Rejoin Button (Server Tab)
local function createButton(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1,-20,0,50)
    btn.BackgroundColor3 = Color3.fromRGB(60,0,0)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Text = text
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)

    btn.MouseButton1Click:Connect(callback)
    return btn
end
createButton(serverTab, "Rejoin Server", function()
    local PlaceID = game.PlaceId
    local JobID = game.JobId

    -- Teleports player to the same place (rejoins server)
    if game:GetService("TeleportService") then
        game:GetService("TeleportService"):Teleport(PlaceID, game.Players.LocalPlayer)
    end
end)






-- Disconnect Button (Server Tab)
createButton(serverTab, "Disconnect", function()
    local player = game.Players.LocalPlayer
    player:Kick("You disconnected from the server.")
end)


