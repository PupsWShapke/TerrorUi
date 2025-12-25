# 📑 Tabs Management

Tabs are the primary way to organize your features into different sections. Each Tab creates a new page in the UI and a corresponding button in the navigation sidebar.

---

## ➕ Creating a Tab: `AddTab`

To add a new section to your window, use the `AddTab` method. You must store the result in a variable to add elements to it later.

```lua
local MyTab = GUI:AddTab(title)

```

**Parameters:**

* `title` (string) — The name of the tab that appears in the sidebar.

**Example:**

```lua
local MainTab = GUI:AddTab("Main")
local CombatTab = GUI:AddTab("Combat")
local VisualsTab = GUI:AddTab("Visuals")

```

---

## 🛠️ Adding Elements to Tabs

Once a Tab is created, you can populate it with various interactive components. Each element is "parented" to the specific tab variable you created.

**Example Structure:**

```lua
local Tab = GUI:AddTab("Example")

-- Adding a button to THIS specific tab
Tab:AddButton("Click Me", function()
    print("Clicked!")
end)

```

---

## 💡 Best Practices

1. **Unique Variable Names:** Always give your tabs unique variable names (e.g., `CombatTab`, `MiscTab`) so you don't accidentally overwrite them.
2. **Tab Order:** Tabs appear in the sidebar in the exact order they are created in your script.
3. **Organization:** Group related features together. Put all movement cheats in a "Movement" tab and all visual cheats in a "Visuals" tab to keep the UI clean.
4. **Naming:** Keep tab titles short (1-2 words) so they fit perfectly within the sidebar width.

---

## 📋 Full Tab Example

```lua
local TerrorUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau"))()
local GUI = TerrorUi.new("Tab Demo", "v1.0", "Default")

-- Creating multiple sections
local Combat = GUI:AddTab("Combat")
local Movement = GUI:AddTab("Movement")
local Settings = GUI:AddTab("Settings")

-- Adding elements to different tabs
Combat:AddToggle("Kill Aura", false, function() end)
Movement:AddSlider("WalkSpeed", 16, 100, 16, function() end)
Settings:AddButton("Reset Config", function() end)

```

---

[⬅ Back to Navigation](Navigation.md)
