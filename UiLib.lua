local UiLibrary = {}
UiLibrary.__index = UiLibrary

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local guiAssets = game:GetObjects("rbxassetid://11260223308")[1]
local disabledColor = Color3.fromRGB(27, 27, 27)
local unhighlightColor = Color3.fromRGB(41, 41, 41)
local theme = Color3.new(1,1,1)
local sliders = {}
local toggles = {}
local colorPickerConnections = {}
local tempPickerConnections = {}
local currentColorPicker
local currentColorPickerButton
local justRebinded = false
local text = {}
local borders = {}
local hideBind = {[2] = Enum.KeyCode.End.Name}
local currentHighlight
local mainGui
local freeThread

local secondaryBinds = {
    [Enum.KeyCode.LeftControl.Name] = "LCtrl",
    [Enum.KeyCode.RightControl.Name] = "RCtrl",
    [Enum.KeyCode.LeftAlt.Name] = "LAlt",
    [Enum.KeyCode.RightAlt.Name] = "RAlt",
    [Enum.KeyCode.Tab.Name] = "Tab",
    [Enum.KeyCode.RightShift.Name] = "RShift"
}

local bindBlacklist = {
    [Enum.KeyCode.Slash.Name] = true,
    [Enum.KeyCode.A.Name] = true,
    [Enum.KeyCode.W.Name] = true,
    [Enum.KeyCode.S.Name] = true,
    [Enum.KeyCode.D.Name] = true,
    [Enum.KeyCode.LeftShift.Name] = true,
    [Enum.KeyCode.Backspace.Name] = true,
    [Enum.KeyCode.Space.Name] = true,
    [Enum.KeyCode.Unknown.Name] = true,
    [Enum.KeyCode.Backquote.Name] = true,
}

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

function UiLibrary.new(name: string)
    local secondaryDown = false
    mainGui = guiAssets.ScreenGui:Clone()
    mainGui.Frame.TopBar.GuiName.Text = name

    table.insert(borders, mainGui.Frame.Border)
    table.insert(borders, mainGui.Frame.Tabs.Border)
    table.insert(text, mainGui.Frame.TopBar.GuiName)

    if syn then
        syn.protect_gui(mainGui)
        mainGui.Parent = game.CoreGui
    elseif gethui then
        mainGui.Parent = gethui()
    else
        mainGui.Parent = game.CoreGui
    end

    mainGui.Frame.TopBar.MouseButton1Down:Connect(function(X, Y)
        local offset = {X - mainGui.Frame.AbsolutePosition.X, Y - mainGui.Frame.AbsolutePosition.Y}
        local anchorPoint = UDim2.new(0,  mainGui.Frame.Size.X.Offset * mainGui.Frame.AnchorPoint.X, 0, mainGui.Frame.Size.Y.Offset * mainGui.Frame.AnchorPoint.Y)
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
                mainGui.Frame.Position = UDim2.new(0, input.Position.X - offset[1], 0, input.Position.Y - offset[2] + 72) + anchorPoint
            end
        end)
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if justRebinded then
            justRebinded = false

            return
        end

        if not gameProcessed then
            if hideBind[1] then
                if input.KeyCode.Name == hideBind[1] then
                    secondaryDown = true
                end

                if input.KeyCode.Name == hideBind[2] and secondaryDown then
                    mainGui.Enabled = not mainGui.Enabled
                    
                    if currentHighlight then
                        currentHighlight.ImageColor3 = unhighlightColor
                        currentHighlight = false
                    end
                end
            else
                if input.KeyCode.Name == hideBind[2] then
                    mainGui.Enabled = not mainGui.Enabled

                    if currentHighlight then
                        currentHighlight.ImageColor3 = unhighlightColor
                        currentHighlight = false
                    end
                end
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode.Name == hideBind[1] then
            secondaryDown = false
        end
    end)

    return setmetatable({
        currentTab = false,
        borders = borders,
        tabCount = 0,
    }, UiLibrary)
end

function UiLibrary:RebindHide(keyCode: {secondaryKey: Enum.KeyCode, primaryKey: Enum.KeyCode})
    justRebinded = true
    hideBind = keyCode["2"] and {[2] = keyCode["2"]} or keyCode
end

