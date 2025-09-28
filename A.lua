local function generateRandomId()
    return tostring(math.random(1000000, 9999999))
end

local function createSimpleUI()
    local ui = {}

    function ui:CreateWindow(config)
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = config.Title or "UIWindow"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "MainFrame"
        mainFrame.Size = config.Size or UDim2.fromOffset(520, 360)
        mainFrame.Position = UDim2.fromOffset(100, 100)
        mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        mainFrame.BorderSizePixel = 0
        mainFrame.Parent = screenGui

        local titleBar = Instance.new("Frame")
        titleBar.Name = "TitleBar"
        titleBar.Size = UDim2.fromOffset(mainFrame.Size.X.Offset, 30)
        titleBar.Position = UDim2.fromOffset(0, 0)
        titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        titleBar.BorderSizePixel = 0
        titleBar.Parent = mainFrame

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "TitleLabel"
        titleLabel.Size = UDim2.fromOffset(titleBar.Size.X.Offset - 60, 25)
        titleLabel.Position = UDim2.fromOffset(10, 2)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = config.Title or "Window"
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextSize = 14
        titleLabel.Font = Enum.Font.Gotham
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = titleBar

        local closeButton = Instance.new("TextButton")
        closeButton.Name = "CloseButton"
        closeButton.Size = UDim2.fromOffset(25, 25)
        closeButton.Position = UDim2.fromOffset(titleBar.Size.X.Offset - 30, 2)
        closeButton.BackgroundTransparency = 1
        closeButton.Text = "X"
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.TextSize = 14
        closeButton.Font = Enum.Font.Gotham
        closeButton.Parent = titleBar

        local tabContainer = Instance.new("Frame")
        tabContainer.Name = "TabContainer"
        tabContainer.Size = UDim2.fromOffset(150, mainFrame.Size.Y.Offset - 30)
        tabContainer.Position = UDim2.fromOffset(0, 30)
        tabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tabContainer.BorderSizePixel = 0
        tabContainer.Parent = mainFrame

        local contentArea = Instance.new("Frame")
        contentArea.Name = "ContentArea"
        contentArea.Size = UDim2.fromOffset(mainFrame.Size.X.Offset - 150, mainFrame.Size.Y.Offset - 30)
        contentArea.Position = UDim2.fromOffset(150, 30)
        contentArea.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        contentArea.BorderSizePixel = 0
        contentArea.Parent = mainFrame

        local scrollingFrame = Instance.new("ScrollingFrame")
        scrollingFrame.Name = "ScrollingFrame"
        scrollingFrame.Size = UDim2.fromScale(1, 1)
        scrollingFrame.Position = UDim2.fromOffset(0, 0)
        scrollingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        scrollingFrame.BorderSizePixel = 0
        scrollingFrame.ScrollBarThickness = 8
        scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        scrollingFrame.Parent = contentArea

        local window = {
            ScreenGui = screenGui,
            MainFrame = mainFrame,
            TitleBar = titleBar,
            TabContainer = tabContainer,
            ContentArea = contentArea,
            ScrollingFrame = scrollingFrame,
            Title = config.Title or "Window",
            Size = config.Size or UDim2.fromOffset(520, 360),
            Theme = config.Theme or "Dark",
            Tabs = {},
            SelectedTab = 1
        }

        function window:AddTab(tabConfig)
            local tabButton = Instance.new("TextButton")
            tabButton.Name = "TabButton_" .. #window.Tabs + 1
            tabButton.Size = UDim2.fromOffset(tabContainer.Size.X.Offset, 30)
            tabButton.Position = UDim2.fromOffset(0, #window.Tabs * 30)
            tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            tabButton.BorderSizePixel = 0
            tabButton.Text = tabConfig.Title or "Tab"
            tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            tabButton.TextSize = 12
            tabButton.Font = Enum.Font.Gotham
            tabButton.Parent = tabContainer

            local tabContent = Instance.new("Frame")
            tabContent.Name = "TabContent_" .. #window.Tabs + 1
            tabContent.Size = UDim2.fromScale(1, 1)
            tabContent.Position = UDim2.fromOffset(0, 0)
            tabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            tabContent.BorderSizePixel = 0
            tabContent.Visible = (#window.Tabs == 0)
            tabContent.Parent = scrollingFrame

            local layout = Instance.new("UIListLayout")
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, 5)
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
                buttonFrame.Size = UDim2.fromOffset(contentArea.Size.X.Offset - 20, 40)
                buttonFrame.Position = UDim2.fromOffset(10, #self.Elements * 45)
                buttonFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                buttonFrame.BorderSizePixel = 0
                buttonFrame.Parent = tabContent

                local button = Instance.new("TextButton")
                button.Name = "Button"
                button.Size = UDim2.fromOffset(buttonFrame.Size.X.Offset - 10, 30)
                button.Position = UDim2.fromOffset(5, 5)
                button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                button.BorderSizePixel = 0
                button.Text = buttonConfig.Title or "Button"
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.TextSize = 12
                button.Font = Enum.Font.Gotham
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
                paragraphFrame.Size = UDim2.fromOffset(contentArea.Size.X.Offset - 20, 60)
                paragraphFrame.Position = UDim2.fromOffset(10, #self.Elements * 65)
                paragraphFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                paragraphFrame.BorderSizePixel = 0
                paragraphFrame.Parent = tabContent

                local titleLabel = Instance.new("TextLabel")
                titleLabel.Name = "Title"
                titleLabel.Size = UDim2.fromOffset(paragraphFrame.Size.X.Offset - 10, 20)
                titleLabel.Position = UDim2.fromOffset(5, 5)
                titleLabel.BackgroundTransparency = 1
                titleLabel.Text = paragraphConfig.Title or "Title"
                titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                titleLabel.TextSize = 12
                titleLabel.Font = Enum.Font.GothamBold
                titleLabel.TextXAlignment = Enum.TextXAlignment.Left
                titleLabel.Parent = paragraphFrame

                local contentLabel = Instance.new("TextLabel")
                contentLabel.Name = "Content"
                contentLabel.Size = UDim2.fromOffset(paragraphFrame.Size.X.Offset - 10, 30)
                contentLabel.Position = UDim2.fromOffset(5, 25)
                contentLabel.BackgroundTransparency = 1
                contentLabel.Text = paragraphConfig.Content or "Content"
                contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                contentLabel.TextSize = 10
                contentLabel.Font = Enum.Font.Gotham
                contentLabel.TextXAlignment = Enum.TextXAlignment.Left
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
                        tab.Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                        tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                        tab.Content.Visible = true
                    else
                        tab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                        tab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
                        tab.Content.Visible = false
                    end
                end
            end
        end

        function window:Notify(notifyConfig)
            local notification = Instance.new("Frame")
            notification.Name = "Notification"
            notification.Size = UDim2.fromOffset(300, 80)
            notification.Position = UDim2.fromOffset(game.Players.LocalPlayer.PlayerGui.AbsoluteSize.X - 320, 20)
            notification.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            notification.BorderSizePixel = 0
            notification.Parent = game.Players.LocalPlayer.PlayerGui

            local titleLabel = Instance.new("TextLabel")
            titleLabel.Name = "Title"
            titleLabel.Size = UDim2.fromOffset(280, 20)
            titleLabel.Position = UDim2.fromOffset(10, 10)
            titleLabel.BackgroundTransparency = 1
            titleLabel.Text = notifyConfig.Title or "Notification"
            titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            titleLabel.TextSize = 14
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.Parent = notification

            local contentLabel = Instance.new("TextLabel")
            contentLabel.Name = "Content"
            contentLabel.Size = UDim2.fromOffset(280, 40)
            contentLabel.Position = UDim2.fromOffset(10, 35)
            contentLabel.BackgroundTransparency = 1
            contentLabel.Text = notifyConfig.Content or "Content"
            contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            contentLabel.TextSize = 12
            contentLabel.Font = Enum.Font.Gotham
            contentLabel.TextXAlignment = Enum.TextXAlignment.Left
            contentLabel.TextWrapped = true
            contentLabel.Parent = notification

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
        local notification = Instance.new("Frame")
        notification.Name = "Notification"
        notification.Size = UDim2.fromOffset(300, 80)
        notification.Position = UDim2.fromOffset(game.Players.LocalPlayer.PlayerGui.AbsoluteSize.X - 320, 20)
        notification.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        notification.BorderSizePixel = 0
        notification.Parent = game.Players.LocalPlayer.PlayerGui

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Size = UDim2.fromOffset(280, 20)
        titleLabel.Position = UDim2.fromOffset(10, 10)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = config.Title or "Notification"
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextSize = 14
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = notification

        local contentLabel = Instance.new("TextLabel")
        contentLabel.Name = "Content"
        contentLabel.Size = UDim2.fromOffset(280, 40)
        contentLabel.Position = UDim2.fromOffset(10, 35)
        contentLabel.BackgroundTransparency = 1
        contentLabel.Text = config.Content or "Content"
        contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        contentLabel.TextSize = 12
        contentLabel.Font = Enum.Font.Gotham
        contentLabel.TextXAlignment = Enum.TextXAlignment.Left
        contentLabel.TextWrapped = true
        contentLabel.Parent = notification

        game:GetService("Debris"):AddItem(notification, config.Duration or 3)
    end

    return ui
end

return createSimpleUI()
