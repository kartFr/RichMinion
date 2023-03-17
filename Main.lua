local version = "0.01"
repeat task.wait() until game:IsLoaded() 
repeat task.wait() until game.Players.LocalPlayer.Character

local Players = game:GetService("Players")
local CoreGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Assets = game:GetObjects("rbxassetid://12795349082")[1]
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/kartFr/UiLib/main/Main.lua"))()
local Gui = Library.new("Karts' poorest minion gui")

local camera = game.Workspace.CurrentCamera
local spellPrecentages = {
    Gate = {Snap = {.8, .9}},
    Ignis = {Snap = {.50, .60}, Normal = {.85, .95}},
    Gelidus = {Normal = {.80, .90}, Snap = {.60, 1}},
    Viribus = {Snap = {.60, .75}, Normal = {.25, .35}},
    Telorum = {Normal = {.80, .90}, Snap = {.75, .85}},
    Snarvindur = {Snap = {.15, .30}, Normal = {.55, .75}},
    Percutiens = {Snap = {.70, .80}, Normal = {.60, .70}},
    Velo = {Snap = {.50, 1}, Normal = {.50, .60}},
    Fimbulvetr = {Normal = {.85, .95}, Snap = {.70, .80}},
    Contrarium = {Snap = {.70, 1}, Normal = {.60, 1}},
    ["Manus Dei"] = {Normal = {.95, .97}, Snap = {.50, .65}},
    Nocere = {Normal = {.70, .80}, Snap = {.70, .90}},
    Sraunus = {Normal = {.01, .50}},
    Hoppa = {Normal = {.30, .60}, Snap = {.5, .6}},
    Tenebris = {Normal = {.90, 1}, Snap = {.4, .7}},
    Trahere = {Normal = {.75, .85}},
    Celeritas = {Normal = {.70, .99}, Snap = {.75, .95}},
    Trixstus = {Normal = {.30, .70}, Snap = {.3, .5}},
    ["Sagitta Sol"] = {Normal = {.50, .60}, Snap = {.40, .70}},
    Scrupus = {Normal = {.01, 1}},
    Armis = {Normal = {.40, .60}, Snap = {.70, .85}},
    Hystericus = {Normal = {.75, .85}, Snap = {.10, .40}},
    Verdien = {Snap = {.8, .9}, Normal = {.7, 1}},
    ["Fons Vitae"] = {Normal = {.70, 1}, Snap = {.5, 1}},
    Perflora = {Normal = {.7, .9}, Snap = {.15, .45}},
    Floresco = {Normal = {.9, 1}, Snap = {.8, 1}},
    Mirgeti = {Normal = {.01, 1}},
    Krusa = {Normal = {.7, 1}},
    Spindulys = {Normal = {.7, 1}},
    Custos = {Normal = {.5, .6}},
    Claritum = {Normal = {.9, 1}},
    Globus = {Normal = {.6, 1}},
    Intermissum = {Normal = {.6, 1}},
    Dominus = {Normal = {.3, 1}},
    ["Mana Fly"] = {Normal = {.3, 1}},
    Duobe = {Normal = {.01, 1}},
    Compress = {Normal = {.01, 1}},
    ["Terra Rebus"] = {Normal = {.01, 1}},
    Inferi = {Normal = {.01, .35}},
    Reditus = {Normal = {.3, 1}},
    Ligans = {Normal = {.6, .7}},
    Secare = {Normal = {.9, .95}},
    Furantur = {Normal = {.55, .80}},
    ["Howler Summoning"] = {Normal = {.6, .85}},
    ["Worm Bombs"] = {Normal = {.55, .8}},
    ["Worm Blast"] = {Normal = {.01, .9}},
    ["Call of The Dead"] = {Normal = {.95, 1}},
    Coercere = {Normal = {.01, 1}},
    Liber = {Normal = {.01, 1}},
    Scribo = {Normal = {.01, 1}},
}

local defaultSettings = {
    phoenixDown = false,
    Walkspeed = 1,
    jumpPower = 1,
    nightstone = false,
    iceessence = false,
    amuletofwhite = false,
    lannis = false,
    scroll = false,
    mod = true,
    observe = true,
    flyspeed = 1,
    AAtimer = false,
    howler = false,
    azael = false,
    ma = false,
    phoenixDownColor = "#FFC90E",
    nightstoneColor = "#1D2E3A",
    iceColor = "#00FFFF",
    whiteColor = "#F8F8F8",
    lannisColor = "#D70EFF",
    scrollColor = "#7A5E27",
    howlerColor = "#FE5564",
    azaelColor = "#960000",
    maColor = "#2C4920",
    normalColor = Color3.new(0, 0, 1):ToHex(),
    snapColor = Color3.new(1, 0, 0):ToHex(),
    characterName = false,
    tool = false,
    playerColor = Color3.new(1, 1, 1):ToHex(),
    maxzoom = false,
    brightnessBool = false,
    brightness = 0,
    day = false,
    shadows = true,
    nofog = false,
    backstabDistance = 1,
    fullbright = false,
    playerAlert = false,
    waterclip = false,
    spellhelp = false,
    playerDistance = false,
    chatlogIlluColor = Color3.fromRGB(0, 150, 255):ToHex(),
    version = version
}
local resetOnDeath = {}
local proxy = {}

local fileName = "PoorMinion.txt"
if writefile then
    if isfile(fileName) then
        proxy = HttpService:JSONDecode(readfile(fileName))

        if proxy.version ~= version then
            proxy = defaultSettings
            writefile(fileName, HttpService:JSONEncode(proxy))
        end
    else
        proxy = defaultSettings
        writefile(fileName, HttpService:JSONEncode(proxy))
    end
end

local settings = setmetatable({},{
    __newindex = function(self, key, value)
        proxy[key] = value
        if writefile then
            writefile(fileName, HttpService:JSONEncode(proxy))
        end
    end,
    __index = function(self, index)
        return proxy[index]
    end
})

local old
old = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)
    if settings.nofall and self.Name == "ApplyFallDamage" then
        return
    end
    return old(self, ...)
end))

local CharacterTab = Gui:CreateTab("Local Player")
local PlayerSection = CharacterTab:CreateSection("Local Player")

local flightConnection
local keysDown = {
    ["W"] = {false, Vector3.new(0, 0, -1)},
    ["A"] = {false, Vector3.new(-1, 0, 0)},
    ["S"] = {false, Vector3.new(0, 0, 1)},
    ["D"] = {false, Vector3.new(1, 0, 0)},
    ["Space"] = {false, Vector3.new(0, 1, 0)},
    ["LeftControl"] = {false, Vector3.new(0, -1, 0)},
}

ContextActionService:BindAction("flight", function(_actionName, inputState, inputObject)
    if inputState == Enum.UserInputState.Begin then
        keysDown[inputObject.KeyCode.Name][1] = true
    elseif inputState == Enum.UserInputState.End then
        keysDown[inputObject.KeyCode.Name][1] = false
    end

    return Enum.ContextActionResult.Pass
end, false, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.Space, Enum.KeyCode.LeftControl)