function UiLibrary:ChangeTheme(newTheme: Color3)
    for i,v in ipairs(mainGui.Frame.Tabs.Holder:GetChildren()) do
        if v:IsA("TextButton") then
            if v.BackgroundColor3 == theme then
                v.BackgroundColor3 = newTheme
            else
                v.TextColor3 = newTheme
            end
        end
    end

    for i,v in ipairs(borders) do
        v.ImageColor3 = newTheme
    end

    for i,v in ipairs(text) do
        v.TextColor3 = newTheme
    end

    for i,v in pairs(sliders) do
        v.Frame.BackgroundColor3 = newTheme
        v.TextLabel.TextColor3 = newTheme
    end

    if currentColorPickerButton then
        currentColorPicker.Border.ImageColor3 = newTheme
        currentColorPicker.Slider.Border.ImageColor3 = newTheme
        currentColorPicker.Gradient.Border.ImageColor3 = newTheme
        currentColorPicker.Gradient.Cursor.Border.ImageColor3 = newTheme
        currentColorPicker.Frame.Button.PlaceholderColor3 = newTheme
        currentColorPicker.Frame.Button.TextColor3 = newTheme
        currentColorPickerButton.ImageButton.Border.ImageColor3 = newTheme
    end

    for i,v in pairs(toggles) do
        if v.ImageButton.BackgroundColor3 == theme then
            v.ImageButton.BackgroundColor3 = newTheme
        end
    end

    if currentHighlight then
        currentHighlight = newTheme
    end

    theme = newTheme
end

function UiLibrary.addBlacklist(keybinds)
    for i,v in pairs(keybinds) do
        bindBlacklist[v] = true
    end
end

local Tabs = {}
Tabs.__index = Tabs

function UiLibrary:CreateTab(name)
    local tab = guiAssets.Tab:Clone()
    local window = guiAssets.Window:Clone()

    self.tabCount += 1
    tab.Text = name
    tab.TextColor3 = theme
    tab.Parent = mainGui.Frame.Tabs.Holder
    window.Parent = mainGui.Frame.Windows

    for i,v in ipairs(mainGui.Frame.Tabs.Holder:GetChildren()) do
        if v:IsA("TextButton") then
            v.Size = UDim2.new(1 / self.tabCount, 0, 1, 0)
        end
    end

    if not self.currentTab then
        self.currentTab = tab
        tab.TextColor3 = disabledColor
        tab.BackgroundColor3 = theme
    else
        window.Visible = false
    end

    tab.MouseButton1Down:Connect(function()
        for i,v in ipairs(mainGui.Frame.Windows:GetChildren()) do
            v.Visible = false
        end

        self.currentTab.TextColor3 = theme
        self.currentTab.BackgroundColor3 = disabledColor
        self.currentTab = tab
        tab.TextColor3 = disabledColor
        tab.BackgroundColor3 = theme
        window.Visible = true
    end)

    return setmetatable({
        window = window
    }, Tabs)
end

local Section = {}
Section.__index = Section

local function getSide(window: ScrollingFrame, shortestSide: boolean)
    if window.Left.UIListLayout.AbsoluteContentSize.Y <= window.Right.UIListLayout.AbsoluteContentSize.Y then
        if shortestSide then
            return window.Right
        else
            return window.Left
        end
    else
        if shortestSide then
            return window.Left
        else
            return window.Right
        end
    end
end

local function updateSizes(section)
    section.Size = UDim2.new(1, 0, 0, section.Frame.Holder.UIListLayout.AbsoluteContentSize.Y + 17)
    section.Parent.Parent.CanvasSize = UDim2.new(0, 0, 0, getSide(section.Parent.Parent, true).UIListLayout.AbsoluteContentSize.Y + 10)
end

function Tabs:CreateSection(name)
    local section = guiAssets.Section:Clone()

    table.insert(text, section.Frame.NameGui.TextLabel)

    section.Parent = getSide(self.window, false)
    section.Frame.NameGui.TextLabel.Text = name
    section.Frame.NameGui.TextLabel.TextYAlignment = Enum.TextYAlignment.Top
    section.Frame.NameGui.TextLabel.TextColor3 = theme
    section.Frame.NameGui.Size = UDim2.new(0, section.Frame.NameGui.TextLabel.TextBounds.X + 6, 0, 20)
    section.Frame.Frame.Border.Size = UDim2.new(0, section.Frame.NameGui.TextLabel.TextBounds.X + 8, 0, 20)

    return setmetatable({
        section = section
    }, Section)
end

local ToggleElement = {}
ToggleElement.__index = ToggleElement

