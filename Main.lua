local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local ContextActionService = game:GetService("ContextActionService")
local TeleportService = game:GetService("TeleportService")
local ScriptContext = game:GetService("ScriptContext")

local httpRequest = syn and syn.request or request

--[[if not (syn and syn.crypt and syn.crypt.custom) or not (crypt and crypt.encrypt) then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kart's Poorest Minion gui",
        Text = "Executor not supported",
        Duration = 10,
        Button1 = "Ignore"
    })

    return
end]]--

--[[local function generateString(length)
    local lastByte
    local newString = ""

    for i=1, length do
        local byte = Random.new():NextInteger(32, 127)

        if lastByte then
            if lastByte == byte then
                while lastByte == byte do
                    byte = Random.new():NextInteger(32, 127)
                end
            end
        end

        lastByte = byte
        newString = newString .. string.char(byte)
    end

    return newString
end

local randomString = generateString(14)
local bigRandomString = generateString(32)
local clock = os.clock()
local random = Random.new(clock * 10000)
local randomNumber = random:NextInteger(10, 99)
local randint = clock * random:NextInteger(2, 5) / random:NextInteger(6, 8)
local data = {}
data[1] = bigRandomString
data[2] = clock
data[3] = game:GetService("Players").LocalPlayer.UserId
data[4] = "pls no crack pls pls 🙏🥺 idk what im doing pls teach me alekfart#0"
data[5] = randomString
data[6] = randint
data[7] = random
data[8] = randomNumber

local result = httpRequest({
    url = "",
    Method = "GET",
    Headers = {
        ["Content-Type"] = "application/json",
        ["Content-Length"] = tostring(#data)
    },
    Body = HttpService:JSONEncode(data)
})

if result then
    print(result.Body)
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kart's Poorest Minion gui",
        Text = "Error authenticating try again later",
        Duration = 10,
        Button1 = "Ignore"
    })
end

local Players = syn and syn.crypt.custom() or crypt.decrypt(result.Body.secret)]]--
local Players = game:GetService("Players")
local UiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/kartFr/RichMinion/main/UiLib.lua"))()
local FileSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/kartFr/RichMinion/main/FileSystem.lua"))()
local Assets = game:GetObjects("rbxassetid://12795349082")[1]
UiLibrary.addBlacklist({"Q", "P", "N", "V", "B", "G", "F", "E", "Z", "X", "C"})

local Gui = UiLibrary.new("Kart's Poorest Minion gui")
local localPlayer = Players.LocalPlayer
local freeThread = false
local errors = 0
local spectating = false
local camera = workspace.CurrentCamera
local illuLabels = {}
local modLabels = {}
local isKhei = game.PlaceId == 13747391385
local keyHandler = isKhei and require(game.ReplicatedStorage.Assets.Modules.KeyHandler) or nil
local mods = {
    scroomlicious = "Moderator"
}
local ignoreRoles = {
    ["Member"] = true,
    ["Guest"] = true
}
local spellPrecentages = { -- Things with the dashes have been confrimed by going into the games source code from a while ago
    Gate = {Snap = {.75, .83}}, --
    Ignis = {Snap = {.50, .60}, Normal = {.85, .95}}, --
    Gelidus = {Normal = {.80, .95}, Snap = {.80, 1}}, -- 
    Viribus = {Snap = {.60, .70}, Normal = {.25, .35}}, --
    Telorum = {Normal = {.80, .90}, Snap = {.70, .80}}, --
    Snarvindur = {Snap = {.20, .30}, Normal = {.6, .75}}, --
    Percutiens = {Snap = {.60, .70}, Normal = {.70, .80}}, --
    Velo = {Snap = {.4, .6}, Normal = {.70, 1}}, --
    Fimbulvetr = {Normal = {.84, .92}, Snap = {.70, .80}}, --
    Contrarium = {Snap = {.70, 1}, Normal = {.60, 1}},
    ["Manus Dei"] = {Normal = {.9, .95}, Snap = {.50, .6}}, --
    Nocere = {Normal = {.70, .85}, Snap = {.70, .85}},
    Sraunus = {Normal = {.01, .50}},
    Hoppa = {Normal = {.40, .60}, Snap = {.5, .6}}, --
    Tenebris = {Normal = {.90, 1}, Snap = {.4, .6}}, --
    Trahere = {Normal = {.75, .85}}, --
    Celeritas = {Normal = {.70, .9}, Snap = {.70, .8}}, --
    Trixstus = {Normal = {.30, .70}, Snap = {.3, .5}},
    ["Sagitta Sol"] = {Normal = {.50, .65}, Snap = {.40, .60}}, --
    Scrupus = {Normal = {.01, 1}},
    Armis = {Normal = {.40, .60}, Snap = {.70, .8}}, --
    Hystericus = {Normal = {.75, .85}, Snap = {.10, .40}},
    Verdien = {Snap = {.75, .85}, Normal = {.75, 1}}, --
    ["Fons Vitae"] = {Normal = {.70, 1}, Snap = {.5, 1}},
    Perflora = {Normal = {.7, .9}, Snap = {.3, .5}},
    Floresco = {Normal = {.9, 1}, Snap = {.8, .95}},
    Mirgeti = {Normal = {.01, 1}},
    Krusa = {Normal = {.7, 1}},
    Spindulys = {Normal = {.7, 1}},
    Custos = {Normal = {.5, .6}},
    Claritum = {Normal = {.9, 1}},
    Globus = {Normal = {.7, 1}}, --
    Intermissum = {Normal = {.6, 1}},
    Dominus = {Normal = {.3, 1}},
    ["Mana Fly"] = {Normal = {.3, 1}},
    Duobe = {Normal = {.01, 1}},
    Compress = {Normal = {.01, 1}},
    ["Terra Rebus"] = {Normal = {.01, 1}},
    Inferi = {Normal = {.1, .35}},
    Reditus = {Normal = {.5, 1}}, --
    Ligans = {Normal = {.6, .7}},
    Secare = {Normal = {.9, .95}}, --
    Furantur = {Normal = {.6, .80}}, --
    ["Howler"] = {Normal = {.6, .8}}, --
    ["Worm Bombs"] = {Normal = {.60, .75}}, --
    ["Worm Blast"] = {Normal = {.01, .9}},
    ["Call of The Dead"] = {Normal = {.95, 1}},
    Coercere = {Normal = {.01, 1}},
    Liber = {Normal = {.01, 1}},
    Scribo = {Normal = {.01, 1}},
    Gourdus = {Normal = {.75, 1}}, -- 
    Mori = {Normal = {.30, .32}, Snap = {.40, .41}}, --
    Nosferatus = {Normal = {.9, 1}}, --
    Pondus = {Normal = {.70, .9}, Snap = {.2, .3}}, --
    ["Shrieker"] = {Normal = {.3, .5}} --
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
    backstabDistance = 0,
    fullbright = false,
    playerAlert = false,
    waterclip = true,
    spellhelp = false,
    chatlogIlluColor = Color3.fromRGB(0, 150, 255):ToHex(),
    phoenixFlowerColor = "#960000",
    phoenixFlower = false,
    playerEsp = false,
    autoBard = false,
    esp = false,
    question = false,
    questionColor = "#5A005A",
    gems = false,
    common = false,
    gemColor = "#7e683f",
    useGemColor = true,
    commonColor = "#555555",
    candy = false,
    candyColor = "#ffff00",
    useCandyColor = true,
    modLeaderboard = Color3.fromRGB(0, 255, 0):ToHex(),
    illuLeaderboard = Color3.fromRGB(0, 150, 255):ToHex(),
    lightpiercer = false,
    climbSpeed = 1,
    healthEsp = false,
    disableBrick = false,
    water = true,
    combat = false,
    bloodthorn = false,
    bloodThornColor = "#5D0101",
    theme = Color3.new(1, 1, 1):ToHex(),
    hideKey = {["2"] = Enum.KeyCode.End.Name},
    healthColor = Color3.fromRGB(0, 255, 0):ToHex(),
    spectatingColor = Color3.fromRGB(255, 128, 0):ToHex(),
    clog = false,
    manaBar = false,
    manaBarColor = Color3.fromRGB(0, 150, 255):ToHex(),
    Z = false,
    X = false,
    C = false,
    font = "Gotham",
    nosunburn = false,
}
local resetOnDeath = {}
local settings = FileSystem.getfile("richestminion", defaultSettings)

local function getParent(gui)
    if syn and syn.protect_gui then
        syn.protect_gui(mainGui)
        gui.Parent = game.CoreGui
    elseif gethui then
        gui.Parent = gethui()
    else
        gui.Parent = localPlayer.PlayerGui
    end
end

local old
old = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)
    if not checkcaller() then
        if self.Name == "ApplyFallDamage" and settings.nofall then
            return
        end
    
        if self.Name == "SunBurn" and settings.nosunburn then
            return
        end
    end

    return old(self, ...)
end))

local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, key)
    if self == localPlayer and key == "CameraMaxZoomDistance" and debug.getinfo(Krnl and 5 or 3).source:find("Input") then
        return 45
    end

    return oldIndex(self, key)
end)

if localPlayer.Character then 
    errors += 1

    for i, connection in pairs(getconnections(ScriptContext.Error)) do
        connection:Disable()
    end
end

local function functionPasser(func, ...)
    local currentThread = freeThread
    freeThread = nil
    func(...)
    freeThread = currentThread
end

local function newThread()
    while true do
        functionPasser(coroutine.yield())
    end
end

local function spawnWithReuse(func, ...)
    if not freeThread then
        freeThread = coroutine.create(newThread)
        coroutine.resume(freeThread)
    end
    
    task.spawn(freeThread, func, ...)
end

local playerLabels = {}
local leaderboardGui = Assets.LeaderboardGui:Clone()
leaderboardGui.DisplayOrder = -1
getParent(leaderboardGui)

local realLeaderboardGui = localPlayer:WaitForChild("PlayerGui"):FindFirstChild("LeaderboardGui")
if realLeaderboardGui then
    realLeaderboardGui.Enabled = false
end

local function updateLeaderboard()
    local layoutOrder = {}

    for i,v in pairs(Players:GetPlayers()) do
        local leaderstats = v:FindFirstChild("leaderstats")

        if leaderstats then
            local firstName = leaderstats:FindFirstChild("FirstName")
            if playerLabels[v] and firstName and firstName.Value ~= "" then
                table.insert(layoutOrder, v)
            end
        end
    end

    table.sort(layoutOrder, function(player1, player2)
        if not player1 then
			return true
		end

		if not player2 then
			return false
		end

		local player1Stats = player1:FindFirstChild("leaderstats")
		local player2Stats = player2:FindFirstChild("leaderstats")
		local player1LastName = player1Stats.LastName.Value
		local player2LastName = player2Stats.LastName.Value

		if player1LastName ~= "" and player2LastName == "" then
			return true
		end

		if player1LastName == "" and player2LastName ~= "" then
			return false
		end

		if player1LastName < player2LastName then
			return true
		end

		if player2LastName < player1LastName then
			return false
		end

		local player1Name = player1Stats.FirstName.Value
		local player2Name = player2Stats.FirstName.Value

		if player1Name < player2Name then
			return true
		end

		if player2Name < player1Name then
			return false
		end

		return player1.Name < player2.Name
    end)

    for i,v in pairs(layoutOrder) do
        playerLabels[v].LayoutOrder = i
    end

    leaderboardGui.MainFrame.Size = UDim2.new(0.05, 150, 0, math.clamp(leaderboardGui.MainFrame.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y + 20, 0, 340))
    leaderboardGui.MainFrame.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, leaderboardGui.MainFrame.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
end

local function getName(houseRank, gender, firstName, lastName, uberTitle)
    local name = ""

    if houseRank.Value == "Owner" then
        name = gender.Value == "Male" and "Lord " or "Lady "
    end

    name = name .. firstName.Value

    if lastName.Value ~= "" then
        name = name .. " " .. lastName.Value
    end

    if uberTitle.Value ~= "" then
        name = name .. ", " .. uberTitle.Value
    end

    return name
end

local function getRankSpaces(prestige)
    if prestige.Value > 0 then
        local spaces = 3 + string.len(tostring(prestige.Value)) * 3
        return string.rep(" ", spaces)
    end
    return ""
end

local function createLabel(player)
	local leaderstats = player:WaitForChild("leaderstats")
	local prestige = leaderstats:WaitForChild("Prestige")
    local firstName = leaderstats:WaitForChild("FirstName")
	local uberTitle = leaderstats:WaitForChild("UberTitle")
	local lastName = leaderstats:WaitForChild("LastName")
	local houseRank = leaderstats:WaitForChild("HouseRank")
	local gender = leaderstats:WaitForChild("Gender")
    local label = Assets.PlayerLabel:Clone()
    local rankSpaces = getRankSpaces(prestige)
    local labelText = ""

    playerLabels[player] = label
    labelText = rankSpaces .. getName(houseRank, gender, firstName, lastName, uberTitle)
    label.Text = labelText

    if prestige.Value > 0 then
        label.Prestige.Text = "#" .. prestige.Value
        label.Prestige.Visible = true
    end

    local role = player:GetRoleInGroup(15131884)

    if not ignoreRoles[role] or mods[player.Name] then
        label.TextColor3 = Color3.fromHex(settings.modLeaderboard)
        modLabels[player] = label
    end

    prestige.Changed:Connect(function()
        rankSpaces = getRankSpaces(prestige)
        labelText = rankSpaces .. getName(houseRank, gender, firstName, lastName, uberTitle)
        label.Text = labelText

        if prestige.Value > 0 then
            label.Prestige.Text = "#" .. prestige.Value
            label.Prestige.Visible = true
        else
            label.Prestige.Visible = false
        end

        updateLeaderboard()
    end)

    firstName.Changed:Connect(function()
        labelText = rankSpaces .. getName(houseRank, gender, firstName, lastName, uberTitle)
        label.Text = labelText
        updateLeaderboard()
    end)

    uberTitle.Changed:Connect(function()
        labelText = rankSpaces .. getName(houseRank, gender, firstName, lastName, uberTitle)
        label.Text = labelText
        updateLeaderboard()
    end)

    lastName.Changed:Connect(function()
        labelText = rankSpaces .. getName(houseRank, gender, firstName, lastName, uberTitle)
        label.Text = labelText
        updateLeaderboard()
    end)

    houseRank.Changed:Connect(function()
        labelText = rankSpaces .. getName(houseRank, gender, firstName, lastName, uberTitle)
        label.Text = labelText
        updateLeaderboard()
    end)

    gender.Changed:Connect(function()
        labelText = rankSpaces .. getName(houseRank, gender, firstName, lastName, uberTitle)
        label.Text = labelText
        updateLeaderboard()
    end)

    label.MouseEnter:Connect(function()
        label.TextTransparency = 0.3
        label.Text = rankSpaces .. player.Name
    end)

    label.MouseLeave:Connect(function()
        label.TextTransparency = 0
        label.Text = labelText
    end)

    label.MouseButton1Down:Connect(function()
        if spectating == player then
            if localPlayer.Character then
                local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
                
                if humanoid then
                    spectating = false
                    camera.CameraSubject = humanoid
                end
            end
        elseif player.Character then
            if player == localPlayer then
                local humanoid = player.Character:FindFirstChild("Humanoid")

                if humanoid then
                    camera.CameraSubject = humanoid
                    spectating = false
                end
            else
                local head = player.Character:FindFirstChild("Head")

                if head then
                    spectating = player
                    camera.CameraSubject = head
                else
                    local humanoid = player.Character:FindFirstChild("Humanoid")

                    if humanoid then
                        spectating = player
                        camera.CameraSubject = humanoid
                    end
                end
            end
        end
    end)

    label.Parent = leaderboardGui.MainFrame.ScrollingFrame
    updateLeaderboard()
