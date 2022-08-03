local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local ServerService = Knit.CreateService {
    Name = "ServerService",
    Client = {}
}

ServerService.Servers = {

    ["PlayerName"] = {
        "Public",
        "Textual",
        "RequiredPlayers",
        ["Roles"] = {
            ["Werewolf"] = 1,
            ["Villager"] = 1,
            ["Fortune Teller"] = 1,
        }
    },

}

function ServerService.CreateServer(owner, requiredPlayers, configurationRoles, privacy, gamemode)
    
end

function ServerService.requestServer(owner)
    local test = self.Servers

    if self.Servers[owner.Name] then
        
    end
end

function ServerService.getServer(owner)
    if self.Servers[owner.Name] then
        return {}
    end
end

return ServerService