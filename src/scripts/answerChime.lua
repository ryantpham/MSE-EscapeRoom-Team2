local part = script.Parent  -- Reference to the part the script is inside
local sound = part:FindFirstChild("Sound")  -- Reference to the sound object inside the part
local ChatService = game:GetService("Chat")  -- Get the Chat service
local touchedPlayers = {}  -- Table to keep track of players who have touched the part

-- Function to send "Correct!" to the player's chatbox and clear it after 0.5 seconds
local function sendToChat(player)
	if not touchedPlayers[player.UserId] then  -- Check if the player has already touched the part
		touchedPlayers[player.UserId] = true  -- Mark the player as having touched the part

		ChatService:Chat(player.Character, "Correct!", Enum.ChatColor.Green)  -- Send message to player's chat

		-- Wait 0.5 seconds and then send a message to clear the chat
		wait(0.5)
		ChatService:Chat(player.Character, " ", Enum.ChatColor.White)  -- Clear the message
	end
end

-- Function to play the sound and send the chat message when the part is touched
local function onTouched(hit)
	local character = hit.Parent  -- The object that touched the part
	local humanoid = character:FindFirstChild("Humanoid")

	if humanoid then  -- Check if it's a player
		local player = game.Players:GetPlayerFromCharacter(character)  -- Get the player from the character
		if player then
			-- Play the sound only the first time the player touches the part
			if sound and not touchedPlayers[player.UserId] then  -- Check if the sound exists and the player hasn't triggered it
				sound:Play()  -- Play the sound
				sendToChat(player)  -- Send "Correct!" to the player's chatbox
			end
		end
	end
end

-- Connect the Touched event to the function
part.Touched:Connect(onTouched)
