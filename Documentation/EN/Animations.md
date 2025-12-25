# ✨ Animations & Effects

**TerrorUi** is powered by smooth, high-performance animations to ensure the interface feels responsive and modern. All transitions are handled using Roblox's `TweenService` for 60 FPS fluidity.

---

## 🌪️ Visual Transitions

The library automatically applies animations to the following interactions:

* **Window Toggling:** When opening or closing the menu, the window uses a smooth fade and scale effect.
* **Tab Switching:** Switching between sections features a clean sliding or fading transition for content.
* **Element Feedback:**
* **Buttons:** Subtle color shifting or scaling when hovered and clicked.
* **Toggles:** Smooth sliding animation for the switch indicator.
* **Dropdowns:** Expand and collapse animations for the option list.



---

## ⚙️ Performance Optimization

Animations are designed to be "lightweight," meaning they won't tank your game's FPS:

* **TweenService Logic:** Uses native C++ engine interpolation.
* **Inactive Cleanup:** Animations only run when the UI is visible to save CPU/GPU cycles.
* **No Yielding:** UI animations run on separate threads, so your main script logic never pauses.

---

## 🛠️ Scripting with Animations

While animations are mostly automatic, you can utilize the built-in `Toggle` method to trigger the main window's entrance and exit effects.

```lua
-- Triggers the built-in Fade & Scale animation
GUI:Toggle()

```

### Tips for Custom Scripts:

If you are writing custom logic that interacts with the UI (like a "Self Destruct" sequence), it is recommended to wait for the animation to finish before destroying the object:

```lua
MainTab:AddButton("Safe Unload", function()
    GUI:Notify("System", "Unloading UI...", 2)
    GUI:Toggle() -- Fade out
    task.wait(0.5) -- Wait for animation duration
    GUI:Destroy() -- Clean up
end)

```

---

## 🎨 Hover Effects

Every interactive element (Buttons, Sliders, TextBoxes) includes a built-in hover state. When a user's mouse enters the element's area, it will slightly brighten or change its border color based on your current **Theme**. This provides immediate visual confirmation to the user.

---

[⬅ Back to Navigation](Navigation.md)
