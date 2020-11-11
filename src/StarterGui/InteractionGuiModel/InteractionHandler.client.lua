local UserInputService = game:GetService("UserInputService")
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:wait()
local hrp = Character:WaitForChild("HumanoidRootPart", 3)


-- local oldWalkSpeed


-- Events
-- local NpcInteractionGuiModel = game.StarterGui.NpcInteractionGuiModel
local InteractionGuiModel = script.Parent


-- Local variables
local interactionGui = InteractionGuiModel.InteractionGui
local isInteracting = false
local playerPos


local function BeginInteraction()
	-- oldWalkSpeed = Character.Humanoid.WalkSpeed
	-- Character.Humanoid.WalkSpeed = 0
	isInteracting = true
	interactionGui.Enabled = false
end

local function finishInteraction()
	-- Character.Humanoid.WalkSpeed = oldWalkSpeed
	isInteracting = false
end



local function bindInteractionE()
	interactionGui.Enabled = true
	game:GetService("ContextActionService"):BindAction("npcInteraction", function()
		game:GetService("Players").LocalPlayer.PlayerGui.NpcInteractionGuiModel.NpcInteractionStartedEvent:Fire()
		BeginInteraction()
	end, false, Enum.KeyCode.E)
end

local function unBindInteractionE()
	interactionGui.Enabled = false
	game:GetService("ContextActionService"):UnbindAction("npcInteraction")
end

local function bindInteractionShopE(name)
	interactionGui.Enabled = true
	game:GetService("ContextActionService"):BindAction("npcInteraction", function()
		local name = name
		game:GetService("Players").LocalPlayer.PlayerGui.ShopGuiModel.ShopGuiStartedEvent:Fire(name)
		BeginInteraction()
	end, false, Enum.KeyCode.E)
end

local function unBindInteractionShopE()
	interactionGui.Enabled = false
	game:GetService("ContextActionService"):UnbindAction("npcInteraction")
end

local function displayGuiLoop()
	while wait() do
		if isInteracting == false then
			unBindInteractionE()
			unBindInteractionShopE()
			for i,v in pairs(workspace.NPCs:GetChildren()) do
				-- if (hrp.Position - v.InteractionPart.Value.Position).magnitude < 18 then		-- use something more abstract than Room.FrontPart
				if (hrp.Position - v.HumanoidRootPart.Position).magnitude < 15 then
					bindInteractionE()
				end
			end	
			for i,v in pairs(workspace.Shops:GetChildren()) do
				if (hrp.Position - v.InteractionPart.Value.Position).magnitude < 10 then		-- use something more abstract than Room.FrontPart
					bindInteractionShopE(v.Name)
				end
			end
		else
			unBindInteractionE()
			unBindInteractionShopE()
		end
	end

end



-- UserInputService.InputBegan:Connect(onInputBegan)
script.Parent.InteractionFinishedEvent.Event:Connect(finishInteraction)
displayGuiLoop()





