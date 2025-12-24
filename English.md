# # TerrorUi v3.0 | Official Framework Documentation

**TerrorUi** is a high-performance, object-oriented UI library for Roblox, designed to provide a sleek, modern interface for scripts and tools. It supports dynamic themes, mobile-friendly interactions, and smooth animations.

---

## ## 1. Setup & Initialization (Remote Load)

Since **TerrorUi** is a remote library, you should use `loadstring` to fetch and execute the code from your hosting provider (e.g., GitHub or Pastebin). This method ensures you always have the latest version of the API.

### ### Fetching the Library

```lua
-- Replace the URL with your raw script link
local TerrorUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUsername/YourRepo/main/GuiApi.lua"))()

-- Constructor: (Title, Subtext, Theme)
local GUI = TerrorUi.new("TERROR", "v3.0 Premium", "Default")

```

* **`Title`** (string): The main name of your script (e.g., "TERROR").
* **`Subtext`** (string): Small text displayed next to the title (e.g., "v3.0").
* **`Theme`** (string): The initial theme name (`"Default"` or `"Midnight"`).

> **Important:** Your source `GuiApi.lua` file must end with `return TerrorUi` for this method to work correctly.

---

### ### Global Methods (Manager API)

#### `GUI:Toggle()`

Switches the visibility of the main window using a smooth **CanvasGroup** fade animation. Useful for binding to a custom key.

#### `GUI:Notify(Title, Text, Duration)`

Spawns a temporary notification window in the bottom-right corner of the screen.

* **`Title`**: The header of the notification (e.g., "Warning").
* **`Text`**: The main message body.
* **`Duration`**: How many seconds the notification stays visible (default: 5).

#### `GUI:ApplyTheme(ThemeName or Table)`

Updates the colors and styling of the entire interface in real-time without flickering.

* **Built-in Themes**: `"Default"`, `"Midnight"`.
* **Custom Theme**: You can pass a table containing specific color keys (`MainBg`, `Accent`, `Sidebar`, etc.) to create a unique look.

---

## ## 2. Layout Structure: Tabs

Before adding buttons or toggles, you must create at least one **Tab**. Tabs act as containers for your elements.

```lua
local MainTab = GUI:AddTab("Main")
local VisualsTab = GUI:AddTab("Visuals")

```

### ### Tab Features:

* **Auto-scaling**: The content area automatically adjusts its scrollable size based on the number of elements.
* **Active Highlighting**: The sidebar button for the active tab will automatically change its color to the `Accent` color of the current theme.

---

## ## 3. Content Elements (Page API)

Once you have a Tab object (e.g., `MainTab`), you can use the following methods to populate it with interactive elements.

### ### 3.1 Buttons

A simple clickable element used to trigger a function once.

```lua
MainTab:AddButton("Destroy All", function()
    print("Action triggered!")
end)

```

* **Visuals**: Includes a built-in "Flash" animation on click.

### ### 3.2 Toggles

A binary switch used for enabling or disabling features.

```lua
MainTab:AddToggle("Flight", false, function(state)
    print("Flight enabled:", state)
end)

```

* **`default`** (boolean): Initial state.
* **`callback`** (function): Passes `true` or `false` when clicked.

### ### 3.3 Sliders

Allows the user to select a value within a specific range by dragging a bar.

```lua
MainTab:AddSlider("WalkSpeed", 16, 100, 16, function(value)
    print("Current Speed:", value)
end)

```

* **`min`** (number): Minimum value.
* **`max`** (number): Maximum value.
* **`default`** (number): Starting value.
* **`callback`** (function): Passes the current integer value.

Continuing the **TerrorUi v3.0 Official Documentation**.

---

### ### 3.4 Color Pickers

A specialized dropdown element for visual customization. It provides three independent sliders for Red, Green, and Blue channels.

```lua
Tab:AddColorPicker("Glow Color", Color3.fromRGB(255, 0, 0), function(selectedColor)
    print("New Color:", selectedColor)
end)

```

* **`default`** (Color3): The initial color shown in the preview box.
* **`callback`** (function): Returns a `Color3` object every time a slider is moved.
* **Expandable UI**: Clicking the header expands the picker to reveal the RGB sliders.

### ### 3.5 Keybinds

Allows users to assign a keyboard key to execute a specific function.

```lua
Tab:AddKeybind("Toggle UI", Enum.KeyCode.RightControl, function()
    print("Keybind triggered!")
end)

```

* **`default`** (Enum.KeyCode): The starting key.
* **Binding Mode**: Clicking the bind button enters "Listening" mode (displays `...`). The next key pressed by the user will become the new bind.
* **GPE Handling**: Automatically ignores inputs when the user is typing in the Roblox chat or other text boxes.

### ### 3.6 TextBoxes

A standard input field for strings or commands.

```lua
Tab:AddTextBox("Speed Multiplier", "Enter number...", function(text, enterPressed)
    if enterPressed then
        print("Final input:", text)
    end
end)

```

* **`placeholder`** (string): Ghost text shown when the box is empty.
* **`callback`** (function): Returns the current text and a boolean (`enterPressed`) indicating if the user finished typing by pressing Enter.

---

## ## 4. Internal Systems & Management

### ### 4.1 Mobile Integration

The framework detects and adapts to mobile environments automatically:

* **Mobile Button**: A floating "T" button appears for touch users.
* **Draggable logic**: Both the Main Menu (via the Header) and the Mobile Button can be repositioned.
* **Input Compatibility**: All elements use `InputBegan` and `InputChanged` to support both Mouse and Touch inputs simultaneously.

### ### 4.2 The Object Storage System (`self.Objects`)

TerrorUi keeps track of every element created in a central table. This allows the `ApplyTheme` function to loop through and update colors without requiring a script restart.

* **`Separators`**: Internal lines.
* **`Elements`**: Buttons, Toggles, etc.
* **`Tabs`**: Sidebar buttons.

### ### 4.3 Dragging Logic (`_MakeDraggable`)

An internal method that handles the math for UI movement.

* It calculates the `delta` (distance) between the initial click and current mouse position.
* It applies this delta to the `MainFrame` (if dragging the header) or the specific object (if dragging the mobile button).

---

## ## 5. Advanced Theme Customization

While you can use `"Default"` or `"Midnight"`, you can also create a custom theme by passing a table to `ApplyTheme`.

### ### Theme Table Structure:

```lua
local myCustomTheme = {
    MainBg = Color3.fromRGB(30, 30, 30),      -- Background of the window
    Accent = Color3.fromRGB(0, 255, 150),     -- Primary color (Toggles, Sliders, Icons)
    Sidebar = Color3.fromRGB(25, 25, 25),     -- Sidebar background
    ElementBg = Color3.fromRGB(40, 40, 40),   -- Element (Button/Toggle) background
    Text = Color3.fromRGB(255, 255, 255),     -- Main text color
    SecondaryText = Color3.fromRGB(180, 180, 180), -- Labels and descriptions
    Rounding = UDim.new(0, 10),               -- Corner radius (UICorner)
    Transparency = 0.1                        -- Main window transparency
}

GUI:ApplyTheme(myCustomTheme)

```

---

## ## 6. Troubleshooting & Best Practices

1. **Placement**: Always place the `ModuleScript` in `ReplicatedStorage` if you plan to access it from multiple scripts.
2. **Cleanup**: Use `self.ScreenGui:Destroy()` or the built-in "X" button to completely remove the UI and stop all background connections.
3. **Parenting**: Ensure the UI is initialized inside a `LocalScript` (Client-side), as Roblox UI does not function correctly when handled by the Server.
