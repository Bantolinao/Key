-- Simple UI Library
local random = math.random
local time = tick
local wait = task.wait

local function createRandomName()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local result = ""
    for i = 1, 8 do
        result = result .. chars:sub(random(1, #chars), random(1, #chars))
    end
    return result
end

local Library = {}
Library.__index = Library

local services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    UserInputService = game:GetService("UserInputService"),
    TweenService = game:GetService("TweenService")
}

local defaultColors = {
    Background = Color3.fromRGB(25, 25, 25),
    Foreground = Color3.fromRGB(35, 35, 35),
    Accent = Color3.fromRGB(0, 120, 215),
    Text = Color3.fromRGB(255, 255, 255),
    Border = Color3.fromRGB(60, 60, 60)
}

function Library.new(options)
    options = options or {}
    local self = setmetatable({}, Library)

    self.Title = options.Title or "UI"
    self.SubTitle = options.SubTitle or ""
    self.Size = options.Size or UDim2.new(0, 400, 0, 300)
    self.Theme = options.Theme or defaultColors
    self.MinimizeKey = options.MinimizeKey or Enum.KeyCode.RightShift

    self.Container = Instance.new("ScreenGui")
    self.Container.Name = createRandomName()
    self.Container.ResetOnSpawn = false
    self.Container.IgnoreGuiInset = true
    self.Container.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.Container.Parent = services.Players.LocalPlayer:WaitForChild("PlayerGui")

    self.Main = Instance.new("Frame")
    self.Main.Name = createRandomName()
    self.Main.Size = self.Size
    self.Main.Position = UDim2.new(0.5, -self.Size.X.Offset/2, 0.5, -self.Size.Y.Offset/2)
    self.Main.BackgroundColor3 = self.Theme.Background
    self.Main.BorderSizePixel = 0
    self.Main.Parent = self.Container

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.Main

    self.Header = Instance.new("Frame")
    self.Header.Name = createRandomName()
    self.Header.Size = UDim2.new(1, 0, 0, 40)
    self.Header.Position = UDim2.new(0, 0, 0, 0)
    self.Header.BackgroundColor3 = self.Theme.Foreground
    self.Header.BorderSizePixel = 0
    self.Header.Parent = self.Main

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 8)
    headerCorner.Parent = self.Header

    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = createRandomName()
    self.TitleLabel.Size = UDim2.new(1, -20, 1, 0)
    self.TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Title .. (self.SubTitle ~= "" and " | " .. self.SubTitle or "")
    self.TitleLabel.TextColor3 = self.Theme.Text
    self.TitleLabel.TextScaled = true
    self.TitleLabel.Font = Enum.Font.GothamBold
    self.TitleLabel.Parent = self.Header

    self.Content = Instance.new("Frame")
    self.Content.Name = createRandomName()
    self.Content.Size = UDim2.new(1, 0, 1, -40)
    self.Content.Position = UDim2.new(0, 0, 0, 40)
    self.Content.BackgroundColor3 = Color3.new(1, 1, 1)
    self.Content.BackgroundTransparency = 1
    self.Content.BorderSizePixel = 0
    self.Content.Parent = self.Main

    self.Tabs = {}
    self:MakeDraggable()
    self:AddMinimizeButton()

    return self
end

function Library:MakeDraggable()
    local dragging = false
    local dragStart, startPos

    self.Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.Main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    self.Header.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            self.Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

function Library:AddMinimizeButton()
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = createRandomName()
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
    minimizeBtn.BackgroundColor3 = Color3.new(1, 1, 1)
    minimizeBtn.BackgroundTransparency = 1
    minimizeBtn.Text = "-"
    minimizeBtn.TextColor3 = self.Theme.Text
    minimizeBtn.TextScaled = true
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Parent = self.Header

    minimizeBtn.MouseButton1Click:Connect(function()
        self.Main.Enabled = not self.Main.Enabled
    end)

    services.UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == self.MinimizeKey then
            self.Main.Enabled = not self.Main.Enabled
        end
    end)
end