function Section:CreateToggle(config)
    --[[
        {
            name: string
            default: boolean?
            callbackOnCreation = false?
            callback = () -> ()
        }
    ]]
    local toggle = guiAssets.Toggle:Clone()
    local toggleTable = {
        toggle = toggle,
        boolean = config.default or false,
        callback = config.callback,
    }

    table.insert(toggles, toggle)
    table.insert(text, toggle.TextLabel)

    toggle.TextLabel.Text = config.name
    toggle.TextLabel.TextColor3 = theme
    toggle.ImageButton.BackgroundColor3 = self.boolean and theme or disabledColor
    toggle.Parent = self.section.Frame.Holder
    updateSizes(self.section)

    if config.default then
        toggle.ImageButton.BackgroundColor3 = theme
    end

    if (not config.callbackOnCreation and config.callbackOnCreation ~= false) or config.callbackOnCreation then
        spawnWithReuse(config.callback, toggleTable.boolean)
    end

    toggle.ImageButton.MouseButton1Down:Connect(function()
        toggleTable.boolean = not toggleTable.boolean
        toggle.ImageButton.BackgroundColor3 = toggleTable.boolean and theme or disabledColor
        toggleTable.callback(toggleTable.boolean)
    end)

    toggle.ImageButton.MouseEnter:Connect(function()
        if currentHighlight then
            currentHighlight.ImageColor3 = unhighlightColor
        end

        toggle.ImageButton.Border.ImageColor3 = theme
        currentHighlight = toggle.ImageButton.Border
    end)

    toggle.ImageButton.MouseLeave:Connect(function()
        toggle.ImageButton.Border.ImageColor3 = unhighlightColor
        currentHighlight = false
    end)

    return setmetatable(toggleTable, ToggleElement)
end

function ToggleElement:Set(boolean: boolean)
    self.boolean = boolean
    self.toggle.ImageButton.BackgroundColor3 = self.boolean and theme or disabledColor
    spawnWithReuse(self.callback, self.boolean)
end

local function makeBind(self)
    self.bindConnections[#self.bindConnections + 1] = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if not gameProcessedEvent then
            if self.bind[1] then
                if input.KeyCode.Name == self.bind[1] then
                    self.secondaryDown = true
                end

                if input.KeyCode.Name == self.bind[2] and self.secondaryDown then
                    if self.toggle then
                        self.boolean = not self.boolean
                        self.toggle.ImageButton.BackgroundColor3 = self.boolean and theme or disabledColor
                        self.callback(self.boolean)
                    else
                        if self.callback then
                            self.callback()
                        end
                    end
                end
            else
                if input.KeyCode.Name == self.bind[2] then
                    if self.toggle then
                        self.boolean = not self.boolean
                        self.toggle.ImageButton.BackgroundColor3 = self.boolean and theme or disabledColor
                        self.callback(self.boolean)
                    else
                        if self.callback then
                            self.callback()
                        end
                    end
                end
            end
        end
    end)

    self.bindConnections[#self.bindConnections + 1] = UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode.Name == self.bind[1] then
            self.secondaryDown = false
        end
    end)
end

local function makeKeybind(parent, self, config)
    local keybind = guiAssets.KeyBind:Clone()
    local getInputs
    self.bindConnections = {}
    self.secondaryDown = false
    self.bind = config.default and {config.default["1"], config.default["2"]} or {}

    keybind.Parent = parent

    if config.default then
        makeBind(self)

        if self.bind[2] or self.bind[1] then
            keybind.Button.Text = self.bind[1] and secondaryBinds[self.bind[1]] .. " + " .. self.bind[2] or self.bind[2]
        else
            keybind.Button.Text = "None"
        end
    end

    keybind.Button.MouseButton1Down:Connect(function()
        if not getInputs then
            self.bind = {}
            self.secondaryDown = false
            keybind.Button.Text = "..."

            for i,v in pairs(self.bindConnections) do
                v:Disconnect()
                self.bindConnections[i] = nil
            end
            
            getInputs = UserInputService.InputBegan:Connect(function(input, gameProccessed)
                if not gameProccessed then
                    if bindBlacklist[input.KeyCode.Name] then
                        return
                    end

                    if secondaryBinds[input.KeyCode.Name] then
                        self.bind[1] = input.KeyCode.Name
                        keybind.Button.Text = secondaryBinds[input.KeyCode.Name] .. " + ..."
                    else
                        self.bind[2] = input.KeyCode.Name
                    end

                    if self.bind[2] then
                        getInputs:Disconnect()
                        getInputs = false
                        keybind.Button.Text = self.bind[1] and secondaryBinds[self.bind[1]] .. " + " .. self.bind[2] or self.bind[2]

                        if config.callback then
                            config.callback(self.bind)
                        end

                        makeBind(self)
                    end

                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        self.bind = {}
                        getInputs:Disconnect()
                        getInputs = false
                        keybind.Button.Text = "None"

                        if config.callback then
                            config.callback({})
                        end
                    end
                end
            end)
        end
    end)

    keybind.Button.MouseButton2Down:Connect(function()
        keybind.Button.Text = "None"
        self.secondaryDown = false
        self.bind = {}

        for i,v in pairs(self.bindConnections) do
            v:Disconnect()
            self.bindConnections[i] = nil
        end

        if getInputs then
            getInputs:Disconnect()
            getInputs = false
        end

        config.callback(self.bind)
    end)
