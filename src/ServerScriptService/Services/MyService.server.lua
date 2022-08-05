local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

local MyService = Knit.CreateService {
    Name = "MyService",
    Client = {},
}

function MyService:KnitStart()
    --print("MyService started.")
end

function MyService:KnitInit()
end

return MyService