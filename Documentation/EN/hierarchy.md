# 🏗️ Library Hierarchy

The structure follows a strict parent-child relationship. You must create the parent object before you can initialize the child elements.

### The Flow:

`Library` ➔ `Window` ➔ `Tab` ➔ `Element` (Button, Toggle, etc.)

---

## 1. The Core Library (The Loader)

The top level is the code fetched via `loadstring`. It contains the constructor for the entire UI.

* **Variable:** `TerrorUi`
* **Purpose:** Acts as the engine. It doesn't appear on screen until you call `.new()`.

## 2. The Window (The Container)

The Window is the main GUI frame that holds everything. It handles themes, dragging, and global settings.

* **Variable:** Usually `GUI` or `Window`.
* **Created via:** `TerrorUi.new(...)`
* **Features:** Header, Title, Version, and the Tab-selection sidebar.

## 3. Tabs (The Sections)

Tabs are the "pages" of your menu. You use them to categorize your features (e.g., "Combat", "Movement", "Visuals").

* **Variable:** e.g., `MainTab`, `CombatTab`.
* **Created via:** `GUI:AddTab("Name")`
* **Note:** Elements **cannot** exist outside of a Tab.

## 4. Elements (The Interaction)

These are the actual tools the user interacts with. They live inside a specific Tab.

* **Types:** Buttons, Toggles, Sliders, Dropdowns, etc.
* **Created via:** `Tab:AddButton(...)`, `Tab:AddToggle(...)`, etc.

---

## 🛠️ Visual Code Representation

```lua
local TerrorUi = loadstring(...)() -- [LEVEL 1: LIBRARY]

local GUI = TerrorUi.new("Project", "1.0", "Default") -- [LEVEL 2: WINDOW]

    local Tab1 = GUI:AddTab("Combat") -- [LEVEL 3: TAB]
        Tab1:AddToggle("Killaura", false, function() ... end) -- [LEVEL 4: ELEMENT]
        Tab1:AddSlider("Reach", 1, 10, 3, function() ... end) -- [LEVEL 4: ELEMENT]

    local Tab2 = GUI:AddTab("Misc") -- [LEVEL 3: TAB]
        Tab2:AddButton("Reset Character", function() ... end) -- [LEVEL 4: ELEMENT]

```

---

## ⚠️ Common Mistakes

* **Adding elements to the Window:** `GUI:AddButton(...)` will return an error. You must use `Tab:AddButton(...)`.
* **Variables:** Make sure to give your Tabs unique variable names (like `Tab1`, `Tab2`) so you don't accidentally add all elements to the same page.

---

[⬅ Back to Navigation](Navigation.md)