end

function ToggleElement:AddKeybind(config)
    --[[
        {
            default = {secondary bind, primary bind}
            callback = () -> ()?
        }
    ]]
    makeKeybind(self.toggle, self, config)
end

local function round(number, decimalPlaces)
    local power = math.pow(10, decimalPlaces)
    return math.round(number * power) / power
end

local function updateSliderSize(sliderbar, number, minMax)
    sliderbar.Frame.Size = UDim2.new((number - minMax[1]) / (minMax[2] - minMax[1]), 0, 1, 0)
    sliderbar.TextLabel.Text = number .. " / " .. minMax[2]
end

local function makeSlider(sliderBar, config)
    local minMax = {config.min, config.max}
    local value = config.default and math.clamp(config.default, minMax[1], minMax[2]) or minMax[1]
    local rounding = config.rounding or 0
    local sliding = false
    local endConnection
    local slidingConnection

    sliderBar.Frame.BackgroundColor3 = theme
    sliderBar.TextLabel.TextColor3 = theme

    updateSliderSize(sliderBar, value, minMax)
    table.insert(sliders, sliderBar)

    sliderBar.TextLabel.MouseButton1Down:Connect(function()
        sliding = true

        endConnection = UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseMovement then
                slidingConnection:Disconnect()
                endConnection:Disconnect()
                sliding = false

                if currentHighlight ~= sliderBar.Border then
                    sliderBar.Border.ImageColor3 = unhighlightColor
                end
            end
        end)

        slidingConnection = UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local precentage = math.clamp((input.Position.X - sliderBar.Frame.AbsolutePosition.X) / sliderBar.TextLabel.AbsoluteSize.X, 0, 1)
                local previousValue = value
                local newValue = precentage * (minMax[2] - minMax[1]) + minMax[1]
                value = rounding > 1 and round(newValue, rounding) or math.floor(newValue + .5)

                if value ~= previousValue then
                    updateSliderSize(sliderBar, value, minMax)
                    config.callback(value)
                end
            end
        end)
    end)

    sliderBar.TextLabel.MouseEnter:Connect(function()
        if currentHighlight then
            currentHighlight.ImageColor3 = unhighlightColor
        end
        
        sliderBar.Border.ImageColor3 = theme
        currentHighlight = sliderBar.Border
    end)

    sliderBar.TextLabel.MouseLeave:Connect(function()
        currentHighlight = false

        if not sliding then
            sliderBar.Border.ImageColor3 = unhighlightColor
        end
    end)
end



function ToggleElement:AddSlider(config)
    --[[
        {
            min: number
            max: number
            default: number?
            rounding: number?
            callback: number
        }
    ]]
    local slider = guiAssets.SliderElement:Clone()

    self.toggle.Size = UDim2.new(1, 0, 0, 40)
    slider.Parent = self.toggle
    updateSizes(self.toggle.Parent.Parent.Parent)
    makeSlider(slider, config)
end

function Section:CreateSlider(config)
    --[[
        {   
            name: string
            min: number
            max: number
            default: number?
            rounding: number?
        }
    ]]
    local slider = guiAssets.Slider:Clone()
    local sliderElement = guiAssets.SliderElement:Clone()

    slider.TextLabel.Text = config.name
    slider.TextLabel.Size = UDim2.new(1, -15, 0, 15)
    sliderElement.Parent = slider
    slider.Parent = self.section.Frame.Holder
    table.insert(text, slider.TextLabel)
    updateSizes(self.section)
    makeSlider(sliderElement, config)
end

