# 📱 Mobile Support

This section explains how to implement and optimize **TerrorUi** for mobile users to ensure a seamless experience on touch devices.

---

## 🔘 The Toggle Button: `CreateMobileButton`

Since mobile players do not have a keyboard to press a "Bind" key, you must provide a physical button to open and close the menu.

```lua
GUI:CreateMobileButton()

```

### Key Features:

* **Draggable:** Users can hold and move the button to any part of their screen.
* **Auto-scaling:** The button is sized specifically for touch interaction.
* **Visibility:** It automatically hides when the main menu is open and reappears when the menu is closed.

---

## 🖐️ Touch Interaction

**TerrorUi** is built with `InputService` and `Touch` events, meaning:

* **Sliders:** Can be dragged by finger or tapped to set a value.
* **Scrolling:** Tab lists and element containers support smooth touch scrolling.
* **Dropdowns:** Optimized hitboxes for easy selection on smaller screens.

---

## 📝 Best Practices for Mobile

When designing your UI for mobile users, keep these tips in mind:

1. **Keep Titles Short:** Mobile screens are narrow; long Tab names might get truncated.
2. **Limit Notifications:** Don't spam `GUI:Notify()`, as notifications take up significant screen real estate on phones.
3. **Test Dragging:** Ensure your `CreateMobileButton` doesn't overlap with the default Roblox joystick or jump button locations.

---

## 🛠️ Code Example

```lua
local TerrorUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau"))()
local GUI = TerrorUi.new("Mobile Hub", "v1.0", "Midnight")

-- Essential for mobile users
GUI:CreateMobileButton()

local Tab = GUI:AddTab("Mobile")
Tab:AddButton("Test Touch", function()
    print("Touch registered!")
end)

```

---

[⬅ Back to Navigation](Navigation.md)
