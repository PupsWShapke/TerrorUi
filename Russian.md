Вот полный текст для твоего файла **Russian.md**. Я структурировал его профессионально, добавил рабочую ссылку на твой репозиторий и учел метод загрузки через `loadstring`.

---

# # TerrorUi v3.0 | Официальная документация (Русский)

**TerrorUi** — это современная и быстрая библиотека интерфейсов для Roblox, оптимизированная для работы через удаленную загрузку (`loadstring`). Она обеспечивает плавные анимации, поддержку тем и полную адаптацию под мобильные устройства.

---

## ## 1. Установка и инициализация

Так как библиотека загружается удаленно, вам необходимо использовать `game:HttpGet` для получения исходного кода.

### ### Загрузка через Loadstring

```lua
-- Загрузка API из вашего репозитория
local TerrorUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/PupsWShapke/TerrorUi/refs/heads/main/Main.luau"))()

-- Создание нового окна: (Заголовок, Подтекст, НазваниеТемы)
local GUI = TerrorUi.new("TERROR", "v3.0 Private", "Default")

```

* **`Title`** (string): Главное название вашего проекта.
* **`Subtext`** (string): Версия или статус (отображается серым цветом).
* **`Theme`** (string): Начальная тема (`"Default"` или `"Midnight"`).

---

## ## 2. Основные методы управления

Эти функции вызываются напрямую через объект `GUI`.

#### `GUI:Toggle()`

Плавно открывает или закрывает главное меню. Отлично подходит для привязки к клавише.

#### `GUI:Notify(Заголовок, Текст, Длительность)`

Создает уведомление в углу экрана.

* **`Длительность`**: Время в секундах до исчезновения (по умолчанию 5).

#### `GUI:ApplyTheme(Название или Таблица)`

Мгновенно меняет цвета интерфейса. Можно передать название встроенной темы или таблицу с кастомными цветами.

---

## ## 3. Создание вкладок (Tabs)

Вкладки позволяют разделять функции по категориям.

```lua
local MainTab = GUI:AddTab("Main")
local VisualsTab = GUI:AddTab("Visuals")

```

---

## ## 4. Элементы управления (Элементы страниц)

Все элементы добавляются внутрь созданной вкладки.

### ### Кнопка (Button)

```lua
MainTab:AddButton("Нажми меня", function()
    print("Кнопка нажата!")
end)

```

### ### Переключатель (Toggle)

```lua
MainTab:AddToggle("Авто-фарм", false, function(state)
    print("Состояние:", state)
end)

```

### ### Слайдер (Slider)

```lua
MainTab:AddSlider("Скорость", 16, 100, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

```

### ### Выбор цвета (ColorPicker)

```lua
VisualsTab:AddColorPicker("Цвет меню", Color3.fromRGB(255, 50, 50), function(color)
    GUI:ApplyTheme({Accent = color}) -- Пример динамической смены акцента
end)

```

### ### Бинд клавиш (Keybind)

```lua
MainTab:AddKeybind("Скрыть меню", Enum.KeyCode.RightControl, function()
    GUI:Toggle()
end)

```

### ### Поле ввода (TextBox)

```lua
MainTab:AddTextBox("Ник игрока", "Введите имя...", function(text, confirmed)
    if confirmed then
        print("Введенный ник:", text)
    end
end)

```

---

## ## 5. Особенности и Мобильная поддержка

* **Мобильная кнопка**: При запуске на телефонах автоматически появляется кнопка "T". Её можно перетаскивать.
* **Перетаскивание меню**: Удерживайте заголовок (Header) меню, чтобы переместить его.
* **Авто-скролл**: Вкладки автоматически расширяются вниз, если элементов становится слишком много.

---

## ## 6. Пример готового скрипта

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

GUI:Notify("Success", "TerrorUi Loaded!", 3)

```
