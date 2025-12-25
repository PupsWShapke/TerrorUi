# ⚡ Quick Start Guide

Get your script up and running in less than a minute. This template includes a window, a tab, and one of each basic UI element.

---

## 🚀 Full Boilerplate Code

Copy this code into a **LocalScript** inside `StarterPlayerScripts` or `StarterGui`:

```lua
-- 1. Load the Library
local TerrorUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau"))()

-- 2. Create the Main Window
-- Parameters: Title, Version, Default Theme ("Default" or "Midnight")
local GUI = TerrorUi.new("TERROR PROJECT", "v3.1", "Default")

-- 3. Add a Mobile Toggle Button (Optional but recommended)
GUI:CreateMobileButton()

-- 4. Create a Tab
local MainTab = GUI:AddTab("Main Features")

-- 5. Add UI Elements
MainTab:AddButton("Click Me", function()
    GUI:Notify("Action", "Button was clicked!", 3)
end)

MainTab:AddToggle("Auto Farm", false, function(state)
    print("Toggle is now: ", state)
end)

MainTab:AddSlider("WalkSpeed", 16, 100, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

MainTab:AddDropdown("Select Mode", {"Legit", "Rage", "Blatant"}, function(selected)
    print("Selected mode: " .. selected)
end)

-- 6. Send a Welcome Notification
GUI:Notify("Success", "TerrorUi Loaded Successfully!", 5)

```

---

## 🛠️ Explaining the Steps

### 1. The Loader

The `loadstring` line fetches the latest source code directly from GitHub. This ensures your script never breaks when the library is updated.

### 2. The Window (`.new`)

This creates the main frame.

* **Title**: The name of your cheat/hub.
* **Version**: Small text displayed in the header.
* **Theme**: Sets the initial color palette.

### 3. Tabs

Everything in **TerrorUi** is organized into Tabs. You must create at least one Tab using `:AddTab()` before you can add buttons or sliders.

### 4. Elements

Each element (Button, Toggle, etc.) requires a **Callback Function**. This is the code that runs when the user interacts with that element.

---

[⬅ Back to Navigation](Documentation/EN/Navigation.md)
