
local gameStates = {
	"intro",
	"catchTried",
	"pickedUpBerry",
	"sellingNettomon"
}

local currentState = 0


local function catchTried()
	if currentState < 2 then
		currentState = 2
		script.State.Value = gameStates[currentState]
		game:GetService("Players").LocalPlayer.PlayerGui.NpcInteractionGuiModel.NpcDialogEvent:Fire(gameStates[currentState])
	end
end

script.catchTried.Event:Connect(catchTried)


local function pickedUpBerry()
	if currentState < 3 then
		currentState = 3
		script.State.Value = gameStates[currentState]
		game:GetService("Players").LocalPlayer.PlayerGui.NpcInteractionGuiModel.NpcDialogEvent:Fire(gameStates[currentState])
	end
end

script.pickedUpBerry.Event:Connect(pickedUpBerry)

local function sellingNettomon()
	if currentState < 4 then
		currentState = 4
		script.State.Value = "sellingNettomon"
		game:GetService("Players").LocalPlayer.PlayerGui.NpcInteractionGuiModel.NpcDialogEvent:Fire(gameStates[currentState])
	end
end

local function handleGameStateEvent(eventString)
	print("Handling event: " .. eventString)
	if eventString == "catchTried" then
		catchTried()
	elseif eventString == "pickedUpBerry" then
		pickedUpBerry()
	elseif eventString == "sellingNettomon" then
		sellingNettomon()
	end
end

script.sellingNettomon.Event:Connect(sellingNettomon)

game:GetService("ReplicatedStorage"):WaitForChild("GameStateEvent").OnClientEvent:Connect(handleGameStateEvent)
script.Parent:WaitForChild("LocalGameStateEvent").Event:Connect(handleGameStateEvent)