resetOnDeath.fly = PlayerSection:CreateToggle({
    name = "Fly",
    default = false,
    callback = function(boolean)
        if boolean then
            flightConnection = RunService.Heartbeat:Connect(function()
                local direction = Vector3.new()

                Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                Players.LocalPlayer.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

                for i,v in pairs(keysDown) do
                    if v[1] then
                        direction += v[2] * (settings.flyspeed / 2)
                    end
                end

                local newPosition = Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(direction)
                newPosition = CFrame.lookAt(newPosition.Position, camera.CFrame.Position + (camera.CFrame.LookVector.Unit * 10000))

                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newPosition
            end)
        else
            if flightConnection then
                flightConnection:Disconnect()
                flightConnection = false
            end
        end
    end
}):AddSlider({
    minimum = 1,
    maximum = 5,
    default = settings.flyspeed,
    callback = function(number)
        settings.flyspeed = number
    end
}):AddKeybind({
    default = settings.flybind,
    callback = function(bind)
        settings.flybind = bind
    end
})

local canWalk = false
local originalWalkSpeed
local speedEvent

resetOnDeath.walkspeed = PlayerSection:CreateToggle({
    name = "WalkSpeed Multiplier", 
    default = false, 
    callback = function(boolean)
        canWalk = boolean

        if boolean then
            originalWalkSpeed = Players.LocalPlayer.Character.Humanoid.WalkSpeed
            Players.LocalPlayer.Character.Humanoid.WalkSpeed *= settings.Walkspeed
            speedEvent = Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                if Players.LocalPlayer.Character.Humanoid.WalkSpeed ~= originalWalkSpeed * settings.Walkspeed then
                    originalWalkSpeed = Players.LocalPlayer.Character.Humanoid.WalkSpeed
                    Players.LocalPlayer.Character.Humanoid.WalkSpeed *= settings.Walkspeed 
                end
            end)
        elseif speedEvent then
            speedEvent:Disconnect()
            Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalWalkSpeed
        end
end}):AddSlider({
    minimum = 0,
    maximum = 5,
    default = settings.Walkspeed,
    callback = function(number)
        settings.Walkspeed = number
        if canWalk then
            Players.LocalPlayer.Character.Humanoid.WalkSpeed = originalWalkSpeed * settings.Walkspeed
        end
    end
}):AddKeybind({
    default = settings.walkbind,
    callback = function(bind)
        settings.walkbind = bind
    end
})

local canJump = false
local originalJumpPower
local jumpEvent

resetOnDeath.jumpHeight = PlayerSection:CreateToggle({
    name = "JumpPower Multiplier", 
    default = false, 
    callback = function(boolean)
        canJump = boolean

        if boolean then
            originalJumpPower = Players.LocalPlayer.character.Humanoid.JumpPower
            jumpEvent = Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
                if Players.LocalPlayer.character.Humanoid.JumpPower ~= originalJumpPower * settings.jumpPower then
                    originalJumpPower = Players.LocalPlayer.character.Humanoid.JumpPower
                    Players.LocalPlayer.character.Humanoid.JumpPower = originalJumpPower * settings.jumpPower
                end
            end)
            Players.LocalPlayer.character.Humanoid.JumpPower *= settings.jumpPower

        elseif jumpEvent then
            jumpEvent:Disconnect()
            jumpEvent = false
            Players.LocalPlayer.Character.Humanoid.JumpPower = originalJumpPower
        end
end}):AddSlider({
    minimum = 0,
    maximum = 10,
    default = settings.jumpPower or 1,
    callback = function(number)
        settings.jumpPower = number
        if canJump then
            Players.LocalPlayer.Character.Humanoid.JumpPower = originalJumpPower * settings.jumpPower
        end
    end
}):AddKeybind({
    default = settings.jumpbind,
    callback = function(bind)
        settings.jumpbind = bind
    end
})

local floating
local floatPart

resetOnDeath.infJump = PlayerSection:CreateToggle({
    name = "Inf Jump",
    default = false,
    callback = function(boolean)
        if boolean then
            ContextActionService:BindAction("InfJump", function(_actionName, inputState, _inputObject)
                if inputState == Enum.UserInputState.Begin then
                    Players.LocalPlayer.Character.Humanoid:ChangeState(3)
                end
                
                return Enum.ContextActionResult.Pass
            end, false, Enum.KeyCode.Space)
        else
            ContextActionService:UnbindAction("InfJump")
        end
    end
}):AddKeybind({
    default = settings.infjumpBind,
    callback = function(bind)
        settings.infjumpBind = bind
    end
})

resetOnDeath.float = PlayerSection:CreateToggle({
    name = "Float",
    default = false,
    callback = function(boolean)
        if boolean then
            floatPart = Instance.new("Part")
            floatPart.Transparency = 1
            floatPart.Anchored = true
            floatPart.Size = Vector3.new(6, 1, 6)
            floatPart.Parent = Players.LocalPlayer.Character
            floating = RunService.Heartbeat:Connect(function()
                if Players.LocalPlayer.Character then
                    floatPart.CFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
                else
                    floating:Disconnect()
                    floatPart:Destroy()
                end
            end)
        else
            if floating then
                floating:Disconnect()
                floating = false
                floatPart:Destroy()
            end
        end
    end
}):AddKeybind({
    default = settings.floatBind,
    callback = function(bind)
        settings.floatBind = bind
    end
})

local inWater

Players.LocalPlayer.Character:WaitForChild("Humanoid").StateChanged:Connect(function(old, new)
    if new == Enum.HumanoidStateType.Swimming then
        inWater = true
    else
        inWater = false
    end
end)

Players.LocalPlayer.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.StateChanged:Connect(function(old, new)
        if new == Enum.HumanoidStateType.Swimming then
            inWater = true
        else
            inWater = false
        end
    end)
end)

local clipConnection
resetOnDeath.noclip = PlayerSection:CreateToggle({
    name = "No Clip",
    default = false,
    callback = function(boolean)
        if boolean then
            clipConnection = RunService.Stepped:Connect(function()
                for i,v in pairs(Players.LocalPlayer.character:GetDescendants()) do
                    if v:IsA("BasePart") and v ~= floatPart and not Players.LocalPlayer.Character.Head:FindFirstChild("RagdollAttach") then
                        if settings.waterclip and inWater then
                            return
                        end

                        v.CanCollide = false
                    end
                end
            end)
        else
            if clipConnection then
                clipConnection:Disconnect()
                clipConnection = false
                if Players.LocalPlayer.Character then
                    Players.LocalPlayer.Character.Torso.CanCollide = true
                end
            end
        end
    end
}):AddKeybind({
    default = settings.noclipBind,
    callback = function(bind)
        settings.noclipBind = bind
    end
})


PlayerSection:CreateToggle({
    name = "Disable No Clip in Water",
    default = settings.waterclip,
    callback = function(boolean)
        settings.waterclip = boolean
    end
})

PlayerSection:CreateButton({
    name = "Reset",
    callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end
})

local StatusSection = CharacterTab:CreateSection("Status Effects")

StatusSection:CreateToggle({
    name = "No Fall",
    default = settings.nofall,
    callback = function(boolean)
        settings.nofall = boolean
    end
})

