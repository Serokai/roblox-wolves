local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local serversGui = playerGui:WaitForChild("ServersGui")
local creatorGui = playerGui:WaitForChild("CreatorGui")

local Knit = require(ReplicatedStorage.Packages.Knit)

local ServerController = Knit.CreateController {
    Name = "ServerController"
}

function ServerController:KnitStart()
    print("ServerController started.")
end

function ServerController:KnitInit()
    --
end

return ServerController