end

for i,v in pairs(Players:GetPlayers()) do
    spawnWithReuse(createLabel, v)
end

RunService.Heartbeat:Connect(function()
    for player, label in pairs(playerLabels) do
        if (player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Observe")) or (player.Character and player.Character:FindFirstChild("Observe")) then
            if not illuLabels[player] then
                illuLabels[player] = label
            end
            
            if spectating == player then
                label.TextColor3 = Color3.fromHex(settings.spectatingColor)
            else
                label.TextColor3 = Color3.fromHex(settings.illuLeaderboard)
            end
            
        else
            if illuLabels[player] then 
                illuLabels[player] = nil
            end
            
            if spectating == player then
                playerLabels[player].TextColor3 = Color3.fromHex(settings.spectatingColor)
            else
                

                if modLabels[player] then
                   label.TextColor3 = Color3.fromHex(settings.modLeaderboard)
                else
                    local maxEdict = player.leaderstats:FindFirstChild("MaxEdict")

                    if maxEdict and maxEdict.Value then
                        label.TextColor3 = Color3.fromRGB(255, 214, 81)
                    else
                        label.TextColor3 = Color3.new(1, 1, 1)
                    end
                end 
            end
        end
    end
end)

ContextActionService:BindAction("mousebutton1clicak", function(_actionName, inputState, _inputObject)
    if inputState ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass
    end

    if not localPlayer.Character then
        return Enum.ContextActionResult.Pass
    end

    if spectating and localPlayer.Character then
        spectating = false
        camera.CameraSubject = localPlayer.Character.Humanoid
    end

    return Enum.ContextActionResult.Pass
end, false, Enum.UserInputType.MouseButton1)

local normalGui
local snapGui
local currentTool
local currentBackpack
local opened = false
local allTools = {}
local items = {}
local itemLookup = {}
local slotLookup = {}
local slots = {
    ["1"] = false, 
    ["2"] = false, 
    ["3"] = false, 
    ["4"] = false, 
    ["5"] = false, 
    ["6"] = false,
    ["7"] = false, 
    ["8"] = false, 
    ["9"] = false, 
    ["0"] = false, 
    ["-"] = false, 
    ["="] = false, 
    ["Z"] = settings.Z, 
    ["X"] = settings.X, 
    ["C"] = settings.C,
}
local slotBinds = {
    [Enum.KeyCode.One] = "1",
    [Enum.KeyCode.Two] = "2",
    [Enum.KeyCode.Three] = "3",
    [Enum.KeyCode.Four] = "4",
    [Enum.KeyCode.Five] = "5",
    [Enum.KeyCode.Six] = "6",
    [Enum.KeyCode.Seven] = "7",
    [Enum.KeyCode.Eight] = "8",
    [Enum.KeyCode.Nine] = "9",
    [Enum.KeyCode.Zero] = "0",
    [Enum.KeyCode.Minus] = "-",
    [Enum.KeyCode.Equals] = "=",
    [Enum.KeyCode.Z] = "Z",
    [Enum.KeyCode.X] = "X",
    [Enum.KeyCode.C] = "C",
}
local slotNumberLookup = {
    [1] = "1",
    [2] = "2",
    [3] = "3",
    [4] = "4",
    [5] = "5",
    [6] = "6",
    [7] = "7",
    [8] = "8",
    [9] = "9",
    [10] = "0",
    [11] = "-",
    [12] = "=",
    [13] = "Z",
    [14] = "X",
    [15] = "C",
}
local deselectedColors = {
    [1] = Color3.fromRGB(200, 204, 198), -- weapon
    [2] = Color3.fromRGB(207, 193, 173), -- items/armor
    [3] = Color3.fromRGB(181, 204, 194), -- skills
    [4] = Color3.fromRGB(181, 204, 194), -- spells was Color3.fromRGB(175, 204, 205)
    [5] = Color3.fromRGB(202, 194, 180), -- gems
    [6] = Color3.fromRGB(207, 204, 173), -- trinkets
    [7] = Color3.fromRGB(175, 211, 173), -- ingredients
    [8] = Color3.fromRGB(186, 179, 205), -- potions
    [9] = Color3.fromRGB(207, 179, 173), -- artifacts
}
local hoverColors = {
    [1] = Color3.fromRGB(220, 225, 214),
    [2] = Color3.fromRGB(224, 211, 187),
    [3] = Color3.fromRGB(198, 222, 208),
    [4] = Color3.fromRGB(198, 222, 208), --Color3.fromRGB(192, 222, 219)
    [5] = Color3.fromRGB(219, 212, 194),
    [6] = Color3.fromRGB(224, 222, 187),
    [7] = Color3.fromRGB(192, 229, 187),
    [8] = Color3.fromRGB(203, 197, 219),
    [9] = Color3.fromRGB(224, 197, 187),
}
local selectedColors = {
    [1] = Color3.fromRGB(248, 255, 238),
    [2] = Color3.fromRGB(249, 238, 209),
    [3] = Color3.fromRGB(223, 249, 229),
    [4] = Color3.fromRGB(223, 249, 244),
    [5] = Color3.fromRGB(244, 238, 215),
    [6] = Color3.fromRGB(249, 249, 209),
    [7] = Color3.fromRGB(217, 255, 209),
    [8] = Color3.fromRGB(228, 224, 241),
    [9] = Color3.fromRGB(249, 224, 209),
}
local itemNames = {
    ["Orange Cowl"] = true,
    ["Purple Cowl"] = true,
    ["Dark Cowl"] = true,
    ["Tan Cowl"] = true,
    ["Light Cowl"] = true,
    ["Sigil Helmet"] = true,
    ["Dark Sigil Helmet"] = true,
    ["Church Knight Helmet"] = true,
}

local function updateSlotData()
    local saveData = {}

    for i=0, 12 do
        local slot = slots[slotNumberLookup[i]]

        if slot then
            saveData[tostring(i)] = slot
        end
    end

    game.ReplicatedStorage.Requests.UpdateSlotData:FireServer(saveData)
    settings.Z = slots["Z"]
    settings.C = slots["C"]
    settings.X = slots["X"]
end

local function makeDraggable(slot)
    slot.MouseButton1Down:Connect(function(X, Y)
        if opened then
            local offset = {X - slot.AbsolutePosition.X, Y - slot.AbsolutePosition.Y}
            local anchorPoint = UDim2.new(0, slot.AbsoluteSize.X * slot.AnchorPoint.X, 0, slot.AbsoluteSize.Y * slot.AnchorPoint.Y)
            local oldParent = slot.Parent
            local mouseConnection
            local dragConnection

            slot.Parent = currentBackpack
            slot.Position = UDim2.new(0, X - offset[1], 0, Y - offset[2] + 32) + anchorPoint
    
            mouseConnection = UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseMovement then
                    dragConnection:Disconnect()
                    mouseConnection:Disconnect()
                    local bestDistance = math.huge
                    local slotKey
                    local best
                    
                    for i,v in pairs(slotLookup) do
                        local distance = math.sqrt(math.pow((input.Position.X - (v.AbsolutePosition.X + 30)), 2) + math.pow((input.Position.Y - (v.AbsolutePosition.Y + 30)), 2))

                        if distance < bestDistance then
                            best = v
                            slotKey = i
                            bestDistance = distance
                        end
                    end

                    if bestDistance <= 40 then
                        local oldSlot = best:GetChildren()[1]

                        if oldSlot then
                            if oldParent.Name == "SlotMarker" then
                                oldSlot.Slot.Text = slot.Slot.Text
                                slots[slot.Slot.Text] = oldSlot.Text
                            else
                                slots[slot.Slot.Text] = false
                                oldSlot.Slot.Visible = false
                            end

                            oldSlot.Parent = oldParent
                        end

                        slot.Slot.Visible = true
                        slots[slotKey] = slot.Text
                        slot.Slot.Text = slotKey
                        slot.Parent = best
                    else
                        slots[slot.Slot.Text] = false
                        slot.Slot.Visible = false
                        slot.Parent = currentBackpack.BackpackFrame.ScrollingFrame
                    end

                    slot.Position = UDim2.new(0.5, 0, 0.5, 0)
                    updateSlotData()
                end
            end)
    
            dragConnection = UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    slot.Position = UDim2.new(0, input.Position.X - offset[1], 0, input.Position.Y - offset[2] + 64) + anchorPoint
                end
            end)
        end
    end)
end

local function getClass(tool)
    if tool:FindFirstChild("PrimaryWeapon") then
        return 1
    end

    if tool:FindFirstChild("Item") or itemNames[tool.Name] then
        return 2
    end

    if tool:FindFirstChild("Skill") then
        return 3
    end

    if tool:FindFirstChild("Spell") then
        return 4
    end

    if tool:FindFirstChild("Gem") and tool.Name ~= "Nightstone" then
        return 5
    end

    if tool:FindFirstChild("Trinket") or (tool.Name:find("Scroll") and not tool.Name:find("Contrarium") and not tool.Name:find("Fimbulvetr") and not tool.Name:find("Percutiens") and not tool.Name:find("Snarvindur") and not tool.Name:find("Manus Dei") and not tool.Name:find("Mori") and not tool.Name:find("Pondus")) then
        return 6
    end

    if tool:FindFirstChild("isIngredient") then
        return 7
    end

    if tool:FindFirstChild("isPotion") then
        return 8
    end

    if tool:FindFirstChild("Artifact") or string.find(tool.Name, "???") or string.find(tool.Name, "Ice Essence") or string.find(tool.Name, "Phoenix Down") then
        return 9
    end
    
    warn("please make a bug report could not find a category for: " .. tool.Name)
    return 1
end

local function equip(tool)
    local character = localPlayer.Character
    
    if character then
        local humanoid = character:FindFirstChild("Humanoid")

        if humanoid then
            humanoid:EquipTool(tool)
        end
    end
end

local function unequip()
    local character = localPlayer.Character
            
    if character then
        local humanoid = character:FindFirstChild("Humanoid")

        if humanoid then
            humanoid:UnequipTools()
            print("tool")
        end
    end
end

local function makeSlot(child, hotbar)
    allTools[child] = true

    if not items[child.Name] then
        local toolFrame = Assets.ToolFrame:Clone()
        toolFrame.Overlay.Size = UDim2.new(1, 6, 1, 6)
        toolFrame.Text = child.Name
        toolFrame.TextTransparency = 0.2
        makeDraggable(toolFrame)

        itemLookup[child.Name] = toolFrame
        items[child.Name] = 1

        local class = getClass(child)
        toolFrame.BackgroundColor3 = deselectedColors[class]
        toolFrame.LayoutOrder = class

        toolFrame.MouseEnter:Connect(function()
            if toolFrame.BackgroundColor3 == deselectedColors[class] then
                toolFrame.BackgroundColor3 = hoverColors[class]
            end
        end)

        toolFrame.MouseLeave:Connect(function()
            if toolFrame.BackgroundColor3 == hoverColors[class] then
                toolFrame.BackgroundColor3 = deselectedColors[class]
            end
        end)

        toolFrame.MouseButton1Down:Connect(function()
            if localPlayer.Character:FindFirstChild(toolFrame.Text) then
                unequip()
            else
                unequip()
                equip(localPlayer.Backpack:FindFirstChild(toolFrame.Text))
            end
        end)
        
        local inSlot = false

        for i,v in ipairs(slotNumberLookup) do
            local slot = slots[v]

            if slot == child.Name then
                toolFrame.Parent = slotLookup[v]
                toolFrame.Slot.Text = v
                slotLookup[v].Visible = true
                inSlot = true

                break
            elseif hotbar and not slotLookup[v]:GetChildren()[1] then
                toolFrame.Parent = slotLookup[v]
                slotLookup[v].Visible = true
                slots[v] = child.Name
                toolFrame.Slot.Text = v
                inSlot = true
                updateSlotData()

                break
            end
        end

        if not inSlot then
            toolFrame.Slot.Visible = false
            toolFrame.Parent = currentBackpack.BackpackFrame.ScrollingFrame
        end

        currentBackpack.BackpackFrame.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, currentBackpack.BackpackFrame.ScrollingFrame.UIGridLayout.AbsoluteContentSize.Y + 16)

        if child.Name == "Vocare" then
            local quantity = child:WaitForChild("Quantity")
            toolFrame.Quantity.Text = "x" .. quantity.Value
            toolFrame.Quantity.Visible = true

            quantity.Changed:Connect(function()
                toolFrame.Quantity.Text = "x" .. quantity.Value
            end)
        end
    else
        local toolFrame = itemLookup[child.Name]

        items[child.Name] += 1
        toolFrame.Quantity.Text = "x" .. items[child.Name]
        toolFrame.Quantity.Visible = true
    end
end

local function toolAdded(child)
    if not child:IsA("Tool") then
        return
    end

    if allTools[child] then
        return
    end

    task.wait()
    makeSlot(child, true)
end

local function removeSlot(child)
    allTools[child] = nil

    if items[child.Name] == 1 then
        items[child.Name] = nil

        if itemLookup[child.Name].Parent.Name == "SlotMarker" then
            itemLookup[child.Name].Parent.Visible = false
        end

        itemLookup[child.Name]:Destroy()
        itemLookup[child.Name] = nil
    else
        if not items[child.Name] then
            return
        end

        items[child.Name] -= 1
        itemLookup[child.Name].Quantity.Text = "x" .. items[child.Name]

        if items[child.Name] == 1 then
            itemLookup[child.Name].Quantity.Visible = false
        end
    end
end

local function toolRemoved(child)
    if not child:IsA("Tool") then
        return
    end

    repeat
        task.wait()
    until child.Parent ~= localPlayer.Backpack

    if child.Parent ~= localPlayer.Character then
        removeSlot(child)
    end
end