function Library:AddTab(options)
    options = options or {}

    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = createRandomName()
    tabBtn.Size = UDim2.new(0, 100, 0, 30)
    tabBtn.Position = UDim2.new(0, #self.Tabs * 105, 0, 5)
    tabBtn.BackgroundColor3 = Color3.new(1, 1, 1)
    tabBtn.BackgroundTransparency = 1
    tabBtn.Text = options.Title or "Tab"
    tabBtn.TextColor3 = self.Theme.Text
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.Parent = self.Header

    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = createRandomName()
    tabContent.Size = UDim2.new(1, -20, 1, -10)
    tabContent.Position = UDim2.new(0, 10, 0, 5)
    tabContent.BackgroundColor3 = Color3.new(1, 1, 1)
    tabContent.BackgroundTransparency = 1
    tabContent.BorderSizePixel = 0
    tabContent.Visible = false
    tabContent.ScrollBarThickness = 6
    tabContent.Parent = self.Content

    tabBtn.MouseButton1Click:Connect(function()
        for _, tab in pairs(self.Tabs) do
            tab.Content.Visible = false
            tab.Button.TextColor3 = self.Theme.Text
        end
        tabContent.Visible = true
        tabBtn.TextColor3 = self.Theme.Accent
    end)

    local tab = {
        Button = tabBtn,
        Content = tabContent
    }

    table.insert(self.Tabs, tab)

    if #self.Tabs == 1 then
        tabContent.Visible = true
        tabBtn.TextColor3 = self.Theme.Accent
    end

    return tab
end

function Library:AddButton(tab, options)
    options = options or {}

    local button = Instance.new("TextButton")
    button.Name = createRandomName()
    button.Size = UDim2.new(1, 0, 0, 35)
    button.Position = UDim2.new(0, 0, 0, #tab.Content:GetChildren() * 40)
    button.BackgroundColor3 = self.Theme.Foreground
    button.BorderSizePixel = 0
    button.Text = options.Title or "Button"
    button.TextColor3 = self.Theme.Text
    button.Font = Enum.Font.Gotham
    button.Parent = tab.Content

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = self.Theme.Accent
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = self.Theme.Foreground
    end)

    if options.Callback then
        button.MouseButton1Click:Connect(options.Callback)
    end

    return button
end

function Library:AddSlider(tab, options)
    options = options or {}

    local container = Instance.new("Frame")
    container.Name = createRandomName()
    container.Size = UDim2.new(1, 0, 0, 50)
    container.Position = UDim2.new(0, 0, 0, #tab.Content:GetChildren() * 55)
    container.BackgroundColor3 = Color3.new(1, 1, 1)
    container.BackgroundTransparency = 1
    container.Parent = tab.Content

    local label = Instance.new("TextLabel")
    label.Name = createRandomName()
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = options.Title or "Slider"
    label.TextColor3 = self.Theme.Text
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local slider = Instance.new("Frame")
    slider.Name = createRandomName()
    slider.Size = UDim2.new(1, 0, 0, 20)
    slider.Position = UDim2.new(0, 0, 0, 25)
    slider.BackgroundColor3 = self.Theme.Border
    slider.BorderSizePixel = 0
    slider.Parent = container

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 10)
    sliderCorner.Parent = slider

    local fill = Instance.new("Frame")
    fill.Name = createRandomName()
    fill.Size = UDim2.new((options.Default or 0) / (options.Max or 100), 0, 1, 0)
    fill.Position = UDim2.new(0, 0, 0, 0)
    fill.BackgroundColor3 = self.Theme.Accent
    fill.BorderSizePixel = 0
    fill.Parent = slider

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 10)
    fillCorner.Parent = fill

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = createRandomName()
    valueLabel.Size = UDim2.new(0, 50, 1, 0)
    valueLabel.Position = UDim2.new(1, -50, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(options.Default or 0)
    valueLabel.TextColor3 = self.Theme.Text
    valueLabel.TextScaled = true
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.Parent = container

    local sliding = false
    local value = options.Default or 0

    local function updateValue(newValue)
        value = math.clamp(newValue, options.Min or 0, options.Max or 100)
        local percentage = (value - (options.Min or 0)) / ((options.Max or 100) - (options.Min or 0))
        fill.Size = UDim2.new(percentage, 0, 1, 0)
        valueLabel.Text = tostring(math.round(value))

        if options.Callback then
            options.Callback(value)
        end
    end

    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = true
        end
    end)

    slider.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = false
        end
    end)

    services.UserInputService.InputChanged:Connect(function(input)
        if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relativeX = input.Position.X - slider.AbsolutePosition.X
            local percentage = math.clamp(relativeX / slider.AbsoluteSize.X, 0, 1)
            updateValue((options.Min or 0) + percentage * ((options.Max or 100) - (options.Min or 0)))
        end
    end)

    return container
end

function Library:AddDropdown(tab, options)
    options = options or {}

    local container = Instance.new("Frame")
    container.Name = createRandomName()
    container.Size = UDim2.new(1, 0, 0, 40)
    container.Position = UDim2.new(0, 0, 0, #tab.Content:GetChildren() * 45)
    container.BackgroundColor3 = self.Theme.Foreground
    container.BorderSizePixel = 0
    container.Parent = tab.Content

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = container

    local button = Instance.new("TextButton")
    button.Name = createRandomName()
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundColor3 = Color3.new(1, 1, 1)
    button.BackgroundTransparency = 1
    button.Text = options.Title or "Dropdown"
    button.TextColor3 = self.Theme.Text
    button.Font = Enum.Font.Gotham
    button.Parent = container

    local selectedValue = options.Default or options.Values[1]

    button.MouseButton1Click:Connect(function()
        -- Simple dropdown toggle logic
        button.Text = options.Values[math.random(1, #options.Values)]
        if options.Callback then
            options.Callback(button.Text)
        end
    end)

    return container
end

function Library:Destroy()
    if self.Container then
        self.Container:Destroy()
    end
end

getgenv().Fluent = Library
return Library
