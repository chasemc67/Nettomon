-- Create leaderboard that shows player varaibles

local function onPlayerJoin(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"	-- must have the name leaderstats to create a leaderboard
	leaderstats.Parent = player

	local gold = Instance.new("IntValue")
	gold.Name = "Gold"
	gold.Value = 0
	gold.Parent = leaderstats

	local items = Instance.new("IntValue")
	items.Name = "Nettomon"
	items.Value = 0
	items.Parent = leaderstats

	--[[
	local spaces = Instance.new("IntValue")
	spaces.Name = "Spaces"
	spaces.Value = 2
	spaces.Parent = leaderstats
	]]
end

game.Players.PlayerAdded:Connect(onPlayerJoin)