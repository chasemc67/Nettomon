local parent = script.Parent
local humanoid = parent:FindFirstChildWhichIsA("Humanoid", true)
local locationsArr = parent.Locations:GetChildren()
local primaryPart = humanoid.Parent.PrimaryPart

local isNettomonStrong = script.Parent.isStrong.Value
local attackRadius = script.Parent.AttackRadius.Value
local alertRadius = script.Parent.AlertRadius.Value

local Players = game:GetService("Players")

-- states:
-- Running away from player
-- Running towards berry
-- substate at berry
-- Running towards player
-- substate at player
-- default


-- Each N frames, it should recalculate what state to be in
-- things that matter to decide:
-- How close to current target (player or berry)
-- how much HP
-- How close is the player right now
-- How close is the closest berry right now


local getNearestPlayer = function(parts)
	-- takes a list of nearby parts and returns the closest player part	
	-- this will only be needed for stronger nettomon
	for i=1, #parts do
		if parts[i].Name == "HumanoidRootPart" and parts[i].Parent.Name ~= "HumanoidNpc" then
			return parts[i]
		end
	end

	return nil
end

local getNearestBerry = function(parts)
	-- takes a list of parts and returns the closest berry part
	-- right now just returns the FIRST berry it finds, not the closest
	for i=1, #parts do
		if (parts[i].parent:FindFirstChild("Consumable")) then
			return parts[i]
		end
	end

	return nil
end

local getDistanceToPart = function(part)
	-- takes single item or location and returns distance from NPC to it
	if part then
		return (primaryPart.Position - part.position).Magnitude 
	end
	return math.huge
end




local getNextState = function(currentState, nearBerryPart, nearCharacterPart)

	local scareDistance = alertRadius
	local berryEatDistance = alertRadius

	local characterDistance = getDistanceToPart(nearCharacterPart)
	local berryDistance = getDistanceToPart(nearBerryPart)


	if berryDistance < berryEatDistance then
		return "berry"
	elseif characterDistance < scareDistance then
		if (isNettomonStrong) then
			return "attack"
		else
			return "run"
		end

	else 
		return "patrolling"
	end
end


local getNearbyParts = function()
	-- if an apple is found, move to that
	local min = primaryPart.Position - (10 * primaryPart.Size)
	local max = primaryPart.Position + (10 * primaryPart.Size)
	local region = Region3.new(min, max)
	local ignoreList = parent:GetChildren()
	local parts = workspace:FindPartsInRegion3WithIgnoreList(region, ignoreList)

	return parts
end


local prevState = nil
local state = "stopped"
local currentTarget = nil

local patrolTarget = nil
while wait(.3) do

	local parts = getNearbyParts()
	local berryPart = getNearestBerry(parts)
	local characterPart = getNearestPlayer(parts)

	local patrolPosition

	prevState = state
	state = getNextState(state, berryPart, characterPart)

	if state == "berry" then
		-- print("Found apple")
		humanoid:MoveTo(berryPart.Position)
		-- humanoid.MoveToFinished:Wait()
		if getDistanceToPart(berryPart) < 3 then
			berryPart:Destroy()
			wait(3)
		end
	elseif state == "run" then
		-- print("Running from player")
		if (prevState ~= "run") then
			-- print("Firing tried catch event")
			-- game:GetService("ReplicatedStorage"):WaitForChild("GameStateEvent"):FireClient(Players["metaverseplumber"], "catchTried")
			game:GetService("ReplicatedStorage"):WaitForChild("GameStateEvent"):FireClient(Players:GetPlayerFromCharacter(characterPart.Parent), "catchTried")
		end
		-- get inverse of direction between you and player
		-- set direction and start moving
		local directionAway = (primaryPart.Position - characterPart.Position)
		humanoid:Move(directionAway)
	elseif state == "patrolling" and prevState ~= "patrolling" then
		patrolTarget = locationsArr[math.random(#locationsArr)].Position
		humanoid:MoveTo(patrolTarget)	
	elseif state == "patrolling" and prevState == "patrolling" then
		if patrolTarget ~= nil and (patrolTarget - primaryPart.Position).Magnitude < 2 then
			patrolTarget = locationsArr[math.random(#locationsArr)].Position
			humanoid:MoveTo(patrolTarget)
		end
	elseif state == "attack" then
		if (getDistanceToPart(characterPart) <= attackRadius) then
			humanoid:MoveTo(primaryPart.Position) -- stop movement

			-- look at player
			primaryPart.Parent:SetPrimaryPartCFrame(CFrame.new(primaryPart.Position, characterPart.Position))

			-- damage player
			characterPart.Parent.Humanoid:TakeDamage(10)
		else 
			humanoid:MoveTo(characterPart.Position)	
		end
	else 
		-- do nothing	
	end
end



-- fill in getDistanceToPart
-- make sure the comparisons work against the integers or change them
-- fill in getCharacterPart
-- figure out how to set direction as "away" from player and move humanoid in that direction 