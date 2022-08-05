local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local menuGui = playerGui:WaitForChild("MenuGui")

local normalBlur = TweenService:Create(Lighting.Blur, TweenInfo.new(1.5), {Size = 4})
local advancedBlur = TweenService:Create(Lighting.Blur, TweenInfo.new(1.5), {Size = 24})

--local roundFrameRight = UDim2.new(0.471, 0, -0.009, 0)
--local roundFrameLeft  = UDim2.new(0, 0, -0.009, 0)

local Knit = require(ReplicatedStorage.Packages.Knit)

local GuiController = Knit.CreateController {
    Name = "GuiController"
}

function GuiController:SetupGuis()
    local whitelistedGuis = {"MenuGui"}

    for _, screenGui in ipairs(playerGui:GetChildren()) do
        if not table.find(whitelistedGuis, screenGui.Name) then
            screenGui.Enabled = false
        else
            screenGui.Enabled = true
        end
    end
end

function GuiController:SetupEffects()
    for _, lightingEffect in pairs(Lighting:GetChildren()) do
        lightingEffect.Enabled = true
    end
    Lighting.Brightness = 2
    Lighting.ClockTime = 20
    Lighting.FogEnd = 100

    for _, textButton in ipairs(menuGui:GetDescendants()) do
        if not textButton:IsA("TextButton") then continue end

        textButton.MouseEnter:Connect(function()
            ReplicatedStorage.Sounds.button_hover:Play()
            textButton.Bar:TweenSize(UDim2.new(1, 0, 0.1, 0), "Out", "Sine", 0.3, true)
        end)

        textButton.MouseLeave:Connect(function()
            textButton.Bar:TweenSize(UDim2.new(0, 0, 0.1, 0), "Out", "Sine", 0.3, true)
        end)

        textButton.MouseButton1Click:Connect(function()
            menuGui.Container:TweenPosition(UDim2.new(-0.5, 0, 0.15, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.3, true)

            for _, imageLabel in ipairs(menuGui.Container:GetChildren()) do
                if not imageLabel:IsA("ImageLabel") then continue end
                local blacklistedGuis = {"SettingsImage", "ShopImage", "CreditsImage"}

                if not table.find(blacklistedGuis, imageLabel.Name) then
                    advancedBlur:Play()

                    local buttonGui = playerGui[string.gsub(imageLabel.Name, "Image", "") .. "Gui"]
                    buttonGui.Enabled = true
                end
            end
        end)
    end
end

function GuiController:SetupReturns()
    for _, backButton in ipairs(playerGui:GetDescendants()) do
        if not (backButton:IsA("TextButton") and backButton.Name == "BackButton") then continue end

        backButton.MouseButton1Click:Connect(function()
            backButton.Parent.Enabled = false
            local guiToEnable = backButton.Parent:GetAttribute("PreviousGui")

            if guiToEnable == "MenuGui" then
                menuGui.Container:TweenPosition(UDim2.new(0.08, 0, 0.15, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.3, true)
            end

            normalBlur:Play()
            playerGui[guiToEnable].Enabled = true
        end)
    end
end

function GuiController:KnitStart()
    print("GuiController started.")
end

function GuiController:KnitInit()
    --

    self:SetupGuis()
    self:SetupEffects()
    self:SetupReturns()
end

return GuiController