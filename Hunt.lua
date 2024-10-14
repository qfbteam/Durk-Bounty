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

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

while true do
    wait(3)  -- Espera 3 segundos

    local closestHumanoid = nil
    local closestDistance = math.huge  -- Inicia com uma distância muito grande

    -- Percorre todos os jogadores no servidor
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            local otherCharacter = otherPlayer.Character
            if otherCharacter and otherCharacter:FindFirstChildOfClass("Humanoid") then
                local otherHumanoid = otherCharacter:FindFirstChildOfClass("Humanoid")
                local distance = (character.HumanoidRootPart.Position - otherCharacter.HumanoidRootPart.Position).magnitude

                -- Verifica se este humanoide é o mais próximo
                if distance < closestDistance then
                    closestDistance = distance
                    closestHumanoid = otherHumanoid
                end
            end
        end
    end

    -- Se um humanoide mais próximo foi encontrado, exibe a notificação
    if closestHumanoid then
        local name = closestHumanoid.Parent.Name  -- Nome do jogador
        local hp = closestHumanoid.Health  -- Vida do humanoide

        OrionLib:MakeNotification({
            Name = name, 
            Content = tostring(hp), 
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
end
