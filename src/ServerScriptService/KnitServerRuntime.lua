local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

Knit.AddServices(script.Parent.Services)

Knit:Start():andThen(function()
    print("Knit Server Started")
end):catch(warn)