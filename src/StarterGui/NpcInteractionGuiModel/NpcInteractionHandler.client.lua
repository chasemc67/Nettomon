local NpcInteractionGuiModel = script.Parent
local gui = NpcInteractionGuiModel.NpcInteractionGui
local textBox = gui.Frame.TextLabel
local textTable = require(game.Workspace.NPCs.Soldier.NpcInteractionLines)

local interacting = false

local function animateIn() 
	gui.Frame.Position = UDim2.new(2,0,2,0)
	gui.Enabled = true
	gui.Frame:TweenPosition(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Bounce, 0.5, true)
	wait(0.5)
end

local function animateOut()
	gui.Frame:TweenPosition(UDim2.new(2, 0, 2, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Bounce, 0.5, true)
	wait(0.5)
	gui.Enabled = false	
end

local function animateText(textBox, text)
	for i = 1, #text do
		textBox.Text = string.sub(text, 0, i)
		wait()
	end
end

local function npcInteraction()
	if interacting then
		return
	end
	interacting = true
	animateIn()
	
	
	local textLabel = textTable[game:GetService("Players").LocalPlayer.PlayerScripts.GameStateManager.State.Value]
	if textLabel == nil then
		textLabel = textTable.intro
	end
	
	for index, line in ipairs(textLabel) do
		animateText(textBox, line)
		wait(2)
	end
	
	wait(2)
	
	animateOut()
	game:GetService("Players").LocalPlayer.PlayerGui.InteractionGuiModel.InteractionFinishedEvent:Fire()
	interacting = false
end

local function handleGameStateNpcDialogEvent(currentState)
	if interacting then
		return
	end
	interacting = true
	-- allows external functions to kick off dialog 
	animateIn()
	
	local textLabel = textTable[currentState]
	for index, line in ipairs(textLabel) do
		animateText(textBox, line)
		wait(2)
	end

	wait(2)

	animateOut()
	interacting = false
	
end

script.Parent.NpcInteractionStartedEvent.Event:Connect(npcInteraction)
script.Parent.NpcDialogEvent.Event:Connect(handleGameStateNpcDialogEvent)