local function toolEquipped(child)
    if not child:IsA("Tool") then
        return
    end

    if settings.spellhelp and spellPrecentages[child.Name] then
        currentTool = child

        if normalGui then
            normalGui:Destroy()
            normalGui = false
        end
    
        if snapGui then
            snapGui:Destroy()
            snapGui = false
        end

        if spellPrecentages[child.Name].Normal then
            local normalPrecentage = spellPrecentages[child.Name].Normal
            normalGui = Instance.new("Frame")
            normalGui.BackgroundTransparency = 0.7
            normalGui.BorderSizePixel = 0
            normalGui.ZIndex = 1000
            normalGui.BackgroundColor3 = Color3.fromHex(settings.normalColor)
            normalGui.AnchorPoint = Vector2.new(.5, 0)
            normalGui.Size = UDim2.new(1, 0, normalPrecentage[2] - normalPrecentage[1], 0)
            normalGui.Position = UDim2.new(0.5, 0, 1 - normalPrecentage[2], 0)
            normalGui.Parent = localPlayer.PlayerGui.StatGui.LeftContainer.Mana 
        end
    
        if spellPrecentages[child.Name].Snap then
            local SnapPrecentage = spellPrecentages[child.Name].Snap
            snapGui = Instance.new("Frame")
            snapGui.ZIndex = 1000
            snapGui.BackgroundTransparency = 0.7
            snapGui.BorderSizePixel = 0
            snapGui.AnchorPoint = Vector2.new(.5, 0)
            snapGui.BackgroundColor3 = Color3.fromHex(settings.snapColor)
            snapGui.Size = UDim2.new(1, 0, SnapPrecentage[2] - SnapPrecentage[1], 0)
            snapGui.Position = UDim2.new(0.5, 0, 1 - SnapPrecentage[2], 0)
            snapGui.Parent = localPlayer.PlayerGui.StatGui.LeftContainer.Mana
        end
    end

    local slotFrame = itemLookup[child.Name]

    if not slotFrame then
        return
    end

    TweenService:Create(slotFrame, TweenInfo.new(0.1), {
        BackgroundColor3 = selectedColors[slotFrame.LayoutOrder],
        TextTransparency = 0,
    }):Play()

    TweenService:Create(slotFrame.Overlay, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
        Size = UDim2.new(1, 10, 1, 10),
    }):Play()
end

local function toolUnequipped(child)
    if not child:IsA("Tool") then
        return
    end

    repeat
        task.wait()
    until child.Parent ~= localPlayer.Character

    if currentTool == child then
        currentTool = nil

        if normalGui then
            normalGui:Destroy()
            normalGui = false
        end
    
        if snapGui then
            snapGui:Destroy()
            snapGui = false
        end
    end
    

    local slotFrame = itemLookup[child.Name]

    if not slotFrame then
        return
    end

    TweenService:Create(slotFrame, TweenInfo.new(0.1), {
        BackgroundColor3 = deselectedColors[slotFrame.LayoutOrder],
        TextTransparency = 0.2,
    }):Play()
    TweenService:Create(slotFrame.Overlay, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
        Size = UDim2.new(1, 6, 1, 6),
    }):Play()

    if child.Parent ~= localPlayer.Backpack then
        removeSlot(child)
    end
end

local function makeBackpack()
    if currentBackpack then
        currentBackpack:Destroy()
    end

    opened = false
    allTools = {}
    items = {}
    itemLookup = {}
    slotLookup = {}

    local slotData
    pcall(function()
        slotData = game.HttpService:JSONDecode(isKhei and keyHandler.getKey("Get"):InvokeServer({"SlotData"}).SlotData or game.ReplicatedStorage.Requests.Get:InvokeServer({"SlotData"}).SlotData)
    end)

    if slotData then
        for i,v in pairs(slotData) do
            if v ~= settings.Z and v ~= settings.X and v ~= settings.C then
                slots[slotNumberLookup[tonumber(i)]] = v
            end
        end
    else
        for i,v in pairs(slots) do
            slots[i] = false
        end

        settings.Z = false
        settings.X = false
        settings.C = false
    end

    currentBackpack = Assets.BackpackGui:Clone()
    getParent(currentBackpack)

    for i,v in ipairs(slotNumberLookup) do
        local slot = Assets.SlotMarker:Clone()
        slot.Visible = false
        slot.Parent = currentBackpack.MainFrame
        slotLookup[v] = slot
    end

    local backpack = localPlayer:WaitForChild("Backpack")

    backpack.ChildAdded:Connect(toolAdded)
    backpack.ChildRemoved:Connect(toolRemoved)
    localPlayer.Character.ChildAdded:Connect(toolEquipped)
    localPlayer.Character.ChildRemoved:Connect(toolUnequipped)

    for i,v in pairs(backpack:GetChildren()) do
        if v:IsA("Tool") and not allTools[v] then
            makeSlot(v)
        end
    end
end

localPlayer.ChildRemoved:Connect(function(child)
    if child.Name == "Ingame" then
        currentBackpack.Enabled = false
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then
        local bind = slotBinds[input.KeyCode]

        if bind then
            if slots[bind] and slotLookup[bind]:GetChildren()[1] then
                local tool = localPlayer.Character:FindFirstChild(slots[bind])

                if tool then
                    unequip()

                    return
                end

                tool = localPlayer.Backpack:FindFirstChild(slots[bind])

                if not tool then
                    return
                end

                unequip()
                equip(tool)
            end
        end

        if input.KeyCode == Enum.KeyCode.Backquote then
            opened = not opened
            currentBackpack.BackpackFrame.Visible = opened
            localPlayer.PlayerGui.StatGui.Container.Visible = not opened

            if opened then
                for i,v in pairs(slotLookup) do
                    v.Visible = true
                end
            else
                for i,v in pairs(slotLookup) do
                    if not v:GetChildren()[1] then
                        v.Visible = false
                    end
                end
            end
        end
    end
end)

local CharacterTab = Gui:CreateTab("Local Player")
local MovementSection = CharacterTab:CreateSection("Movement")

local flightConnection
local keysDown = {
    ["W"] = false,
    ["A"] = false,
    ["S"] = false,
    ["D"] = false,
    ["Space"] = false,
    ["LeftControl"] = false
}

ContextActionService:BindAction("flight", function(_actionName, inputState, inputObject)
    if inputState == Enum.UserInputState.Begin then
        keysDown[inputObject.KeyCode.Name] = true
    elseif inputState == Enum.UserInputState.End then
        keysDown[inputObject.KeyCode.Name] = false
    end

    return Enum.ContextActionResult.Pass
end, false, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.Space, Enum.KeyCode.LeftControl)

UserInputService.InputEnded:Connect(function(input)
    if keysDown[input.KeyCode.Name] then
        keysDown[input.KeyCode.Name] = false
    end
end)

resetOnDeath.fly = MovementSection:CreateToggle({
    name = "Fly",
    default = false,
    callback = function(boolean)
        if boolean then
            flightConnection = RunService.Heartbeat:Connect(function()
                local direction = Vector3.zero

                localPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                localPlayer.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

                for i,v in pairs(keysDown) do
                    if v then
                        if i == "W" then
                            direction += camera.CFrame.LookVector
                        elseif i == "S" then
                            direction -= camera.CFrame.LookVector
                        elseif i == "A" then
                            direction -= camera.CFrame.XVector
                        elseif i == "D" then
                            direction += camera.CFrame.XVector
                        elseif i == "Space" then
                            direction += Vector3.yAxis
                        else
                            direction -= Vector3.yAxis
                        end
                    end
                end

                localPlayer.Character:TranslateBy(direction * (settings.flyspeed / 2))
            end)
        else
            if flightConnection then
                flightConnection:Disconnect()
                flightConnection = false
            end
        end
    end
})
resetOnDeath.fly:AddSlider({
    min = 1,
    max = 5,
    default = settings.flyspeed,
    callback = function(number)
        settings.flyspeed = number
    end
})
resetOnDeath.fly:AddKeybind({
    default = settings.flybind,
    callback = function(bind)
        settings.flybind = bind
    end
})

local inWater
local floatPart

if localPlayer.Character then
    localPlayer.Character.Humanoid.StateChanged:Connect(function(_old, new)
        if new == Enum.HumanoidStateType.Swimming then
            inWater = true
        else
            inWater = false
        end
    end)
end

local clipConnection
resetOnDeath.noclip = MovementSection:CreateToggle({
    name = "No Clip",
    default = false,
    callback = function(boolean)
        if boolean then
            clipConnection = RunService.Stepped:Connect(function()
                if not localPlayer.Character then
                    return
                end

                for i,v in pairs(localPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v ~= floatPart and localPlayer.Character then
                        if settings.waterclip and inWater then
                            return
                        end
                        
                        if localPlayer.Character.Head:FindFirstChild("RagdollAttach") then
                            localPlayer.Character.Torso.CanCollide = true
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
                if localPlayer.Character then
                    localPlayer.Character.Torso.CanCollide = true
                end
            end
        end
    end
})
resetOnDeath.noclip:AddKeybind({
    default = settings.noclipBind,
    callback = function(bind)
        settings.noclipBind = bind
    end
})


MovementSection:CreateToggle({
    name = "Disable No Clip in Water",
    default = settings.waterclip,
    callback = function(boolean)
        settings.waterclip = boolean
    end
})

local canWalk = false
local originalWalkSpeed
local speedEvent

resetOnDeath.walkspeed = MovementSection:CreateToggle({
    name = "WalkSpeed", 
    default = false, 
    callback = function(boolean)
        canWalk = boolean

        if boolean then
            originalWalkSpeed = localPlayer.Character.Humanoid.WalkSpeed
            
            speedEvent = localPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                if localPlayer.Character.Humanoid.WalkSpeed ~= settings.Walkspeed then
                    originalWalkSpeed = localPlayer.Character.Humanoid.WalkSpeed
                    localPlayer.Character.Humanoid.WalkSpeed = settings.Walkspeed 
                end
            end)

            localPlayer.Character.Humanoid.WalkSpeed = settings.Walkspeed
        elseif speedEvent then
            speedEvent:Disconnect()
            localPlayer.Character.Humanoid.WalkSpeed = originalWalkSpeed
        end
end})
resetOnDeath.walkspeed:AddSlider({
    min = 0,
    max = 200,
    default = settings.Walkspeed,
    callback = function(number)
        settings.Walkspeed = number
        if canWalk then
            localPlayer.Character.Humanoid.WalkSpeed = settings.Walkspeed
        end
    end
})
resetOnDeath.walkspeed:AddKeybind({
    default = settings.walkbind,
    callback = function(bind)
        settings.walkbind = bind
    end
})

local canJump = false
local originalJumpPower
local jumpEvent

resetOnDeath.jumpHeight = MovementSection:CreateToggle({
    name = "JumpPower", 
    default = false, 
    callback = function(boolean)
        canJump = boolean

        if boolean then
            originalJumpPower = localPlayer.character.Humanoid.JumpPower
            jumpEvent = localPlayer.Character.Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
                if localPlayer.character.Humanoid.JumpPower ~= settings.jumpPower then
                    originalJumpPower = localPlayer.character.Humanoid.JumpPower
                    localPlayer.character.Humanoid.JumpPower = settings.jumpPower
                end
            end)

            localPlayer.character.Humanoid.JumpPower = settings.jumpPower
        elseif jumpEvent then
            jumpEvent:Disconnect()
            jumpEvent = false
            localPlayer.Character.Humanoid.JumpPower = originalJumpPower
        end
end})
resetOnDeath.jumpHeight:AddSlider({
    min = 0,
    max = 300,
    default = settings.jumpPower,
    callback = function(number)
        settings.jumpPower = number
        if canJump then
            localPlayer.Character.Humanoid.JumpPower = settings.jumpPower
        end
    end
})
resetOnDeath.jumpHeight:AddKeybind({
    default = settings.jumpbind,
    callback = function(bind)
        settings.jumpbind = bind
    end
})

local floating

resetOnDeath.infJump = MovementSection:CreateToggle({
    name = "Inf Jump",
    default = false,
    callback = function(boolean)
        if boolean then
            ContextActionService:BindAction("InfJump", function(_actionName, inputState, _inputObject)
                if inputState == Enum.UserInputState.Begin then
                    localPlayer.Character.Humanoid:ChangeState(3)
                end
                
                return Enum.ContextActionResult.Pass
            end, false, Enum.KeyCode.Space)
        else
            ContextActionService:UnbindAction("InfJump")
        end
    end
})
resetOnDeath.infJump:AddKeybind({
    default = settings.infjumpBind,
    callback = function(bind)
        settings.infjumpBind = bind
    end
})