local fireConnection
local noFire = false
resetOnDeath.nofire = StatusSection:CreateToggle({
    name = "No Fire",
    default = false,
    callback = function(boolean)
        noFire = boolean
        if boolean then
            fireConnection = Players.LocalPlayer.Character.ChildAdded:Connect(function(child)
                if noFire then
                    if child.Name == "Burning" then
                        Players.LocalPlayer.Character.CharacterHandler.Remotes.Dodge:FireServer("180", "Normal")
                    end
                else
                    fireConnection:Disconnect()
                    fireConnection = false
                end
            end)
        else
            if fireConnection then
                fireConnection:Disconnect()
                fireConnection = false
            end
        end
    end
})

local VisualSection = CharacterTab:CreateSection("Visuals")

local currentTool
local snapGui
local normalGui
local spellCheck

VisualSection:CreateToggle({
    name = "Spell Helper",
    default = settings.spellhelp,
    callbackOnCreation = true,
    callback = function(boolean)
        settings.spellhelp = boolean

        if boolean then
            spellCheck = game.RunService.Heartbeat:Connect(function()
                if Players.LocalPlayer.Character then
                    local hasTool = false

                    for i,v in pairs(Players.LocalPlayer.Character:GetChildren()) do
                        if v:IsA("Tool") and spellPrecentages[v.Name] then
                            hasTool = v
                            break
                        end
                    end
                    
                    if not hasTool then
                        if normalGui then
                            normalGui:Destroy()
                            normalGui = false
                        end
    
                        if snapGui then
                            snapGui:Destroy()
                            snapGui = false
                        end
                        
                        currentTool = false
                        return
                    end
    
                    if currentTool == hasTool then
                        if normalGui then
                            normalGui.BackgroundColor3 = Color3.fromHex(settings.normalColor)
                        end
                        
                        if snapGui then
                            snapGui.BackgroundColor3 = Color3.fromHex(settings.snapColor)
                        end
                        
                        return
                    end
    
                    currentTool = hasTool
    
                    if normalGui then
                        normalGui:Destroy()
                        normalGui = false
                    end
    
                    if snapGui then
                        snapGui:Destroy()
                        snapGui = false
                    end
    
                    if spellPrecentages[currentTool.Name].Normal then
                        local normalPrecentage = spellPrecentages[currentTool.Name].Normal
                        normalGui = Instance.new("Frame")
                        normalGui.BackgroundTransparency = 0.7
                        normalGui.BorderSizePixel = 0
                        normalGui.ZIndex = 1000
                        normalGui.BackgroundColor3 = Color3.fromHex(settings.normalColor)
                        normalGui.AnchorPoint = Vector2.new(.5, 0)
                        normalGui.Size = UDim2.new(1, 0, normalPrecentage[2] - normalPrecentage[1], 0)
                        normalGui.Position = UDim2.new(0.5, 0, 1 - normalPrecentage[2], 0)
                        normalGui.Parent = Players.LocalPlayer.PlayerGui.StatGui.LeftContainer.Mana 
                    end
    
                    if spellPrecentages[currentTool.Name].Snap then
                        local SnapPrecentage = spellPrecentages[currentTool.Name].Snap
                        snapGui = Instance.new("Frame")
                        snapGui.ZIndex = 1000
                        snapGui.BackgroundTransparency = 0.7
                        snapGui.BorderSizePixel = 0
                        snapGui.AnchorPoint = Vector2.new(.5, 0)
                        snapGui.BackgroundColor3 = Color3.fromHex(settings.snapColor)
                        snapGui.Size = UDim2.new(1, 0, SnapPrecentage[2] - SnapPrecentage[1], 0)
                        snapGui.Position = UDim2.new(0.5, 0, 1 - SnapPrecentage[2], 0)
                        snapGui.Parent = Players.LocalPlayer.PlayerGui.StatGui.LeftContainer.Mana
                    end
                end
            end)
        else
            spellCheck:Disconnect()

            if normalGui then
                normalGui:Destroy()
                normalGui = false
            end

            if snapGui then
                snapGui:Destroy()
                snapGui = false
            end
        end
    end
})

local espConnection
local espGuis = {}
VisualSection:CreateToggle({
    name = "Player Esp",
    default = false,
    callback = function(boolean)
        if boolean then
            espConnection = RunService.Heartbeat:Connect(function()
                for i,v in pairs(game.Workspace.Live:GetChildren()) do
                    if string.sub(v.Name, 1, 1) ~= "." and v ~= Players.LocalPlayer.Character then
                        if v:FindFirstChild("Head") then
                            local esp = v.Head:FindFirstChild("Esp")
                            if not esp then
                                esp = Assets.Esp:Clone()
                                esp.Parent = v.Head
                                esp.StudsOffsetWorldSpace = Vector3.new(0, 1, 0)
                                table.insert(espGuis, esp)
                            end

                            esp.TextLabel.TextColor3 = Color3.fromHex(settings.playerColor)
                            esp.TextLabel.Text = v.Name
    
                            if settings.characterName then
                                local player = Players[v.Name]
                                esp.TextLabel.Text = esp.TextLabel.Text .. "[" .. player.leaderstats.FirstName.Value.. " " .. player.leaderstats.LastName.Value .. player.leaderstats.UberTitle.Value .. "]"
                            end

                            if settings.health then
                                esp.TextLabel.Text = esp.TextLabel.Text .. "[" .. math.floor(v.Humanoid.Health) .. "/" .. math.floor(v.Humanoid.MaxHealth) .. "]"
                            end

                            if settings.tool then
                                local tool = v:FindFirstChildWhichIsA("Tool")
                                if tool then
                                    esp.TextLabel.Text = esp.TextLabel.Text .. "[" .. tool.Name .. "]"
                                else
                                    esp.TextLabel.Text = esp.TextLabel.Text .. "[Fists]"
                                end
                            end

                            if settings.playerDistance then
                                esp.TextLabel.Text = esp.TextLabel.Text .. "[" .. math.floor((Players.LocalPlayer.Character.Torso.Position - v.Torso.Position).Magnitude) .. "]"
                            end
                        end
                    end
                end
            end)
        else
            espConnection:Disconnect()

            for i,v in pairs(espGuis) do
                v:Destroy()
            end

            espGuis = {}
        end
    end
}):AddKeybind({
    default = settings.playerEspBind,
    callback = function(bind)
        settings.playerEspBind = bind
    end
})

VisualSection:CreateToggle({
    name = "Character Name ESP",
    default = settings.characterName,
    callback = function(boolean)
        settings.characterName = boolean
    end
})

VisualSection:CreateToggle({
    name = "Health ESP",
    default = settings.health,
    callback = function(boolean)
        settings.health = boolean
    end
})

VisualSection:CreateToggle({
    name = "Tool ESP",
    default = settings.tool,
    callback = function(boolean)
        settings.tool = boolean
    end
})

VisualSection:CreateToggle({
    name = "Distance ESP",
    default = settings.playerDistance,
    callback = function(boolean)
        settings.playerDistance = boolean
    end
})

VisualSection:CreateToggle({
    name = "Inf Zoom",
    default = settings.maxzoom,
    callback = function(boolean)
        settings.maxzoom = boolean
        if boolean then
            Players.LocalPlayer.CameraMaxZoomDistance = math.huge
        else
            Players.LocalPlayer.CameraMaxZoomDistance = 45
        end
    end
})

local VisualsTab = Gui:CreateTab("World Visuals")
local AppearanceSection = VisualsTab:CreateSection("Appearance")

