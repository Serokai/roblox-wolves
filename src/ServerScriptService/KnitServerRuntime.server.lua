local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

for _, moduleScript in pairs(script.Parent.Services:GetChildren()) do
	if moduleScript:IsA("ModuleScript") then
		local success, err = pcall(function()
			require(moduleScript)
		end)
		if not success then
			warn(string.format("Service '%s' errored while loading!", moduleScript.Name))
		end
	end
end

Knit.Start():catch(warn)