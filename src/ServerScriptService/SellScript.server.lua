local function sellItems(playerItems, playerGold)
	local totalSell = playerItems.Value * 50
	playerGold.Value = playerGold.Value + totalSell
	playerItems.Value = 0
end


local function sellShopEventHandler(player)
	print("Selling your nettomon")

	local playerStats = player:FindFirstChild("leaderstats")
	local playerItems = playerStats:FindFirstChild("Nettomon")
	local playerGold = playerStats:FindFirstChild("Gold")
	sellItems(playerItems, playerGold)
end

game:GetService("ReplicatedStorage"):WaitForChild("SellShopEvent").OnServerEvent:Connect(sellShopEventHandler)