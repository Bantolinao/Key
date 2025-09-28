local function generateRandomId()
    return tostring(math.random(1000000, 9999999))
end

local function createGlassBlur(parent, size, position)
    local blur = Instance.new("Frame")
    blur.Name = "GlassBlur"
    blur.Size = size or UDim2.new(1, 0, 1, 0)
    blur.Position = position or UDim2.fromOffset(0, 0)
    blur.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    blur.BackgroundTransparency = 0.9
    blur.BorderSizePixel = 0
    blur.Parent = parent

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.8
    stroke.Parent = blur

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = blur

    return blur
end

local function createSimpleUI()
    local ui = {}

    function ui:CreateWindow(config)
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = config.Title or "UIWindow"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        local backgroundBlur = Instance.new("Frame")
        backgroundBlur.Name = "BackgroundBlur"
        backgroundBlur.Size = UDim2.new(1, 0, 1, 0)
        backgroundBlur.Position = UDim2.fromOffset(0, 0)
        backgroundBlur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        backgroundBlur.BackgroundTransparency = 0.3
        backgroundBlur.BorderSizePixel = 0
        backgroundBlur.Parent = screenGui

        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "MainFrame"
        mainFrame.Size = config.Size or UDim2.fromOffset(500, 600)
        mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
        mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        mainFrame.BackgroundTransparency = 0.85
        mainFrame.BorderSizePixel = 0
        mainFrame.Parent = screenGui

        local mainCorner = Instance.new("UICorner")
        mainCorner.CornerRadius = UDim.new(0, 25)
        mainCorner.Parent = mainFrame

        local mainStroke = Instance.new("UIStroke")
        mainStroke.Thickness = 0.5
        mainStroke.Color = Color3.fromRGB(255, 255, 255)
        mainStroke.Transparency = 0.7
        mainStroke.Parent = mainFrame

        local titleBar = Instance.new("Frame")
        titleBar.Name = "TitleBar"
        titleBar.Size = UDim2.new(1, 0, 0, 60)
        titleBar.Position = UDim2.fromOffset(0, 0)
        titleBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        titleBar.BackgroundTransparency = 0.95
        titleBar.BorderSizePixel = 0
        titleBar.Parent = mainFrame

        local titleCorner = Instance.new("UICorner")
        titleCorner.CornerRadius = UDim.new(0, 25)
        titleCorner.Parent = titleBar

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "TitleLabel"
        titleLabel.Size = UDim2.new(1, -80, 1, 0)
        titleLabel.Position = UDim2.fromOffset(20, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = config.Title or "Window"
        titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        titleLabel.TextSize = 18
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.TextYAlignment = Enum.TextYAlignment.Center
        titleLabel.Parent = titleBar

        local closeButton = Instance.new("TextButton")
        closeButton.Name = "CloseButton"
        closeButton.Size = UDim2.fromOffset(35, 35)
        closeButton.Position = UDim2.new(1, -45, 0.5, -17.5)
        closeButton.BackgroundColor3 = Color3.fromRGB(255, 59, 48)
        closeButton.BackgroundTransparency = 0.2
        closeButton.Text = "✕"
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.TextSize = 16
        closeButton.Font = Enum.Font.GothamBold
        closeButton.Parent = titleBar

        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 10)
        closeCorner.Parent = closeButton

        local tabContainer = Instance.new("Frame")
        tabContainer.Name = "TabContainer"
        tabContainer.Size = UDim2.new(1, 0, 0, 80)
        tabContainer.Position = UDim2.fromOffset(0, 60)
        tabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabContainer.BackgroundTransparency = 0.9
        tabContainer.BorderSizePixel = 0
        tabContainer.Parent = mainFrame

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 15)
        tabCorner.Parent = tabContainer

        local contentArea = Instance.new("Frame")
        contentArea.Name = "ContentArea"
        contentArea.Size = UDim2.new(1, -40, 1, -160)
        contentArea.Position = UDim2.fromOffset(20, 140)
        contentArea.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        contentArea.BackgroundTransparency = 0.92
        contentArea.BorderSizePixel = 0
        contentArea.Parent = mainFrame

        local contentCorner = Instance.new("UICorner")
        contentCorner.CornerRadius = UDim.new(0, 20)
        contentCorner.Parent = contentArea

        local contentStroke = Instance.new("UIStroke")
        contentStroke.Thickness = 0.5
        contentStroke.Color = Color3.fromRGB(200, 200, 200)
        contentStroke.Transparency = 0.8
        contentStroke.Parent = contentArea

        local scrollingFrame = Instance.new("ScrollingFrame")
        scrollingFrame.Name = "ScrollingFrame"
        scrollingFrame.Size = UDim2.new(1, -20, 1, -20)
        scrollingFrame.Position = UDim2.fromOffset(10, 10)
        scrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        scrollingFrame.BackgroundTransparency = 1
        scrollingFrame.BorderSizePixel = 0
        scrollingFrame.ScrollBarThickness = 0
        scrollingFrame.Parent = contentArea

        local window = {
            ScreenGui = screenGui,
            MainFrame = mainFrame,
            TitleBar = titleBar,
            TabContainer = tabContainer,
            ContentArea = contentArea,
            ScrollingFrame = scrollingFrame,
            Title = config.Title or "Window",
            Size = config.Size or UDim2.fromOffset(500, 600),
            Theme = config.Theme or "Light",
            Tabs = {},
            SelectedTab = 1
        }

        function window:AddTab(tabConfig)
            local tabButton = Instance.new("TextButton")
            tabButton.Name = "TabButton_" .. #window.Tabs + 1
            tabButton.Size = UDim2.new(0, 120, 0, 50)
            tabButton.Position = UDim2.fromOffset(20 + (#window.Tabs * 130), 15)
            tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            tabButton.BackgroundTransparency = 0.7
            tabButton.BorderSizePixel = 0
            tabButton.Text = tabConfig.Title or "Tab"
            tabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            tabButton.TextSize = 14
            tabButton.Font = Enum.Font.GothamMedium
            tabButton.Parent = tabContainer

            local tabCorner = Instance.new("UICorner")
            tabCorner.CornerRadius = UDim.new(0, 15)
            tabCorner.Parent = tabButton

            local tabStroke = Instance.new("UIStroke")
            tabStroke.Thickness = 1
            tabStroke.Color = Color3.fromRGB(200, 200, 200)
            tabStroke.Transparency = 0.8
            tabStroke.Parent = tabButton

            local tabContent = Instance.new("Frame")
            tabContent.Name = "TabContent_" .. #window.Tabs + 1
            tabContent.Size = UDim2.new(1, 0, 1, 0)
            tabContent.Position = UDim2.fromOffset(0, 0)
            tabContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            tabContent.BackgroundTransparency = 1
            tabContent.BorderSizePixel = 0
            tabContent.Visible = (#window.Tabs == 0)
            tabContent.Parent = scrollingFrame

            local layout = Instance.new("UIListLayout")
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, 15)
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
                buttonFrame.Size = UDim2.new(1, 0, 0, 60)
                buttonFrame.Position = UDim2.fromOffset(0, #self.Elements * 75)
                buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
                buttonFrame.BackgroundTransparency = 0.3
                buttonFrame.BorderSizePixel = 0
                buttonFrame.Parent = tabContent

                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 15)
                buttonCorner.Parent = buttonFrame

                local buttonStroke = Instance.new("UIStroke")
                buttonStroke.Thickness = 1
                buttonStroke.Color = Color3.fromRGB(0, 122, 255)
                buttonStroke.Transparency = 0.5
                buttonStroke.Parent = buttonFrame

                local button = Instance.new("TextButton")
                button.Name = "Button"
                button.Size = UDim2.new(1, -10, 1, -10)
                button.Position = UDim2.fromOffset(5, 5)
                button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                button.BackgroundTransparency = 1
                button.BorderSizePixel = 0
                button.Text = buttonConfig.Title or "Button"
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.TextSize = 16
                button.Font = Enum.Font.GothamMedium
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
                paragraphFrame.Size = UDim2.new(1, 0, 0, 100)
                paragraphFrame.Position = UDim2.fromOffset(0, #self.Elements * 115)
                paragraphFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                paragraphFrame.BackgroundTransparency = 0.8
                paragraphFrame.BorderSizePixel = 0
                paragraphFrame.Parent = tabContent

                local paragraphCorner = Instance.new("UICorner")
                paragraphCorner.CornerRadius = UDim.new(0, 15)
                paragraphCorner.Parent = paragraphFrame

                local paragraphStroke = Instance.new("UIStroke")
                paragraphStroke.Thickness = 0.5
                paragraphStroke.Color = Color3.fromRGB(200, 200, 200)
                paragraphStroke.Transparency = 0.8
                paragraphStroke.Parent = paragraphFrame

                local titleLabel = Instance.new("TextLabel")
                titleLabel.Name = "Title"
                titleLabel.Size = UDim2.new(1, -20, 0, 25)
                titleLabel.Position = UDim2.fromOffset(10, 10)
                titleLabel.BackgroundTransparency = 1
                titleLabel.Text = paragraphConfig.Title or "Title"
                titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
                titleLabel.TextSize = 16
                titleLabel.Font = Enum.Font.GothamBold
                titleLabel.TextXAlignment = Enum.TextXAlignment.Left
                titleLabel.TextYAlignment = Enum.TextYAlignment.Top
                titleLabel.Parent = paragraphFrame

                local contentLabel = Instance.new("TextLabel")
                contentLabel.Name = "Content"
                contentLabel.Size = UDim2.new(1, -20, 0, 55)
                contentLabel.Position = UDim2.fromOffset(10, 40)
                contentLabel.BackgroundTransparency = 1
                contentLabel.Text = paragraphConfig.Content or "Content"
                contentLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
                contentLabel.TextSize = 14
                contentLabel.Font = Enum.Font.Gotham
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
                        tab.Button.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
                        tab.Button.BackgroundTransparency = 0.3
                        tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                        tab.Button.TextStrokeTransparency = 1
                        tab.Content.Visible = true
                    else
                        tab.Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        tab.Button.BackgroundTransparency = 0.7
                        tab.Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                        tab.Button.TextStrokeTransparency = 0
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
            notification.Size = UDim2.fromOffset(350, 120)
            notification.Position = UDim2.new(0.5, -175, 0, -150)
            notification.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            notification.BackgroundTransparency = 0.1
            notification.BorderSizePixel = 0
            notification.Parent = playerGui

            local notifCorner = Instance.new("UICorner")
            notifCorner.CornerRadius = UDim.new(0, 20)
            notifCorner.Parent = notification

            local notifStroke = Instance.new("UIStroke")
            notifStroke.Thickness = 1
            notifStroke.Color = Color3.fromRGB(255, 255, 255)
            notifStroke.Transparency = 0.5
            notifStroke.Parent = notification

            local blur = createGlassBlur(notification, UDim2.new(1, 0, 1, 0), UDim2.fromOffset(0, 0))

            local titleLabel = Instance.new("TextLabel")
            titleLabel.Name = "Title"
            titleLabel.Size = UDim2.new(1, -30, 0, 30)
            titleLabel.Position = UDim2.fromOffset(15, 15)
            titleLabel.BackgroundTransparency = 1
            titleLabel.Text = notifyConfig.Title or "Notification"
            titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            titleLabel.TextSize = 18
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.TextYAlignment = Enum.TextYAlignment.Top
            titleLabel.Parent = notification

            local contentLabel = Instance.new("TextLabel")
            contentLabel.Name = "Content"
            contentLabel.Size = UDim2.new(1, -30, 0, 60)
            contentLabel.Position = UDim2.fromOffset(15, 50)
            contentLabel.BackgroundTransparency = 1
            contentLabel.Text = notifyConfig.Content or "Content"
            contentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            contentLabel.TextSize = 14
            contentLabel.Font = Enum.Font.Gotham
            contentLabel.TextXAlignment = Enum.TextXAlignment.Left
            contentLabel.TextYAlignment = Enum.TextYAlignment.Top
            contentLabel.TextWrapped = true
            contentLabel.Parent = notification

            local tweenService = game:GetService("TweenService")
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            local goal = {Position = UDim2.new(0.5, -175, 0, 20)}
            local tween = tweenService:Create(notification, tweenInfo, goal)
            tween:Play()

            game:GetService("Debris"):AddItem(notification, notifyConfig.Duration or 3)
        end

        closeButton.MouseButton1Click:Connect(function()
            screenGui:Destroy()
        end)

        backgroundBlur.MouseButton1Click:Connect(function()
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
        notification.Size = UDim2.fromOffset(350, 120)
        notification.Position = UDim2.new(0.5, -175, 0, -150)
        notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notification.BackgroundTransparency = 0.3
        notification.BorderSizePixel = 0
        notification.Parent = playerGui

        local notifCorner = Instance.new("UICorner")
        notifCorner.CornerRadius = UDim.new(0, 20)
        notifCorner.Parent = notification

        local blur = createGlassBlur(notification, UDim2.new(1, 0, 1, 0), UDim2.fromOffset(0, 0))

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Size = UDim2.new(1, -30, 0, 30)
        titleLabel.Position = UDim2.fromOffset(15, 15)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = config.Title or "Notification"
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextSize = 18
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.TextYAlignment = Enum.TextYAlignment.Top
        titleLabel.Parent = notification

        local contentLabel = Instance.new("TextLabel")
        contentLabel.Name = "Content"
        contentLabel.Size = UDim2.new(1, -30, 0, 60)
        contentLabel.Position = UDim2.fromOffset(15, 50)
        contentLabel.BackgroundTransparency = 1
        contentLabel.Text = config.Content or "Content"
        contentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        contentLabel.TextSize = 14
        contentLabel.Font = Enum.Font.Gotham
        contentLabel.TextXAlignment = Enum.TextXAlignment.Left
        contentLabel.TextYAlignment = Enum.TextYAlignment.Top
        contentLabel.TextWrapped = true
        contentLabel.Parent = notification

        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local goal = {Position = UDim2.new(0.5, -175, 0, 20)}
        local tween = tweenService:Create(notification, tweenInfo, goal)
        tween:Play()

        game:GetService("Debris"):AddItem(notification, config.Duration or 3)
    end

    return ui
end

return createSimpleUI()
