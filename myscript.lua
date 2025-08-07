local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/AbstractPoo/Fluent-UI/main/source.lua"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Variables
local runningAutoDig = false
local autoSellAll = false
local autoSellInterval = 10
local selectedCharm = nil

local Window = Fluent:CreateWindow({
    Title = "Saturn Hub (.gg/6UaRDjBY42)",
    SubTitle = "DIG Discontinued Script",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker"
})

local MainTab = Window:AddTab({ Title = "Main", Icon = "shovel" })

MainTab:AddToggle("Auto Dig", { Default = false }, function(Value)
    runningAutoDig = Value
    if Value then
        task.spawn(function()
            while runningAutoDig do
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait(0.05)
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                task.wait(1.5)
                -- Your Dig_Finished event logic can go here
            end
        end)
    end
end)

MainTab:AddButton("Sell All Items", function()
    task.spawn(function()
        local args = {
            workspace:WaitForChild("World"):WaitForChild("NPCs"):WaitForChild("Rocky")
        }
        ReplicatedStorage:WaitForChild("DialogueRemotes"):WaitForChild("SellAllItems"):FireServer(unpack(args))
    end)
end)

MainTab:AddToggle("Auto Sell All", { Default = false }, function(Value)
    autoSellAll = Value
    if Value then
        task.spawn(function()
            while autoSellAll do
                local args = {
                    workspace:WaitForChild("World"):WaitForChild("NPCs"):WaitForChild("Rocky")
                }
                ReplicatedStorage:WaitForChild("DialogueRemotes"):WaitForChild("SellAllItems"):FireServer(unpack(args))
                Fluent:Notify({
                    Title = "Auto Sell",
                    Content = "All items sold.",
                    Duration = 3
                })
                task.wait(autoSellInterval)
            end
        end)
    end
end)

MainTab:AddSlider("Auto Sell Interval (s)", {
    Min = 1,
    Max = 300,
    Default = 10,
    Rounding = 0,
    Suffix = "s"
}, function(Value)
    autoSellInterval = Value
end)

Fluent:Notify({
    Title = "Saturn Hub",
    Content = "DIG loaded successfully!",
    Duration = 5
})
