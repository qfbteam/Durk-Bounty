    ["Theme"] = {
        ["Enable"] = false,
        ["Name"] = "Ayaka", -- Hutao, Raiden, Ayaka, Yelan
        ["Custom Theme"] = {
            ["Enable"] = true,
            ["Text Color"] = Color3.fromRGB(231, 85, 88),
            ["Character Position"] = UDim2.new(0.563000023, 0, -0.174999997, 0)
        }
    },
    ["Webhook"] = {
        ["Enable"] = false,
        ["Url"] = "https://discord.com/api/webhooks/1290696805759057993/UNhPuNKxI1BJjkV3uAyg_PX1dHSsixK1F72GNvIoYCqfS6YzoWC6PM7e6zgQ-udEVf6l",
        ["Image"] = ""
    }
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/verudous/Xero-Hub/main/autobounty.lua"))()
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Durk Ware|Auto Bounty", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local players = game:GetService("Players") -- Obtém o serviço de jogadores
local numberPlayer = #players:GetPlayers() -- Conta o número de jogadores no servidor

Tab:AddLabel(tostring(numberPlayer))


local RunService = game:GetService("RunService")
local fps = 0
local frames = 0
local lastTime = tick()

-- Adiciona o label sem o valor inicial
local fpsLabel = Tab:AddLabel("Fps: Calculando...")

-- Função para calcular o FPS
RunService.RenderStepped:Connect(function()
    frames = frames + 1
    local currentTime = tick()

    -- Verifica se passou 1 segundo
    if currentTime - lastTime >= 1 then
        fps = frames
        frames = 0
        lastTime = currentTime

        -- Atualiza o texto do label com o novo FPS
        fpsLabel:Set("Fps: " .. fps)
    end
end)


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Função para encontrar o jogador mais próximo
local function getNearestPlayer()
    local nearestPlayer = nil
    local shortestDistance = math.huge -- Um número muito grande

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - Camera.CFrame.Position).magnitude
            
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end

    return nearestPlayer
end

-- Criação do parágrafo inicial
local CoolParagraph = Tab:AddParagraph("Jogador Mais Próximo", "Aguardando...")

-- Atualização do parágrafo
local function updateParagraph()
    while true do
        wait(1) -- Atualiza a cada segundo
        
        local nearestPlayer = getNearestPlayer()
        if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("Humanoid") then
            local hp = nearestPlayer.Character.Humanoid.Health
            CoolParagraph:Set(nearestPlayer.Name, tostring(hp)) -- Atualiza o parágrafo
        else
            CoolParagraph:Set("Nenhum jogador próximo", "0") -- Atualiza para quando não houver jogador próximo
        end
    end
end

-- Inicie a atualização do parágrafo
updateParagraph()



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function getNearestPlayer()
    local localPlayer = Players.LocalPlayer
    local nearestPlayer = nil
    local nearestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestPlayer = player
            end
        end
    end

    return nearestPlayer
end

local lastNearestPlayer = nil -- Armazena o último jogador mais próximo

while true do
    wait(4) -- Espera 4 segundos

    local nearestPlayer = getNearestPlayer()
    
    -- Verifica se o jogador mais próximo mudou
    if nearestPlayer ~= lastNearestPlayer then
        lastNearestPlayer = nearestPlayer
        
        if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("Humanoid") then
            local hp = nearestPlayer.Character.Humanoid.Health
            -- Exibe a notificação duas vezes
            for i = 1, 2 do
                OrionLib:MakeNotification({
                    Name = nearestPlayer.Name,
                    Content = "Vida: " .. tostring(hp), -- Mostra a vida do humanoide mais próximo
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
                wait(1) -- Espera 1 segundo entre as notificações
            end
        end
    end
end
