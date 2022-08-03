local ReplicatedStorage = game:GetService("ReplicatedStorage")


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