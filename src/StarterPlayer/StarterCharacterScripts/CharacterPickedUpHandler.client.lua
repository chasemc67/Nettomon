local LocalPlayer = game:GetService("Players").LocalPlayer

script.Parent.ChildAdded:Connect(function(instance)
	if instance.Name == "Apple" then
		print("firing event from local script")
		-- game:GetService("ReplicatedStorage"):WaitForChild("GameStateEvent"):FireServer("pickedUpBerry")
		LocalPlayer.PlayerScripts.LocalGameStateEvent:Fire("pickedUpBerry")
	end
end)