local brightnessConnection
AppearanceSection:CreateToggle({
    name = "Brightness",
    default = settings.brightnessBool,
    callbackOnCreation = true,
    callback = function(boolean)
        settings.brightnessBool = boolean

        if boolean then
            brightnessConnection = game.Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
                if not settings.day and not settings.fullbright then
                    game.Lighting.Brightness = settings.brightness
                end
            end)

            game.Lighting.Brightness = settings.brightness
        else
            if brightnessConnection then
                brightnessConnection:Disconnect()
                brightnessConnection = false
            end
        end
    end
}):AddSlider({
    minimum = 0,
    maximum = 10,
    default = settings.brightness,
    decimalPlaces = 2,
    callback = function(number)
        settings.brightness = number
    end
})

local shadowConnection
AppearanceSection:CreateToggle({
    name = "Shadows",
    default = settings.shadows,
    callbackOnCreation = true,
    callback = function(boolean)
        settings.shadows = boolean

        if boolean then
            shadowConnection = game.Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
                if not settings.fullbright then
                    game.Lighting.GlobalShadows = boolean
                end
            end)

            game.Lighting.GlobalShadows = boolean
        else
            if shadowConnection then
                shadowConnection:Disconnect()
                shadowConnection = false
            end

            game.Lighting.GlobalShadows = boolean
        end
    end
})

local dayBright
local dayTime
local soft

AppearanceSection:CreateToggle({
    name = "Always Day",
    default = settings.day,
    callbackOnCreation = true,
    callback = function(boolean)
        settings.day = boolean
        
        if boolean then
            dayBright = game.Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
                if not settings.fullbright then
                    game.Lighting.Brightness = 1
                end
            end)

            dayTime = game.Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
                game.Lighting.ClockTime = 12
            end)

            soft = game.Lighting:GetPropertyChangedSignal("ShadowSoftness"):Connect(function()
                game.Lighting.ShadowSoftness = 0.5
            end)

            game.Lighting.ShadowSoftness = 0.5
            game.Lighting.Brightness = 1
            game.Lighting.ClockTime = 12
        else
            if dayBright then
                dayBright:Disconnect()
                dayBright = false
                dayTime:Disconnect()
                soft:Disconnect()
                game.Lighting.ClockTime = 24
            end
        end
    end
})

local fogConnection

AppearanceSection:CreateToggle({
    name = "No Fog",
    default = settings.nofog,
    callbackOnCreation = true,
    callback = function(boolean)
        settings.nofog = boolean

        if boolean then
            fogConnection = game.Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
                game.Lighting.FogEnd = math.huge
            end)
        else
            if fogConnection then
                fogConnection:Disconnect()
                fogConnection = false
            end
        end
    end
})

local ambienceConnection
local brightfb
local shadowfb
AppearanceSection:CreateToggle({
    name = "Fullbright",
    default = settings.fullbright,
    callback = function(boolean)
        settings.fullbright = boolean

        if boolean then
            ambienceConnection = game.Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
                game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            end)

            brightfb = game.Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
                game.Lighting.Brightness = 2
            end)

            shadowfb = game.Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
                game.Lighting.GlobalShadows = false
            end)

            game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            game.Lighting.Brightness = 2
            game.Lighting.GlobalShadows = false
        else
            if ambienceConnection then
                ambienceConnection:Disconnect()
                ambienceConnection = false
                brightfb:Disconnect()
                shadowfb:Disconnect()
                game.Lighting.GlobalShadows = false
            end
        end
    end
})

local RageSection = CharacterTab:CreateSection("Rage")

local backstabParams = RaycastParams.new()
backstabParams.FilterType = Enum.RaycastFilterType.Include
backstabParams.FilterDescendantsInstances = {game.Workspace.Live}
local deathConnection
local distanceConnection
local hasTarget

local backstab
backstab = RageSection:CreateToggle({
    name = "Backstab",
    default = false,
    callback = function(boolean)
        if boolean then
            local mouse = Players.LocalPlayer:GetMouse()
            local unitRay = camera:ScreenPointToRay(mouse.X, mouse.Y)
            local raycastResult = workspace:Raycast(unitRay.Origin, unitRay.Direction * 150, backstabParams)
            if raycastResult then
                local parent = raycastResult.Instance

                while true do
                parent = parent.Parent
                
                if parent.Parent == game.Workspace.Live then
                        break
                end
                end

                if parent ~= Players.LocalPlayer.Character then
                    hasTarget = true

                    deathConnection = Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
                        deathConnection:Disconnect()
                        deathConnection = false
                        distanceConnection:Disconnect()
                        distanceConnection = false
                        hasTarget = false
                    end)

                    distanceConnection = RunService.Heartbeat:Connect(function()
                        if (Players.LocalPlayer.Character.HumanoidRootPart.Position - parent.HumanoidRootPart.Position).Magnitude <= 50 then
                            Players.LocalPlayer.Character.HumanoidRootPart.CFrame = parent.HumanoidRootPart.CFrame * CFrame.new(0, 0, settings.backstabDistance)
                        else
                            deathConnection:Disconnect()
                            deathConnection = false
                            distanceConnection:Disconnect()
                            distanceConnection = false
                            hasTarget = false
                        end
                    end)
                else
                    backstab:Set(false)
                    return
                end
            else
                backstab:Set(false)
                return
            end
        else
            if hasTarget then
                deathConnection:Disconnect()
                deathConnection = false
                distanceConnection:Disconnect()
                distanceConnection = false
                hasTarget = false
            end
        end
    end
}):AddKeybind({
    default = settings.backstabBind,
    callback = function(bind)
        settings.backstabBind = bind
    end
}):AddSlider({
    minimum = 1,
    maximum = 6,
    default = settings.backstabDistance,
    callback = function(number)
        settings.backstabDistance = number
    end
})

local ItemsSection = Gui:CreateTab("Items")
local EspSection = ItemsSection:CreateSection("Trinket Esp")

local espHolder = {
    ["scroll"] = {},
    ["phoenix"] = {},
    ["night"] = {},
    ["ice"] = {},
    ["lannis"] = {},
    ["white"] = {},
    ["howler"] = {},
    ["ma"] = {},
    ["azael"] = {}
}
local espEvent

