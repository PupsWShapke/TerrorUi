# 🚀 Performance Tips

**TerrorUi** is designed to be lightweight, but how you script your features can significantly impact the game's performance. Follow these guidelines to ensure your project remains smooth and lag-free.

---

## ⚡ Optimize Callbacks

The code inside your buttons, toggles, and sliders runs every time a user interacts with them. Avoid putting "heavy" logic directly inside the callback.

**❌ Bad Practice (Laggy):**

```lua
Tab:AddSlider("WalkSpeed", 16, 100, 16, function(value)
    -- This runs every single pixel the slider moves
    while task.wait() do 
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

```

**✅ Good Practice (Efficient):**

```lua
Tab:AddSlider("WalkSpeed", 16, 100, 16, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = value
    end
end)

```

---

## 📉 Handling Loops

If you have a feature like "Auto Farm" or "ESP," do not start a new loop every time a toggle is clicked. Instead, use a variable to control a single background loop.

```lua
local AutoFarmEnabled = false

-- The Loop (Run this once)
task.spawn(function()
    while true do
        if AutoFarmEnabled then
            -- Do farming logic here
        end
        task.wait(1) -- Use appropriate wait times
    end
end)

-- The UI Toggle
Tab:AddToggle("Auto Farm", false, function(state)
    AutoFarmEnabled = state
end)

```

---

## 🧹 Memory Management

When you are done with the UI (e.g., the user uninjects the script), always use the `Destroy` method. This cleans up all events, instances, and animations to prevent memory leaks.

```lua
GUI:Destroy()

```

---

## 🖼️ UI Rendering

* **Notifications:** Avoid spamming `GUI:Notify`. Every notification creates new UI objects and tweens. Use them only for important status changes.
* **Dropdown Updates:** Only call `:Refresh()` on dropdowns when the data actually changes (e.g., when a player joins or leaves), rather than on a fast loop.
* **Visibility:** Use `GUI:Toggle()` to hide the menu when not in use. This allows the Roblox engine to skip rendering the internal elements of the menu.

---

## 🛠️ Summary Checklist

* [ ] Use `task.wait()` instead of `wait()`.
* [ ] Use `task.spawn()` for background tasks.
* [ ] Only update UI elements when necessary.
* [ ] Ensure all loops have a way to stop when the feature is toggled off.

---

[⬅ Back to Navigation](Navigation.md)
