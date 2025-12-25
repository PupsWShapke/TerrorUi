# 🎨 Theming

**TerrorUi** comes with a built-in theme engine that allows you to change the visual style of the interface with a single command. This is perfect for offering users a "Dark Mode" (Midnight) or a classic look (Default).

---

## 🔁 Switching Themes: `SetTheme`

You can switch themes at any time—during initialization or while the script is already running.

```lua
GUI:SetTheme(themeName)

```

**Available Options:**

* `"Default"` — A professional dark gray interface with **Red** accents.
* `"Midnight"` — A deep black "amoled" style interface with **Blue** accents.

---

## 🛠️ Usage Examples

### 1. Setting Theme on Startup

Choose your preferred look when you first create the window:

```lua
-- Initializes the UI in Midnight mode
local GUI = TerrorUi.new("My Script", "v1.0", "Midnight")

```

### 2. Interactive Theme Switcher

Allow your users to choose their favorite style using a Dropdown in the Settings tab:

```lua
SettingsTab:AddDropdown("UI Theme", {"Default", "Midnight"}, function(selected)
    GUI:SetTheme(selected)
    GUI:Notify("Theme Applied", "Interface style changed to " .. selected, 2)
end)

```

---

## 🎨 Theme Comparison

| Feature | **Default** | **Midnight** |
| --- | --- | --- |
| **Main Background** | Dark Gray | Deep Black |
| **Accent Color** | Vivid Red | Electric Blue |
| **Secondary Color** | Light Gray | Dark Charcoal |
| **Best For** | High Visibility | Night Gaming / Sleek Look |

---

## 💡 How it Works

When `SetTheme` is called, the library performs the following actions:

1. **Identifies** all active UI components (Buttons, Toggles, Sliders, etc.).
2. **Calculates** the new color values based on the selected preset.
3. **Animates** the color transition using `TweenService`, ensuring the change is smooth and doesn't flicker.

---

[⬅ Back to Navigation](Navigation.md)