local function applyEsp(instance)
    if not instance:FindFirstChild("ClickPart") then
        instance:WaitForChild("ClickPart")
    end
    if instance:IsA("MeshPart") and instance.MeshId == "rbxassetid://5204453430" then
        if settings.scroll then
            local esp = Assets.Esp:Clone()
            esp.Parent = instance
            esp.Adornee = instance
            esp.TextLabel.TextColor3 = Color3.fromHex(settings.scrollColor)
            esp.TextLabel.Text = "[Scroll]"

            espHolder.scroll[instance] = esp
        else
            espHolder.scroll[instance] = false
        end

        return
    end
    
    if instance:FindFirstChild("Attachment") and instance.Attachment:FindFirstChild("ParticleEmitter") and instance.Attachment.ParticleEmitter.Texture == "rbxassetid://1536547385" then
        if tostring(instance.Attachment.ParticleEmitter.Color) == "0 1 0.8 0 0 1 1 0.501961 0 0 " then
            if settings.phoenixDown then
                local esp = Assets.Esp:Clone()
                esp.Parent = instance
                esp.Adornee = instance
                esp.TextLabel.TextColor3 = Color3.fromHex(settings.phoenixDownColor)
                esp.TextLabel.Text = "[Phoenix Down]"
                
                espHolder.phoenix[instance] = esp
            else
                espHolder.phoenix[instance] = false
            end

            return
        end

        if instance.Attachment.ParticleEmitter.Rate == 3 then
            if settings.ma then
                local esp = Assets.Esp:Clone()
                esp.Parent = instance
                esp.Adornee = instance
                esp.TextLabel.TextColor3 = Color3.fromHex(settings.maColor)
                esp.TextLabel.Text = "[Mysterious Artifact]"
    
                espHolder.ma[instance] = esp
            else
                espHolder.ma[instance] = false
            end

            return
        end

        if settings.azael then
            local esp = Assets.Esp:Clone()
            esp.Parent = instance
            esp.Adornee = instance
            esp.TextLabel.TextColor3 = Color3.fromHex(settings.azaelColor)
            esp.TextLabel.Text = "[Azael Horn]"

            espHolder.azael[instance] = esp
        else
            espHolder.azael[instance] = false
        end
        
        return
    end

    if instance:IsA("UnionOperation") and instance.Color ==Color3.fromRGB(29, 46, 58) then
        if settings.nightstone then
            local esp = Assets.Esp:Clone()
            esp.Parent = instance
            esp.Adornee = instance
            esp.TextLabel.TextColor3 = Color3.fromHex(settings.nightstoneColor)
            esp.TextLabel.Text = "[Nightstone]"

            espHolder.night[instance] = esp
        else
            espHolder.night[instance] = false
        end

        return
    end
    
    if instance.Color == Color3.fromRGB(254, 85, 100) then
        if settings.iceessence then
            local esp = Assets.Esp:Clone()
            esp.Parent = instance
            esp.Adornee = instance
            esp.TextLabel.TextColor3 = Color3.fromHex(settings.iceColor)
            esp.TextLabel.Text = "[Ice Essence]"

            espHolder.ice[instance] = esp
        else
            espHolder.ice[instance] = false
        end

        return
    end

    if instance:IsA("UnionOperation") and instance.Color ==Color3.fromRGB(248, 248, 248) then
        if instance:FindFirstChild("PointLight") then
            if settings.amuletofwhite then
                local esp = Assets.Esp:Clone()
                esp.Parent = instance
                esp.Adornee = instance
                esp.TextLabel.TextColor3 = Color3.fromHex(settings.whiteColor)
                esp.TextLabel.Text = "[Amulet Of The White King]"
    
                espHolder.white[instance] = esp
            else
                espHolder.white[instance] = false
            end
        else 
            if settings.lannis then
                local esp = Assets.Esp:Clone()
                esp.Parent = instance
                esp.Adornee = instance
                esp.TextLabel.TextColor3 = Color3.fromHex(settings.lannisColor)
                esp.TextLabel.Text = "[Lannis Amulet]"
    
                espHolder.lannis[instance] = esp
            else
                espHolder.lannis[instance] = false
            end
        end
        
        return
    end

    if instance:IsA("MeshPart") and instance.MeshId == "rbxassetid://2520762076" then
        if settings.howler then
            local esp = Assets.Esp:Clone()
            esp.Parent = instance
            esp.Adornee = instance
            esp.TextLabel.TextColor3 = Color3.fromHex(settings.howlerColor)
            esp.TextLabel.Text = "[Howler Friend]"

            espHolder.howler[instance] = esp
        else
            espHolder.howler[instance] = false
        end

        return
    end
    
end

local espOn = false

EspSection:CreateToggle({
    name = "ESP",
    default = false,
    callback = function(boolean)
        espOn = boolean

        if boolean then
            for i,v in pairs(game.Workspace.Trinkets:GetChildren()) do
                applyEsp(v)
            end

            espEvent = game.Workspace.Trinkets.ChildAdded:Connect(function(child)
                applyEsp(child)
            end)
        else
            for i,v in pairs(espHolder) do
                for i,esp in pairs(v) do
                    if esp then
                        esp:Destroy()
                    else
                        break
                    end
                end
                
                v = {}
            end

            if espEvent then
                espEvent:Disconnect()
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Scroll",
    default = settings.scroll,
    callback = function(boolean)
        settings.scroll = boolean

        if espOn then
            if boolean then
                for i,v in pairs(espHolder.scroll) do
                    local esp = Assets.Esp:Clone()
                    esp.Parent = i
                    esp.Adornee = i
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.scrollColor)
                    esp.TextLabel.Text = "[Scroll]"

                    espHolder.scroll[i] = esp
                end
            else
                for i,v in pairs(espHolder.scroll) do
                    if v then
                        v:Destroy()
                        espHolder.scroll[i] = false
                    end
                end
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Phoenix Down",
    default = settings.phoenixDown,
    callback = function(boolean)
        settings.phoenixDown = boolean

        if espOn then
            if boolean then
                for i,v in pairs(espHolder.phoenix) do
                    local esp = Assets.Esp:Clone()
                    esp.Parent = i
                    esp.Adornee = i
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.phoenixDownColor)
                    esp.TextLabel.Text = "[Phoenix Down]"

                    espHolder.phoenix[i] = esp
                end
            else
                for i,v in pairs(espHolder.phoenix) do
                    if v then
                        v:Destroy()
                        espHolder.phoenix[i] = false
                    end
                end
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Night Stone",
    default = settings.nightstone,
    callback = function(boolean)
        settings.nightstone = boolean

        if espOn then
            if boolean then
                for i,v in pairs(espHolder.night) do
                    local esp = Assets.Esp:Clone()
                    esp.Parent = i
                    esp.Adornee = i
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.nightstoneColor)
                    esp.TextLabel.Text = "[Nightstone]"

                    espHolder.night[i] = esp
                end
            else
                for i,v in pairs(espHolder.night) do
                    if v then
                        v:Destroy()
                        espHolder.night[i] = false
                    end
                end
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Ice Essence",
    default = settings.iceessence,
    callback = function(boolean)
        settings.iceessence = boolean

        if espOn then
            if boolean then
                for i,v in pairs(espHolder.ice) do
                    local esp = Assets.Esp:Clone()
                    esp.Parent = i
                    esp.Adornee = i
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.iceColor)
                    esp.TextLabel.Text = "[Ice Essence]"

                    espHolder.ice[i] = esp
                end
            else
                for i,v in pairs(espHolder.ice) do
                    if v then
                        v:Destroy()
                        espHolder.ice[i] = false
                    end
                end
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Amulet of the White King",
    default = settings.amuletofwhite,
    callback = function(boolean)
        settings.amuletofwhite = boolean

        if espOn then
            if boolean then
                for i,v in pairs(espHolder.white) do
                    local esp = Assets.Esp:Clone()
                    esp.Parent = i
                    esp.Adornee = i
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.whiteColor)
                    esp.TextLabel.Text = "[Amulet of the White King]"

                    espHolder.white[i] = esp
                end
            else
                for i,v in pairs(espHolder.white) do
                    if v then
                        v:Destroy()
                        espHolder.white[i] = false
                    end
                end
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Lannis Amulet",
    default = settings.lannis,
    callback = function(boolean)
        settings.lannis = boolean

        if espOn then
            if boolean then
                for i,v in pairs(espHolder.lannis) do
                    local esp = Assets.Esp:Clone()
                    esp.Parent = i
                    esp.Adornee = i
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.lannisColor)
                    esp.TextLabel.Text = "[Lannis Amulet]"

                    espHolder.lannis[i] = esp
                end
            else
                for i,v in pairs(espHolder.lannis) do
                    if v then
                        v:Destroy()
                        espHolder.lannis[i] = false
                    end
                end
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Howler",
    default = settings.howler,
    callback = function(boolean)
        settings.howler = boolean

        if espOn then
            if boolean then
                for i,v in pairs(espHolder.howler) do
                    local esp = Assets.Esp:Clone()
                    esp.Parent = i
                    esp.Adornee = i
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.howlerColor)
                    esp.TextLabel.Text = "[Howler Friend]"

                    espHolder.howler[i] = esp
                end
            else
                for i,v in pairs(espHolder.howler) do
                    if v then
                        v:Destroy()
                        espHolder.howler[i] = false
                    end
                end
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Azael Horn",
    default = settings.azael,
    callback = function(boolean)
        settings.azael = boolean

        if espOn then
            if boolean then
                for i,v in pairs(espHolder.azael) do
                    local esp = Assets.Esp:Clone()
                    esp.Parent = i
                    esp.Adornee = i
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.azaelColor)
                    esp.TextLabel.Text = "[Azael Horn]"

                    espHolder.azael[i] = esp
                end
            else
                for i,v in pairs(espHolder.azael) do
                    if v then
                        v:Destroy()
                        espHolder.azael[i] = false
                    end
                end
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Mysterious Artifact",
    default = settings.ma,
    callback = function(boolean)
        settings.ma = boolean

        if espOn then
            if boolean then
                for i,v in pairs(espHolder.ma) do
                    local esp = Assets.Esp:Clone()
                    esp.Parent = i
                    esp.Adornee = i
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.maColor)
                    esp.TextLabel.Text = "[Mysterious Artifact]"

                    espHolder.ma[i] = esp
                end
            else
                for i,v in pairs(espHolder.ma) do
                    if v then
                        v:Destroy()
                        espHolder.ma[i] = false
                    end
                end
            end
        end
    end
})


