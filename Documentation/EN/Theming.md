# 🎨 Custom Themes

**TerrorUi** features a flexible theme engine that allows you to change the appearance of the entire interface instantly. You can choose from built-in presets or modify colors to match your project's branding.

---

## 🌓 Built-in Themes

The library comes with two professional presets. You can set the initial theme during initialization or change it dynamically.

```lua
-- During initialization
local GUI = TerrorUi.new("Project", "v1.0", "Midnight")

-- Changing it later
GUI:SetTheme("Default")

```

| Theme Name | Background | Accent Color | Vibe |
| --- | --- | --- | --- |
| `"Default"` | Dark Gray | **Red** | Aggressive / Classic |
| `"Midnight"` | Deep Black | **Blue** | Sleek / Modern |

---

## 🛠️ Creating a Custom Theme

To create a unique look, you can access the theme controller (if supported by your version) or manually override the color properties of the UI objects.

### Defining Custom Colors

If you want to create a custom color palette, you typically define a table of `Color3` values:

```lua
local CustomPalette = {
    MainBackground = Color3.fromRGB(30, 30, 35),
    SidebarColor = Color3.fromRGB(25, 25, 30),
    AccentColor = Color3.fromRGB(180, 100, 255), -- Purple Accent
    TextColor = Color3.fromRGB(255, 255, 255),
    SecondaryText = Color3.fromRGB(150, 150, 150)
}

```

---

## 🌈 Real-time Theme Swapping

You can use a **Color Picker** or a **Dropdown** to let your users customize their own experience.

**Example: Theme Selector**

```lua
SettingsTab:AddDropdown("UI Theme", {"Default", "Midnight"}, function(choice)
    GUI:SetTheme(choice)
    GUI:Notify("Theme Updated", "Switched to " .. choice .. " mode.", 3)
end)

```

**Example: Custom Accent Color**

```lua
SettingsTab:AddColorPicker("Accent Color", Color3.fromRGB(255, 0, 0), function(newColor)
    -- This assumes your version of TerrorUi supports a :UpdateAccent() method
    GUI:UpdateAccent(newColor) 
end)

```

---

## 💡 Design Tips

1. **Contrast:** Ensure your text color has high contrast against the background color for readability.
2. **Consistency:** Use the same accent color for Buttons, Toggles, and Sliders to keep the UI looking professional.
3. **Dark Mode:** Most users prefer dark backgrounds (near-black or dark navy) as they are easier on the eyes during long gaming sessions.

---

[⬅ Back to Navigation](Navigation.md)