resetOnDeath.float = MovementSection:CreateToggle({
    name = "Float",
    default = false,
    callback = function(boolean)
        if boolean then
            floatPart = Instance.new("Part")
            floatPart.Transparency = 1
            floatPart.Anchored = true
            floatPart.Size = Vector3.new(6, 1, 6)
            floatPart.Parent = localPlayer.Character
            floating = RunService.Heartbeat:Connect(function()
                if localPlayer.Character then
                    floatPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
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
})
resetOnDeath.float:AddKeybind({
    default = settings.floatBind,
    callback = function(bind)
        settings.floatBind = bind
    end
})

local climbEvent
local oldClimb
resetOnDeath.climbSpeed = MovementSection:CreateToggle({
    name = "Climb Speed",
    default = false,
    callback = function(boolean)
        
        if boolean then
            local climbBoost = localPlayer.Character.Boosts:FindFirstChild("ClimbBoost")

            if not climbBoost then
                climbBoost = Instance.new("NumberValue")
                climbBoost.Name = "ClimbBoost" 
                climbBoost.Value = settings.climbSpeed - 1
                climbBoost.Parent = localPlayer.Character.Boosts
                oldClimb = false
            else
                oldClimb = climbBoost.Value
                climbBoost.Value = settings.climbSpeed - 1
            end

            climbEvent = localPlayer.Character.Boosts.ChildAdded:Connect(function(child)
                if child.Name == "ClimbBoost" then
                    climbBoost = child
                    oldClimb = child.Value
                    child.Value = settings.climbSpeed - 1
                end
            end)
        else
            if climbEvent then
                climbEvent:Disconnect()

                if localPlayer.Character.Boosts:FindFirstChild("ClimbBoost") then
                    if oldClimb then
                        localPlayer.Character.Boosts.ClimbBoost.Value = oldClimb
                    else
                        localPlayer.Character.Boosts.ClimbBoost:Destroy()
                    end
                end

                oldClimb = false
                climbEvent = nil
            end
        end
    end
})
resetOnDeath.climbSpeed:AddSlider({
    min = 1,
    max = 4,
    default = settings.climbSpeed,
    rounding = 1,
    callback = function(number)
        settings.climbSpeed = number

        if climbEvent then
            localPlayer.Character.Boosts.ClimbBoost.Value = number - 1
        end
    end
})
resetOnDeath.climbSpeed:AddKeybind({
    default = settings.climbBind,
    callback = function(bind)
        settings.climbBind = bind
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
StatusSection:CreateToggle({
    name = "No Fire",
    default = false,
    callback = function(boolean)
        if boolean then
            fireConnection = RunService.Heartbeat:Connect(function()
                if localPlayer.Character and localPlayer.Character:FindFirstChild("Burning") then
                    localPlayer.Character.CharacterHandler.Remotes.Dodge:FireServer("180", "Normal")
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

StatusSection:CreateToggle({
    name = "No Sun Burn",
    default = settings.nosunburn,
    callback = function(boolean)
        settings.nosunburn = boolean

        if localPlayer.Character then
            localPlayer.Character.CharacterHandler.Remotes.SunBurn:FireServer(false)
        end
    end
})

local CombatSection = CharacterTab:CreateSection("Combat Visuals")

CombatSection:CreateToggle({
    name = "Spell Helper",
    default = settings.spellhelp,
    callback = function(boolean)
        settings.spellhelp = boolean

        if boolean then
            if not localPlayer.Character then
                return
            end

            local tool = localPlayer.Character:FindFirstChildWhichIsA("Tool")

            if not tool or not spellPrecentages[tool.Name] then
                return
            end

            if spellPrecentages[tool.Name].Normal then
                local normalPrecentage = spellPrecentages[tool.Name].Normal
                normalGui = Instance.new("Frame")
                normalGui.BackgroundTransparency = 0.7
                normalGui.BorderSizePixel = 0
                normalGui.ZIndex = 1000
                normalGui.BackgroundColor3 = Color3.fromHex(settings.normalColor)
                normalGui.AnchorPoint = Vector2.new(.5, 0)
                normalGui.Size = UDim2.new(1, 0, normalPrecentage[2] - normalPrecentage[1], 0)
                normalGui.Position = UDim2.new(0.5, 0, 1 - normalPrecentage[2], 0)
                normalGui.Parent = localPlayer.PlayerGui.StatGui.LeftContainer.Mana 
            end
        
            if spellPrecentages[tool.Name].Snap then
                local SnapPrecentage = spellPrecentages[tool.Name].Snap
                snapGui = Instance.new("Frame")
                snapGui.ZIndex = 1000
                snapGui.BackgroundTransparency = 0.7
                snapGui.BorderSizePixel = 0
                snapGui.AnchorPoint = Vector2.new(.5, 0)
                snapGui.BackgroundColor3 = Color3.fromHex(settings.snapColor)
                snapGui.Size = UDim2.new(1, 0, SnapPrecentage[2] - SnapPrecentage[1], 0)
                snapGui.Position = UDim2.new(0.5, 0, 1 - SnapPrecentage[2], 0)
                snapGui.Parent = localPlayer.PlayerGui.StatGui.LeftContainer.Mana
            end
        else
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

RunService.Heartbeat:Connect(function()
    for i,v in pairs(workspace.Live:GetChildren()) do
        if not v.Name:find("%.") then
            if v:FindFirstChild("Humanoid") then
                if spectating then
                    v.Humanoid.HealthDisplayDistance = settings.health and math.huge
                    v.Humanoid.NameDisplayDistance = settings.health and math.huge
                else
                    v.Humanoid.HealthDisplayDistance = settings.health and 100 or 0
                    v.Humanoid.NameDisplayDistance = 100
                end
    
                v.Humanoid.HealthDisplayType = settings.health and Enum.HumanoidHealthDisplayType.AlwaysOn or Enum.HumanoidHealthDisplayType.AlwaysOff
                v.Humanoid.DisplayDistanceType = settings.health and Enum.HumanoidDisplayDistanceType.Viewer or Enum.HumanoidDisplayDistanceType.Subject
            end
        end
    end
end)

CombatSection:CreateToggle({
    name = "Eyes of Elemira",
    default = settings.health,
    callback = function(boolean)
        settings.health = boolean
    end
})

local manaBars = {}
local manaConnections = {}

local function createManaBars(player)
    if manaConnections[player] then
        manaConnections[player]:Disconnect()
    end

    manaConnections[player] = {}

    local manaBar = Assets.ManaBar:Clone()
    manaBar.Bar.AnchorPoint = Vector2.new(0, 1)
    manaBar.Bar.BackgroundColor3 = Color3.fromHex(settings.manaBarColor)
    manaBar.Bar.Position = UDim2.new(0, 3, 1, -3)
    manaBar.Bar.Size = UDim2.new(0, 2, 0, 0)
    manaBar.Parent = player.Character:WaitForChild("HumanoidRootPart")

    manaConnections[player] = player.Character:WaitForChild("Mana").Changed:Connect(function()
        if player.Character.Mana.Value >= 0.5 then
            manaBar.Bar.Size = UDim2.new(0, 2, player.Character.Mana.Value/100, -6)
        else
            manaBar.Bar.Size = UDim2.new(0, 2, 0, 0)
        end
    end)
end

CombatSection:CreateToggle({
    name = "Mana Bars",
    default = settings.manaBar,
    callback = function(boolean)
        settings.manaBar = boolean

        if boolean then
            for i,v in pairs(Players:GetPlayers()) do
                if v.Character and v ~= localPlayer then
                    createManaBars(v)
                end 
            end
        else
            for i,v in pairs(manaBars) do
                v:Destroy()
            end

            manaBars = {}

            for i, v in pairs(manaConnections) do
                v:Disconnect()
            end

            manaConnections = {}
        end
    end
})

local seerConnections = {}
local seerGuis = {}

local function makeIntent(player)
    local head = player.Character:WaitForChild("Head")

    local esp = Assets.Intent:Clone()
    esp.Parent = head
    
    if seerGuis[player] then
        seerGuis[player]:Destroy()

        for i,v in pairs(seerConnections[player]) do
            v:Disconnect()
        end

        seerGuis[player] = esp
    end

    local hasTool = player.Character:FindFirstChildWhichIsA("Tool")

    if hasTool then
        esp.InformationLabel.Text = hasTool.Name
    end

    seerConnections[player] = {}

    seerConnections[player][#seerConnections[player] + 1] = player.Character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            esp.InformationLabel.Text = child.Name
        end
    end)

    seerConnections[player][#seerConnections[player] + 1] = player.Character.ChildRemoved:Connect(function(child)
        if child:IsA("Tool") then
            esp.InformationLabel.Text = ""
        end
    end)
end

CombatSection:CreateToggle({
    name = "Intent",
    default = settings.tool,
    callback = function(boolean)
        settings.tool = boolean

        if boolean then
            for i,v in pairs(game.Players:GetPlayers()) do
                if v ~= localPlayer and v.Character then
                    spawnWithReuse(makeIntent, v)
                end
            end  
        else
            for i,v in pairs(seerGuis) do
                v:Destroy()
            end

            seerGuis = {}

            for i,v in pairs(seerConnections) do
                for i, connection in pairs(v) do
                    connection:Disconnect()
                end
            end

            seerConnections = {}
        end
    end
})

local VisualSection = CharacterTab:CreateSection("Visuals")

local nameChanges = {}
local healthChanges = {}
local distanceGuis = {}
local espGuis = {}
local combatGuis = {}
local healthGuis = {}
local distanceESPConnection
local combatConnection

local function makeEsp(player)
    local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
    local esp = Assets.PlayerEsp:Clone()
    local text = Assets.EspText:Clone()

    text.Text = player.Name
    text.LayoutOrder = 1
    text.TextColor3 = Color3.fromHex(settings.playerColor)
    text.Name = "PlayerText"
    espGuis[player] = esp
    text.Parent = esp.Frame
    esp.Parent = humanoidRootPart

    return esp
end

local function getEspName(firstName, lastName, uberTitle)
    local text = "[" .. firstName.Value

    if lastName.Value ~= "" then
        text = text .. " " .. lastName.Value
    end

    if uberTitle.Value ~= "" then
        text = text .. ", " .. uberTitle.Value
    end

    return text .. "]"
end

local function makeCharacterNameEsp(player, gui)
    local text = gui.Frame:FindFirstChild("PlayerText")
    local leaderstats = player:WaitForChild("leaderstats")
    local firstName = leaderstats:WaitForChild("FirstName")
    local lastName = leaderstats:WaitForChild("LastName")
    local uberTitle = leaderstats:WaitForChild("UberTitle")
    nameChanges[player] = {}

    nameChanges[player][#nameChanges[player] + 1] = firstName.Changed:Connect(function()
        text.Text = player.Name .. getEspName(firstName, lastName, uberTitle)
    end)

    nameChanges[player][#nameChanges[player] + 1] = lastName.Changed:Connect(function()
        text.Text = player.Name .. getEspName(firstName, lastName, uberTitle)
    end)

    nameChanges[player][#nameChanges[player] + 1] = uberTitle.Changed:Connect(function()
        text.Text = player.Name .. getEspName(firstName, lastName, uberTitle)
    end)

    text.Text = player.Name .. getEspName(firstName, lastName, uberTitle)
end

local function makeHealthEsp(player, gui)
    if not player.Character then
        return
    end

    local text = Assets.EspText:Clone()
    local humanoid = player.Character:WaitForChild("Humanoid")
    healthChanges[player] = {}

    healthChanges[player][#healthChanges[player] + 1] = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        text.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
    end)

    healthChanges[player][#healthChanges[player] + 1] = humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
        text.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
    end)

    text.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
    text.LayoutOrder = 2
    text.TextColor3 = Color3.fromHex(settings.healthColor)
    text.Name = "HealthText"
    healthGuis[player] = text
    text.Parent = gui.Frame
end

local function makeDistanceEsp(player, gui)
    local text = Assets.EspText:Clone()
    local player1 = player.Character
    local player2 = localPlayer.Character

    if player1 and player2 then
        local torso1 = player.Character:FindFirstChild("Torso")
        local torso2 = localPlayer.Character:FindFirstChild("Torso")
        
        if torso1 and torso2 then
            text.Text = math.floor((torso1.Position - torso2.Position).Magnitude)
        else
            text.Text = "???"
        end
    else
        text.Text = "???"
    end

    text.LayoutOrder = 3
    text.TextColor3 = Color3.fromHex(settings.playerColor)
    text.Name = "DistanceText"
    distanceGuis[player] = text
    text.Parent = gui.Frame
end

local function startEsp(player)
    if nameChanges[player] then
        for i,v in pairs(nameChanges[player]) do
            v:Disconnect()
        end
        
        nameChanges[player] = nil
    end

    if healthChanges[player] then
        for i,v in pairs(healthChanges[player]) do
            v:Disconnect()
        end
        
        healthChanges[player] = nil
    end

    if healthGuis[player] then
        healthGuis[player] = nil
    end

    local gui = makeEsp(player)

    if settings.characterName then
        makeCharacterNameEsp(player, gui)
    end

    if settings.playerDistance then
        makeDistanceEsp(player, gui)
    end

    if settings.healthEsp then
        makeHealthEsp(player, gui)
    end
end

VisualSection:CreateToggle({
    name = "Player ESP",
    default = settings.playerEsp,
    callback = function(boolean)
        settings.playerEsp = boolean

        if boolean then
            for i,v in pairs(game.Players:GetPlayers()) do
                if not v.Name:find("%.") and v ~= localPlayer and v.Character then
                    spawnWithReuse(startEsp, v)
                end
            end
        else
            for i, connections in pairs(nameChanges) do
                for i, v in pairs(connections) do
                    v:Disconnect()
                end
            end

            nameChanges = {}

            for i, connections in pairs(healthChanges) do
                for i, v in pairs(connections) do
                    v:Disconnect()
                end
            end

            healthChanges = {}
            distanceGuis = {}
            combatGuis = {}

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
    name = "Character Name",
    default = settings.characterName,
    callback = function(boolean)
        settings.characterName = boolean

        if settings.playerEsp then
            if boolean then
                for i,v in pairs(espGuis) do
                    if not nameChanges[i] then
                        makeCharacterNameEsp(i, v)
                    end
                end
            else
                for i, connections in pairs(nameChanges) do
                    for i, v in pairs(connections) do
                        v:Disconnect()
                    end
                end
    
                nameChanges = {}
    
                for player, gui in pairs(espGuis) do
                    local text = gui.Frame:FindFirstChild("PlayerText")
                    text.Text = player.Name
                end
            end
        end
    end
})

VisualSection:CreateToggle({
    name = "Health",
    default = settings.healthEsp,
    callback = function(boolean)
        settings.healthEsp = boolean

        if settings.playerEsp then
            if boolean then
                for i,v in pairs(espGuis) do
                    if not healthChanges[i] then
                        makeHealthEsp(i, v)
                    end
                end
            else
                for i, connections in pairs(healthChanges) do
                    for i, v in pairs(connections) do
                        v:Disconnect()
                    end
                end
    
                healthChanges = {}
    
                for player, gui in pairs(healthGuis) do
                    gui:Destroy()
                end
    
                healthGuis = {}
            end
        end
    end
})

VisualSection:CreateToggle({
    name = "Distance",
    default = settings.playerDistance,
    callback = function(boolean)
        settings.playerDistance = boolean

        if settings.playerEsp then
            if boolean then
                for i,v in pairs(espGuis) do
                    if not distanceGuis[i] then
                        makeDistanceEsp(i, v)
                    end
                end
    
                distanceESPConnection = RunService.Heartbeat:Connect(function()
                    local player1 = localPlayer.Character
    
                    if player1 then
                        local torso1 = localPlayer.Character:FindFirstChild("Torso")
                        if torso1 then
                            for player, gui in pairs(distanceGuis) do
                                local player2 = player.Character
                                if player2 then
                                    local torso2 = player.Character:FindFirstChild("Torso")
                                    
                                    if torso2 then
                                        gui.Text = math.floor((torso1.Position - torso2.Position).Magnitude)
                                    else
                                        gui.Text = "???"
                                    end
                                else
                                    gui.Text = "???"
                                end
                            end
                        end
                     end
                end)
            else
                for player, gui in pairs(distanceGuis) do
                    gui:Destroy()
                end
    
                distanceGuis = {}
    
                if distanceESPConnection then
                    distanceESPConnection:Disconnect()
                    distanceESPConnection = false
                end
            end
        end
    end
})

VisualSection:CreateToggle({
    name = "In Combat",
    default = settings.combat,
    callback = function(boolean)
        settings.combat = boolean

        if settings.playerEsp then
            if boolean then
                combatConnection = RunService.Heartbeat:Connect(function()
                    for i,v in pairs(Players:GetPlayers()) do
                        local playerGui = espGuis[v]

                        if playerGui then
                            if v:FindFirstChild("Danger") or v:FindFirstChild("MortalDanger") then
                                if not combatGuis[v] then
                                    local text = Assets.EspText:Clone()

                                    text.Text = "In combat"
                                    text.LayoutOrder = 4
                                    text.TextColor3 = Color3.fromHex(settings.playerColor)
                                    text.Name = "CombatText"
                                    combatGuis[v] = text
                                    text.Parent = playerGui.Frame
                                end
                            else
                                if combatGuis[v] then
                                    combatGuis[v]:Destroy()
                                    combatGuis[v] = nil
                                end
                            end
                        end
                    end
                end)
            else
                if combatConnection then
                    combatConnection:Disconnect()
                    combatConnection = false
                end

                for i,v in pairs(combatGuis) do
                    v:Destroy()
                end

                combatGuis = {}
            end
        end
    end
})

local MiscPlayerSection = CharacterTab:CreateSection("Misc")

MiscPlayerSection:CreateToggle({
    name = "Inf Zoom",
    default = settings.maxzoom,
    callback = function(boolean)
        settings.maxzoom = boolean
        if boolean then
            localPlayer.CameraMaxZoomDistance = math.huge
        else
            localPlayer.CameraMaxZoomDistance = 45
        end
    end
})

MiscPlayerSection:CreateButton({
    name = "Reset",
    callback = function()
        localPlayer.Character:BreakJoints()
    end
})

MiscPlayerSection:CreateButton({
    name = "Server Hop",
    callback = function()
        RunService.Heartbeat:Connect(function()
            if not localPlayer:FindFirstChild("Danger") and not localPlayer:FindFirstChild("MortalDanger") then
                localPlayer:Kick("Server Hopping")
                TeleportService:Teleport(9978746069)
            end
        end)
    end
})

MiscPlayerSection:CreateText("Server Hop Keybind"):AddKeybind({
    default = settings.serverHop,
    keyPressed = function()
        RunService.Heartbeat:Connect(function()
            if not localPlayer:FindFirstChild("Danger") and not localPlayer:FindFirstChild("MortalDanger") then
                localPlayer:Kick("Server Hopping")
                TeleportService:Teleport(9978746069)
            end
        end)
    end 
})

if isKhei then
    MiscPlayerSection:CreateButton({
        name = "Menu",
        callback = function()
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not localPlayer:FindFirstChild("Danger") and not localPlayer:FindFirstChild("MortalDanger") then
                    game:GetService("ReplicatedStorage").toMenu:FireServer()
                    connection:Disconnect()
                end
            end)
        end
    })
    
    MiscPlayerSection:CreateText("Menu Keybind"):AddKeybind({
        default = settings.serverHop,
        keyPressed = function()
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not localPlayer:FindFirstChild("Danger") and not localPlayer:FindFirstChild("MortalDanger") then
                    game:GetService("ReplicatedStorage").toMenu:FireServer()
                    connection:Disconnect()
                end
            end)
        end 
    })
end

MiscPlayerSection:CreateText("Insta-Log Keybind"):AddKeybind({
    default = settings.serverHop,
    keyPressed = function()
        RunService.Heartbeat:Connect(function()
            if not localPlayer:FindFirstChild("Danger") and not localPlayer:FindFirstChild("MortalDanger") then
                localPlayer:Kick("Logged")
            end
        end)
    end 
})

if isKhei then
    MiscPlayerSection:CreateButton({
        name = "Get Blessings",
        callback = function()
            local blessings = keyHandler.getKey("Get"):InvokeServer({"Blessings"})

            if blessings and blessings.Blessings then
                StarterGui:SetCore("SendNotification", {
                    Title = "Your blessings are:",
                    Text = blessings.Blessings,
                    Duration = 10,
                    Button1 = "Ignore",
                })
            end
        end
    })
end

local RageSection = CharacterTab:CreateSection("Combat")

local backstabParams = RaycastParams.new()
backstabParams.FilterType = Enum.RaycastFilterType.Include
backstabParams.FilterDescendantsInstances = {workspace.Live}
local deathConnection
local distanceConnection
local hasTarget

local backstab
backstab = RageSection:CreateToggle({
    name = "Backstab",
    default = false,
    callback = function(boolean)
        if boolean then
            local mouse = localPlayer:GetMouse()
            local unitRay = camera:ScreenPointToRay(mouse.X, mouse.Y)
            local raycastResult = workspace:Raycast(unitRay.Origin, unitRay.Direction * 150, backstabParams)

            if raycastResult then
                local parent = raycastResult.Instance

                while true do
                    parent = parent.Parent
                
                    if parent.Parent == workspace.Live then
                        break
                    end
                end

                if parent ~= localPlayer.Character then
                    hasTarget = true

                    deathConnection = localPlayer.Character.Humanoid.Died:Connect(function()
                        backstab:Set(false)
                    end)

                    distanceConnection = RunService.Heartbeat:Connect(function()
                        if parent.Parent then
                            local humanoidRootPart = parent:FindFirstChild("HumanoidRootPart")

                            if humanoidRootPart and (localPlayer.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude <= 50 and not parent:FindFirstChild("Unconscious") then
                                localPlayer.Character.HumanoidRootPart.CFrame = parent.HumanoidRootPart.CFrame * CFrame.new(0, 0, settings.backstabDistance)
                            else
                                backstab:Set(false)
                            end
                        else
                            backstab:Set(false)
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
})
backstab:AddKeybind({
    default = settings.backstabBind,
    callback = function(bind)
        settings.backstabBind = bind
    end
})
backstab:AddSlider({
    min = 0,
    max = 10,
    default = settings.backstabDistance,
    callback = function(number)
        settings.backstabDistance = number
    end
})

local bardConnection
local bardButtons = {}

RageSection:CreateToggle({
    name = "Auto Bard",
    default = settings.autoBard,
    callback = function(boolean)
        settings.autoBard = boolean

        if boolean then
            bardConnection = RunService.Heartbeat:Connect(function()
                if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
                    for i,v in pairs(localPlayer.PlayerGui.BardGui:GetChildren()) do
                        if v.Name == "Button" then
                            if v.OuterRing.Size.X.Offset <= 130 and not bardButtons[v] then
                                firesignal(v.MouseButton1Click)
                                bardButtons[v] = true
                            end
                        end
                    end
                end
            end)
        else
            if bardConnection then
                bardConnection:Disconnect()
            end
        end
    end
}):AddKeybind({
    default = settings.bardBind,
    callback = function(bind)
        settings.bardBind = bind
    end
})

local VisualsTab = Gui:CreateTab("World")
local AppearanceSection = VisualsTab:CreateSection("Appearance")

local brightnessConnection
AppearanceSection:CreateToggle({
    name = "Brightness",
    default = settings.brightnessBool,
    callback = function(boolean)
        settings.brightnessBool = boolean

        if boolean then
            brightnessConnection = game.Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
                if not settings.day and not settings.fullbright and game.Lighting.Brightness ~= settings.brightness then
                    game.Lighting.Brightness = settings.brightness
                end
            end)

            game.Lighting.Brightness = settings.brightness
        else
            if brightnessConnection then
                brightnessConnection:Disconnect()
                brightnessConnection = false

                if isKhei then
                    game.Lighting.Brightness = 1.25
                else
                    game.Lighting.Brightness = 0
                end
            end
        end
    end
}):AddSlider({
    min = 0,
    max = 10,
    default = settings.brightness,
    rounding = 2,
    callback = function(number)
        settings.brightness = number

        if not settings.day and not settings.fullbright then
            game.Lighting.Brightness = settings.brightness
        end
    end
})

local shadowConnection
AppearanceSection:CreateToggle({
    name = "Shadows",
    default = settings.shadows,
    callback = function(boolean)
        settings.shadows = boolean

        if boolean then
            if shadowConnection then
                shadowConnection:Disconnect()
                shadowConnection = false
            end

            game.Lighting.GlobalShadows = boolean
        else
            shadowConnection = game.Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
                if not settings.fullbright and game.Lighting.GlobalShadows then
                    game.Lighting.GlobalShadows = false
                end
            end)

            game.Lighting.GlobalShadows = boolean
        end
    end
})

local dayBright
local dayTime
local soft
local shadowColor

AppearanceSection:CreateToggle({
    name = "Always Day",
    default = settings.day,
    callback = function(boolean)
        settings.day = boolean
        
        if boolean then
            dayBright = game.Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
                if not settings.fullbright and game.Lighting.Brightness ~= 1 then
                    game.Lighting.Brightness = 1
                end
            end)

            dayTime = game.Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
                if game.Lighting.ClockTime ~= 12 then
                    game.Lighting.ClockTime = 12
                end
            end)

            soft = game.Lighting:GetPropertyChangedSignal("ShadowSoftness"):Connect(function()
                if game.Lighting.ShadowSoftness ~= 0.5 then
                    game.Lighting.ShadowSoftness = 0.5
                end
            end)

            shadowColor = game.Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
                if game.Lighting.OutdoorAmbient ~= Color3.fromRGB(127, 126, 101) then
                    game.Lighting.OutdoorAmbient = Color3.fromRGB(127, 126, 101)
                end
            end)
            
            game.Lighting.OutdoorAmbient = Color3.fromRGB(127, 126, 101)
            game.Lighting.ShadowSoftness = 0.5
            game.Lighting.Brightness = 1
            game.Lighting.ClockTime = 12
        else
            if dayBright then
                dayBright:Disconnect()
                dayBright = false
                dayTime:Disconnect()
                soft:Disconnect()
                shadowColor:Disconnect()
                game.Lighting.ClockTime = 24
                game.Lighting.Brightness = 0
                game.Lighting.ShadowSoftness = 0
            end
        end
    end
})

local fogConnection

AppearanceSection:CreateToggle({
    name = "No Fog",
    default = settings.nofog,
    callback = function(boolean)
        settings.nofog = boolean

        if boolean then
            fogConnection = game.Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
                if game.Lighting.FogEnd ~= 9e9 then
                    game.Lighting.FogEnd = 9e9
                end
            end)

            game.Lighting.FogEnd = 9e9
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
                if game.Lighting.OutdoorAmbient ~= Color3.fromRGB(128, 128, 128) and not settings.day then
                    game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                end
            end)

            brightfb = game.Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
                if game.Lighting.Brightness ~= 2 then
                    game.Lighting.Brightness = 2
                end
            end)

            shadowfb = game.Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
                if game.Lighting.GlobalShadows then
                    game.Lighting.GlobalShadows = false
                end
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
                game.Lighting.GlobalShadows = true
            end
        end
    end
})

