# 🎚️ Sliders & Inputs

This section covers elements used for precise numeric control and text-based data entry.

---

## 📏 Sliders: `AddSlider`

Sliders allow users to select a numeric value within a specific range by dragging a bar.

```lua
Tab:AddSlider(text, min, max, default, callback)

```

**Parameters:**

* `text` (string) — The label for the slider.
* `min` (number) — The minimum possible value.
* `max` (number) — The maximum possible value.
* `default` (number) — The initial value when the UI loads.
* `callback` (function) — Runs whenever the slider moves. Passes the current `value`.

**Example:**

```lua
MainTab:AddSlider("WalkSpeed", 16, 100, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

```

---

## ⌨️ Text Boxes: `AddTextBox`

Text boxes allow users to type in custom strings or numbers, such as player names or teleport coordinates.

```lua
Tab:AddTextBox(text, placeholder, callback)

```

**Parameters:**

* `text` (string) — The label above or beside the input field.
* `placeholder` (string) — The gray text shown when the box is empty.
* `callback` (function) — Runs when the user presses **Enter** or clicks away. Passes the `input` string.

**Example:**

```lua
SettingsTab:AddTextBox("Join Code", "Enter code here...", function(text)
    print("User entered: " .. text)
end)

```

---

## 🛠️ Advanced Usage

### Dynamic Slider Updates

You can store a slider in a variable to change its value via code:

```lua
local mySlider = Tab:AddSlider("FOV", 70, 120, 70, function(v) 
    workspace.CurrentCamera.FieldOfView = v 
end)

-- Reset FOV to 70 via script
mySlider:SetValue(70)

```

### Input Validation

Since `AddTextBox` returns a string, you should convert it to a number if needed:

```lua
Tab:AddTextBox("Set JumpPower", "1-200", function(input)
    local num = tonumber(input)
    if num then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = num
    else
        GUI:Notify("Error", "Please enter a valid number!", 3)
    end
end)

```

---

[⬅ Back to Navigation](Navigation.md)
