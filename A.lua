local function generateRandomId()
    return tostring(math.random(1000000, 9999999))
end

local function createGradient(parent, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = rotation or 90
    gradient.Parent = parent

    local colorSequence = ColorSequence.new(colors[1], colors[2])
    gradient.Color = colorSequence

    return gradient
end

local function createShadow(parent, offset, transparency)
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.fromOffset(offset, offset)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = transparency or 0.9
    shadow.BorderSizePixel = 0
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent.Parent

    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 15)
    shadowCorner.Parent = shadow

    return shadow
end

local function createSimpleUI()
    local ui = {}

    function ui:CreateWindow(config)
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = config.Title or "UIWindow"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "MainFrame"
        mainFrame.Size = config.Size or UDim2.fromOffset(450, 500)
        mainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
        mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        mainFrame.BorderSizePixel = 0
        mainFrame.Parent = screenGui

        createGradient(mainFrame, {
            Color3.fromRGB(25, 25, 35),
            Color3.fromRGB(40, 40, 60)
        }, 135)

        createShadow(mainFrame, 4, 0.8)

        local mainCorner = Instance.new("UICorner")
        mainCorner.CornerRadius = UDim.new(0, 12)
        mainCorner.Parent = mainFrame

        local mainStroke = Instance.new("UIStroke")
        mainStroke.Thickness = 1
        mainStroke.Color = Color3.fromRGB(100, 150, 255)
        mainStroke.Transparency = 0.8
        mainStroke.Parent = mainFrame

        local titleBar = Instance.new("Frame")
        titleBar.Name = "TitleBar"
        titleBar.Size = UDim2.new(1, 0, 0, 45)
        titleBar.Position = UDim2.fromOffset(0, 0)
        titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        titleBar.BorderSizePixel = 0
        titleBar.Parent = mainFrame

        createGradient(titleBar, {
            Color3.fromRGB(30, 30, 45),
            Color3.fromRGB(50, 50, 70)
        }, 135)

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "TitleLabel"
        titleLabel.Size = UDim2.new(1, -60, 1, 0)
        titleLabel.Position = UDim2.fromOffset(15, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = config.Title or "Window"
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextSize = 16
        titleLabel.Font = Enum.Font.SourceSansBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.TextYAlignment = Enum.TextYAlignment.Center
        titleLabel.Parent = titleBar

        local closeButton = Instance.new("TextButton")
        closeButton.Name = "CloseButton"
        closeButton.Size = UDim2.fromOffset(30, 30)
        closeButton.Position = UDim2.new(1, -35, 0.5, -15)
        closeButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
        closeButton.BorderSizePixel = 0
        closeButton.Text = "✕"
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.TextSize = 14
        closeButton.Font = Enum.Font.SourceSansBold
        closeButton.Parent = titleBar

        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 6)
        closeCorner.Parent = closeButton

        local tabContainer = Instance.new("Frame")
        tabContainer.Name = "TabContainer"
        tabContainer.Size = UDim2.new(1, 0, 0, 50)
        tabContainer.Position = UDim2.fromOffset(0, 45)
        tabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        tabContainer.BorderSizePixel = 0
        tabContainer.Parent = mainFrame

        createGradient(tabContainer, {
            Color3.fromRGB(35, 35, 50),
            Color3.fromRGB(55, 55, 75)
        }, 135)

        local contentArea = Instance.new("Frame")
        contentArea.Name = "ContentArea"
        contentArea.Size = UDim2.new(1, -20, 1, -115)
        contentArea.Position = UDim2.fromOffset(10, 105)
        contentArea.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        contentArea.BorderSizePixel = 0
        contentArea.Parent = mainFrame

        createGradient(contentArea, {
            Color3.fromRGB(20, 20, 30),
            Color3.fromRGB(35, 35, 50)
        }, 135)

        local contentCorner = Instance.new("UICorner")
        contentCorner.CornerRadius = UDim.new(0, 8)
        contentCorner.Parent = contentArea

        local contentStroke = Instance.new("UIStroke")
        contentStroke.Thickness = 0.5
        contentStroke.Color = Color3.fromRGB(80, 120, 200)
        contentStroke.Transparency = 0.9
        contentStroke.Parent = contentArea

        local scrollingFrame = Instance.new("ScrollingFrame")
        scrollingFrame.Name = "ScrollingFrame"
        scrollingFrame.Size = UDim2.new(1, -10, 1, -10)
        scrollingFrame.Position = UDim2.fromOffset(5, 5)
        scrollingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        scrollingFrame.BorderSizePixel = 0
        scrollingFrame.ScrollBarThickness = 6
        scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
        scrollingFrame.Parent = contentArea

        local window = {
            ScreenGui = screenGui,
            MainFrame = mainFrame,
            TitleBar = titleBar,
            TabContainer = tabContainer,
            ContentArea = contentArea,
            ScrollingFrame = scrollingFrame,
            Title = config.Title or "Window",
            Size = config.Size or UDim2.fromOffset(450, 500),
            Theme = config.Theme or "Dark",
            Tabs = {},
            SelectedTab = 1
        }

        function window:AddTab(tabConfig)
            local tabButton = Instance.new("TextButton")
            tabButton.Name = "TabButton_" .. #window.Tabs + 1
            tabButton.Size = UDim2.new(0, 100, 0, 35)
            tabButton.Position = UDim2.fromOffset(10 + (#window.Tabs * 110), 7.5)
            tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            tabButton.BorderSizePixel = 0
            tabButton.Text = tabConfig.Title or "Tab"
            tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            tabButton.TextSize = 12
            tabButton.Font = Enum.Font.SourceSans
            tabButton.Parent = tabContainer

            createGradient(tabButton, {
                Color3.fromRGB(50, 50, 70),
                Color3.fromRGB(70, 70, 90)
            }, 135)

            local tabCorner = Instance.new("UICorner")
            tabCorner.CornerRadius = UDim.new(0, 6)
            tabCorner.Parent = tabButton

            local tabContent = Instance.new("Frame")
            tabContent.Name = "TabContent_" .. #window.Tabs + 1
            tabContent.Size = UDim2.new(1, 0, 1, 0)
            tabContent.Position = UDim2.fromOffset(0, 0)
            tabContent.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
            tabContent.BackgroundTransparency = 1
            tabContent.BorderSizePixel = 0
            tabContent.Visible = (#window.Tabs == 0)
            tabContent.Parent = scrollingFrame

            local layout = Instance.new("UIListLayout")
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, 10)
            layout.Parent = tabContent

            local tab = {
                Button = tabButton,
                Content = tabContent,
                Title = tabConfig.Title or "Tab",
                Icon = tabConfig.Icon or "",
                Elements = {},
                Layout = layout
            }

            tabButton.MouseButton1Click:Connect(function()
                window:SelectTab(#window.Tabs + 1)
            end)

            function tab:AddButton(buttonConfig)
                local buttonFrame = Instance.new("Frame")
                buttonFrame.Name = "ButtonFrame"
                buttonFrame.Size = UDim2.new(1, 0, 0, 50)
                buttonFrame.Position = UDim2.fromOffset(0, #self.Elements * 60)
                buttonFrame.BackgroundColor3 = Color3.fromRGB(70, 100, 180)
                buttonFrame.BorderSizePixel = 0
                buttonFrame.Parent = tabContent

                createGradient(buttonFrame, {
                    Color3.fromRGB(70, 100, 180),
                    Color3.fromRGB(90, 120, 200)
                }, 135)

                createShadow(buttonFrame, 2, 0.9)

                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 8)
                buttonCorner.Parent = buttonFrame

                local button = Instance.new("TextButton")
                button.Name = "Button"
                button.Size = UDim2.new(1, -6, 1, -6)
                button.Position = UDim2.fromOffset(3, 3)
                button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                button.BackgroundTransparency = 1
                button.BorderSizePixel = 0
                button.Text = buttonConfig.Title or "Button"
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.TextSize = 14
                button.Font = Enum.Font.SourceSansBold
                button.TextXAlignment = Enum.TextXAlignment.Center
                button.TextYAlignment = Enum.TextYAlignment.Center
                button.Parent = buttonFrame

                button.MouseButton1Click:Connect(function()
                    if buttonConfig.Callback then
                        buttonConfig.Callback()
                    end
                end)

                local buttonData = {
                    Title = buttonConfig.Title or "Button",
                    Description = buttonConfig.Description or "",
                    Callback = buttonConfig.Callback or function() end,
                    Frame = buttonFrame,
                    Button = button
                }
                table.insert(self.Elements, buttonData)
            end

            function tab:AddParagraph(paragraphConfig)
                local paragraphFrame = Instance.new("Frame")
                paragraphFrame.Name = "ParagraphFrame"
                paragraphFrame.Size = UDim2.new(1, 0, 0, 80)
                paragraphFrame.Position = UDim2.fromOffset(0, #self.Elements * 90)
                paragraphFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
                paragraphFrame.BorderSizePixel = 0
                paragraphFrame.Parent = tabContent

                createGradient(paragraphFrame, {
                    Color3.fromRGB(30, 30, 45),
                    Color3.fromRGB(45, 45, 65)
                }, 135)

                local paragraphCorner = Instance.new("UICorner")
                paragraphCorner.CornerRadius = UDim.new(0, 8)
                paragraphCorner.Parent = paragraphFrame

                local titleLabel = Instance.new("TextLabel")
                titleLabel.Name = "Title"
                titleLabel.Size = UDim2.new(1, -15, 0, 20)
                titleLabel.Position = UDim2.fromOffset(10, 8)
                titleLabel.BackgroundTransparency = 1
                titleLabel.Text = paragraphConfig.Title or "Title"
                titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                titleLabel.TextSize = 14
                titleLabel.Font = Enum.Font.SourceSansBold
                titleLabel.TextXAlignment = Enum.TextXAlignment.Left
                titleLabel.TextYAlignment = Enum.TextYAlignment.Top
                titleLabel.Parent = paragraphFrame

                local contentLabel = Instance.new("TextLabel")
                contentLabel.Name = "Content"
                contentLabel.Size = UDim2.new(1, -15, 0, 45)
                contentLabel.Position = UDim2.fromOffset(10, 30)
                contentLabel.BackgroundTransparency = 1
                contentLabel.Text = paragraphConfig.Content or "Content"
                contentLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                contentLabel.TextSize = 12
                contentLabel.Font = Enum.Font.SourceSans
                contentLabel.TextXAlignment = Enum.TextXAlignment.Left
                contentLabel.TextYAlignment = Enum.TextYAlignment.Top
                contentLabel.TextWrapped = true
                contentLabel.Parent = paragraphFrame

                local paragraphData = {
                    Title = paragraphConfig.Title or "Title",
                    Content = paragraphConfig.Content or "Content",
                    Type = "Paragraph",
                    Frame = paragraphFrame
                }
                table.insert(self.Elements, paragraphData)
            end

            table.insert(window.Tabs, tab)
            return tab
        end

        function window:SelectTab(index)
            if window.Tabs[index] then
                window.SelectedTab = index

                for i, tab in ipairs(window.Tabs) do
                    if i == index then
                        tab.Button.BackgroundColor3 = Color3.fromRGB(100, 130, 210)
                        tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                        tab.Content.Visible = true
                    else
                        tab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                        tab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
                        tab.Content.Visible = false
                    end
                end
            end
        end

        function window:Notify(notifyConfig)
            local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
            if not playerGui then return end

            local notification = Instance.new("Frame")
            notification.Name = "Notification"
            notification.Size = UDim2.fromOffset(300, 100)
            notification.Position = UDim2.new(0.5, -150, 0, -120)
            notification.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            notification.BorderSizePixel = 0
            notification.Parent = playerGui

            createGradient(notification, {
                Color3.fromRGB(30, 30, 45),
                Color3.fromRGB(50, 50, 70)
            }, 135)

            createShadow(notification, 3, 0.85)

            local notifCorner = Instance.new("UICorner")
            notifCorner.CornerRadius = UDim.new(0, 10)
            notifCorner.Parent = notification

            local titleLabel = Instance.new("TextLabel")
            titleLabel.Name = "Title"
            titleLabel.Size = UDim2.new(1, -20, 0, 25)
            titleLabel.Position = UDim2.fromOffset(10, 10)
            titleLabel.BackgroundTransparency = 1
            titleLabel.Text = notifyConfig.Title or "Notification"
            titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            titleLabel.TextSize = 14
            titleLabel.Font = Enum.Font.SourceSansBold
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.TextYAlignment = Enum.TextYAlignment.Top
            titleLabel.Parent = notification

            local contentLabel = Instance.new("TextLabel")
            contentLabel.Name = "Content"
            contentLabel.Size = UDim2.new(1, -20, 0, 50)
            contentLabel.Position = UDim2.fromOffset(10, 35)
            contentLabel.BackgroundTransparency = 1
            contentLabel.Text = notifyConfig.Content or "Content"
            contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            contentLabel.TextSize = 12
            contentLabel.Font = Enum.Font.SourceSans
            contentLabel.TextXAlignment = Enum.TextXAlignment.Left
            contentLabel.TextYAlignment = Enum.TextYAlignment.Top
            contentLabel.TextWrapped = true
            contentLabel.Parent = notification

            local tweenService = game:GetService("TweenService")
            local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local goal = {Position = UDim2.new(0.5, -150, 0, 20)}
            local tween = tweenService:Create(notification, tweenInfo, goal)
            tween:Play()

            game:GetService("Debris"):AddItem(notification, notifyConfig.Duration or 3)
        end

        closeButton.MouseButton1Click:Connect(function()
            screenGui:Destroy()
        end)

        local dragging = false
        local dragInput, mousePos, framePos

        titleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                mousePos = input.Position
                framePos = mainFrame.Position
            end
        end)

        titleBar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)

        titleBar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - mousePos
                mainFrame.Position = UDim2.new(
                    framePos.X.Scale,
                    framePos.X.Offset + delta.X,
                    framePos.Y.Scale,
                    framePos.Y.Offset + delta.Y
                )
            end
        end)

        return window
    end

    function ui:Notify(config)
        local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
        if not playerGui then return end

        local notification = Instance.new("Frame")
        notification.Name = "Notification"
        notification.Size = UDim2.fromOffset(300, 100)
        notification.Position = UDim2.new(0.5, -150, 0, -120)
        notification.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        notification.BorderSizePixel = 0
        notification.Parent = playerGui

        createGradient(notification, {
            Color3.fromRGB(30, 30, 45),
            Color3.fromRGB(50, 50, 70)
        }, 135)

        createShadow(notification, 3, 0.85)

        local notifCorner = Instance.new("UICorner")
        notifCorner.CornerRadius = UDim.new(0, 10)
        notifCorner.Parent = notification

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Size = UDim2.new(1, -20, 0, 25)
        titleLabel.Position = UDim2.fromOffset(10, 10)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = config.Title or "Notification"
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextSize = 14
        titleLabel.Font = Enum.Font.SourceSansBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.TextYAlignment = Enum.TextYAlignment.Top
        titleLabel.Parent = notification

        local contentLabel = Instance.new("TextLabel")
        contentLabel.Name = "Content"
        contentLabel.Size = UDim2.new(1, -20, 0, 50)
        contentLabel.Position = UDim2.fromOffset(10, 35)
        contentLabel.BackgroundTransparency = 1
        contentLabel.Text = config.Content or "Content"
        contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        contentLabel.TextSize = 12
        contentLabel.Font = Enum.Font.SourceSans
        contentLabel.TextXAlignment = Enum.TextXAlignment.Left
        contentLabel.TextYAlignment = Enum.TextYAlignment.Top
        contentLabel.TextWrapped = true
        contentLabel.Parent = notification

        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local goal = {Position = UDim2.new(0.5, -150, 0, 20)}
        local tween = tweenService:Create(notification, tweenInfo, goal)
        tween:Play()

        game:GetService("Debris"):AddItem(notification, config.Duration or 3)
    end

    return ui
end

return createSimpleUI()
