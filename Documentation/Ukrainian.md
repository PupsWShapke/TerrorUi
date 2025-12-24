# # TerrorUi v3.0 | Офіційна документація (Українська)

**TerrorUi** — це сучасна та швидка бібліотека інтерфейсів для Roblox, оптимізована для роботи через віддалене завантаження (`loadstring`). Вона забезпечує плавні анімації, підтримку тем та повну адаптацію під мобільні пристрої.

---

## ## 1. Встановлення та ініціалізація

Оскільки бібліотека завантажується віддалено, вам необхідно використовувати `game:HttpGet` для отримання вихідного коду.

### ### Завантаження через Loadstring

```lua
-- Завантаження API з вашого репозиторію
local TerrorUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau"))()

-- Створення нового вікна: (Заголовок, Підтекст, НазваТеми)
local GUI = TerrorUi.new("TERROR", "v3.0 Private", "Default")

```

* **`Title`** (string): Головна назва вашого проєкту.
* **`Subtext`** (string): Версія або статус (відображається сірим кольором).
* **`Theme`** (string): Початкова тема (`"Default"` або `"Midnight"`).

---

## ## 2. Основні методи керування

Ці функції викликаються безпосередньо через об'єкт `GUI`.

#### `GUI:Toggle()`

Плавно відкриває або закриває головне меню. Чудово підходить для прив'язки до клавіші.

#### `GUI:Notify(Заголовок, Текст, Тривалість)`

Створює сповіщення у кутку екрана.

* **`Тривалість`**: Час у секундах до зникнення (за замовчуванням 5).

#### `GUI:ApplyTheme(Назва або Таблиця)`

Миттєво змінює кольори інтерфейсу. Можна передати назву вбудованої теми або таблицю з кастомними кольорами.

---

## ## 3. Створення вкладок (Tabs)

Вкладки дозволяють розділяти функції за категоріями.

```lua
local MainTab = GUI:AddTab("Main")
local VisualsTab = GUI:AddTab("Visuals")

```

---

## ## 4. Елементи керування (Елементи сторінок)

Усі елементи додаються всередину створеної вкладки.

### ### Кнопка (Button)

```lua
MainTab:AddButton("Натисни мене", function()
    print("Кнопку натиснуто!")
end)

```

### ### Перемикач (Toggle)

```lua
MainTab:AddToggle("Авто-фарм", false, function(state)
    print("Стан:", state)
end)

```

### ### Слайдер (Slider)

```lua
MainTab:AddSlider("Швидкість", 16, 100, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

```

### ### Вибір кольору (ColorPicker)

```lua
VisualsTab:AddColorPicker("Колір меню", Color3.fromRGB(255, 50, 50), function(color)
    GUI:ApplyTheme({Accent = color}) -- Приклад динамічної зміни акценту
end)

```

### ### Бінд клавіш (Keybind)

```lua
MainTab:AddKeybind("Приховати меню", Enum.KeyCode.RightControl, function()
    GUI:Toggle()
end)

```

### ### Поле введення (TextBox)

```lua
MainTab:AddTextBox("Нік гравця", "Введіть ім'я...", function(text, confirmed)
    if confirmed then
        print("Введений нік:", text)
    end
end)

```

---

## ## 5. Особливості та Мобільна підтримка

* **Мобільна кнопка**: При запуску на телефонах автоматично з'являється кнопка "T". Її можна перетягувати.
* **Перетягування меню**: Утримуйте заголовок (Header) меню, щоб перемістити його.
* **Авто-скрол**: Вкладки автоматично розширюються вниз, якщо елементів стає забагато.

---

## ## 6. Приклад готового скрипта

```lua
local TerrorUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau"))()
local GUI = TerrorUi.new("MY PROJECT", "v1.0", "Default")

local Tab = GUI:AddTab("Settings")
Tab:AddButton("Destroy UI", function()
    GUI.ScreenGui:Destroy()
end)

Tab:AddKeybind("Toggle UI", Enum.KeyCode.RightControl, function()
    GUI:Toggle()
end)

GUI:Notify("Успіх", "TerrorUi завантажено!", 3)

```
