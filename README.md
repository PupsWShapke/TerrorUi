Для того чтобы твой проект выглядел на **9/10**, корневой `README.md` должен быть лаконичным, визуально приятным и сразу давать понять, как запустить библиотеку.

Вот готовый код для твоего основного **README.md**, который объединяет структуру навигации, установку и ссылки на документацию, которые ты указал.

---

```markdown
# 💀 TerrorUi v3.1

**TerrorUi** is a powerful, lightweight, and highly customizable UI library for Roblox. Designed for performance and aesthetics, it features smooth animations, dynamic themes, and full mobile support.

---

## 🚀 Quick Start

To use **TerrorUi** in your project, copy and paste the following code into your `LocalScript`:

```lua
local TerrorUi = loadstring(game:HttpGet("[https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau](https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau)"))()

-- Initialize UI
local GUI = TerrorUi.new("TERROR PROJECT", "v3.1", "Default")
GUI:CreateMobileButton()

-- Add your first Tab
local MainTab = GUI:AddTab("Main")
MainTab:AddButton("Hello World", function()
    print("TerrorUi is working!")
end)

```

---

## 📚 Documentation / Документация / Документація

Select your preferred language to view the full API reference and guides.

### [English documentation 🇺🇸](Documentation/EN/Navigation.md)

*Complete technical specification and usage guides.*

---

### [Українська документація 🇺🇦](Documentation/UA/Navigation.md)

*Повна технічна специфікація та посібники з використання.*

---

### [Русская документация 🇷🇺](Documentation/RU/Navigation.md)

*Полная техническая спецификация и руководства по использованию.*

---

## ✨ Core Features

* 🏎️ **Optimized Performance**: Smooth 60 FPS animations.
* 🎨 **Theme System**: Switch between Default, Midnight, or create your own.
* 📱 **Mobile Ready**: Built-in dragging and mobile-friendly controls.
* 🛠️ **Developer Friendly**: Clean API and detailed documentation.

---

*Developed by [PupsWShapke](https://github.com/PupsWShapke). Licensed under MIT.*

Хочешь, чтобы я написал содержимое для одного из них (например, для **Navigation.md** на русском), чтобы ты использовал его как шаблон для остальных?

```
