# 🧠 Internal Logic

This section provides a technical overview of how **TerrorUi** operates under the hood. Understanding the internal logic helps advanced developers extend the library or debug complex script interactions.

---

## 🏗️ Object-Oriented Structure

The library is built using a pseudo-OOP (Object-Oriented Programming) approach. Each component—from the Window to a Toggle—is an independent object with its own properties and methods.

1. **The Constructor:** When you call `TerrorUi.new()`, the library initializes a "Master Object" that stores global settings like the current theme, screen resolution, and a list of active tabs.
2. **Parent-Child Mapping:** Every element maintains a reference to its parent. A Button knows which Tab it belongs to, and a Tab knows which Window it is attached to. This allows for cascading updates (like changing a theme across all elements).

---

## 🔄 The Callback System

TerrorUi uses **Asynchronous Callbacks**. When you interact with a UI element (click a button or move a slider), the library triggers the function you provided without pausing the rest of the UI's internal processes.

* **Thread Safety:** Callbacks are wrapped in `task.spawn()` or executed directly to ensure that a crashing script in one button doesn't freeze the entire interface.
* **State Management:** Toggles and Sliders update their internal state *before* firing the callback, ensuring that if you check the value inside the function, it is already current.

---

## 🎨 Rendering & Themes

The theming logic works through a **Centralized Theme Controller**.

* **Direct Referencing:** Every UI object (Frames, TextLabels, Buttons) is added to an internal table of "Themeables."
* **Dynamic Updating:** When `GUI:SetTheme()` is called, the controller loops through this table and applies new `Color3` values using `TweenService`. This ensures that theme transitions are smooth rather than instant and jarring.

---

## 🖱️ Input Handling

To remain compatible with both PC and Mobile, the library utilizes `UserInputService` rather than simple `MouseButton1Click` events.

* **Input Sink:** The UI is designed to "sink" inputs when active, preventing clicks from passing through the menu and interacting with the game world (e.g., shooting a gun while clicking a menu button).
* **Drag Logic:** Draggable elements (like the Main Window or the Mobile Button) use a Delta-calculation system to track mouse/finger movement relative to the last frame.

---

## 🛡️ Cleanup Logic

Memory leaks are a common issue in Roblox scripts. TerrorUi manages this via the `:Destroy()` method:

1. **Disconnection:** All `RBXScriptConnection` objects (events like `RenderStepped` or `InputBegan`) are disconnected.
2. **Instance Removal:** All physical UI instances are called with `:Destroy()` to clear them from the `CoreGui` or `PlayerGui`.
3. **Table Clearing:** Internal tables are nil-ed out to allow the Lua Garbage Collector to reclaim memory.

---

[⬅ Back to Navigation](Navigation.md)
