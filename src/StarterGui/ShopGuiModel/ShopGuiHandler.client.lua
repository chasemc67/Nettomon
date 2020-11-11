local shopGui = script.Parent.ShopGui
local noButton = shopGui.Frame.NoButton
local yesButton = shopGui.Frame.YesButton
local shopText = shopGui.Frame.TextBox

local sellShopDialog = {
	intro = "I'll buy yer Nettomon. \nThat theres a Tinymon, I'll give ya 50 gold a piece",
	yes = "I'll make sure they have a good long life with a nice young human",
	no = "Too bad, some fine specimens you have"
}

local buyShopDialog = {
	intro = "I sell Guns N' Flowers.\nI'm all out of flowers but wanna buy some guns? \nOnly 100 gold!",
	yes =  "If you shoot someone's eye out, its not my fault",
	no = "Good thinking, these could shoot someone's eye out"
}

local shopDialog
local shopType

local function exitShop()
	shopGui.Enabled = false
	game:GetService("Players").LocalPlayer.PlayerGui.InteractionGuiModel.InteractionFinishedEvent:Fire()
end

local function enableButtons()
	noButton.Visible = true
	yesButton.Visible = true
	shopText.Text = shopDialog.intro
end

local function disableButtons()
	noButton.Visible = false
	yesButton.Visible = false
end


local function shopGuiHandler(shopName)
	shopGui.Enabled = true
	shopType = shopName
	if shopType == "BuyBuilding" then
		shopDialog = buyShopDialog
	else 
		shopDialog = sellShopDialog
	end
	enableButtons(shopName)
end

local function yesButtonHandler()
	disableButtons()
	shopText.Text = shopDialog.yes
	
	-- fire remote event to call sellScript
	if shopType == "BuyBuilding" then
		game:GetService("ReplicatedStorage"):WaitForChild("BuyShopEvent"):FireServer(game.Players.LocalPlayer)
	else
		game:GetService("ReplicatedStorage"):WaitForChild("SellShopEvent"):FireServer(game.Players.LocalPlayer)
	end
	
	
	wait(3)
	exitShop()
end

local function noButtonHandler()
	disableButtons()
	shopText.Text = shopDialog.no
	wait(3)
	exitShop()
end


script.Parent.ShopGuiStartedEvent.Event:Connect(shopGuiHandler)
shopGui.Frame.YesButton.MouseButton1Click:Connect(yesButtonHandler)
shopGui.Frame.NoButton.MouseButton1Click:Connect(noButtonHandler)