local MapSection = VisualsTab:CreateSection("Map")

local real = {}
local fake = {}
local brickNames = {
    ["KillFire"] = true,
    ["ArdorianKillbrick"] = true,
    ["KillBrick"] = true,
    ["PoisonField"] = true,
    ["Lava"] = true,
    ["CryptKiller"] = true,
    ["SpectralFire"] = true,
    ["PitKillBrick"] = true,
}

for i,v in ipairs(workspace.Map:GetChildren()) do
    if brickNames[v.Name] then
        table.insert(real, v)
        table.insert(fake, v:Clone())
    end
end

MapSection:CreateToggle({
    name = "Disable Kill Bricks",
    default = settings.disableBrick,
    callback = function(boolean)
        settings.disableBrick = boolean

        for i, connection in pairs(getconnections(workspace.Map.ChildRemoved)) do
            connection:Disable()
        end

        if boolean then
            for i,v in ipairs(fake) do
                v.Parent = workspace.Map
            end

            for i,v in ipairs(real) do
                v.Parent = nil
            end
        else
            for i,v in ipairs(real) do
                v.Parent = workspace.Map
            end

            for i,v in ipairs(fake) do
                v.Parent = nil
            end
        end
    end
})

local waterTerrain = workspace.Terrain:CopyRegion(workspace.Terrain.MaxExtents)

