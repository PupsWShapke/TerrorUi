# ⌨️ Keybinds

Keybinds allow users to execute functions or toggle the menu visibility using specific keys on their keyboard.

---

## 🎹 Adding a Keybind: `AddKeybind`

Use this method to bind a specific action to a key.

```lua
Tab:AddKeybind(text, defaultKey, callback)

```

**Parameters:**

* `text` (string) — The label for the keybind.
* `defaultKey` (Enum.KeyCode) — The initial key (e.g., `Enum.KeyCode.F`).
* `callback` (function) — Runs whenever the key is pressed.

**Example:**

```lua
MainTab:AddKeybind("Self Destruct", Enum.KeyCode.K, function()
    print("Keybind pressed!")
    GUI:Destroy()
end)

```

---

## 🔄 Changing Binds

When the user clicks on the keybind element in the UI, it will wait for them to press a new key. Once pressed, the bind is automatically updated to the new key.

### Programmatic Update

You can also change the keybind via script:

```lua
local myBind = Tab:AddKeybind("Fly", Enum.KeyCode.G, function() end)

-- Change it to 'H' later
myBind:SetKey(Enum.KeyCode.H)

```

---

## 💡 Important Notes

1. **Input Buffering:** Keybinds work globally as long as the script is running.
2. **Toggle Menu Bind:** By default, many users prefer `RightControl` or `Insert` to hide/show the menu. You can set this up manually:
```lua
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightControl then
        GUI:Toggle()
    end
end)

```


3. **Conflict Prevention:** Avoid using common game keys (like `W`, `A`, `S`, `D` or `Space`) to prevent interfering with player movement.

---

## 📋 Full Example

```lua
local TerrorUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau"))()
local GUI = TerrorUi.new("Keybind System", "v1.0", "Midnight")
local Tab = GUI:AddTab("Combat")

Tab:AddKeybind("Toggle Reach", Enum.KeyCode.T, function()
    GUI:Notify("Keybind", "Reach has been toggled!", 2)
end)

```

---

[⬅ Back to Navigation](Navigation.md)
