local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local Knit = require(ReplicatedStorage.Packages.Knit)

local localPlayer = Players.LocalPlayer

local PlayerController = Knit.CreateController {
    Name = "PlayerController"
}

function PlayerController:CreateDummy()
    local dummy = ReplicatedStorage.Clones.Dummy:Clone()
    dummy.Parent = Workspace.Scenes.Main
    dummy:WaitForChild("Humanoid"):ApplyDescription(Players:GetHumanoidDescriptionFromUserId(localPlayer.UserId))

    local dummyAnimation = Instance.new("Animation")
    dummyAnimation.AnimationId = "rbxassetid://10474977650"
    
    local dummyAnimationTrack = dummy.Humanoid:LoadAnimation(dummyAnimation)
    dummyAnimationTrack.Looped = true
    dummyAnimationTrack:Play()
end

function PlayerController:KnitStart()
    print("PlayerController started.")
end

function PlayerController:KnitInit()
    self:CreateDummy()
end

return PlayerController