MapSection:CreateToggle({
    name = "Terrain Water",
    default = settings.water,
    callback = function(boolean)
        settings.water = boolean

        if boolean then
            workspace.Terrain:PasteRegion(waterTerrain, workspace.Terrain.MaxExtents.Min, true)
        else
            workspace.Terrain:Clear()
        end
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
    ["azael"] = {},
    ["phoenixFlower"] = {},
    ["question"] = {},
    ["gems"] = {},
    ["common"] = {},
    ["candy"] = {},
}
local gemColors = {
    [Color3.fromRGB(164, 187, 190):ToHex()] = "Diamond",
    [Color3.fromRGB(0, 184, 49):ToHex()] = "Emerald",
    [Color3.fromRGB(16, 42, 220):ToHex()] = "Sapphire",
    [Color3.fromRGB(248, 248, 248):ToHex()] = "Opal",
    [Color3.fromRGB(255, 0, 0):ToHex()] = "Ruby",
}
local trinketMeshes = {
    ["rbxassetid://5196551436"] = "Amulet",
    ["rbxassetid://5204003946"] = "Goblet",
    ["rbxassetid://5196577540"] = "Old Amulet",
    ["rbxassetid://5196782997"] = "Old Ring",
    ["rbxassetid://5196776695"] = "Ring",
}

local function createESPForTrinketSection(espIndex, colorIndex, name)
    for i,v in pairs(espHolder[espIndex]) do
        if not v then
            local esp = Assets.Esp:Clone()
            esp.Adornee = i
            esp.TextLabel.TextColor3 = Color3.fromHex(settings[colorIndex])
            esp.TextLabel.Text = name
            esp.Parent = i

            espHolder[espIndex][i] = esp
        end
    end
end

local function applyEsp(instance)
    if not instance:FindFirstChild("ClickPart") then
        instance:WaitForChild("ClickPart")
    end

    if ((instance:IsA("MeshPart") and trinketMeshes[instance.MeshId]) or (instance:IsA("UnionOperation") and instance.Color == Color3.fromRGB(111, 113, 125))) and instance:FindFirstChild("ParticleEmitter")  then
        if settings.common then
            local esp = Assets.Esp:Clone()
            esp.Adornee = instance
            esp.TextLabel.TextColor3 = Color3.fromHex(settings.commonColor)

            if instance.Color == Color3.fromRGB(111, 113, 125) then
                esp.TextLabel.Text = "Idol of the Forgotten"
            else
                esp.TextLabel.Text = trinketMeshes[instance.MeshId]
            end

            esp.Parent = instance
            espHolder.common[instance] = esp
        else
            espHolder.common[instance] = false
        end

        return
    end

    if instance:FindFirstChild("Mesh") and not instance:FindFirstChild("PointLight") then
        if instance.Mesh.MeshType == Enum.MeshType.Sphere or instance.Mesh.MeshId == "rbxassetid://%202877143560%20" then
            if settings.gems and settings.esp then
                local esp = Assets.Esp:Clone()
                esp.Adornee = instance
                esp.TextLabel.TextColor3 = not settings.useGemColor and Color3.fromHex(settings.gemColor) or instance.Color
                esp.TextLabel.Text = gemColors[instance.Color:ToHex()]
                esp.Parent = instance

                espHolder.gems[instance] = esp
            else
                espHolder.gems[instance] = false
            end
    
            return
        end
    end
    
    if instance:IsA("MeshPart") and instance.MeshId == "rbxassetid://%202877143560%20" then
        if settings.gems and settings.esp then
            local esp = Assets.Esp:Clone()
            esp.Adornee = instance
            esp.TextLabel.TextColor3 = not settings.useGemColor and Color3.fromHex(settings.gemColor) or instance.Color
            esp.TextLabel.Text = gemColors[instance.Color:ToHex()]
            esp.Parent = instance

            espHolder.gems[instance] = esp
        else
            espHolder.gems[instance] = false
        end

        return
    end

    if instance:IsA("MeshPart") and instance.MeshId == "rbxassetid://5204453430" then
        if settings.scroll and settings.esp then
            local esp = Assets.Esp:Clone()
            esp.Adornee = instance
            esp.TextLabel.TextColor3 = Color3.fromHex(settings.scrollColor)
            esp.TextLabel.Text = "Scroll"
            esp.Parent = instance

            espHolder.scroll[instance] = esp
        else
            espHolder.scroll[instance] = false
        end

        return
    end

    if instance.Color == Color3.fromRGB(254, 85, 100) then
        if settings.iceessence and settings.esp then
            local esp = Assets.Esp:Clone()
            esp.Adornee = instance
            esp.TextLabel.TextColor3 = Color3.fromHex(settings.iceColor)
            esp.TextLabel.Text = "Ice Essence"
            esp.Parent = instance

            espHolder.ice[instance] = esp
        else
            espHolder.ice[instance] = false
        end

        return
    end

    if isKhei then
        if instance:IsA("MeshPart") and instance.MeshId == "rbxassetid://923469333" then
            if settings.candy then
                local esp = Assets.Esp:Clone()
                esp.Adornee = instance
                esp.TextLabel.TextColor3 = not settings.useCandyColor and Color3.fromHex(settings.candyColor) or instance.Color
                esp.TextLabel.Text = "Candy"
                esp.Parent = instance
    
                espHolder.candy[instance] = esp
            else
                espHolder.candy[instance] = false
            end
    
            return
        end

        if instance:FindFirstChild("Attachment") and instance.Attachment:FindFirstChild("ParticleEmitter") and instance.Attachment.ParticleEmitter.Texture == "rbxassetid://1536547385" then
            if settings.phoenixFlower and settings.esp then
                local esp = Assets.Esp:Clone()
                esp.Adornee = instance
                esp.TextLabel.TextColor3 = Color3.fromHex(settings.phoenixFlowerColor)
                esp.TextLabel.Text = "Phoenix Flower"
                esp.Parent = instance

                espHolder.phoenixFlower[instance] = esp
            else
                espHolder.phoenixFlower[instance] = false
            end
        end
    else
        if instance:FindFirstChild("OrbParticle") then
            if settings.question and settings.esp then
                local esp = Assets.Esp:Clone()
                esp.Adornee = instance
                esp.TextLabel.TextColor3 = Color3.fromHex(settings.questionColor)
                esp.TextLabel.Text = "???"
                esp.Parent = instance
    
                espHolder.question[instance] = esp
            else
                espHolder.question[instance] = false
            end
    
            return
        end

        if instance:IsA("UnionOperation") then
            if instance.Color == Color3.fromRGB(29, 46, 58) then
                if settings.nightstone and settings.esp then
                    local esp = Assets.Esp:Clone()
                    esp.Adornee = instance
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.nightstoneColor)
                    esp.TextLabel.Text = "Nightstone"
                    esp.Parent = instance
        
                    espHolder.night[instance] = esp
                else
                    espHolder.night[instance] = false
                end
        
                return
            end

            if instance.Color ==Color3.fromRGB(248, 248, 248) then
                if instance:FindFirstChild("PointLight") then
                    if settings.amuletofwhite and settings.esp then
                        local esp = Assets.Esp:Clone()
                        esp.Adornee = instance
                        esp.TextLabel.TextColor3 = Color3.fromHex(settings.whiteColor)
                        esp.TextLabel.Text = "Amulet Of The White King"
                        esp.Parent = instance
            
                        espHolder.white[instance] = esp
                    else
                        espHolder.white[instance] = false
                    end
                else 
                    if settings.lannis and settings.esp then
                        local esp = Assets.Esp:Clone()
                        esp.Adornee = instance
                        esp.TextLabel.TextColor3 = Color3.fromHex(settings.lannisColor)
                        esp.TextLabel.Text = "Lannis Amulet"
                        esp.Parent = instance
            
                        espHolder.lannis[instance] = esp
                    else
                        espHolder.lannis[instance] = false
                    end
                end
            end
            
        end
    
        if instance:IsA("MeshPart") and instance.MeshId == "rbxassetid://2520762076" then
            if settings.howler and settings.esp then
                local esp = Assets.Esp:Clone()
                esp.Adornee = instance
                esp.TextLabel.TextColor3 = Color3.fromHex(settings.howlerColor)
                esp.TextLabel.Text = "Howler Friend"
                esp.Parent = instance
    
                espHolder.howler[instance] = esp
            else
                espHolder.howler[instance] = false
            end
    
            return
        end

        if instance:FindFirstChild("Attachment") and instance.Attachment:FindFirstChild("ParticleEmitter") and instance.Attachment.ParticleEmitter.Texture == "rbxassetid://1536547385" then
            if tostring(instance.Attachment.ParticleEmitter.Color) == "0 1 0.8 0 0 1 1 0.501961 0 0 " then
                if settings.phoenixDown and settings.esp then
                    local esp = Assets.Esp:Clone()
                    esp.Adornee = instance
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.phoenixDownColor)
                    esp.TextLabel.Text = "Phoenix Down"
                    esp.Parent = instance
    
                    espHolder.phoenix[instance] = esp
                else
                    espHolder.phoenix[instance] = false
                end
    
                return
            end
    
            if instance.Attachment.ParticleEmitter.Rate == 3 then
                if settings.ma and settings.esp then
                    local esp = Assets.Esp:Clone()
                    esp.Adornee = instance
                    esp.TextLabel.TextColor3 = Color3.fromHex(settings.maColor)
                    esp.TextLabel.Text = "Mysterious Artifact"
                    esp.Parent = instance
    
                    espHolder.ma[instance] = esp
                else
                    espHolder.ma[instance] = false
                end
    
                return
            end
    
            if settings.azael and settings.esp then
                local esp = Assets.Esp:Clone()
                esp.Adornee = instance
                esp.TextLabel.TextColor3 = Color3.fromHex(settings.azaelColor)
                esp.TextLabel.Text = "Azael Horn"
                esp.Parent = instance
    
                espHolder.azael[instance] = esp
            else
                espHolder.azael[instance] = false
            end
            
            return
        end
    end
end

workspace.Trinkets.ChildAdded:Connect(function(child)
    applyEsp(child)
end)

workspace.Trinkets.ChildRemoved:Connect(function(child)
    local trinketFound = false

    for i, v in pairs(espHolder) do
        for trinket, v in pairs(v) do
            if trinket == child then
                espHolder[i][trinket] = nil
                trinketFound = true

                break
            end
        end

        if trinketFound then
            break
        end
    end
end)

for i,v in pairs(workspace.Trinkets:GetChildren()) do
    applyEsp(v)
end

EspSection:CreateToggle({
    name = "ESP",
    default = settings.esp,
    callback = function(boolean)
        settings.esp = boolean

        if boolean then
            if settings.common then
                for i,v in pairs(espHolder.common) do
                    if not v then
                        local esp = Assets.Esp:Clone()
                        esp.Adornee = i
                        esp.TextLabel.TextColor3 = Color3.fromHex(settings.commonColor)
                        esp.TextLabel.Text = i:IsA("UnionOperation") and "Idol of the Forgotten" or trinketMeshes[i.MeshId]
                        esp.Parent = i
                        espHolder.common[i] = esp
                    end
                end
            end
            
            if settings.gems then
                for i,v in pairs(espHolder.gems) do
                    if not v then
                        local esp = Assets.Esp:Clone()
                        esp.Adornee = i
                        esp.TextLabel.TextColor3 = not settings.useGemColor and Color3.fromHex(settings.gemColor) or i.Color
                        esp.TextLabel.Text = gemColors[i.Color:ToHex()]
                        esp.Parent = i
                        espHolder.gems[i] = esp
                    end
                end
            end
            
            if settings.scroll then
                createESPForTrinketSection("scroll", "scrollColor", "Scroll")
            end
            
            if settings.iceessence then
                createESPForTrinketSection("ice", "iceColor", "Ice Essence")
            end
            
            if settings.phoenixFlower then
                createESPForTrinketSection("phoenixFlower", "phoenixFlowerColor", "Phoenix Flower")
            end
            
            if settings.candy then
                for i,v in pairs(espHolder.candy) do
                    if not v then
                        local esp = Assets.Esp:Clone()
                        esp.Adornee = i
                        esp.TextLabel.TextColor3 = not settings.useCandyColor and Color3.fromHex(settings.candyColor) or i.Color
                        esp.TextLabel.Text = "Candy"
                        esp.Parent = i

                        espHolder.candy[i] = esp
                    end
                end
            end
            
            if settings.question then
                createESPForTrinketSection("question", "questionColor", "???")
            end
            
            if settings.phoenixDown then
                createESPForTrinketSection("phoenix", "phoenixDownColor", "Phoenix Down")
            end
            
            if settings.ma then
                createESPForTrinketSection("ma", "maColor", "Mysterious Artifact")
            end
            
            if settings.amuletofwhite then
                createESPForTrinketSection("white", "whiteColor", "Amulet of the White King")
            end
            
            if settings.lannis then
                createESPForTrinketSection("lannis", "lannisColor", "Lannis Amulet")
            end
            
            if settings.nightstone then
                createESPForTrinketSection("night", "nightstoneColor", "Nightstone")
            end
            
            if settings.azael then
                createESPForTrinketSection("azael", "azaelColor", "Azael Horn")
            end
            
            if settings.howler then
                createESPForTrinketSection("howler", "howlerColor", "Howler Friend")
            end            
        else
            for i, v in pairs(espHolder) do
                for trinket, esp in pairs(v) do
                    if esp then
                        esp:Destroy()
                    end

                    espHolder[i][trinket] = false
                end
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Common Trinkets",
    default = settings.common,
    callback = function(boolean)
        settings.common = boolean

        if settings.esp then
            if boolean then
                for i,v in pairs(espHolder.common) do
                    if not v then
                        local esp = Assets.Esp:Clone()
                        esp.Adornee = i
                        esp.TextLabel.TextColor3 = Color3.fromHex(settings.commonColor)
                        esp.TextLabel.Text = i:IsA("UnionOperation") and "Idol of the Forgotten" or trinketMeshes[i.MeshId]
                        esp.Parent = i
                        espHolder.common[i] = esp
                    end
                end
            else
                for i,v in pairs(espHolder.common) do
                    if v then
                        v:Destroy()
                        espHolder.common[i] = false
                    end
                end
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Gems",
    default = settings.gems,
    callback = function(boolean)
        settings.gems = boolean

        if settings.esp then
            if boolean then
                for i,v in pairs(espHolder.gems) do
                    if not v then
                        local esp = Assets.Esp:Clone()
                        esp.Adornee = i
                        esp.TextLabel.TextColor3 = not settings.useGemColor and Color3.fromHex(settings.gemColor) or i.Color
                        esp.TextLabel.Text = gemColors[i.Color:ToHex()]
                        esp.Parent = i
                        espHolder.gems[i] = esp
                    end
                end
            else
                for i,v in pairs(espHolder.gems) do
                    if v then
                        v:Destroy()
                        espHolder.gems[i] = false
                    end
                end
            end
        end
    end
})

