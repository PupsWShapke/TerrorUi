# 🎨 Color Picker

The Color Picker element allows users to select custom colors dynamically. It is essential for features like "ESP Color," "UI Accent Color," or "Chams."

---

## 🌈 Adding a Color Picker: `AddColorPicker`

Use this method to add a color selection tool to your Tab.

```lua
Tab:AddColorPicker(text, defaultColor, callback)

```

**Parameters:**

* `text` (string) — The label for the color picker.
* `defaultColor` (Color3) — The initial color (e.g., `Color3.fromRGB(255, 0, 0)`).
* `callback` (function) — Runs whenever the color is changed. Passes the current `Color3` value.

**Example:**

```lua
VisualsTab:AddColorPicker("ESP Color", Color3.fromRGB(255, 0, 0), function(color)
    print("New color selected: ", color)
    -- Update your ESP color here
end)

```

---

## 🔄 Dynamic Management

You can store the Color Picker in a variable to update its value or retrieve the current color via code.

### Setting a Color

```lua
local myPicker = Tab:AddColorPicker("Theme Color", Color3.new(1, 1, 1), function() end)

-- Change the color to Green programmatically
myPicker:SetColor(Color3.fromRGB(0, 255, 0))

```

---

## 💡 Usage Tips

1. **Visual Feedback:** The element usually displays a small preview box of the currently selected color.
2. **Performance:** Since the callback triggers while the user slides their mouse across the palette, ensure your callback code is optimized to avoid lag.
3. **Default Values:** Always provide a sensible default color so users don't have to configure it every time the script runs.

---

## 📋 Full Example

```lua
local TerrorUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau"))()
local GUI = TerrorUi.new("Visuals Hub", "v1.0", "Default")
local Tab = GUI:AddTab("Visuals")

Tab:AddColorPicker("Box ESP Color", Color3.fromRGB(255, 255, 255), function(newColor)
    GUI:Notify("Color Updated", "ESP color changed successfully!", 2)
    -- Logic to apply newColor to ESP system
end)

```

---

[⬅ Back to Navigation](Navigation.md)
