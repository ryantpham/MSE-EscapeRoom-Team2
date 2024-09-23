local npc = script.Parent
local TextLabel = script.Parent:WaitForChild("Frame"):WaitForChild("TextLabel")
script.Value.Value.Enabled = false

-- Function to play sound effect
function SoundEffect()
	local Sound = Instance.new("Sound", workspace)
	Sound.Name = "TextSound"
	Sound.SoundId = "http://www.roblox.com/asset/?id=3333976425"
	Sound.PlaybackSpeed = 1
	Sound.Volume = 1
	Sound:Play()
	coroutine.resume(coroutine.create(function()
		wait(1)
		Sound:Destroy()
	end))
end

-- Function to display text letter by letter
function setText(word)
	local Text = word
	for i = 1, #Text do
		TextLabel.Text = string.sub(Text, 1, i)
		SoundEffect()
		wait(0.01)  -- Adjust delay for speed of text display
	end
end

-- NPC Message to send after the text display
local messageToSend = "General Program Summary - The program focuses on teaching the full process of building software, from planning to completion. It covers key industry practices and methods, such as Agile, Scrum, and design patterns. What makes this program stand out is its strong focus on following established processes and best practices in software development."

-- Displaying text on the UI
setText("Welcome to California State University, Fullerton!")
wait(2)
setText("We're excited to have you here.")  -- Your text here
wait(2)

-- Send the summary message to the chat using TextChatService
local TextChatService = game:GetService("TextChatService")
TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage("[NPC]: " .. messageToSend)

-- Finish up
script.Value.Value.Enabled = true
script.Destroyer:FireServer()