local TrinketSection = ItemsSection:CreateSection("Trinkets")

local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Include
overlapParams.FilterDescendantsInstances = {game.Workspace.Trinkets, game.Workspace.Ingredients }
local pickup
local whenPicked = math.huge
local amountPicked = 0

RunService.Heartbeat:Connect(function()
    if whenPicked - os.clock() <= 0 then
        whenPicked = math.huge
        amountPicked = 0 
    end
end)

resetOnDeath.autopickup = TrinketSection:CreateToggle({
    name = "Auto Pickup Trinkets",
    default = false,
    callback = function(boolean)
        if boolean then
            pickup = RunService.Heartbeat:Connect(function()
                local trinkets = game.Workspace:GetPartBoundsInRadius(Players.LocalPlayer.Character.Torso.Position, 12, overlapParams)

                if trinkets[1] then
                    for i,v in pairs(trinkets) do
                        if v.Parent == game.Workspace.Trinkets then
                            for i,v in pairs(v:GetChildren()) do
                                if v.Name == "ClickPart" and amountPicked <= 5 then
                                    fireclickdetector(v.ClickDetector)
                                    amountPicked += 1
                                    whenPicked = os.clock() + 1
                                end
                            end
                        end
                    end
                end
            end)
        else
            if pickup then
                pickup:Disconnect()
                pickup = false
            end
        end
    end
})

local IngredientSection = ItemsSection:CreateSection("Ingredients")

local ingredientConnection
resetOnDeath.autopickup = IngredientSection:CreateToggle({
    name = "Auto Pickup Ingredients",
    default = false,
    callback = function(boolean)
        if boolean then
            ingredientConnection = RunService.Heartbeat:Connect(function()
                local trinkets = game.Workspace:GetPartBoundsInRadius(Players.LocalPlayer.Character.Torso.Position, 12, overlapParams)

                if trinkets[1] then
                    for i,v in pairs(trinkets) do
                        if v.Parent == game.Workspace.Ingredients then
                            fireclickdetector(v.ClickDetector)
                        end
                    end
                end
            end)
        else
            if ingredientConnection then
                ingredientConnection:Disconnect()
                ingredientConnection = false
            end
        end
    end
})

local waterParams = OverlapParams.new()
waterParams.FilterType = Enum.RaycastFilterType.Include
waterParams.FilterDescendantsInstances = {game.Workspace.Stations}


IngredientSection:CreateButton({
    name = "Create Health Potion",
    callback = function()
        local findwater = game.Workspace:GetPartBoundsInRadius(Players.LocalPlayer.Character.Torso.Position, 12)

        for i,v in pairs(findwater) do
            if v.Name == "Water" then
                flower = Players.LocalPlayer.Backpack:FindFirstChild("Lava Flower")

                if flower then
                    local scrooms = {}
                    for i,v in pairs(Players.LocalPlayer.Backpack:GetDescendants()) do
                        if v.Name == "Scroom" then
                            table.insert(scrooms, v)
                            if #scrooms >= 2 then
                                break
                            end
                        end
                    end
                    
                    if #scrooms >= 2 then
                        Players.LocalPlayer.Character.Humanoid:EquipTool(flower)
                        flower.RemoteEvent:FireServer(CFrame.new(), v)
                        Players.LocalPlayer.Character.Humanoid:EquipTool(scrooms[1])
                        scrooms[1].RemoteEvent:FireServer(CFrame.new(), v)
                        Players.LocalPlayer.Character.Humanoid:EquipTool(scrooms[2])
                        scrooms[2].RemoteEvent:FireServer(CFrame.new(), v)
                        fireclickdetector(v.Parent.Ladle.ClickConcoct)
                    end

                    break
                end
            end
        end
    end
})

Players.LocalPlayer.CharacterRemoving:Connect(function(character)
    for i,v in pairs(resetOnDeath) do
        v:Set(false)
    end
end)

local SettingsSection = Gui:CreateTab("Settings")
local ColorTab = SettingsSection:CreateSection("Trinket ESP Colors")

