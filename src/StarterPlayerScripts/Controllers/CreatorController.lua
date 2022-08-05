local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local serversGui = playerGui:WaitForChild("ServersGui")
local creatorGui = playerGui:WaitForChild("CreatorGui")

local scrollingFrame = creatorGui.Background:WaitForChild("ScrollingFrame")
local overview = scrollingFrame:WaitForChild("Overview")

local Knit = require(ReplicatedStorage.Packages.Knit)

local CreatorController = Knit.CreateController {
    Name = "CreatorController"
}

CreatorController.classicRoles = {
    [1] = {"Villager", 0, "rbxassetid://10474063967"},
    [2] = {"Werewolf", 0, "rbxassetid://10474063679"}
}

CreatorController.specialRoles = {
    [1] = {"Fortune Teller", false, "rbxassetid://10474065037"},
    [2] = {"Little Girl", false, "rbxassetid://10474064460"},
    [3] = {"Witch", false, "rbxassetid://10474063454"},
    [4] = {"Hunter", false, "rbxassetid://10474064697"},
    [5] = {"Cupid", false, "rbxassetid://10474065356"},
    [6] = {"Thief", false, "rbxassetid://10474064222"}
}

function CreatorController:SetupClicks()
    serversGui.CreateButton.MouseButton1Click:Connect(function()
        serversGui.Enabled = false
        creatorGui.Enabled = true

        self:SetupCreatorGui()
    end)
end

function CreatorController:SetupCreatorGui()
    local function DestroyImageLabels(list)
        if not list:FindFirstChildWhichIsA("ImageLabel") then return end

        for _, imageLabel in pairs(list) do
            if imageLabel:IsA("ImageLabel") then
                imageLabel:Destroy()
            end
        end
    end


    for _, value in ipairs(self.classicRoles) do
        value[2] = 0

        local classicRole = scrollingFrame.ClassicRoles.RoleName:Clone()
        classicRole.Name = value[1]
        classicRole.Image = value[3]
        classicRole.Visible = true
        classicRole.Parent = scrollingFrame.ClassicRoles.List
    end

    for _, value in ipairs(self.specialRoles) do
        value[2] = false

        local specialRole = scrollingFrame.SpecialRoles.RoleName:Clone()
        specialRole.Name = value[1]
        specialRole.Image = value[3]
        specialRole.Visible = true
        specialRole.Parent = scrollingFrame.SpecialRoles.List
    end

    -- ? Overview
    overview.OwnerImage.Image = Players:GetUserThumbnailAsync(localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    overview.OwnerName.Text = localPlayer.Name

    -- ? Roles
    self:RefreshCreatorGui()
end

function CreatorController:RefreshCreatorGui()
    
end

function CreatorController:KnitStart()
    print("CreatorController started.")
end

function CreatorController:KnitInit()
    self:SetupClicks()
end

return CreatorController