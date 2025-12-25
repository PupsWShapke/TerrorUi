# 🖱️ Buttons & Toggles

These are the primary interactive elements used to trigger functions or switch between states (On/Off).

---

## 🔘 Buttons: `AddButton`

A standard button that executes a function when clicked. Perfect for "Reset", "Teleport", or "Save" actions.

```lua
Tab:AddButton(text, callback)

```

**Parameters:**

* `text` (string) — The label displayed on the button.
* `callback` (function) — The code that runs when the button is pressed.

**Example:**

```lua
MainTab:AddButton("Print Hello", function()
    print("Hello from TerrorUi!")
end)

```

---

## 🔄 Toggles: `AddToggle`

A switch that maintains its state. It is used for features that need to stay active, like "Auto Farm" or "Fly".

```lua
Tab:AddToggle(text, default, callback)

```

**Parameters:**

* `text` (string) — The label for the toggle.
* `default` (boolean) — The starting state (`true` for ON, `false` for OFF).
* `callback` (function) — Runs every time the state changes. Passes a `state` boolean.

**Example:**

```lua
MainTab:AddToggle("Speed Hack", false, function(state)
    if state then
        print("Speed Enabled")
    else
        print("Speed Disabled")
    end
end)

```

---

## 🛠️ Modifying Elements

You can store the element in a variable to update it later programmatically.

**Example:**

```lua
local myToggle = MainTab:AddToggle("Feature", false, function() end)

-- Later in your script:
myToggle:SetState(true) -- Force turns it on

```

---

[⬅ Back to Navigation](Navigation.md)
