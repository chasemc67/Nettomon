-- gives players items when it hits cupcakes

local tool = script.Parent
local scoop = tool.MeshPart

local backpack = tool.Parent
local player = backpack.Parent
local playerStats = player:FindFirstChild("leaderstats")
local playerItems = playerStats:FindFirstChild("Nettomon")

local Players = game:GetService("Players")


local function onTouch(partTouched)
	local canHarvest = partTouched.Parent:FindFirstChild("CanHarvest")
	if canHarvest and canHarvest.Value == true then
		playerItems.Value = playerItems.Value + 1
		canHarvest.Value = false
		
		local parts = partTouched.parent:GetChildren()
		for i=#parts, 1, -1 do
			parts[i]:Destroy()
		end
		
		print("Firing selling nettomon")
		game:GetService("ReplicatedStorage"):WaitForChild("GameStateEvent"):FireClient(player, "sellingNettomon")
			
	end
end

scoop.Touched:Connect(onTouch)