EspSection:CreateToggle({
    name = "Scrolls",
    default = settings.scroll,
    callback = function(boolean)
        settings.scroll = boolean

        if settings.esp then
            if boolean then
                createESPForTrinketSection("scroll", "scrollColor", "Scroll")
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
    name = "Ice Essence",
    default = settings.iceessence,
    callback = function(boolean)
        settings.iceessence = boolean

        if settings.esp then
            if boolean then
                createESPForTrinketSection("ice", "iceColor", "Ice Essence")
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

if isKhei then
    EspSection:CreateToggle({
        name = "Phoenix Flower",
        default = settings.phoenixFlower,
        callback = function(boolean)
            settings.phoenixFlower = boolean
    
            if settings.esp then
                if boolean then
                    createESPForTrinketSection("phoenixFlower", "phoenixFlowerColor", "Phoenix Flower")
                else
                    for i,v in pairs(espHolder.phoenixFlower) do
                        if v then
                            v:Destroy()
                            espHolder.phoenixFlower[i] = false
                        end
                    end
                end
            end
        end
    })

    EspSection:CreateToggle({
        name = "Candy",
        default = settings.candy,
        callback = function(boolean)
            settings.candy = boolean
    
            if settings.esp then
                if boolean then
                    for i,v in pairs(espHolder.candy) do
                        if not v then
                            local esp = Assets.Esp:Clone()
                            esp.Adornee = i
                            esp.TextLabel.TextColor3 = not settings.useCandyColor and Color3.fromHex(settings.candyColor) or i.Color
                            esp.TextLabel.Text = "Candy"
                            esp.Parent = i

                            espHolder.candy[i] = esp
                        end
                    end
                else
                    for i,v in pairs(espHolder.candy) do
                        if v then
                            v:Destroy()
                            espHolder.candy[i] = false
                        end
                    end
                end
            end
        end
    })
else
    EspSection:CreateToggle({
        name = "???",
        default = settings.question,
        callback = function(boolean)
            settings.question = boolean
    
            if settings.esp then
                if boolean then
                    createESPForTrinketSection("question", "questionColor", "???")
                else
                    for i,v in pairs(espHolder.question) do
                        if v then
                            v:Destroy()
                            espHolder.question[i] = false
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
    
            if settings.esp then
                if boolean then
                    createESPForTrinketSection("phoenix", "phoenixDownColor", "Phoenix Down")
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
        name = "Mysterious Artifact",
        default = settings.ma,
        callback = function(boolean)
            settings.ma = boolean
    
            if settings.esp then
                if boolean then
                    createESPForTrinketSection("ma", "maColor", "Mysterious Artifact")
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
    
    EspSection:CreateToggle({
        name = "Amulet of the White King",
        default = settings.amuletofwhite,
        callback = function(boolean)
            settings.amuletofwhite = boolean
    
            if settings.esp then
                if boolean then
                    createESPForTrinketSection("white", "whiteColor", "Amulet of the White King")
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
    
            if settings.esp then
                if boolean then
                    createESPForTrinketSection("lannis", "lannisColor", "Lannis Amulet")
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
        name = "Nightstone",
        default = settings.nightstone,
        callback = function(boolean)
            settings.nightstone = boolean
    
            if settings.esp then
                if boolean then
                    createESPForTrinketSection("night", "nightstoneColor", "Nightstone")
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
        name = "Azael Horn",
        default = settings.azael,
        callback = function(boolean)
            settings.azael = boolean
    
            if settings.esp then
                if boolean then
                    createESPForTrinketSection("azael", "azaelColor", "Azael Horn")
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
        name = "Howler Friend",
        default = settings.howler,
        callback = function(boolean)
            settings.howler = boolean
    
            if settings.esp then
                if boolean then
                    createESPForTrinketSection("howler", "howlerColor", "Howler Friend")
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
end


local TrinketSection = ItemsSection:CreateSection("Trinkets")

local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Include
overlapParams.FilterDescendantsInstances = { workspace.Trinkets, workspace.Ingredients }
local pickup
local amountPicked = 0
local timePicked = math.huge

resetOnDeath.autopickup = TrinketSection:CreateToggle({
    name = "Auto Pickup Trinkets",
    default = false,
    callback = function(boolean)
        if boolean then
            amountPicked = 0
            timePicked = os.clock()

            pickup = RunService.Heartbeat:Connect(function()
                if os.clock() - timePicked >= 1 then
                    amountPicked = 0
                    timePicked = os.clock()
                end

                if amountPicked >= 10 then
                    return
                end

                if not localPlayer.Character or not localPlayer.Character:FindFirstChild("Torso") then
                    return
                end

                local trinkets = workspace:GetPartBoundsInRadius(localPlayer.Character.Torso.Position, 16, overlapParams)

                if trinkets[1] then
                    for i,v in pairs(trinkets) do
                        if v.Parent == workspace.Trinkets then
                            local clickPart = v:FindFirstChild("ClickPart")
                            local clickDetector = clickPart:FindFirstChild("ClickDetector")
                            if clickDetector and (clickPart.Position - localPlayer.Character.Torso.Position).Magnitude <= clickDetector.MaxActivationDistance then
                                if amountPicked >= 10 then
                                    break
                                else
                                    fireclickdetector(clickDetector)
                                    amountPicked += 1
                                    timePicked = os.clock()
                                end
                            end
                        end
                    end
                end
            end)
        else
            if pickup then
                pickup:Disconnect()
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
                local trinkets = workspace:GetPartBoundsInRadius(localPlayer.Character.Torso.Position, 16, overlapParams)

                if trinkets[1] then
                    for i,v in pairs(trinkets) do
                        if v.Parent == workspace.Ingredients then
                            if (v.Position - localPlayer.Character.Torso.Position).Magnitude <= v.ClickDetector.MaxActivationDistance then
                                fireclickdetector(v.ClickDetector)
                            end
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

local makingHealth = false
local waterParams = OverlapParams.new()
waterParams.FilterType = Enum.RaycastFilterType.Include
waterParams.FilterDescendantsInstances = {workspace.Stations}

IngredientSection:CreateButton({
    name = "Create Health Potion",
    callback = function()
        if makingHealth then 
            return
        end

        local foundWater = false
        local findwater = workspace:GetPartBoundsInRadius(localPlayer.Character.Torso.Position, 12)

        for i,v in pairs(findwater) do
            if v.Name == "Water" then
                foundWater = true
                local flower = localPlayer.Backpack:FindFirstChild("Lava Flower")

                if flower then
                    local scrooms = {}
                    for i,v in pairs(localPlayer.Backpack:GetDescendants()) do
                        if v.Name == "Scroom" then
                            table.insert(scrooms, v)
                            if #scrooms >= 2 then
                                break
                            end
                        end
                    end

                    if #scrooms >= 2 then
                        makingHealth = true
                        local tools = {flower, scrooms[1], scrooms[2]}

                        for i, ingredient in pairs(tools) do
                            localPlayer.Character.Humanoid:EquipTool(ingredient)
                            ingredient.RemoteEvent:FireServer(CFrame.new(), v)
                            v.Parent.Contents.Changed:Wait()
                        end

                        fireclickdetector(v.Parent.Ladle.ClickConcoct)
                        makingHealth = false
                    else
                        StarterGui:SetCore("SendNotification", {
                            Title = "Create Health Potion",
                            Text = "Not enough ingredients",
                            Duration = 10,
                            Button1 = "Ignore",
                        })
                    end
                else
                    StarterGui:SetCore("SendNotification", {
                        Title = "Create Health Potion",
                        Text = "Not enough ingredients",
                        Duration = 10,
                        Button1 = "Ignore",
                    })
                end

                break
            end
        end

        if not foundWater then
            StarterGui:SetCore("SendNotification", {
                Title = "Create Health Potion",
                Text = "Get close to a cauldron",
                Duration = 10,
                Button1 = "Ignore",
            })
        end
    end
})

local makingTespian = false

IngredientSection:CreateButton({
    name = "Create Tespian",
    callback = function()
        if makingTespian then
            return
        end

        local findwater = workspace:GetPartBoundsInRadius(localPlayer.Character.Torso.Position, 12)
        local foundWater

        for i,v in pairs(findwater) do
            if v.Name == "Water" then
                foundWater = true
                local flower = localPlayer.Backpack:FindFirstChild("Lava Flower")
                local scroom = localPlayer.Backpack:FindFirstChild("Scroom")

                if flower and scroom then
                    local moss = {}
                    for i,v in pairs(localPlayer.Backpack:GetDescendants()) do
                        if v.Name == "Moss Plant" then
                            table.insert(moss, v)
                            if #moss >= 2 then
                                break
                            end
                        end
                    end
                    
                    if #moss >= 2 then
                        local tools = {flower, scroom, moss[1], moss[2]}
                        makingTespian = true

                        for i, ingredient in pairs(tools) do
                            localPlayer.Character.Humanoid:EquipTool(ingredient)
                            ingredient.RemoteEvent:FireServer(CFrame.new(), v)
                            v.Parent.Contents.Changed:Wait()
                        end

                        fireclickdetector(v.Parent.Ladle.ClickConcoct)
                        makingTespian = false
                    else
                        StarterGui:SetCore("SendNotification", {
                            Title = "Create Tespian",
                            Text = "Not enough ingredients",
                            Duration = 10,
                            Button1 = "Ignore",
                        })
                    end
                else
                    StarterGui:SetCore("SendNotification", {
                        Title = "Create Tespian",
                        Text = "Not enough ingredients",
                        Duration = 10,
                        Button1 = "Ignore",
                    })
                end

                break
            end
        end

        if not foundWater then
            StarterGui:SetCore("SendNotification", {
                Title = "Create Tespian",
                Text = "Get close to a cauldron",
                Duration = 10,
                Button1 = "Ignore",
            })
        end
    end
})

local ingredientESPSection = ItemsSection:CreateSection("Ingredient ESP")

local bloodConnection
local bloodThorns = {}

for i,v in pairs(workspace.Ingredients:GetChildren()) do
    if v.Name == "Blood Thorn" then
        bloodThorns[v] = false
    end
end

workspace.Ingredients.ChildAdded:Connect(function(child)
    if child.Name == "Blood Thorn" then
        if settings.bloodthorn then
            local esp = Assets.Esp:Clone()
            esp.TextLabel.Text = "Blood Thorn"
            esp.TextLabel.TextColor3 = Color3.fromHex(settings.bloodThornColor)
            esp.Parent = child

            bloodThorns[child] = esp
        else
            bloodThorns[child] = false
        end
    end
end)

ingredientESPSection:CreateToggle({
    name = "Blood Thorn",
    default = settings.bloodthorn,
    callback = function(boolean)
        settings.bloodthorn = boolean

        if boolean then
            for i, v in pairs(bloodThorns) do
                local esp = Assets.Esp:Clone()
                esp.TextLabel.Text = "Blood Thorn"
                esp.TextLabel.TextColor3 = Color3.fromHex(settings.bloodThornColor)
                esp.Parent = i

                bloodThorns[i] = esp
            end

            bloodConnection = RunService.Heartbeat:Connect(function()
                for i,v in pairs(bloodThorns) do
                    if v then
                        v.TextLabel.TextTransparency = i.Transparency
                        v.TextLabel.TextStrokeTransparency = i.Transparency
                    end
                end
            end)
        else
            for i,v in pairs(bloodThorns) do
                if v then
                    v:Destroy()
                    bloodThorns[i] = false
                end
            end

            if bloodConnection then
                bloodConnection:Disconnect()
                bloodConnection = false
            end
        end
    end
})

localPlayer.CharacterRemoving:Connect(function()
    for i,v in pairs(resetOnDeath) do
        v:Set(false)
    end
end)

local SettingsSection = Gui:CreateTab("Settings")
local ColorTab = SettingsSection:CreateSection("Trinket ESP Colors")

ColorTab:CreateColorPicker({
    name = "Common Trinket ESP color",
    default = Color3.fromHex(settings.commonColor),
    resetColor = Color3.fromHex("#555555"),
    callback = function(color)
        settings.commonColor = color:ToHex()

        if settings.esp and settings.common then
            for i,v in pairs(espHolder.common) do
                if v then
                    v.TextLabel.TextColor3 = color
                end
            end
        end
    end
})


ColorTab:CreateColorPicker({
    name = "Gem ESP color",
    default = Color3.fromHex(settings.gemColor),
    resetColor = Color3.fromHex("#7e683f"),
    callback = function(color)
        settings.gemColor = color:ToHex()

        if settings.esp and settings.gems then
            if not settings.useGemColor then
                for i,v in pairs(espHolder.gems) do
                    v.TextLabel.TextColor3 = color
                end
            end
        end
    end
})

ColorTab:CreateToggle({
    name = "Use Gem color for ESP",
    default = settings.useGemColor,
    callback = function(boolean)
        settings.useGemColor = boolean

        if settings.esp and settings.gems then
            if boolean then
                for i,v in pairs(espHolder.gems) do
                    v.TextLabel.TextColor3 = i.Color
                end
            else
                for i,v in pairs(espHolder.gems) do
                    v.TextLabel.TextColor3 = settings.gemColor
                end
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Scroll ESP color",
    default = Color3.fromHex(settings.scrollColor),
    resetColor = Color3.fromHex("#7A5E27"),
    callback = function(color)
        settings.scrollColor = color:ToHex()

        if settings.esp and settings.scroll then
            for i,v in pairs(espHolder.scroll) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Ice Essence ESP color",
    default = Color3.fromHex(settings.iceColor),
    resetColor = Color3.fromHex("#00FFFF"),
    callback = function(color)
        settings.iceColor = color:ToHex()

        if settings.esp and settings.ice then
            for i,v in pairs(espHolder.ice) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "??? Color ESP color",
    default = Color3.fromHex(settings.questionColor),
    resetColor = Color3.fromHex("#5A005A"),
    callback = function(color)
        settings.questionColor = color:ToHex()
            
        if settings.esp and settings.question then
            for i,v in pairs(espHolder.question) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Phoenix Down ESP color",
    default = Color3.fromHex(settings.phoenixDownColor),
    resetColor = Color3.fromHex("#FFC90E"),
    callback = function(color)
        settings.phoenixDownColor = color:ToHex()

        if settings.esp and settings.phoenixDown then
            for i,v in pairs(espHolder.phoenix) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Mysterious Artifact ESP color",
    default = Color3.fromHex(settings.maColor),
    resetColor = Color3.fromHex("#2C4920"),
    callback = function(color)
        settings.maColor = color:ToHex()
            
        if settings.esp and settings.ma then
            for i,v in pairs(espHolder.ma) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "White King ESP color",
    default = Color3.fromHex(settings.whiteColor),
    resetColor = Color3.fromHex("#F8F8F8"),
    callback = function(color)
        settings.whiteColor = color:ToHex()

        if settings.esp and settings.amuletofwhite then
            for i,v in pairs(espHolder.white) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Lannis Amulet ESP color",
    default = Color3.fromHex(settings.lannisColor),
    resetColor = Color3.fromHex("#D70EFF"),
    callback = function(color)
        settings.lannisColor = color:ToHex()

        if settings.esp and settings.lannis then
            for i,v in pairs(espHolder.lannis) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Nightstone ESP color",
    default = Color3.fromHex(settings.nightstoneColor),
    resetColor = Color3.fromHex("#1D2E3A"),
    callback = function(color)
        settings.nightstoneColor = color:ToHex()

        if settings.esp and settings.nightstone then
            for i,v in pairs(espHolder.night) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Azael Horn ESP color",
    default = Color3.fromHex(settings.azaelColor),
    resetColor = Color3.fromHex("#960000"),
    callback = function(color)
        settings.azaelColor = color:ToHex()

        if settings.esp and settings.azael then
            for i,v in pairs(espHolder.azael) do
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

        if settings.esp and settings.howler then
            for i,v in pairs(espHolder.howler) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Phoenix Flower ESP color",
    default = Color3.fromHex(settings.phoenixFlowerColor),
    resetColor = Color3.fromHex("#960000"),
    callback = function(color)
        settings.phoenixFlowerColor = color:ToHex()
            
        if settings.esp and settings.phoenixFlower then
            for i,v in pairs(espHolder.phoenixFlower) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateColorPicker({
    name = "Candy ESP color",
    default = Color3.fromHex(settings.candyColor),
    resetColor = Color3.fromHex("#ffff00"),
    callback = function(color)
        settings.candyColor = color:ToHex()
            
        if settings.esp and settings.candy then
            for i,v in pairs(espHolder.candy) do
                v.TextLabel.TextColor3 = color
            end
        end
    end
})

ColorTab:CreateToggle({
    name = "Use Candy color for ESP",
    default = settings.useCandyColor,
    callback = function(boolean)
        settings.useCandyColor = boolean

        if settings.esp and settings.candy then
            if boolean then
                for i,v in pairs(espHolder.candy) do
                    v.TextLabel.TextColor3 = i.Color
                end
            else
                for i,v in pairs(espHolder.candy) do
                    v.TextLabel.TextColor3 = settings.candyColor
                end
            end
        end
    end
})

local MiscTab = SettingsSection:CreateSection("Misc")

local amountLogs = {}
local activeLogs = {}
local chat = false

local function makeLog(player, message, isObserving)
    local log = Assets.Log:Clone()
    log.Text = "[" .. player.Name .. "]:" .. message
    log.Parent = chat.Menu.Body.Holder

    table.insert(activeLogs, 1, log)

    if #activeLogs > 50 then
        activeLogs[51]:Destroy()
        activeLogs[51] = nil
    end

    chat.Menu.Body.Holder.CanvasSize = UDim2.new(0, 0, 0, chat.Menu.Body.Holder.UIListLayout.AbsoluteContentSize.Y + 5)

    if isObserving then
        log.TextColor3 = Color3.fromHex(settings.chatlogIlluColor)
    end

    log.MouseButton1Down:Connect(function()
        if player == localPlayer then
            camera.CameraSubject = localPlayer.Character.Humanoid
            spectating = false
        else
            if workspace.Live:FindFirstChild(player.Name) then
                camera.CameraSubject = workspace.Live[player.Name]
                spectating = player
                return
            end

            if workspace.Dead:FindFirstChild(player.Name) then
                camera.CameraSubject = workspace.Dead[player.Name]
                spectating = player

                return
            end
        end
    end)

    if math.abs(chat.Menu.Body.Holder.AbsoluteCanvasSize.Y - chat.Menu.Body.Holder.AbsoluteSize.Y - 30) - math.abs(chat.Menu.Body.Holder.CanvasPosition.Y) <= 5 then
        chat.Menu.Body.Holder.CanvasPosition = Vector2.new(0, chat.Menu.Body.Holder.CanvasSize.Y.Offset)
    end
end

local function logChat(player, message)
    local head = false

    if player.Character then
        head = player.Character:FindFirstChild("Head")
    end

    local isObserving = head:FindFirstChild("MindMage") or false
    table.insert(amountLogs, 1, {player, message, isObserving})

    if #amountLogs > 50 then
        amountLogs[51] = nil
    end

    if chat then
        makeLog(player, message, isObserving)
    end
end

MiscTab:CreateToggle({
    name = "Chat Logger",
    default = false,
    callback = function(boolean)
        if boolean then
            chat = Assets.ChatLogger:Clone()

            getParent(chat)

            chat.Menu.TopBar.Drag.MouseButton1Down:Connect(function(X,Y)
                local offset = {X - chat.Menu.AbsolutePosition.X, Y - chat.Menu.AbsolutePosition.Y}
                local anchorPoint = UDim2.new(0,  chat.Menu.Size.X.Offset * chat.Menu.AnchorPoint.X, 0, chat.Menu.Size.Y.Offset * chat.Menu.AnchorPoint.Y)
                local mouseConnection
                local dragConnection

                mouseConnection = UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseMovement then
                        dragConnection:Disconnect()
                        mouseConnection:Disconnect()
                    end
                end)
        
                dragConnection = UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        chat.Menu.Position = UDim2.new(0, input.Position.X - offset[1], 0, input.Position.Y - offset[2] + 32) + anchorPoint
                    end
                end)
            end)

            for i = 50, 1, -1 do
                local log = amountLogs[i]
                
                if log then
                    makeLog(log[1], log[2], log[3])
                end
            end
        else
            if chat then
                chat:Destroy()
                chat = false
            end
        end
    end
})

local observingYou = {}
local playerList = Players:GetPlayers()
local observeGui = Assets.BeingObserved:Clone()
getParent(observeGui)
table.remove(playerList, 1)
table.insert(playerList, localPlayer)

RunService.Heartbeat:Connect(function()
    local observed = false
    for i,v in pairs(observingYou) do
        observed = true
    end

    observeGui.Enabled = settings.observe and observed or false
end)

local function observeNotification(player, mindMage)
    local observingPlayer = false
    local illuChat
    local remove

    if settings.observe then
        StarterGui:SetCore("SendNotification", {
            Title = player.Name,
            Text = "Started observing",
            Duration = 10,
            Button1 = "Ignore",
            Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48),
        })
    end
    
    remove = mindMage:GetPropertyChangedSignal("Name"):Connect(function()
        if observingYou[player] then
            observingYou[player] = nil
        end

        if settings.observe then
            StarterGui:SetCore("SendNotification", {
                Title = player.Name,
                Text = "Stopped observing",
                Duration = 10,
                Button1 = "Ignore",
                Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
            })
        end

        illuChat:Disconnect()
        remove:Disconnect()
    end)

    illuChat = player.Chatted:Connect(function(message)
        if localPlayer.Backpack:FindFirstChild("ObserveBlock") or not localPlayer.Character or localPlayer.Character.Boosts:FindFirstChild("ObserveBlock") or localPlayer.Character:FindFirstChild("in green room") then
            return
        end

        local observePlayer = false

        for i, v in ipairs(playerList) do
            if v.Character and v.leaderstats:FindFirstChild("FirstName") and (not v.Backpack:FindFirstChild("ObserveBlock")) and v.Character:FindFirstChild("Boosts") and (not v.Character.Boosts:FindFirstChild("ObserveBlock")) and (not v.Character:FindFirstChild("in green room")) then
                observePlayer = v
            end
        end

        local name = observePlayer.leaderstats.FirstName.Value
        local Lastname = observePlayer.leaderstats.LastName.Value
        local playerName = string.lower(name .. " " .. Lastname)

        if string.sub(playerName, 1, #string.lower(message)) == string.lower(message) then
            if observePlayer == localPlayer and not observingPlayer then
                observingPlayer = true
                observingYou[player] = true

                if settings.obserobservePlayere then
                    StarterGui:SetCore("SendNotification", {
                        Title = player.Name,
                        Text = "Started obserobservePlayering you",
                        Duration = 10,
                        Button1 = "Ignore",
                        Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                    }) 
                end
            elseif observingPlayer and observePlayer ~= player and observePlayer ~= localPlayer then
                observingPlayer = false
                observingYou[player] = nil

                if settings.obserobservePlayere then
                    StarterGui:SetCore("SendNotification", {
                        Title = player.Name,
                        Text = "Stopped obserobservePlayering you",
                        Duration = 10,
                        Button1 = "Ignore",
                        Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                    })
                end
            end
        end
    end)
end

local function observeWatch(player)
    local head = player.Character:WaitForChild("Head")
    head.ChildAdded:Connect(function(instance)
        if instance.Name == "MindMage" then
            observeNotification(player, instance)
        end
    end)
end

MiscTab:CreateToggle({
    name = "Observe Notifier",
    default = settings.observe,
    callback = function(boolean)
        settings.observe = boolean

        if boolean then
            for i,v in pairs(Players:GetPlayers()) do
                if v.Character and v ~= localPlayer then
                    local mindMage = v.Character.Head:FindFirstChild("MindMage")

                    if mindMage then
                        observeNotification(v, mindMage)
                    end
                end
            end
        end
    end
})

MiscTab:CreateToggle({
    name = "Mod Notifier",
    default = settings.mod,
    callback = function(boolean)
        settings.mod = boolean

        if boolean then
            for i,v in pairs(Players:GetPlayers()) do
                if v ~= localPlayer then
                    task.spawn(function()
                        local role = v:GetRoleInGroup(15131884)
            
                        if not ignoreRoles[role] or mods[v.Name] then
                            StarterGui:SetCore("SendNotification", {
                                Title = role,
                                Text = v.Name .. " in server",
                                Duration = 30,
                                Button1 = "Ignore",
                                Icon = Players:GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                            })
                        end 
                    end)
                end
            end
        end
    end
})

local timerStarted = false
local airTimer = false
local resetTime
local timerGui
local airConnection
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = {workspace.Map, workspace.Stations}

MiscTab:CreateToggle({
    name = "AA Timer",
    default = settings.AAtimer,
    callback = function(boolean)
        settings.AAtimer = boolean

        if boolean then
            timerGui = Assets.AirTimer:Clone()
            timerGui.Enabled = false

            getParent(timerGui)

            airConnection = RunService.Heartbeat:Connect(function()
                if not localPlayer.Character then
                    return
                end

                if not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    return
                end
                local onFloor = workspace:Raycast(localPlayer.Character.HumanoidRootPart.Position, Vector3.new(0, -3.5, 0), raycastParams)

                if onFloor or (localPlayer.Character:FindFirstChild("IsClimbing") and localPlayer.Character.IsClimbing.Value) or inWater then
                    if not resetTime then
                        resetTime = os.clock() + 1
                    end

                    if resetTime - os.clock() <= 0 then
                        timerStarted = false
                        timerGui.Enabled = false
                        airTimer = false
                    end
                else
                    if not timerStarted then
                        resetTime = false
                        timerStarted = true
                        airTimer = os.clock() + 50
                    end

                    if airTimer - os.clock() <= 49 then
                        resetTime = false
                        timerGui.Enabled = true
                    end
                end

                if airTimer then
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

MiscTab:CreateToggle({
    name = "Combat Log Notifier",
    default = settings.clog,
    callback = function(boolean)
        settings.clog = boolean
    end
})

local miscColorTab = SettingsSection:CreateSection("Other Colors")

miscColorTab:CreateColorPicker({
    name = "Mana Helper Normal color",
    default = Color3.fromHex(settings.normalColor),
    resetColor = Color3.new(0, 0, 1),
    callback = function(color)
        settings.normalColor = color:ToHex()

        if normalGui then
            normalGui.BackgroundColor3 = color
        end
    end
})

miscColorTab:CreateColorPicker({
    name = "Mana Helper Snap color",
    default = Color3.fromHex(settings.snapColor),
    resetColor = Color3.new(1, 0, 0),
    callback = function(color)
        settings.snapColor = color:ToHex()

        if snapGui then
            snapGui.BackgroundColor3 = color
        end
    end
})

miscColorTab:CreateColorPicker({
    name = "Player ESP color",
    default = Color3.fromHex(settings.playerColor),
    resetColor = Color3.new(1, 1, 1),
    callback = function(color)
        settings.playerColor = color:ToHex()

        for i,v in pairs(espGuis) do
            local guiFrame = v.Frame

            for i, text in pairs(guiFrame:GetChildren()) do
                if text:IsA("TextLabel") and text.Name ~= "HealthText" then
                    text.TextColor3 = color
                end
            end
        end
    end
})

miscColorTab:CreateColorPicker({
    name = "Health ESP color",
    default = Color3.fromHex(settings.healthColor),
    resetColor = Color3.new(0, 1, 0),
    callback = function(color)
        settings.healthColor = color:ToHex()

        for i,v in pairs(healthGuis) do
            v.TextColor3 = color
        end
    end
})

miscColorTab:CreateColorPicker({
    name = "Mana ESP color",
    default = Color3.fromHex(settings.manaBarColor),
    resetColor = Color3.fromRGB(0, 150, 255),
    callback = function(color)
        settings.manaBarColor = color:ToHex()

        for i,v in pairs(manaBars) do
            v.Bar.BackgroundColor3 = Color3.fromHex(settings.manaBarColor)
        end
    end
})

miscColorTab:CreateColorPicker({
    name = "Chat Logger Spectate color",
    default = Color3.fromHex(settings.chatlogIlluColor),
    resetColor = Color3.fromRGB(0, 150, 255),
    callback = function(color)
        settings.chatlogIlluColor = color:ToHex()
    end
})

miscColorTab:CreateColorPicker({
    name = "Mod leaderboard color",
    default = Color3.fromHex(settings.modLeaderboard),
    resetColor = Color3.fromRGB(0, 255, 0),
    callback = function(color)
        settings.modLeaderboard = color:ToHex()
    end
})

miscColorTab:CreateColorPicker({
    name = "Illusionist leaderboard color",
    default = Color3.fromHex(settings.illuLeaderboard),
    resetColor = Color3.fromRGB(0, 150, 255),
    callback = function(color)
        settings.illuLeaderboard = color:ToHex()
    end
})

miscColorTab:CreateColorPicker({
    name = "Spectating leaderboard color",
    default = Color3.fromHex(settings.spectatingColor),
    resetColor = Color3.fromRGB(255, 128, 0),
    callback = function(color)
        settings.spectatingColor = color:ToHex()
    end
})

local IngredientColorTab = SettingsSection:CreateSection("Ingredient ESP Colors")

IngredientColorTab:CreateColorPicker({
    name = "Blood Thorn color",
    default = Color3.fromHex(settings.bloodThornColor),
    resetColor = Color3.fromHex(defaultSettings.bloodThornColor),
    callback = function(color)
        settings.bloodThornColor = color:ToHex()

        if settings.bloodthorn then
            for i,v in pairs(bloodThorns) do
                if v then
                    v.TextColor3 = color
                end
            end
        end
    end
})

local GuiSettings = SettingsSection:CreateSection("Gui Settings")

GuiSettings:CreateColorPicker({
    name = "Gui theme",
    default = Color3.fromHex(settings.theme),
    resetColor = Color3.new(1, 1, 1),
    callback = function(color)
        settings.theme = color:ToHex()
        Gui:ChangeTheme(color)

        if chat then
            chat.Menu.Body.Holder.ScrollBarImageColor3 = color
            chat.Menu.Border.ImageColor3 = color
            chat.Menu.Body.Border.ImageColor3 = color
        end
    end
})

Gui:ChangeTheme(Color3.fromHex(settings.theme))

GuiSettings:CreateText("Hide keybind"):AddKeybind({
    default = settings.hideKey,
    callback = function(bind)
        settings.hideKey = bind
        Gui:RebindHide(bind)
    end
})

Gui:RebindHide(settings.hideKey)

GuiSettings:CreateDropDown({
    name = "Font",
    default = settings.font,
    options = {"Gotham", "SourceSans"},
    callback = function(option)
        settings.font = option
        Gui:ChangeFont(Enum.Font[option])
    end
})

Gui:ChangeFont(Enum.Font[settings.font])

for i,v in pairs(Players:GetPlayers()) do
    if v ~= localPlayer then
        v.Chatted:Connect(function(message)
            logChat(v, message)
        end)

        v.CharacterAdded:Connect(function()
            observeWatch(v)
            
            if settings.tool then
                makeIntent(v)
            end
            
            if settings.playerEsp then
                startEsp(v)
            end

            if settings.manaBar then
                createManaBars(v)
            end
        end)
    
        if v.Character then
            observeWatch(v)
        end
    end
end

Players.PlayerRemoving:Connect(function(player)
    table.remove(playerList, table.find(playerList, player))

    if settings.mod and player then
        local role = player:GetRoleInGroup(15131884)

        if not ignoreRoles[role] or mods[player.Name] then
            StarterGui:SetCore("SendNotification", {
                Title = role,
                Text = player.Name .. " left server",
                Duration = 10,
                Button1 = "Ignore",
                Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
            })
        end
    end

    if settings.clog then
        if player:FindFirstChild("Danger") or player:FindFirstChild("MortalDanger") then
            StarterGui:SetCore("SendNotification", {
                Title = player.Name,
                Text = "Combat logged",
                Duration = 10,
                Button1 = "Ignore",
                Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
            })
        end
    end

    if playerLabels[player] then
        playerLabels[player]:Destroy()
        playerLabels[player] = nil
        illuLabels[player] = nil
        modLabels[player] = nil
        updateLeaderboard()
    end
end)

Players.PlayerAdded:Connect(function(player)
    table.insert(playerList, player)

    if settings.mod then
        local role = player:GetRoleInGroup(15131884)

        if not ignoreRoles[role] or mods[player.Name] then
            StarterGui:SetCore("SendNotification", {
                Title = mods[player.Name] or role,
                Text = player.Name .. " joined server",
                Duration = 30,
                Button1 = "Ignore",
                Icon = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
            })
        end
    end

    player.Chatted:Connect(function(message)
        logChat(player, message)
    end)

    player.CharacterAdded:Connect(function()
        observeWatch(player)

        if settings.tool then
            makeIntent(player)
        end

        if settings.playerEsp then
            startEsp(player)
        end

        if settings.manaBar then
            createManaBars(player)
        end
    end)

    createLabel(player)
end)

localPlayer.Chatted:Connect(function(message)
    logChat(localPlayer, message)
end)

localPlayer.CharacterAdded:Connect(function(character)
    if spectating then
        spectating = false
    end

    if normalGui then
        normalGui:Destroy()
        normalGui = false
    end

    if snapGui then
        snapGui:Destroy()
        snapGui = false
    end

    local humanoid = character:WaitForChild("Humanoid")

    humanoid.AnimationPlayed:Connect(function(animation)
        if animation.Animation.AnimationId == "rbxassetid://9389354015" then
            localPlayer:Kick("Evaded Ban")
        end
    end)

    if getconnections(ScriptContext.Error)[1] then
        repeat task.wait() until getconnections(ScriptContext.Error)[errors + 1]

        for i, connection in pairs(getconnections(ScriptContext.Error)) do
            connection:Disable()
            errors = i
        end
    end

    humanoid.StateChanged:Connect(function(old, new)
        if new == Enum.HumanoidStateType.Swimming then
            inWater = true
        else
            inWater = false
        end
    end)

    makeBackpack()
end)

localPlayer.PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "LeaderboardGui" then
        child.Enabled = false
    end

    if child.Name == "BardGui" then
        child.ChildRemoved:Connect(function(button)
            if bardButtons[button] then
                bardButtons[button] = nil
            end
        end)
    end

    if child.Name == "BackpackGui" then
        child:Destroy()
    end
end)

if localPlayer.Character then
    local humanoid = localPlayer.Character:WaitForChild("Humanoid")

    humanoid.AnimationPlayed:Connect(function(animation)
        if animation.Animation.AnimationId == "rbxassetid://9389354015" then
            localPlayer:Kick("Evaded Ban")
        end
    end)

    if localPlayer.PlayerGui:FindFirstChild("BackpackGui") then
        localPlayer.PlayerGui.BackpackGui:Destroy()
    end

    makeBackpack()
end
