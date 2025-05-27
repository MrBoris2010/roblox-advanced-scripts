-- ESPModule--
local ESP = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local DrawingObjects = {}

function ESP:DrawESP(player)
	local box = Drawing.new("Square")
	box.Visible = true
	box.Color = Color3.fromRGB(0, 255, 0)
	box.Thickness = 2
	box.Filled = false
	DrawingObjects[player] = box
end

function ESP:RemoveESP(player)
	if DrawingObjects[player] then
		DrawingObjects[player]:Remove()
		DrawingObjects[player] = nil
	end
end

RunService.RenderStepped:Connect(function()
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
			if not DrawingObjects[player] then
				ESP:DrawESP(player)
			end
			local size = 50 -- simplified box size
			local box = DrawingObjects[player]
			box.Size = Vector2.new(size, size * 2)
			box.Position = Vector2.new(pos.X - size/2, pos.Y - size)
			box.Visible = onScreen
		elseif DrawingObjects[player] then
			ESP:RemoveESP(player)
		end
	end
end)

return ESP
