-- AimbotModule.lua
local Aimbot = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

Aimbot.Enabled = false
Aimbot.FOV = 80
Aimbot.Smoothness = 0.15

function Aimbot.GetClosestPlayer()
	local closest, distance = nil, math.huge
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
			local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
			if onScreen then
				local dist = (Vector2.new(screenPos.X, screenPos.Y) - UserInputService:GetMouseLocation()).Magnitude
				if dist < Aimbot.FOV and dist < distance then
					closest = player
					distance = dist
				end
			end
		end
	end
	return closest
end

RunService.RenderStepped:Connect(function()
	if Aimbot.Enabled then
		local target = Aimbot.GetClosestPlayer()
		if target and target.Character and target.Character:FindFirstChild("Head") then
			local aimPos = target.Character.Head.Position
			local screenPoint = Camera:WorldToScreenPoint(aimPos)
			mousemoverel((screenPoint.X - UserInputService:GetMouseLocation().X) * Aimbot.Smoothness,
			             (screenPoint.Y - UserInputService:GetMouseLocation().Y) * Aimbot.Smoothness)
		end
	end
end)

return Aimbot
