-- Tải Fluent 2.0 UI Library (david/akvtd version)
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/source.lua"))()

local Window = Fluent:CreateWindow({
    Title = "ImFar69",
    SubTitle = "by akvtd",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 300),
    Acrylic = true,
    Theme = "Dark", -- Bạn có thể đổi sang "Aqua", "Light", v.v.
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Tạo tab chính
local MainTab = Window:AddTab({ Title = "Main", Icon = "💼" })

-- Biến điều khiển
local autoSell = false
local delayTime = 5

-- Hàm bán cho Rocky
local function sellToRocky()
    local rs = game:GetService("ReplicatedStorage")
    local remote = rs:WaitForChild("DialogueRemotes"):WaitForChild("SellAllItems")
    local rocky = workspace:WaitForChild("World"):WaitForChild("NPCs"):WaitForChild("Rocky")
    pcall(function()
        remote:InvokeServer(rocky)
        print("Đã bán tất cả vật phẩm cho Rocky.")
    end)
end

-- Auto bán loop
task.spawn(function()
    while true do
        if autoSell then
            sellToRocky()
        end
        task.wait(delayTime)
    end
end)

-- 🧠 Tạo phần tử giao diện trong Main
MainTab:AddToggle("Auto Sell", {
    Title = "Auto Sell",
    Default = false,
    Callback = function(state)
        autoSell = state
    end
})

MainTab:AddSlider("Sell Delay", {
    Title = "Thời gian giữa mỗi lần bán (giây)",
    Description = "Chọn khoảng thời gian giữa các lần bán.",
    Min = 1,
    Max = 30,
    Default = 5,
    Callback = function(value)
        delayTime = value
    end
})

-- (Tùy chọn) Tab Cài đặt
Window:AddTab({ Title = "Settings", Icon = "⚙️" })