ColorTab:CreateColorPicker({
    name = "Scroll ESP Color",
    default = Color3.fromHex(settings.scrollColor),
    resetColor = Color3.fromHex("#7A5E27"),
    callback = function(color)
        print(color)
        settings.scrollColor = color:ToHex()

        if espOn and settings.scroll then
            for i,v in pairs(espHolder.scroll) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Phoenix Down ESP Color",
    default = Color3.fromHex(settings.phoenixDownColor),
    resetColor = Color3.fromHex("#FFC90E"),
    callback = function(color)
        settings.phoenixDownColor = color:ToHex()

        if espOn and settings.phoenixDown then
            for i,v in pairs(espHolder.phoenix) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Nightstone ESP Color",
    default = Color3.fromHex(settings.nightstoneColor),
    resetColor = Color3.fromHex("#1D2E3A"),
    callback = function(color)
        settings.nightstoneColor = color:ToHex()

        if espOn and settings.nightstone then
            for i,v in pairs(espHolder.nightstone) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Ice Essence ESP Color",
    default = Color3.fromHex(settings.iceColor),
    resetColor = Color3.fromHex("#00FFFF"),
    callback = function(color)
        settings.iceColor = color:ToHex()

        if espOn and settings.ice then
            for i,v in pairs(espHolder.ice) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Amulet of the White King ESP Color",
    default = Color3.fromHex(settings.whiteColor),
    resetColor = Color3.fromHex("#F8F8F8"),
    callback = function(color)
        settings.whiteColor = color:ToHex()

        if espOn and settings.amuletofwhite then
            for i,v in pairs(espHolder.white) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Lannis Amulet ESP Color",
    default = Color3.fromHex(settings.lannisColor),
    resetColor = Color3.fromHex("#D70EFF"),
    callback = function(color)
        settings.lannisColor = color:ToHex()

        if espOn and settings.lannis then
            for i,v in pairs(espHolder.lannis) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Howler Friend ESP Color",
    default = Color3.fromHex(settings.howlerColor),
    resetColor = Color3.fromHex("#FE5564"),
    callback = function(color)
        settings.howlerColor = color:ToHex()

        if espOn and settings.howler then
            for i,v in pairs(espHolder.howler) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Azael Horn ESP Color",
    default = Color3.fromHex(settings.azaelColor),
    resetColor = Color3.fromHex("#960000"),
    callback = function(color)
        settings.azaelColor = color:ToHex()

        if espOn and settings.azael then
            for i,v in pairs(espHolder.azael) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Mysterious Artifact ESP Color",
    default = Color3.fromHex(settings.maColor),
    resetColor = Color3.fromHex("#2C4920"),
    callback = function(color)
        settings.maColor = color:ToHex()
            
        if espOn and settings.ma then
            for i,v in pairs(espHolder.ma) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

local MiscTab = SettingsSection:CreateSection("Misc")

local dragConnections = {}
local chat = false
local spectating = false

local function logChat(player, message)
    if chat then
        local observe = false
        local action = false
        local log = Assets.Log:Clone()
        log.Text = "[" .. player.Name .. "]:" .. message
        log.Parent = chat.Menu.Body.Holder
        chat.Menu.Body.Holder.CanvasSize = UDim2.new(0, 0, 0, chat.Menu.Body.Holder.UIListLayout.AbsoluteContentSize.Y)
           
        for i,v in pairs(player.Character:GetChildren()) do
            if v.Name == "Action" then
                action = true
            end

            if v.Name == "Observe" then
                observe = true
            end
        end

        if observe and action then
            log.TextColor3 = Color3.fromHex(settings.chatlogIlluColor)
        end

        log.MouseButton1Down:Connect(function()
            if game.Workspace.Live:FindFirstChild(player.Name) then
                camera.CameraSubject = game.Workspace.Live[player.Name]
                spectating = true
                return
            end

            if game.Workspace.Dead:FindFirstChild(player.Name) then
                camera.CameraSubject = game.Workspace.Dead[player.Name]
                spectating = true
                return
            end
        end)

        if math.abs(chat.Menu.Body.Holder.AbsoluteCanvasSize.Y - chat.Menu.Body.Holder.AbsoluteSize.Y - 30) - math.abs(chat.Menu.Body.Holder.CanvasPosition.Y) <= 5 then
            chat.Menu.Body.Holder.CanvasPosition = Vector2.new(0, chat.Menu.Body.Holder.CanvasSize.Y.Offset)
        end
    end
end

ContextActionService:BindAction("mousebutton1click", function(_actionName, inputState, _inputObject)
    if inputState == Enum.UserInputState.Begin and spectating then
        spectating = false
        camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    end

    return Enum.ContextActionResult.Pass
end, false, Enum.UserInputType.MouseButton1)

game.Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        logChat(player, message)
    end)
end)

for i,v in pairs(Players:GetPlayers()) do
    v.Chatted:Connect(function(message)
        logChat(v, message)
    end)
end

MiscTab:CreateToggle({
    name = "Chat Logger",
    default = false,
    callback = function(boolean)
        if boolean then
            chat = Assets.ChatLogger:Clone()

            if syn then
                syn.protect_gui(chat)
                chat.Parent = game.CoreGui
            elseif gethui then
                chat.Parent = gethui()
            else
                chat.Parent = game.CoreGui
            end

            chat.Menu.TopBar.Drag.MouseButton1Down:Connect(function(X,Y)
                local Offset = UDim2.new(0, chat.Menu.AbsolutePosition.X - X + 225, 0, chat.Menu.AbsolutePosition.Y - Y + 155)
                dragConnections[#dragConnections + 1] = UserInputService.InputChanged:Connect(function(inputObject, _gameProccessed)
                    if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
                        chat.Menu.Position = UDim2.new(0, inputObject.Position.X, 0, inputObject.Position.Y) + Offset
                    end
                end)
        
                dragConnections[#dragConnections + 1] = UserInputService.InputEnded:Connect(function(inputObject, _gameProccessed)
                    if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
                        for i,v in pairs(dragConnections) do
                            v:Disconnect()
                            dragConnections[i] = nil
                        end
                    end
                end)
        
                dragConnections[#dragConnections + 1] = UserInputService.WindowFocusReleased:Connect(function()
                    for i,v in pairs(dragConnections) do
                        v:Disconnect()
                        dragConnections[i] = nil
                    end
                end)
            end)
        else
            chat:Destroy()
            chat = false
        end
    end
})

local beingObserved = {}

local function observeNotification(player)
    if settings.observe then
        CoreGui:SetCore("SendNotification", {
            Title = player.Name,
            Text = "Started observing",
            Duration = math.huge,
            Button1 = "Ignore",
            Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48),
        })
    end
    
    local illuChat
    local remove
    remove = player.Character.ChildRemoved:Connect(function(child)
        if child.Name == "Action" then
            if settings.observe then
                CoreGui:SetCore("SendNotification", {
                    Title = player.Name,
                    Text = "Stopped observing",
                    Duration = math.huge,
                    Button1 = "Ignore",
                    Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                })
            end

            illuChat:Disconnect()
            remove:Disconnect()
            table.remove(beingObserved, table.find(beingObserved, player.Character))
        end
    end)

    illuChat = player.Chatted:Connect(function(message)
        local bestMatch = 0
        local bestMatchPlayer = false
        for i,v in pairs(Players:GetPlayers()) do
            if v.leaderstats:FindFirstChild("FirstName") and not v:FindFirstChild("ObserveBlock") then
                local name = v.leaderstats.FirstName.Value
                local start, stringEnd = string.find(string.lower(name), string.lower(message))
                if start == 1 and stringEnd > bestMatch then
                    bestMatch = stringEnd
                    bestMatchPlayer = v
                end
            end
        end

        if bestMatchPlayer == Players.LocalPlayer and not Players.LocalPlayer:FindFirstChild("ObserveBlock") then
            CoreGui:SetCore("SendNotification", {
                Title = player.Name,
                Text = "Is observing you",
                Duration = math.huge,
                Button1 = "Ignore",
                Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
            })
        end
    end)
end

local function observeWatch(player)
    if player ~= Players.LocalPlayer.Character then
        player.Character.ChildAdded:Connect(function(instance)
            local observe = false
            local action = false

            for i,v in pairs(player.Character:GetChildren()) do
                if v.Name == "Action" then
                    action = true
                end

                if v.Name == "Observe" then
                    observe = true
                end
            end

            if observe and action and not table.find(beingObserved, player.Character) then
                observeNotification(player)
                table.insert(beingObserved, player.Character)
            end
        end)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(_character)
        observeWatch(player)
    end)
