# 📥 Installation Guide

This guide will help you integrate **TerrorUi** into your Roblox project.

---

## 🛠️ Method 1: Loadstring (Recommended)

The most efficient way to use the library is via `loadstring`. This ensures you always have the latest version without manually updating files.

Paste this into a **LocalScript** (e.g., in `StarterPlayerScripts` or `StarterGui`):

```lua
local TerrorUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau"))()

-- Create your Window
local Window = TerrorUi.new("My Project", "1.0", "Default")

```

---

## 📂 Method 2: Manual Installation

If you prefer to have the source code locally or want to work offline:

1. Go to the [Main.luau](https://github.com/PupsWShapke/TerrorUi/blob/main/Main.luau) file in this repository.
2. Copy the entire source code.
3. In Roblox Studio, create a new **ModuleScript**.
4. Paste the code into the ModuleScript and rename it to `TerrorUi`.
5. Access it in your script like this:

```lua
local TerrorUi = require(path.to.your.ModuleScript)

```

---

## ⚠️ Requirements

To ensure the library functions correctly, please check the following:

* **HTTP Requests**: If you are using Method 1, ensure **Allow HTTP Requests** is enabled in your Game Settings (Security tab).
* **API Services**: Enable **Allow Access to API Services** if you plan to save configurations or themes.
* **Environment**: This library is designed to run in a **LocalScript**. Do not attempt to run it from a Server Script.

---

[⬅ Back to Navigation](Navigation.md)
