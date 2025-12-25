# 🔽 Dropdowns

Dropdowns provide a clean way to let users select one option from a list of multiple choices without cluttering the UI.

---

## 📑 Creating a Dropdown: `AddDropdown`

Use this method to add a selectable list to your Tab.

```lua
Tab:AddDropdown(text, list, callback)

```

**Parameters:**

* `text` (string) — The label for the dropdown.
* `list` (table) — An array of strings representing the options.
* `callback` (function) — Runs whenever an option is selected. Passes the `selected` string.

**Example:**

```lua
MainTab:AddDropdown("Select Team", {"Red", "Blue", "Green", "Yellow"}, function(selected)
    print("User joined team: " .. selected)
end)

```

---

## 🔄 Dynamic Management

You can update the list of items in the dropdown or clear them while the script is running. This is useful for lists that change, like "Player Lists".

### Updating Items

```lua
local playerDropdown = Tab:AddDropdown("Select Player", {}, function(name)
    print("Targeting: " .. name)
end)

-- Later in your script to refresh the list:
local names = {}
for _, v in pairs(game.Players:GetPlayers()) do
    table.insert(names, v.Name)
end

playerDropdown:Refresh(names) -- Updates the dropdown with current player names

```

### Setting a Value

You can force the dropdown to select a specific item programmatically:

```lua
playerDropdown:SetOption("Player1")

```

---

## 💡 Usage Tips

1. **Placeholder:** If the initial list is empty, the dropdown will display as empty until `:Refresh()` is called.
2. **Long Lists:** The dropdown container is scrollable, so you can add many items without breaking the layout.
3. **Clean UI:** Use dropdowns instead of multiple buttons when you have more than 3 related options (e.g., "Teleport Locations").

---

## 📋 Full Example

```lua
local TerrorUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau"))()
local GUI = TerrorUi.new("Dropdown Demo", "v1.0", "Default")
local Tab = GUI:AddTab("Settings")

Tab:AddDropdown("Map Theme", {"Day", "Night", "Sunset", "Void"}, function(choice)
    if choice == "Day" then
        -- Change lighting to Day
    elseif choice == "Night" then
        -- Change lighting to Night
    end
    GUI:Notify("Theme Changed", "Map is now set to " .. choice, 3)
end)

```

---

[⬅ Back to Navigation](Navigation.md)
