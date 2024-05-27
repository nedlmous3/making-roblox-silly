--[[

███╗   ██╗███████╗██████╗ ██╗     ███╗   ███╗ ██████╗ ██╗   ██╗███████╗
████╗  ██║██╔════╝██╔══██╗██║     ████╗ ████║██╔═══██╗██║   ██║██╔════╝
██╔██╗ ██║█████╗  ██║  ██║██║     ██╔████╔██║██║   ██║██║   ██║███████╗
██║╚██╗██║██╔══╝  ██║  ██║██║     ██║╚██╔╝██║██║   ██║██║   ██║╚════██║
██║ ╚████║███████╗██████╔╝███████╗██║ ╚═╝ ██║╚██████╔╝╚██████╔╝███████║
╚═╝  ╚═══╝╚══════╝╚═════╝ ╚══════╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝
@nedlmous

]]



--[[
loadstring is down there

loadstring(game:HttpGet("https://raw.githubusercontent.com/nedlmous3/making-roblox-silly/main/outlaster.luau"))()
]]

-- objects
local highlightesp = Instance.new("Highlight")
highlightesp.FillTransparency = 0
highlightesp.OutlineTransparency = 0
highlightesp.OutlineColor = Color3.new(.5,1,1)
highlightesp.FillColor = Color3.new(1,.5,1)

-- variables
local rs = game:GetService("RunService")
local loopsp = 16
local loopjp = 50
local player = game:GetService("Players").LocalPlayer
local character = player.Character
local humanoid = character:WaitForChild("Humanoid")
local TeleportService = game:GetService("TeleportService")
local hrp = character.HumanoidRootPart
local thickness = 10
local lines = {}

-- functions
local function setName(name)
    local finalN = string.gsub(name, "\\n", "\n")
    game:GetService("ReplicatedStorage").Core.Remote.Remote:FireServer("NameCheck", finalN)
    wait(1)
    game:GetService("ReplicatedStorage").Core.Remote.Remote:FireServer("NameSet", {})
end

local function modifyHumanoidProperties(humanoid)
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
end

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    modifyHumanoidProperties(humanoid)
end

local function onPlayerRespawn()
    local character = player.Character
    if character then
        onCharacterAdded(character)
    end
end

-- connections
player.CharacterAdded:Connect(onCharacterAdded)
player.CharacterRemoving:Connect(onPlayerRespawn)

-- main reason anyone uses this (esp)
local function NewEsp(from, to)
    local line = Instance.new("LineHandleAdornment")
    line.Adornee = game.workspace.Terrain
    line.ZIndex = 1
    line.Parent = to
    line.AlwaysOnTop = true
    line.Thickness = thickness
    line.Color3 = Color3.new(255, 0, 255)
    local startVector = from.Position
    local endVector = to.Position
    
    line.CFrame = CFrame.new(startVector, endVector)
    line.Length = (endVector - startVector).Magnitude
    
    table.insert(lines, {line = line, start = from, target = to})
end

local function UpdateEsp()
    while true do
        wait(0.025)
        
        for i, lineData in ipairs(lines) do
            if not lineData.target:IsDescendantOf(game) then
                lineData.line:Destroy()
                table.remove(lines, i)
            end
            
            local startVector = lineData.start.Position
            local endVector = lineData.target.Position
            local distance = (endVector - startVector).Magnitude
            
            local green = math.clamp(1 - distance / (300 * 1), 0, 1)
            local red = math.clamp(distance / (300 * 1), 0, 1)
            
            lineData.line.Color3 = Color3.new(red * 2, green * 2, 0)
            
            lineData.line.CFrame = CFrame.new(startVector, endVector)
            lineData.line.Length = distance
            if distance > 500 then
                lineData.line.Transparency = .7
            else
                lineData.line.Transparency = 0.2
            end
        end
    end
end


local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/nedlmous/robloxexploits/main/MLMOD.lua"))()

local GUI = Mercury:Create{
    Name = "NedlNodl",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.NedlNodl,
    Link = "https://github.com/deeeity/mercury-lib"
}

local Tab = GUI:Tab{
    Name = "Main",
    Icon = "rbxassetid://8569322835"
}

local Tab2 = GUI:Tab{
    Name = "Local",
    Icon = "rbxassetid://2795572800"
}

local Tab3 = GUI:Tab{
    Name = "Games",
    Icon = "rbxassetid://12684121161"
}

local Tab4 = GUI:Tab{
    Name = "Teleports",
    Icon = "rbxassetid://6723742952"
}

Tab:Button{
    Name = "Advantage ESP",
    Description = nil,
    Callback = function()
    hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("TouchTransmitter") and v.Parent:IsA("MeshPart") and v.Parent.Parent:IsA("Model") and v.Parent.Parent.Parent:IsA("MeshPart") and v.Parent.Parent.Parent.Parent:IsA("Model") then
                NewEsp(hrp, v.Parent)
                print("found it")
    end
end

UpdateEsp()
    end
}

Tab:Button{
    Name = "Remove Barriers",
    Description = nil,
    Callback = function()
        for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency > .9 then
        v.CanCollide = false
    end
end

UpdateEsp()
    end
}

Tab3:Button{
    Name = "Order Ordeal",
    Description = "Remove Curtains",
    Callback = function()
        workspace["Order Ordeal"].Map.Curtains:Destroy()
    end
}

Tab3:Button{
    Name = "Flag It Down",
    Description = "Flag ESP",
    Callback = function()
        for i,v in pairs(game.Workspace["Flag It Down"].Map.FlagSpawns:GetChildren()) do
                if v.Name == "Base" then
                local esp = highlightesp:Clone()
                esp.Parent = v
            end
        end
    end
}

Tab2:Slider{
    Name = "Speed",
    Default = humanoid.WalkSpeed,
    Min = 0,
    Max = 30,
    Callback = function(value)
        player = game:GetService("Players").LocalPlayer
    character = player.Character
    humanoid = character:WaitForChild("Humanoid")
        loopsp = value
    end
}

Tab2:Slider{
    Name = "JumpPower",
    Default = humanoid.JumpPower,
    Min = 0,
    Max = 100,
    Callback = function(value)
    player = game:GetService("Players").LocalPlayer
    character = player.Character
    humanoid = character:WaitForChild("Humanoid")
        loopjp = value
    end
}

Tab4:Button{
    Name = "Main game",
    Description = nil,
    Callback = function()
    TeleportService:Teleport(5343994291, game.Players.LocalPlayer)   
end
}

Tab4:Button{
    Name = "Allstars",
    Description = nil,
    Callback = function()
    TeleportService:Teleport(5765666554, game.Players.LocalPlayer)   
end
}

Tab:Textbox{
    Name = "Set name",
    Description = "has new line support [ \\n ]",
    Callback = function(text)
    setName(text)
end
}

rs.Heartbeat:Connect(function()
    humanoid.WalkSpeed = loopsp
    humanoid.JumpPower = loopjp
end)
