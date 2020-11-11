local Players = game:GetService("Players")

script.Parent.Activated:connect(function()
	
	print("throwing apple")
	
	local tool = script.Parent
	local character = tool.Parent
	
	-- Add a trail
	local attachment0 = Instance.new("Attachment")
	attachment0.Name = "Attachment0"
	attachment0.Parent = tool.Handle
	attachment0.Position = Vector3.new(0,-1,0)
	local attachment1 = Instance.new("Attachment")
	attachment1.Name = "Attachment1"
	attachment1.Parent = tool.Handle
	attachment1.Position = Vector3.new(0,1,0)
	local trail = Instance.new("Trail")
	trail.Parent = tool.Handle
	trail.Attachment0 = attachment0
	trail.Attachment1 = attachment1
	local color1 = Color3.new(1, 0, 0)
	local color2 = Color3.new(1, 1, 1)
	trail.Color = ColorSequence.new(color1, color2)
	
	
	tool.Handle.Transparency = 1
	tool.Parent = workspace
	tool.Consumable.Value = true
	
	
	-- throw with velocity
	local targetPos = character.HumanoidRootPart.CFrame.lookVector
	tool.Handle.Transparency = 0
	tool.Handle.Velocity = targetPos * 75
	
	wait(3)
	trail:Destroy()
	attachment0:Destroy()
	attachment1:Destroy()
end)

--[[
script.Parent.Handle.Touched:Connect(function()
	print("firing picked up berry event")
	game:GetService("ReplicatedStorage"):WaitForChild("GameStateEvent"):FireClient(Players["metaverseplumber"], "pickedUpBerry")
end)
]]