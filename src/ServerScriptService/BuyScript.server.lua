local function buyShopEventHandler(player)
	print("Selling your nettomon")

	local playerStats = player:FindFirstChild("leaderstats")
	local playerGold = playerStats:FindFirstChild("Gold")

	local tool = game:GetService("ServerStorage"):WaitForChild("Pistol")


	if playerGold.Value >= 100 then
		playerGold.Value -= 100
		local clonedTool = tool:Clone()
		clonedTool.Parent = player.Backpack
	end
end

-- adding a comment

game:GetService("ReplicatedStorage"):WaitForChild("BuyShopEvent").OnServerEvent:Connect(buyShopEventHandler)