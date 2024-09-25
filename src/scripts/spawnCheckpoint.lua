local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local Camera = game.Workspace.CurrentCamera

local checkpoint = script.Parent

function onTouched(hit)
	if hit and hit.Parent and hit.Parent:FindFirstChildOfClass("Humanoid") then
		local player = Players:GetPlayerFromCharacter(hit.Parent)
		local checkpointData = ServerStorage:FindFirstChild("CheckpointData")

		if not checkpointData then
			checkpointData = Instance.new("Folder")
			checkpointData.Name = "CheckpointData"
			checkpointData.Parent = ServerStorage
		end

		local userIdString = tostring(player.UserId)
		local checkpointValue = checkpointData:FindFirstChild(userIdString)

		if not checkpointValue then
			checkpointValue = Instance.new("ObjectValue")
			checkpointValue.Name = userIdString
			checkpointValue.Parent = checkpointData

			player.CharacterAdded:Connect(function(character)
				wait()
				local storedCheckpoint = checkpointValue.Value
				local spawnPosition = storedCheckpoint.Position + Vector3.new(math.random(-3, 3), 3, math.random(-3, 3))
				character:MoveTo(spawnPosition)

				-- Set the character's CFrame to face forward (adjust the Vector3 as needed)
				local forwardDirection = Vector3.new(0, 0, 1) -- This is the forward direction
				character:SetPrimaryPartCFrame(CFrame.new(spawnPosition, spawnPosition + forwardDirection))

				-- Set the camera to face the same direction with an angle
				local cameraOffset = Vector3.new(0, 5, -10) -- Adjust the camera position relative to the spawn position
				local cameraPosition = spawnPosition + cameraOffset
				Camera.CFrame = CFrame.new(cameraPosition, spawnPosition) -- Look at the spawn position
			end)
		end

		checkpointValue.Value = checkpoint
	end
end

checkpoint.Touched:Connect(onTouched)
