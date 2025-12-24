# 🩸 TerrorUi v3.0

**TerrorUi** is a high-performance, modern, and sleek UI library for Roblox designed to be loaded remotely. It features a dark-themed aesthetic with smooth animations, dynamic theme switching, and full mobile compatibility.

[![License: MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/Version-3.0-blue.svg)](#)

---

## 📖 Documentation

To make the library accessible to everyone, we provide documentation in multiple languages:

* [**English Documentation**](Documentation/English.md) 🇺🇸
* [**Russian Documentation (Русский)**](Documentation/Russian.md) 🇷🇺
* [**Ukrainian Documentation (Українська)**](Documentation/Ukrainian.md) 🇺🇦

---

## 🚀 Quick Start

To use TerrorUi in your project, simply use `loadstring` to fetch the API directly from this repository.

```lua
local TerrorUi = loadstring(game:HttpGet("[https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau](https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau)"))()

local GUI = TerrorUi.new("TERROR", "v3.0 Private", "Default")
local Tab = GUI:AddTab("Main")

Tab:AddButton("Hello World", function()
    print("TerrorUi is working!")
end)

GUI:Notify("Welcome", "Library successfully loaded!", 5)