function Section:CreateButton(config)
    --[[
        {
            name: string
            callback: () -> ()
        }
    ]]

    local button = guiAssets.Button:Clone()

    button.ImageButton.Text = config.name
    button.ImageButton.TextColor3 = theme
    button.Parent = self.section.Frame.Holder
    updateSizes(self.section)
    table.insert(text, button.ImageButton)

    button.ImageButton.MouseButton1Down:Connect(function()
        button.ImageButton.TextColor3 = disabledColor
        button.ImageButton.TextStrokeTransparency = 1
        button.ImageButton.BackgroundColor3 = theme
        config.callback()
    end)

    button.ImageButton.MouseButton1Up:Connect(function()
        button.ImageButton.TextColor3 = theme
        button.ImageButton.TextStrokeTransparency = 0
        button.ImageButton.BackgroundColor3 = disabledColor
    end)

    button.ImageButton.MouseEnter:Connect(function()
        button.ImageButton.Border.ImageColor3 = theme
    end)

    button.ImageButton.MouseLeave:Connect(function()
        button.ImageButton.TextColor3 = theme
        button.ImageButton.TextStrokeTransparency = 0
        button.ImageButton.BackgroundColor3 = disabledColor
        button.ImageButton.Border.ImageColor3 = unhighlightColor
    end)
end

local function updatePicker(button, h, s, v)
    local newColor = Color3.fromHSV(h, s, v)
    
    button.ImageButton.BackgroundColor3 = newColor
    if currentColorPickerButton == button then
        currentColorPicker.Frame.Button.PlaceholderText = math.floor(newColor.R * 255)..", "..math.floor(newColor.G * 255)..", "..math.floor(newColor.B * 255)
        currentColorPicker.Gradient.Cursor.Position = UDim2.new(math.clamp(s, 0, 1), 0, math.clamp(1 - v, 0, 1), 0)
        currentColorPicker.Gradient.UIGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV(h, 1, 1))
        }
    end
end

