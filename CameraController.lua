-- DynamicCameraController.lua
local CameraController = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Sensitivity = 0.25
local Distance = 10
local Height = 2
local angleX, angleY = 0, 0

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		angleX = angleX - input.Delta.X * Sensitivity
		angleY = math.clamp(angleY - input.Delta.Y * Sensitivity, -45, 75)
	end
end)

RunService.RenderStepped:Connect(function()
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local root = LocalPlayer.Character.HumanoidRootPart
		local offset = CFrame.new(0, Height, Distance)
		local rotate = CFrame.Angles(math.rad(angleY), math.rad(angleX), 0)
		Camera.CFrame = CFrame.new(root.Position) * rotate * offset:Inverse()
	end
end)

return CameraController