end)

for i,v in pairs(Players:GetPlayers()) do
    if v ~= Players.LocalPlayer then
        v.CharacterAdded:Connect(function(_character)
            observeWatch(v)
        end)
    
        if v.Character then
            observeWatch(v)
        end
    end
end

MiscTab:CreateToggle({
    name = "Observe Notifier",
    default = settings.observe,
    callbackOnCreation = true,
    callback = function(boolean)
        settings.observe = boolean

        if boolean then
            for i,v in pairs(Players:GetPlayers()) do
                if v.Character and v ~= Players.LocalPlayer then
                    local observe = false
                    local action = false
                    for i, instance in pairs(v.Character:GetChildren()) do
                        if instance.Name == "Action" then
                            action = true
                        end

                        if instance.Name == "Observe" then
                            observe = true
                        end
                    end

                    if observe and action and not table.find(beingObserved, v.Character) then
                        observeNotification(v)
                        table.insert(beingObserved, v.Character)
                    end
                end
            end
        end
    end
})

local joinEvent
local leaveEvent
local ignoreRoles = {
    ["Member"] = true,
    ["Guest"] = true
}

local function onJoin(player)
    if settings.mod then
        local role = player:GetRoleInGroup(15131884)

        if not ignoreRoles[role] and settings.mod then
            CoreGui:SetCore("SendNotification", {
                Title = role,
                Text = player.Name .. " joined server",
                Duration = math.huge,
                Button1 = "Ignore",
                Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
            })
        end
    end
end

local function onLeave(player)
    if settings.mod then
        local role = player:GetRoleInGroup(15131884)

        if not ignoreRoles[role] then
            CoreGui:SetCore("SendNotification", {
                Title = role,
                Text = player.Name .. " left server",
                Duration = math.huge,
                Button1 = "Ignore",
                Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
            })
        end
    end
end

MiscTab:CreateToggle({
    name = "Mod Notifier",
    default = settings.mod,
    callbackOnCreation = true,
    callback = function(boolean)
        settings.mod = boolean

        if boolean then
            joinEvent = Players.PlayerAdded:Connect(onJoin)
            leaveEvent = Players.PlayerRemoving:Connect(onLeave)

            for i,v in pairs(Players:GetPlayers()) do
                if v ~= Players.LocalPlayer then
                    local role = v:GetRoleInGroup(15131884)
            
                    if not ignoreRoles[role] then
                        CoreGui:SetCore("SendNotification", {
                            Title = role,
                            Text = v.Name .. " in server",
                            Duration = math.huge,
                            Button1 = "Ignore",
                            Icon = Players:GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                        })
                    end 
                end
            end
        else
            if joinEvent then
                joinEvent:Disconnect()
                leaveEvent:Disconnect()
            end
        end
    end
})

local timerStarted = false
local airTimer = 0
local timerGui
local airConnection
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {game.Workspace.AreaMarkers, game.Workspace.Live}

MiscTab:CreateToggle({
    name = "AA Timer",
    default = settings.AAtimer,
    callbackOnCreation = true,
    callback = function(boolean)
        settings.AAtimer = boolean

        if boolean then
            timerGui = Assets.AirTimer:Clone()
            timerGui.Enabled = false

            if syn then
                syn.protect_gui(timerGui)
                timerGui.Parent = game.CoreGui
            elseif gethui then
                timerGui.Parent = gethui()
            else
                timerGui.Parent = game.CoreGui
            end

            airConnection = RunService.Heartbeat:Connect(function()
                local onFloor = workspace:Raycast(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(0, -3.5, 0), raycastParams)

                if onFloor then
                    timerStarted = false
                    timerGui.Enabled = false
                else
                    if not timerStarted then
                        timerStarted = true
                        timerGui.Enabled = true
                        airTimer = os.clock() + 55
                    end

                    timerGui.Frame.Timer.Text = math.floor((airTimer - os.clock()) + 0.5)
                end
            end)
        else
            if airConnection then
                airConnection:Disconnect()
                airConnection = false
                timerGui:Destroy()
            end
        end
    end
})

local alertParams = OverlapParams.new()
alertParams.FilterType = Enum.RaycastFilterType.Include
alertParams.FilterDescendantsInstances = {game.Workspace.Live}

local alertGui
local alertConnection
MiscTab:CreateToggle({
    name = "Player Alert",
    default = settings.playerAlert,
    callbackOnCreation = true,
    callback = function(boolean)
        settings.playerAlert = boolean

        if boolean then
            alertGui = Assets.Nearby:Clone()
            
            if syn then
                syn.protect_gui(alertGui)
                alertGui.Parent = game.CoreGui
            elseif gethui then
                alertGui.Parent = gethui()
            else
                alertGui.Parent = game.CoreGui
            end

            alertConnection = RunService.Heartbeat:Connect(function()
                local nearby = workspace:GetPartBoundsInRadius(Players.LocalPlayer.Character.HumanoidRootPart.Position, 200, alertParams) 
                alertGui.Enabled = false

                if nearby[1] then
                    local closest = math.huge
                    local hasClosest = false
                    for i,v in pairs(nearby) do
                        if string.sub(v.Name, 1, 1) ~= "." then
                            local partParent = v

                            repeat
                                partParent = partParent.Parent
                            until partParent.Parent == game.Workspace.Live

                            if partParent ~= Players.LocalPlayer.Character then
                                local magnitude = (Players.LocalPlayer.Character.Torso.Position - partParent.Torso.Position).Magnitude

                                if magnitude < closest then
                                    closest = magnitude
                                    hasClosest = true
                                end
                            end
                        end
                    end

                    if hasClosest then
                        alertGui.Enabled = true
                        alertGui.Frame.Timer.Text = math.floor(closest).. " Studs"
                    end
                end
            end)
        else
            if alertConnection then
                alertConnection:Disconnect()
                alertConnection = false
                alertGui.Enabled = false
            end
        end
    end
})

MiscTab:CreateButton({
    name = "Server Hop",
    callback = function()
        TeleportService:Teleport(9978746069)
    end
})

local ColorTab = SettingsSection:CreateSection("Other Colors")

ColorTab:CreateColorPicker({
    name = "Mana Helper Normal",
    default = Color3.fromHex(settings.normalColor),
    resetColor = Color3.new(0, 0, 1),
    callback = function(color)
        settings.normalColor = color:ToHex()
    end
})

ColorTab:CreateColorPicker({
    name = "Mana Helper Normal",
    default = Color3.fromHex(settings.snapColor),
    resetColor = Color3.new(1, 0, 0),
    callback = function(color)
        settings.snapColor = color:ToHex()
    end
})

ColorTab:CreateColorPicker({
    name = "Player ESP",
    default = Color3.fromHex(settings.playerColor),
    resetColor = Color3.new(1, 1, 1),
    callback = function(color)
        settings.playerColor = color:ToHex()
    end
})

ColorTab:CreateColorPicker({
    name = "Chat Logger Illusionist",
    default = Color3.fromHex(settings.chatlogIlluColor),
    resetColor = Color3.fromRGB(0, 150, 255),
    callback = function(color)
        settings.chatlogIlluColor = color:ToHex()
    end
})