function Section:CreateColorPicker(config)
    --[[
        {
            name: string
            default: Color3?
            resetColor: Color3?
            callbackOnCreation: boolean?
            callback: () -> ()
        }
    ]]
    local colorPicker = guiAssets.ColorPickerButton:Clone()
    local default = config.default or Color3.new(1, 1, 1)
    local hue, saturation, value = default:ToHSV()

    colorPicker.TextLabel.Text = config.name
    colorPicker.ImageButton.BackgroundColor3 = default
    colorPicker.Parent = self.section.Frame.Holder
    updateSizes(self.section)
    table.insert(text, colorPicker.TextLabel)

    if (not config.callbackOnCreation and config.callbackOnCreation ~= false) or config.callbackOnCreation then
        spawnWithReuse(config.callback, default)
    end

    colorPicker.ImageButton.MouseEnter:Connect(function()
        colorPicker.ImageButton.Border.ImageColor3 = theme
    end)

    colorPicker.ImageButton.MouseLeave:Connect(function()
        if currentColorPickerButton ~= colorPicker then
            colorPicker.ImageButton.Border.ImageColor3 = disabledColor
        end
    end)

    if config.resetColor then
        colorPicker.ImageButton.MouseButton2Down:Connect(function()
            local h, s, v = config.resetColor:ToHSV()

            hue = h
            saturation = s
            value = v
            updatePicker(colorPicker, hue, saturation, value)
            config.callback(config.resetColor)
        end)
    end

    colorPicker.ImageButton.MouseButton1Down:Connect(function()
        if currentColorPickerButton == colorPicker then
            for i,v in pairs(colorPickerConnections) do
                v:Disconnect()
                colorPickerConnections[i] = nil
            end
            
            currentColorPickerButton.ImageButton.Border.ImageColor3 = disabledColor
            currentColorPickerButton = nil
            currentColorPicker:Destroy()
            return
        end

        if currentColorPickerButton then
            for i,v in pairs(colorPickerConnections) do
                v:Disconnect()
                colorPickerConnections[i] = nil
            end

            currentColorPickerButton.ImageButton.Border.ImageColor3 = disabledColor
            updatePicker(colorPicker, hue, saturation, value)
        else
            currentColorPickerButton = colorPicker
            currentColorPicker = guiAssets.ColorPicker:Clone()
            currentColorPicker.Position = UDim2.new(0, colorPicker.ImageButton.AbsolutePosition.X, 0, colorPicker.ImageButton.AbsolutePosition.Y + 65)
            currentColorPicker.Border.ImageColor3 = theme
            currentColorPicker.Slider.Border.ImageColor3 = theme
            currentColorPicker.Gradient.Border.ImageColor3 = theme
            currentColorPicker.Gradient.Cursor.Border.ImageColor3 = theme
            currentColorPicker.Frame.Button.PlaceholderColor3 = theme
            currentColorPicker.Frame.Button.TextColor3 = theme
            updatePicker(colorPicker, hue, saturation, value)
            currentColorPicker.Visible = true

            currentColorPicker.Parent = mainGui
        end

        colorPickerConnections[#colorPickerConnections + 1] = RunService.Heartbeat:Connect(function()
            currentColorPicker.Position = UDim2.new(0, colorPicker.ImageButton.AbsolutePosition.X, 0, colorPicker.ImageButton.AbsolutePosition.Y + 65)
        end)

        colorPickerConnections[#colorPickerConnections + 1] = UserInputService.InputEnded:Connect(function(inputObject)
            if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.MouseMovement then
                for i, v in pairs(tempPickerConnections) do
                    v:Disconnect()
                    tempPickerConnections[i] = nil
                end
            end
        end)

        colorPickerConnections[#colorPickerConnections + 1] = currentColorPicker.Slider.MouseButton1Down:Connect(function(X, Y)
            hue = math.clamp((X - currentColorPicker.Slider.AbsolutePosition.X) / currentColorPicker.Slider.AbsoluteSize.X, 0, 1)
            updatePicker(colorPicker, hue, saturation, value)
            config.callback(Color3.fromHSV(hue, saturation, value))

            tempPickerConnections[#tempPickerConnections + 1] = UserInputService.InputChanged:Connect(function(inputObject)
                if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
                    hue = math.clamp((inputObject.Position.X - currentColorPicker.Slider.AbsolutePosition.X) / currentColorPicker.Slider.AbsoluteSize.X, 0, 1)
                    updatePicker(colorPicker, hue, saturation, value)
                    config.callback(Color3.fromHSV(hue, saturation, value))
                end
            end)
        end)

        colorPickerConnections[#colorPickerConnections + 1] = currentColorPicker.Gradient.TextButton.MouseButton1Down:Connect(function(X, Y)
            local absoluteSize = currentColorPicker.Gradient.TextButton.AbsoluteSize
            local absolutePosition = currentColorPicker.Gradient.TextButton.AbsolutePosition

            saturation = math.clamp((X - absolutePosition.X) / absoluteSize.X, 0, 1)
            value = 1 - math.clamp(((Y - 36) - absolutePosition.Y) / absoluteSize.Y, 0, 1)
            updatePicker(colorPicker, hue, saturation, value)
            config.callback(Color3.fromHSV(hue, saturation, value))

            tempPickerConnections[#tempPickerConnections + 1] = UserInputService.InputChanged:Connect(function(inputObject)
                if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
                    saturation = math.clamp((inputObject.Position.X - absolutePosition.X) / absoluteSize.X, 0, 1)
                    value = 1 - math.clamp((inputObject.Position.Y - absolutePosition.Y) / absoluteSize.Y, 0, 1)
                    updatePicker(colorPicker, hue, saturation, value)
                    config.callback(Color3.fromHSV(hue, saturation, value))
                end
            end)
        end)

        colorPickerConnections[#colorPickerConnections + 1] = currentColorPicker.Frame.Button.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local color = string.split(string.gsub(currentColorPicker.Frame.Button.Text, " ", ""), ",")
                local h, s, v = Color3.fromRGB(color[1], color[2], color[3]):ToHSV()

                hue = h
                saturation = s
                value = v
                updatePicker(colorPicker, hue, saturation, value)
                config.callback(Color3.fromHSV(hue, saturation, value))
            end

            currentColorPicker.Frame.Button.Text = ""
        end)
    end)
end

local TextElement = {}
TextElement.__index = TextElement

function Section:CreateText(name)
    local textLabel = guiAssets.Slider:Clone()

    textLabel.TextLabel.Text = name
    textLabel.TextLabel.Size = UDim2.new(1, -15, 1, 0)
    textLabel.Size = UDim2.new(1, 0, 0, 20)
    textLabel.Parent = self.section.Frame.Holder
    table.insert(text, textLabel.TextLabel)
    updateSizes(self.section)

    return setmetatable({
        textLabel = textLabel
    }, TextElement)
end

function TextElement:AddKeybind(config)
    --[[
        {
            default = {secondary bind, primary bind}
            callback = () -> ()?
            keyPressed = () -> ()
        }
    ]]

    self.callback = config.keyPressed
    makeKeybind(self.textLabel, self, config)
end
