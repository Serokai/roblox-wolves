local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local menuGui = playerGui:WaitForChild("MenuGui")
local menuGuiX = UDim2.new(0.08, 0)

local normalBlur = 8
local advancedBlur = 24

local roundFrameRight = UDim2.new(0.471, 0, -0.009, 0)
local roundFrameLeft  = UDim2.new(0, 0, -0.009, 0)

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
            menuGui.Container:TweenPosition(UDim2.new(-1, 0, menuGui.Container.Position.Y.Scale, 0))

            for _, imageLabel in ipairs(menuGui.Container:GetChildren()) do
                if not imageLabel:IsA("ImageLabel") then continue end
                local blacklistedGuis = {"SettingsImage", "ShopImage", "CreditsImage"}

                if not table.find(blacklistedGuis, imageLabel.Name) then
                    local BlurTween = TweenService:Create(Lighting.Blur, TweenInfo.new(1.5), {Size = advancedBlur})
                    BlurTween:Play()

                    local buttonGui = playerGui[string.gsub(imageLabel.Name, "Image", "") .. "Gui"]
                    --buttonGui.Enabled = true
                    playerGui.HostGui.Enabled = true

                    --local sizeTween = TweenService:Create(buttonGui.Background, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 1, false, 0), {Size = UDim2.new(0, 670, 0, 730)})
                    --sizeTween:Play()

                    --buttonGui.Background.Frame:TweenSize(UDim2.new(0, 655, 0, 717))
                    --buttonGui.Background:TweenSize(UDim2.new(0, 670, 0, 730))
    
                    local currentrot = buttonGui.Overlay.UIGradient.Rotation -- Gets the initial rotation of the UIGradient
                    local TweenInformation = TweenInfo.new(5, Enum.EasingStyle.Linear,Enum.EasingDirection.In,-1,false)
                    local Goal = {Rotation = currentrot + 360}
                    local Tween = TweenService:Create(buttonGui.Overlay.UIGradient, TweenInformation, Goal)
                    Tween:Play()
                end
            end
        end)
    end
end

function GuiController:KnitStart()
    print("GuiController KnitStart called")
end

function GuiController:KnitInit()
    print("GuiController KnitInit called")

    self:SetupGuis()
    self:SetupEffects()
end

return GuiController