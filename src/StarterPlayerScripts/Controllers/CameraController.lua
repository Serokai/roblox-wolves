local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Knit = require(ReplicatedStorage.Packages.Knit)

local CameraController = Knit.CreateController {
    Name = "CameraController"
}

function CameraController:SetupCamera()
    local currentCamera = Workspace.CurrentCamera

    currentCamera.CFrame = Workspace.CameraParts.Main.CFrame
    currentCamera.CameraType = Enum.CameraType.Scriptable
end

function CameraController:KnitStart()
    print("CameraController KnitStart called")
end

function CameraController:KnitInit()
    print("CameraController KnitInit called")

    RunService.RenderStepped:Connect(function()
        self:SetupCamera()
    end)
end

return CameraController