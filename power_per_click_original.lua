local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local clickTrain = false
local autoRebirth = false
-- Remove old GUI
local oldGui = CoreGui:FindFirstChild("CustomPanel")
if oldGui then
    oldGui:Destroy()
end

-- =========================================
-- SETTINGS
-- =========================================

local ACCENT = Color3.fromRGB(110, 80, 255)
local BG = Color3.fromRGB(15, 15, 20)
local BUTTON_BG = Color3.fromRGB(25, 25, 32)
local BUTTON_HOVER = Color3.fromRGB(38, 38, 48)

-- =========================================
-- GUI
-- =========================================

local gui = Instance.new("ScreenGui")
gui.Name = "CustomPanel"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = CoreGui

-- Shadow
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(0, 324, 0, 424)
shadow.Position = UDim2.new(0, 493, 0.5, -207)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.45
shadow.BorderSizePixel = 0
shadow.ZIndex = 0
shadow.Parent = gui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 18)
shadowCorner.Parent = shadow

-- Main window
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 310, 0, 410)
main.Position = UDim2.new(0, 500, 0.5, -205)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.ZIndex = 2
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(70, 70, 85)
mainStroke.Thickness = 1
mainStroke.Transparency = 0.35
mainStroke.Parent = main

-- Background gradient
local gradient = Instance.new("UIGradient")
gradient.Rotation = 90
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 24, 31)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(16, 16, 21)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 16))
})
gradient.Parent = main

-- =========================================
-- HEADER
-- =========================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 82)
header.BackgroundTransparency = 1
header.ZIndex = 3
header.Parent = main

-- Accent line
local accent = Instance.new("Frame")
accent.Size = UDim2.new(0, 4, 0, 42)
accent.Position = UDim2.new(0, 16, 0, 18)
accent.BackgroundColor3 = ACCENT
accent.BorderSizePixel = 0
accent.ZIndex = 4
accent.Parent = header

local accentCorner = Instance.new("UICorner")
accentCorner.CornerRadius = UDim.new(1, 0)
accentCorner.Parent = accent

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 28)
title.Position = UDim2.new(0, 31, 0, 13)
title.BackgroundTransparency = 1
title.Text = "+1 POWER PER CLICK"
title.TextColor3 = Color3.fromRGB(245, 245, 250)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 4
title.Parent = header

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -60, 0, 18)
subtitle.Position = UDim2.new(0, 31, 0, 42)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Menu  •  Press K to toggle"
subtitle.TextColor3 = Color3.fromRGB(125, 125, 140)
subtitle.TextSize = 11
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.ZIndex = 4
subtitle.Parent = header

-- Status indicator
local statusDot = Instance.new("Frame")
statusDot.Size = UDim2.new(0, 7, 0, 7)
statusDot.Position = UDim2.new(1, -28, 0, 22)
statusDot.BackgroundColor3 = Color3.fromRGB(80, 220, 140)
statusDot.BorderSizePixel = 0
statusDot.ZIndex = 4
statusDot.Parent = header

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = statusDot

-- Divider
local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -32, 0, 1)
divider.Position = UDim2.new(0, 16, 0, 81)
divider.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
divider.BackgroundTransparency = 0.25
divider.BorderSizePixel = 0
divider.ZIndex = 4
divider.Parent = main

-- =========================================
-- BUTTON CONTAINER
-- =========================================

local container = Instance.new("Frame")
container.Size = UDim2.new(1, -32, 1, -105)
container.Position = UDim2.new(0, 16, 0, 97)
container.BackgroundTransparency = 1
container.ZIndex = 3
container.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 9)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = container

-- =========================================
-- BUTTON CREATOR
-- =========================================

