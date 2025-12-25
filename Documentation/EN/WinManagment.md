# 🏗️ Window Management

The Window is the foundation of your interface. It manages the global state, themes, and notifications.

---

## 🟢 Creating a Window: `TerrorUi.new`

This is the first line of code you need after loading the library. It initializes the main frame.

```lua
local GUI = TerrorUi.new(title, version, theme)

```

**Parameters:**

* `title` (string) — The name of your hub (appears in the top left).
* `version` (string) — A version tag (appears in gray next to the title).
* `theme` (string) — The starting theme. Options: `"Default"` or `"Midnight"`.

**Example:**

```lua
local GUI = TerrorUi.new("TERROR PROJECT", "v3.1", "Midnight")

```

---

## 📱 Mobile Support: `CreateMobileButton`

To make your menu accessible for mobile players, use this method. It creates a draggable floating button with a "T" logo that toggles the menu visibility.

```lua
GUI:CreateMobileButton()

```

---

## 🔔 Notifications: `Notify`

Notifications appear as sleek pop-ups in the bottom-right corner of the screen. They are perfect for status updates or welcome messages.

```lua
GUI:Notify(title, content, duration)

```

**Parameters:**

* `title` (string) — The bold header of the notification.
* `content` (string) — The main message body.
* `duration` (number) — How many seconds the notice stays on screen (Default: 5).

**Example:**

```lua
GUI:Notify("Update", "New features have been loaded!", 4)

```

---

## 👁️ Visibility: `Toggle`

You can programmatically hide or show the menu using this method. It includes a smooth fade-in/fade-out animation.

```lua
GUI:Toggle()

```

---

## 🎨 Global Theming: `SetTheme`

Changes the color palette of the entire UI instantly.

```lua
GUI:SetTheme(themeName)

```

**Available Themes:**

* `"Default"` — Dark gray background with **Red** accents.
* `"Midnight"` — Deep black background with **Blue** accents.

---

## 🗑️ Destroying the UI: `Destroy`

If you need to completely remove the UI from the player's screen and clean up memory (e.g., when uninjecting a script):

```lua
GUI:Destroy()

```

---

[⬅ Back to Navigation](Navigation.md)
