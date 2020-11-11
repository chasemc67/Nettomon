-- The amount of time to swing the tool. 0.5 will be shorter, 3 will be longer
local SWING_TIME = 2

--====================== DO NOT EDIT UNDER HERE ======================--
local Players = game:GetService("Players")

-- Checks if player can or cannot swing the tool
local canSwing = true
-- Gets the humanoid attached to the player with this tool
local tool = script.Parent
local player = Players.LocalPlayer

-- local character = player.Character
player.CharacterAdded:Connect(function(character) 
	if not character then
		character = player.CharacterAdded:Wait()
	end
	local humanoid = character:WaitForChild("Humanoid")

	-- Animations
	local r6swing = script:WaitForChild("R6AnimationSwing")
	local r15swing = script:WaitForChild("R15AnimationSwing")

	wait()

	-- local r6swing = script.R6AnimationSwing
	-- local r15swing = script.R15AnimationSwing

	-- Wait for the character to be part of the workspace (can't set animations
	-- on characters not in the workspace)
	while not character:IsDescendantOf(game.Workspace) do
		wait()
	end
	-- Sets the animation to the correct rig type for the player rig
	local rigType = humanoid.RigType
	local swing = nil 
	if rigType == Enum.HumanoidRigType.R15 then
		swing = humanoid:LoadAnimation(r15swing)
	elseif rigType == Enum.HumanoidRigType.R6 then
		swing = humanoid:LoadAnimation(r6swing)
	end
	-- Calculate the animation speed based on actual length and desired time
	while swing.Length == 0 do
		wait()
	end
	local swingSpeed = swing.Length / SWING_TIME

	local function swingTool()
		if canSwing == true then
			-- Keep user from clicking until animation finishes
			canSwing = false

			-- Start playing animation
			swing:Play()
			swing:AdjustSpeed(swingSpeed)

			-- Wait before allowing user to click again
			wait(SWING_TIME)
			canSwing = true
		end
	end

	-- Plays whenever player left clicks using the tool
	tool.Activated:Connect(swingTool)
end)


