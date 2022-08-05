local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Knit = require(ReplicatedStorage.Packages.Knit)

local ServerService = Knit.CreateService {
    Name = "ServerService",
    Client = {}
}

ServerService.Servers = {
    ["Owner Name"] = {
        ["Privacy Mode"] = "Public",
        ["Chat Mode"] = "Textual",
        ["Required Players"] = 10,
        ["Waiting Players"] = {
            "Player1",
            "Player2",
            "Player3"
        },
        ["Configuration Roles"] = {
            ["Role 1"] = 1,
            ["Role 2"] = 2,
            ["Role 3"] = 3,
        }
    },

}

function ServerService:ListenForLeaves()
    Players.PlayerRemoving:Connect(function(player)
        if self.Servers[player] then
            self:DeleteServer(player)
        end
    end)
end

function ServerService:UpdateServer(owner, privacyMode, chatMode, requiredPlayers, configurationRoles)
    if not self.Servers[owner] then
        self:CreateServer(owner, privacyMode, chatMode, requiredPlayers, configurationRoles)
    end

    self.Servers[owner]["Privacy Mode"] = privacyMode
    self.Servers[owner]["Chat Mode"] = chatMode
    self.Servers[owner]["Required Players"] = requiredPlayers
    self.Servers[owner]["Configuration Roles"] = configurationRoles

    self:UpdateServerList()
end

function ServerService:UpdateServerList()
    
end

function ServerService:CreateServer(owner, privacyMode, chatMode, requiredPlayers, configurationRoles)
    self.Servers[owner]["Privacy Mode"] = privacyMode
    self.Servers[owner]["Chat Mode"] = chatMode
    self.Servers[owner]["Required Players"] = requiredPlayers
    self.Servers[owner]["Configuration Roles"] = configurationRoles

    self.Servers[owner]["Waiting Players"] = 0
end

function ServerService:DeleteServer(owner)
    if self.Servers[owner.Name] then
        for _, value in pairs(self.Servers[owner.Name]) do
            value:Destroy()
        end
    end

    self:UpdateServerList()
end

function ServerService:GetServerKey(owner, requestedKey)
    if self.Servers[owner] then
        for serverKey, serverValue in pairs(self.Servers[owner]) do
            if serverKey == requestedKey then
                return serverValue
            end
        end
    end

    return warn("Server or value not found.")
end

function ServerService:KnitStart() end

function ServerService:KnitInit()
    print("ServerService initiated.")

    self:ListenForLeaves()
end

return ServerService