local function createButton(text, icon, callback)

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 44)
    button.BackgroundColor3 = BUTTON_BG
    button.BorderSizePixel = 0
    button.Text = ""
    button.AutoButtonColor = false
    button.ZIndex = 4
    button.Parent = container

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(55, 55, 68)
    stroke.Thickness = 1
    stroke.Transparency = 0.35
    stroke.Parent = button

    -- Icon
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 38, 1, 0)
    iconLabel.Position = UDim2.new(0, 7, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(175, 175, 190)
    iconLabel.TextSize = 17
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.ZIndex = 5
    iconLabel.Parent = button

    -- Text
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -125, 1, 0)
    label.Position = UDim2.new(0, 48, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(225, 225, 232)
    label.TextSize = 13
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    label.Parent = button

    -- =========================================
    -- MINI SWITCH
    -- =========================================

    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 42, 0, 22)
    toggle.Position = UDim2.new(1, -55, 0.5, -11)
    toggle.BackgroundColor3 = Color3.fromRGB(48, 48, 58)
    toggle.BorderSizePixel = 0
    toggle.ZIndex = 6
    toggle.Parent = button

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggle

    -- Toggle knob
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 3, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(145, 145, 155)
    knob.BorderSizePixel = 0
    knob.ZIndex = 7
    knob.Parent = toggle

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local enabled = false

    -- =========================================
    -- UPDATE SWITCH
    -- =========================================

    local function updateToggle()

        if enabled then

            TweenService:Create(
                toggle,
                TweenInfo.new(0.15),
                {
                    BackgroundColor3 = ACCENT
                }
            ):Play()

            TweenService:Create(
                knob,
                TweenInfo.new(0.15),
                {
                    Position = UDim2.new(1, -19, 0.5, -8),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                }
            ):Play()

            TweenService:Create(
                iconLabel,
                TweenInfo.new(0.15),
                {
                    TextColor3 = ACCENT
                }
            ):Play()

        else

            TweenService:Create(
                toggle,
                TweenInfo.new(0.15),
                {
                    BackgroundColor3 = Color3.fromRGB(48, 48, 58)
                }
            ):Play()

            TweenService:Create(
                knob,
                TweenInfo.new(0.15),
                {
                    Position = UDim2.new(0, 3, 0.5, -8),
                    BackgroundColor3 = Color3.fromRGB(145, 145, 155)
                }
            ):Play()

            TweenService:Create(
                iconLabel,
                TweenInfo.new(0.15),
                {
                    TextColor3 = Color3.fromRGB(175, 175, 190)
                }
            ):Play()
        end
    end

    -- =========================================
    -- CLICK ENTIRE BUTTON
    -- =========================================

    button.MouseButton1Click:Connect(function()

        enabled = not enabled

        updateToggle()

        -- Pass ON/OFF state to your function
        callback(enabled)
    end)

    -- =========================================
    -- HOVER
    -- =========================================

    button.MouseEnter:Connect(function()

        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = BUTTON_HOVER
            }
        ):Play()

        TweenService:Create(
            stroke,
            TweenInfo.new(0.15),
            {
                Color = ACCENT,
                Transparency = 0.15
            }
        ):Play()
    end)

    button.MouseLeave:Connect(function()

        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = BUTTON_BG
            }
        ):Play()

        TweenService:Create(
            stroke,
            TweenInfo.new(0.15),
            {
                Color = Color3.fromRGB(55, 55, 68),
                Transparency = 0.35
            }
        ):Play()
    end)

    return button
end

-- =========================================
-- BUTTONS
-- =========================================

createButton("Click Train", "⚡", function(enabled)

    clickTrain = enabled

    if enabled then
        print("Click Train ON")
    else
        print("Click Train OFF")
    end

end)

createButton("Auto Rebirth", "⭐", function(enabled)
    autoRebirth = enabled

    if enabled then
        print("Auto Rebirth ON")
    else
        print("Auto Rebirth OFF")
    end

end)

-- =========================================
-- Functions
-- =========================================

-- CLICK TRAIN

task.spawn(function()
    while true do
        if clickTrain then
            game:GetService("ReplicatedStorage").ClickTrainEvent:FireServer()
        end

        task.wait(0.1)
    end
end)

-- AUTO REBIRTH

task.spawn(function()
    while true do
        if autoRebirth then
            game:GetService("ReplicatedStorage").RebirthFunction:InvokeServer("Rebirth")
        end

        task.wait(1)
    end
end)

-- =========================================
-- K = HIDE / SHOW
-- =========================================

UserInputService.InputBegan:Connect(function(input, processed)

    if processed then
        return
    end

    if input.KeyCode == Enum.KeyCode.K then
        main.Visible = not main.Visible
        shadow.Visible = main.Visible
    end
end)

-- =========================================
-- DRAG GUI
-- =========================================

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

header.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

        local delta = input.Position - dragStart

        local newPosition = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )

        main.Position = newPosition

        shadow.Position = UDim2.new(
            newPosition.X.Scale,
            newPosition.X.Offset - 7,
            newPosition.Y.Scale,
            newPosition.Y.Offset - 7
        )
    end
end)