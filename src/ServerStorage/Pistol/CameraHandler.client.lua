--[[
local WeaponsSystemFolder = script.Parent:WaitForChild("WeaponsSystem")
local Libraries = WeaponsSystemFolder:WaitForChild("Libraries")
local WeaponsSystemModule = require(WeaponsSystemFolder:WaitForChild("WeaponsSystem"))


local Camera

script.Parent.Equipped:Connect(function()
	WeaponsSystemModule.camera:setEnabled(true)
end)

script.Parent.Unequipped:Connect(function()
	WeaponsSystemModule.camera:setEnabled(false)
	workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end)
]]