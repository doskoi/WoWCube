﻿-- Version : Russian
-- Translated by StingerSoft aka Eritnull

function TitanLocalizeRU() 
	TITAN_DEBUG = "<Titan>";
	TITAN_INFO = "<Titan>"

	TITAN_NA = "N/A";
	TITAN_SECONDS = "секунды";
	TITAN_MINUTES = "минуьы";
	TITAN_HOURS = "часы";
	TITAN_DAYS = "дни";
	TITAN_SECONDS_ABBR = "с";
	TITAN_MINUTES_ABBR = "м";
	TITAN_HOURS_ABBR = "ч";
	TITAN_DAYS_ABBR = "д";
	TITAN_MILLISECOND = "мс";
	TITAN_KILOBYTES_PER_SECOND = "КБ/с";
	TITAN_KILOBITS_PER_SECOND = "кбит/с"
	TITAN_MEGABYTE = "мб";
	TITAN_NONE = "None";
	
	TITAN_MOVABLE_TOOLTIP = "Тяните для перемещения";

	TITAN_PANEL_ERROR_DUP_PLUGIN = " возможно зарегистрирован дважды, неудается загрузить Titan panel, пожалуйста исправьте эту проблему"
	TITAN_PANEL_ERROR_PROF_DELCURRENT = "Вы не можете удалить свой текущий профиль.";
	TITAN_PANEL_RESET_WARNING = GREEN_FONT_COLOR_CODE.."Предупреждение:"..FONT_COLOR_CODE_CLOSE.."Будут сброшены настройки ваших полос(ы) и панели на стандартные значения и будет пересоздан ваш текущий профиль. Если вы уверены в своих действиях, и хотите продолжить, то нажмите 'Accept' (ваш интерфей перезагрузится), или же нажмите 'Cancel' или клавишу 'Escape'.";
	
	-- slash command help
	TITAN_PANEL_SLASH_STRING2 = LIGHTYELLOW_FONT_COLOR_CODE.."Используйте: |cffffffff/tp {reset | reset tipfont/tipalpha/panelscale/spacing}";
	TITAN_PANEL_SLASH_STRING3 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset: |cffffffffСбрасывает все на стандартные значения/позиции.";
	TITAN_PANEL_SLASH_STRING4 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset tipfont: |cffffffffСбрасывает масштаб шрифта подсказки панели на стандартное значение.";
	TITAN_PANEL_SLASH_STRING5 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset tipalpha: |cffffffffСбрасывает прозрачность подсказки панели на стандартное значение.";
	TITAN_PANEL_SLASH_STRING6 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset panelscale: |cffffffffСбрасывает масштаб на стандартное значение.";
	TITAN_PANEL_SLASH_STRING7 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."reset spacing: |cffffffffСбрасывает расстояние кнопок  на стандартное значение.";
	TITAN_PANEL_SLASH_STRING8 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui control: |cffffffffОткрывает интерфейс Ace3 контроля панели.";
	TITAN_PANEL_SLASH_STRING9 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui trans: |cffffffffОткрывает интерфейс Ace3 контроля прозрачности.";
	TITAN_PANEL_SLASH_STRING10 = " - "..LIGHTYELLOW_FONT_COLOR_CODE.."gui skin: |cffffffffОткрывает интерфейс Ace3 контроля шкурок.";
    TITAN_PANEL_SLASH_STRING11 = LIGHTYELLOW_FONT_COLOR_CODE.."Для помощи по BonusScanner, введите : |cffffffff/bscan";
	
	-- slash command responses
	TITAN_PANEL_SLASH_RESP1 = LIGHTYELLOW_FONT_COLOR_CODE.."Масштаб шрифта подсказки Titan Panel сброшен.";
	TITAN_PANEL_SLASH_RESP2 = LIGHTYELLOW_FONT_COLOR_CODE.."Прозрачность шрифта подсказки Titan Panel сброшена.";
	TITAN_PANEL_SLASH_RESP3 = LIGHTYELLOW_FONT_COLOR_CODE.."Масштаб Titan Panel сброшен.";
	TITAN_PANEL_SLASH_RESP4 = LIGHTYELLOW_FONT_COLOR_CODE.."Расстояние кнопок Titan Panel сброшено.";
	
	-- general panel locale
	TITAN_PANEL = "Титан Панель";
	TITAN_PANEL_VERSION_INFO = "|cffffffff by the |cffff8c00Titan Dev Team".." |cffffffff(HonorGoG, joejanko, Lothayer, Tristanian, oXidFoX, urnati & StingerSoft)";
	TITAN_PANEL_MENU_TITLE = "Титан панель";
	TITAN_PANEL_MENU_HIDE = "Скрыть";
	TITAN_PANEL_MENU_CUSTOMIZE = "Настроить";
	TITAN_PANEL_MENU_IN_COMBAT_LOCKDOWN = "(В Бою)";
	TITAN_PANEL_MENU_RELOADUI = "(Перезагрузить ПИ)";
	TITAN_PANEL_MENU_SHOW_COLORED_TEXT = "Показывать цветной текст";
	TITAN_PANEL_MENU_SHOW_ICON = "Показывать иконку";
	TITAN_PANEL_MENU_SHOW_LABEL_TEXT = "Текст ярлыка";
	TITAN_PANEL_MENU_AUTOHIDE = "Авто-скрытие";
	TITAN_PANEL_MENU_BGMINIMAP = "Мини-карта ПС";
	TITAN_PANEL_MENU_CENTER_TEXT = "Текст в центре";
	TITAN_PANEL_MENU_DISPLAY_ONTOP = "Показывать сверху";
	TITAN_PANEL_MENU_DISPLAY_BOTH = "Показывать обе полосы";
	TITAN_PANEL_MENU_DISABLE_PUSH = "Выключить подстройку экрана";
	TITAN_PANEL_MENU_DISABLE_MINIMAP_PUSH = "Отключить подстройку мини-карты";
	TITAN_PANEL_MENU_DISABLE_LOGS = "Авто подстройка записи";
	TITAN_PANEL_MENU_BUILTINS = "Сборки титана";
	TITAN_PANEL_MENU_LEFT_SIDE = "Левая сторона";
	TITAN_PANEL_MENU_RIGHT_SIDE = "Правая сторона";
	TITAN_PANEL_MENU_PROFILES = "Профиля";
	TITAN_PANEL_MENU_PROFILE = "Профиль ";
	TITAN_PANEL_MENU_PROFILE_CUSTOM = "Выборочный";
	TITAN_PANEL_MENU_PROFILE_DELETED = " удален.";
	TITAN_PANEL_MENU_PROFILE_SERVERS = "Сервер";
	TITAN_PANEL_MENU_PROFILE_CHARS = "Персонаж";
	TITAN_PANEL_MENU_PROFILE_RELOADUI = "Ваш UI будет перезагружен после нажатия 'Okay' для сохранения вашего профиля.";
	TITAN_PANEL_MENU_PROFILE_SAVE_CUSTOM_TITLE = "Введите имя вашего профиля:\n(Макс 20 букв, пропуск недопустим)";
	TITAN_PANEL_MENU_PROFILE_SAVE_PENDING = "Настройки текущей панели будут сохранены под названием профиля: ";
	TITAN_PANEL_MENU_PROFILE_ALREADY_EXISTS = "Введенное имя профиля уже существует. Пожалуйста введите уникальное имя.";
	TITAN_PANEL_MENU_MANAGE_SETTINGS = "Управление";
	TITAN_PANEL_MENU_LOAD_SETTINGS = "Загрузить настройки";
	TITAN_PANEL_MENU_DELETE_SETTINGS = "Удалить";
	TITAN_PANEL_MENU_SAVE_SETTINGS = "Сохранить";
	TITAN_PANEL_MENU_DOUBLE_BAR = "Двойные Полосы";
	TITAN_PANEL_MENU_CONFIGURATION = "Конфигурация";
	TITAN_PANEL_MENU_OPTIONS = "Опции";
	TITAN_PANEL_MENU_OPTIONS_PANEL = "Панель";
	TITAN_PANEL_MENU_OPTIONS_BARS = "Панели";
	TITAN_PANEL_MENU_OPTIONS_TOOLTIPS = "Подсказки";
	TITAN_PANEL_MENU_OPTIONS_FRAMES = "Фреймы";
	TITAN_PANEL_MENU_OPTIONS_LDB = "Data Broker";
	TITAN_PANEL_MENU_PLUGINS = "Плагины";
	TITAN_PANEL_MENU_LOCK_BUTTONS = "Блокировать кнопки";
	TITAN_PANEL_MENU_VERSION_SHOWN = "Показывать версии плагинов";
	TITAN_PANEL_MENU_LDB_SHOWN = "Показ суффикс Broker плагина";
	TITAN_PANEL_MENU_LDB_SIDE = "Плагин справа";
	TITAN_PANEL_MENU_LDB_FORCE_LAUNCHER = "Направить модули запусков в правую сторону";
	TITAN_PANEL_MENU_DISABLE_FONT = "Выключить масштабирование шрифтов";
	TITAN_PANEL_MENU_CATEGORIES = {"Общее","Бой","Информация","Интерфейс","Профессия"}
	TITAN_PANEL_MENU_TOOLTIPS_SHOWN = "Показывать подсказки";
	TITAN_PANEL_MENU_TOOLTIPS_SHOWN_IN_COMBAT = "Скрыть подсказки в бою";
	TITAN_PANEL_MENU_CASTINGBAR = "Двигать полосу применения заклинания";
	TITAN_PANEL_MENU_RESET = "Сброс панели на стандарт";
	TITAN_PANEL_MENU_TEXTURE_SETTINGS = "Настройки шкурки";	
	TITAN_PANEL_MENU_FONT = "Шрифт";
	TITAN_PANEL_MENU_LSM_FONTS = "Шрифты LibSharedMedia"
	TITAN_PANEL_MENU_ENABLED = "Включен";
	TITAN_PANEL_MENU_DISABLED = "Отключен";
	
	-- localization strings for AceConfigDialog-3.0     
	TITAN_PANEL_CONFIG_MAIN_LABEL = "Аддон отображения полосы информации. Позволяет пользователям добавлять вывод данных или плагины модуля запуска на верхнюю панель или нижнюю.";			 
	TITAN_TRANS_MENU_TEXT_SHORT = "Прозрачность";
	TITAN_TRANS_MENU_DESC = "Регулировка прозрачности панели Титана и подсказкиp.";
	TITAN_TRANS_MAIN_CONTROL_TITLE = "Главная панель";
	TITAN_TRANS_AUX_CONTROL_TITLE = "Вспомог-ная панель";
	TITAN_TRANS_CONTROL_TITLE_TOOLTIP = "Подсказка";
	TITAN_TRANS_MAIN_BAR_DESC = "Регулировка прозрачности главной панели.";
	TITAN_TRANS_AUX_BAR_DESC = "Регулировка прозрачности вспомогательной (нижней) панели.";
	TITAN_TRANS_TOOLTIP_DESC = "Регулировка прозрачности подсказки различных плагинов.";
	TITAN_UISCALE_MENU_TEXT = "Управление панелью";
	TITAN_UISCALE_CONTROL_TITLE_UI = "Размер интерфейса";
	TITAN_UISCALE_CONTROL_TITLE_PANEL = "Размер панели";
	TITAN_UISCALE_CONTROL_TITLE_BUTTON = "Расстояние кнопок";
	TITAN_UISCALE_CONTROL_TOOLTIP_TOOLTIPFONT = "Размер шрифта подсказок";
	TITAN_UISCALE_TOOLTIP_DISABLE_TEXT = "Отключить маштабирование шрифта подсказок";
	TITAN_UISCALE_MENU_DESC = "Управление различными аспектами панели и интерфейса.";
	TITAN_UISCALE_SLIDER_DESC = "Регулировка масштаба вашего интерфейса.";
	TITAN_UISCALE_PANEL_SLIDER_DESC = "Регулировка масштаба различных кнопок и иконкк панели.";
	TITAN_UISCALE_BUTTON_SLIDER_DESC = "Регулировка пространства между плагинами с левой стороны.";
	TITAN_UISCALE_TOOLTIP_SLIDER_DESC = "Регулировка размера подсказки различных плагинов.";
	TITAN_UISCALE_DISABLE_TOOLTIP_DESC = "Отключить контроль масштабирования шрифта подсказок Титана.";
	TITAN_SKINS_MAIN_DESC = "Управление различными шкурками для панелей Титана.";
	TITAN_SKINS_LIST_TITLE = "Список шкурок";
	TITAN_SKINS_SET_DESC = "Выберите шкурку для панелей Титана.";
	TITAN_SKINS_SET_HEADER = "Установить шкурку панели";
	TITAN_SKINS_NEW_HEADER = "Добавить новую шкурку";
	TITAN_SKINS_NAME_TITLE = "Название шкурки";
	TITAN_SKINS_NAME_DESC = "Введите название вашей новой шкурки.";
	TITAN_SKINS_NAME_EXAMPLE = "пример: Моя шкурка для Титана";
	TITAN_SKINS_PATH_TITLE = "Путь к шкурке";
	TITAN_SKINS_PATH_DESC = "Введите точный путь к месту гне расположены рисунки вашей шкурки, как показано в примере и в объяснении 'Совет'.";
	TITAN_SKINS_PATH_EXAMPLE = "пример: Interface\\AddOns\\Titan\\Artwork\\Custom\\<папка вашей шкурки>\\";
	TITAN_SKINS_ADD_HEADER = "Добавить шкурку";
	TITAN_SKINS_ADD_DESC = "Добавить новую шкурку, в список доступных шкурок панели.";
	TITAN_SKINS_REMOVE_HEADER = "Удалить шкурку";
	TITAN_SKINS_REMOVE_DESC = "Выберите шкурку для удаления, из доступных шкурок панели.";
	TITAN_SKINS_REMOVE_BUTTON = "Удалить";
	TITAN_SKINS_REMOVE_BUTTON_DESC = "Удалить выбранную шкурку, из списка доступных шкурок панели.";
	TITAN_SKINS_NOTES = "|cff19ff19Совет:|r Добавляя новую шкурку, пожалуйста убедитесь, что папка, содержащая ваши художественные работы, была создана до загрузки 'World of Warcraft', и путь, введенный здесь, полностью соответствует реальному пути (пути вводите с учетом регистра и всегда заканчивайте '\\' символами).";
	-- /end localization strings for AceConfigDialog-3.0
	
	TITAN_AUTOHIDE_TOOLTIP = "Авто-скрытие панели вкл/выкл";
	TITAN_AUTOHIDE_MENU_TEXT = "Авто-скрытие";
	
	TITAN_AMMO_FORMAT = "%d";
	TITAN_AMMO_BUTTON_LABEL_AMMO = "Боеприпасы: ";
	TITAN_AMMO_BUTTON_LABEL_THROWN = "Бросок: ";
	TITAN_AMMO_BUTTON_LABEL_AMMO_THROWN = "Боеприпасов/Бросок: ";
	TITAN_AMMO_TOOLTIP = "Число доступных Боеприпасов/Бросков";
	TITAN_AMMO_MENU_TEXT = "Боеприпасы/Броски";
	TITAN_AMMO_BUTTON_NOAMMO = "Нет боеприпасов";
	TITAN_AMMO_MENU_REFRESH = "Обновление отображения";
	TITAN_AMMO_BULLET_NAME = "Show ammo name";
	
	TITAN_BAG_FORMAT = "%d/%d";
	TITAN_BAG_BUTTON_LABEL = "Сумки: ";
	TITAN_BAG_TOOLTIP = "Использование сумок";
	TITAN_BAG_TOOLTIP_HINTS = "ЛКМ -открыть все сумки";
	TITAN_BAG_MENU_TEXT = "Сумки";
	TITAN_BAG_USED_SLOTS = "Используемые слоты";
	TITAN_BAG_FREE_SLOTS = "Свободные слоты";
	TITAN_BAG_BACKPACK = "Рюкзак";
	TITAN_BAG_MENU_SHOW_USED_SLOTS = "Показывать исп. сумки";
	TITAN_BAG_MENU_SHOW_AVAILABLE_SLOTS = "Показывать доступные слоты";
	TITAN_BAG_MENU_SHOW_DETAILED = "Отображать подробную подсказку";
	TITAN_BAG_MENU_IGNORE_AMMO_POUCH_SLOTS = "Игнорорировать Подсумок";
	TITAN_BAG_MENU_IGNORE_SHARD_BAGS_SLOTS = "Игнорорировать сумки осколков";
	TITAN_BAG_MENU_IGNORE_PROF_BAGS_SLOTS = "Игнорорировать сумки для профф";
	TITAN_BAG_SHARD_BAG_NAMES = {"Мешок душ","Малая сума душ","Коробка душ","Сумка из ткани Скверны","Сумка из сердцевинной ткани Скверны","Черная сумка теней","Сумка Бездны"};
	TITAN_BAG_AMMO_POUCH_NAMES = {"Колчан из шкуры копытня", "Колчан из шкуры ворга", "Древняя перетянутая жилами ламина", "Колчан тысячи оперений", "Колчан из узловатой кожи", "Колчан из шкуры гарпии", "Колчан Риббли", "Колчан быстрой тетивы", "Тяжелый колчан", "Колчан Ночного Дозора", "Охотничий колчан", "Средний колчан", "Колчан из тонкой кожи", "Небольшой колчан", "Легкий колчан", "Подсумок контрабандиста", "Подсумок из узловатой кожи", "Подсумок из чешуи дракона Пустоты", "Нагрудный патронташ из кожи гнолла", "Нагрудный патронташ Риббли", "Подсумок из плотной кожи", "Подсумок из толстой кожи", "Нагрудный патронташ Ночного Дозора", "Средний патронташ", "Охотничья сумка для боеприпасов", "Небольшой кожаный подсумок", "Небольшой патронташ", "Небольшой подсумок","Подсумок из драконьей чешуи","Усиленный нерубский колчан"};
	TITAN_BAG_PROF_BAG_NAMES = {"Зачарованный мешочек из магической ткани","Зачарованная сумка из рунной ткани","Большая сумка зачаровывателя","Сумка зачаровывателя","Сумка из чароткани","Кориевый ящик с инструментами","Ящик для инструментов из оскверненного железа","Тяжелый ящик с инструментами","Мешочек для самоцветов","Сумка для драгоценностей","Укрепленная шахтерская сумка","Шахтерский мешок","Сумка кожевника","Сумка Многих шкур","Мешочек для трав","Сумка для трав Ценариона","Сумка Ценариона","Ботаническая сумка Микаа","Кориевый ящик с инструментами","Шахтерская сумка из шкуры мамонта","Походная сума зверолова","Таинственная котомка","Рюкзак с бесчисленными карманами"};

	TITAN_BGMINIMAP_MENU_TEXT = "Мини-карта Поля Сражения"
	TITAN_BGMINIMAP_TOOLTIP = "Переключение мини-карты полей сражений."
	
	TITAN_CLOCK_TOOLTIP = "Часы";
	TITAN_CLOCK_TOOLTIP_VALUE = "Часовое смещение: ";
	TITAN_CLOCK_TOOLTIP_LOCAL_TIME = "Местное время: ";
	TITAN_CLOCK_TOOLTIP_SERVER_TIME = "Серверное время: ";
	TITAN_CLOCK_TOOLTIP_SERVER_ADJUSTED_TIME = "Заданное серверное время: ";
	TITAN_CLOCK_TOOLTIP_HINT1 = "ЛКМ для настройки разницы с ОФФ"
	TITAN_CLOCK_TOOLTIP_HINT2 = "12/24 ч формат";
	TITAN_CLOCK_TOOLTIP_HINT3 = "[Shift Левый-Клик] открывает календарь.";
	TITAN_CLOCK_CONTROL_TOOLTIP = "Часовое смещение: ";
	TITAN_CLOCK_CONTROL_TITLE = "Смещение";
	TITAN_CLOCK_CONTROL_HIGH = "+12";
	TITAN_CLOCK_CONTROL_LOW = "-12";
	TITAN_CLOCK_CHECKBUTTON = "Фрмт 24ч";
	TITAN_CLOCK_CHECKBUTTON_TOOLTIP = "Преключение между отображением времени в 12-часовым и 24-часовым форматом";
	TITAN_CLOCK_MENU_TEXT = "Часы";
	TITAN_CLOCK_MENU_LOCAL_TIME = "Отображать местное время(М)";
	TITAN_CLOCK_MENU_SERVER_TIME = "Отображать серверное время (С)";
	TITAN_CLOCK_MENU_SERVER_ADJUSTED_TIME = "Отображать заданное серверное время (З)";
	TITAN_CLOCK_MENU_DISPLAY_ON_RIGHT_SIDE = "Отображать часы справа";
	TITAN_CLOCK_MENU_HIDE_GAMETIME = "Скрыть кнопку времени/календаря";
	
	TITAN_COORDS_FORMAT = "(%.d, %.d)";
	TITAN_COORDS_FORMAT2 = "(%.1f, %.1f)";
	TITAN_COORDS_FORMAT3 = "(%.2f, %.2f)";
	TITAN_COORDS_FORMAT_LABEL = "(xx , yy)";
	TITAN_COORDS_FORMAT2_LABEL = "(xx.x , yy.y)";
	TITAN_COORDS_FORMAT3_LABEL = "(xx.xx , yy.yy)";
	TITAN_COORDS_FORMAT_COORD_LABEL = "Формат координат";
	TITAN_COORDS_BUTTON_LABEL = "Место: ";
	TITAN_COORDS_TOOLTIP = "Информация о локации";
	TITAN_COORDS_TOOLTIP_HINTS_1 = "Shift + ЛКМ для добавления локации";
	TITAN_COORDS_TOOLTIP_HINTS_2 = "Информации в чат";
	TITAN_COORDS_TOOLTIP_ZONE = "Зона: ";
	TITAN_COORDS_TOOLTIP_SUBZONE = "Подзона: ";
	TITAN_COORDS_TOOLTIP_PVPINFO = "PVP инфо: ";
	TITAN_COORDS_TOOLTIP_HOMELOCATION = "Место дома";
	TITAN_COORDS_TOOLTIP_INN = "Дом: ";
	TITAN_COORDS_MENU_TEXT = "Координаты";
	TITAN_COORDS_MENU_SHOW_ZONE_ON_PANEL_TEXT = "Показывать зону";
	TITAN_COORDS_MENU_SHOW_COORDS_ON_MAP_TEXT = "Показывать координаты на мировой карте";
	TITAN_COORDS_MAP_CURSOR_COORDS_TEXT = "Курсор(X,Y): %s";
	TITAN_COORDS_MAP_PLAYER_COORDS_TEXT = "Игрок(X,Y): %s";
	TITAN_COORDS_NO_COORDS = "Нет координат";
	
	TITAN_FPS_FORMAT = "%.1f";
	TITAN_FPS_BUTTON_LABEL = "FPS: ";
	TITAN_FPS_MENU_TEXT = "FPS";
	TITAN_FPS_TOOLTIP_CURRENT_FPS = "Текущий FPS: ";
	TITAN_FPS_TOOLTIP_AVG_FPS = "Средний FPS: ";
	TITAN_FPS_TOOLTIP_MIN_FPS = "Мин. FPS: ";
	TITAN_FPS_TOOLTIP_MAX_FPS = "Макс. FPS: ";
	TITAN_FPS_TOOLTIP = "Кадров в секунду";
	
	TITAN_LATENCY_FORMAT = "%d"..TITAN_MILLISECOND;
	TITAN_LATENCY_BANDWIDTH_FORMAT = "%.3f "..TITAN_KILOBYTES_PER_SECOND;
	TITAN_LATENCY_BUTTON_LABEL = "Пинг: ";
	TITAN_LATENCY_TOOLTIP = "Статус сети";
	TITAN_LATENCY_TOOLTIP_LATENCY = "Пинг: ";
	TITAN_LATENCY_TOOLTIP_BANDWIDTH_IN = "Вход пропуск.способность: ";
	TITAN_LATENCY_TOOLTIP_BANDWIDTH_OUT = "Выход пропуск.способность: ";
	TITAN_LATENCY_MENU_TEXT = "Пинг";
	
	TITAN_LOOTTYPE_BUTTON_LABEL = "Добыча: ";
	TITAN_LOOTTYPE_FREE_FOR_ALL = "Каждый за себя";
	TITAN_LOOTTYPE_ROUND_ROBIN = "По очереди";
	TITAN_LOOTTYPE_MASTER_LOOTER = "Ответственный за добычу";
	TITAN_LOOTTYPE_GROUP_LOOT = "Групповая очередь";
	TITAN_LOOTTYPE_NEED_BEFORE_GREED = "Приоритет по нужности";
	TITAN_LOOTTYPE_TOOLTIP = "Информация о типе добычи";
	TITAN_LOOTTYPE_MENU_TEXT = "Тип добычи";
	TITAN_LOOTTYPE_RANDOM_ROLL_LABEL = "Случайный ролл";
	TITAN_LOOTTYPE_TOOLTIP_HINT1 = "Совет: ЛКМ для случайного рола.";
	TITAN_LOOTTYPE_TOOLTIP_HINT2 = "ПКМ: Выберите тип ролла из меню.";
	
	TITAN_MEMORY_FORMAT = "%.3f"..TITAN_MEGABYTE;
	TITAN_MEMORY_FORMAT_KB = "%d".."KB";
	TITAN_MEMORY_RATE_FORMAT = "%.3f"..TITAN_KILOBYTES_PER_SECOND;
	TITAN_MEMORY_BUTTON_LABEL = "Память: ";
	TITAN_MEMORY_TOOLTIP = "Использование памяти";
	TITAN_MEMORY_TOOLTIP_CURRENT_MEMORY = "Текущая: ";
	TITAN_MEMORY_TOOLTIP_INITIAL_MEMORY = "Исходная: ";
	TITAN_MEMORY_TOOLTIP_INCREASING_RATE = "Темп прироста: ";
	TITAN_MEMORY_KBMB_LABEL = "KB/MB"; 	
	
	TITAN_MONEY_GOLD = "з";
	TITAN_MONEY_SILVER = "с";
	TITAN_MONEY_COPPER = "м";
	TITAN_MONEY_FORMAT = "%d"..TITAN_MONEY_GOLD..", %d"..TITAN_MONEY_SILVER..", %d"..TITAN_MONEY_COPPER;
	
	TITAN_PERFORMANCE_TOOLTIP = "Производительность";
	TITAN_PERFORMANCE_MENU_TEXT = "Производительность";
	TITAN_PERFORMANCE_ADDONS = "Аддоны используют";
	TITAN_PERFORMANCE_ADDON_MEM_USAGE_LABEL = "Использование памети аддонами";
	TITAN_PERFORMANCE_ADDON_MEM_FORMAT_LABEL = "Формат памяти аддонов";
	TITAN_PERFORMANCE_ADDON_CPU_USAGE_LABEL = "Загрузка ЦПУ аддонами";
	TITAN_PERFORMANCE_ADDON_NAME_LABEL = "Имя:";
	TITAN_PERFORMANCE_ADDON_USAGE_LABEL = "Испл";
	TITAN_PERFORMANCE_ADDON_RATE_LABEL = "Скорость";
	TITAN_PERFORMANCE_ADDON_TOTAL_MEM_USAGE_LABEL = "Всего памети на аддоны:";
	TITAN_PERFORMANCE_ADDON_TOTAL_CPU_USAGE_LABEL = "Всего ЦПУ:";
	TITAN_PERFORMANCE_MENU_SHOW_FPS = "Показывать FPS";
	TITAN_PERFORMANCE_MENU_SHOW_LATENCY = "Показывать латентность";
	TITAN_PERFORMANCE_MENU_SHOW_MEMORY = "Показывать память";
	TITAN_PERFORMANCE_MENU_SHOW_ADDONS = "Покапз исп. памети аддонами";
	TITAN_PERFORMANCE_MENU_SHOW_ADDON_RATE = "Показ размер исп. аддонами";
	TITAN_PERFORMANCE_MENU_CPUPROF_LABEL = "Режим анализа ЦПУ";
	TITAN_PERFORMANCE_MENU_CPUPROF_LABEL_ON = "Включить режим анализа ЦПУ ";
	TITAN_PERFORMANCE_MENU_CPUPROF_LABEL_OFF = "Отключить режим анализа ЦПУ ";
	TITAN_PERFORMANCE_CONTROL_TOOLTIP = "Мониторинг Аддонов: ";
	TITAN_PERFORMANCE_CONTROL_TITLE = "Мониторинг Аддонов";
	TITAN_PERFORMANCE_CONTROL_HIGH = "40";
	TITAN_PERFORMANCE_CONTROL_LOW = "1";
	TITAN_PERFORMANCE_TOOLTIP_HINT = "Совет: ЛКМ для Чистки памяти.";
	
	TITAN_XP_FORMAT = "%d";
	TITAN_XP_PERCENT_FORMAT = TITAN_XP_FORMAT.." (%.1f%%)";
	TITAN_XP_BUTTON_LABEL_XPHR_LEVEL = "ОПТ/ч на этом уровне: ";
	TITAN_XP_BUTTON_LABEL_XPHR_SESSION = "ОПТ/ч за эту сессию: ";
	TITAN_XP_BUTTON_LABEL_TOLEVEL_TIME_LEVEL = "Время до уровня: ";
	TITAN_XP_LEVEL_COMPLETE = "Завершение уровня: ";
	TITAN_XP_TOTAL_RESTED = "Отдых: ";
	TITAN_XP_XPTOLEVELUP = "Опыта до поднятия урв: ";
	TITAN_XP_TOOLTIP = "Информация о опыте";
	TITAN_XP_TOOLTIP_TOTAL_TIME = "Всего времени сыграно: ";
	TITAN_XP_TOOLTIP_LEVEL_TIME = "Время игры на этом уровне: ";
	TITAN_XP_TOOLTIP_SESSION_TIME = "Время сыграно за эту сессию: ";
	TITAN_XP_TOOLTIP_TOTAL_XP = "Всего Опыта на этот уровень: ";
	TITAN_XP_TOOLTIP_LEVEL_XP = "Опыта получено на этом уровне: ";
	TITAN_XP_TOOLTIP_TOLEVEL_XP = "Опыта нужно для уровня: ";
	TITAN_XP_TOOLTIP_SESSION_XP = "Опыта получено за эту сессию: ";
	TITAN_XP_TOOLTIP_XPHR_LEVEL = "Опыт/ч на этом уровне: ";
	TITAN_XP_TOOLTIP_XPHR_SESSION = "Опыт/ч за эту сессию: ";
	TITAN_XP_TOOLTIP_TOLEVEL_LEVEL = "Время до уровня (темп уровня): ";
	TITAN_XP_TOOLTIP_TOLEVEL_SESSION = "Время до уровня (темп сессии): ";
	TITAN_XP_MENU_TEXT = "Опыт";
	TITAN_XP_MENU_SHOW_XPHR_THIS_LEVEL = "Показывать Опыт/ч на этом уровне";
	TITAN_XP_MENU_SHOW_XPHR_THIS_SESSION = "Показывать Опыт/ч за эту сессию";
	TITAN_XP_MENU_SHOW_RESTED_TOLEVELUP = "Вид мульти-инфо";
  TITAN_XP_MENU_SIMPLE_BUTTON_TITLE = "Кнопка";
  TITAN_XP_MENU_SIMPLE_BUTTON_RESTED = "Показ опыта за отдых";
  TITAN_XP_MENU_SIMPLE_BUTTON_TOLEVELUP = "Показ опыта до уровня";
  TITAN_XP_MENU_SIMPLE_BUTTON_KILLS = "Показ прим.убийств до уровня";
	TITAN_XP_MENU_RESET_SESSION = "Сбросить сессию";
	TITAN_XP_MENU_REFRESH_PLAYED = "Обновить таймеры";
	TITAN_XP_UPDATE_PENDING = "Обновляется...";
	TITAN_XP_UNKNOWN = "неизвестно";
	TITAN_XP_KILLS_LABEL = "Убийств до уровня (%d опыта полученно): ";
	TITAN_XP_KILLS_LABEL_SHORT = "Оц. Убийств: ";
	
	TITAN_REGEN_MENU_TEXT 				= "Реген"
	TITAN_REGEN_MENU_TOOLTIP_TITLE		= "Инфо о Регене"
	TITAN_REGEN_MENU_SHOW1 				= "Показывать"
	TITAN_REGEN_MENU_SHOW2 				= "ЗД"
	TITAN_REGEN_MENU_SHOW3 				= "МН"
	TITAN_REGEN_MENU_SHOW4				= "в процентах"
	TITAN_REGEN_BUTTON_TEXT_HP 			= "ЗД: "..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
	TITAN_REGEN_BUTTON_TEXT_HP_PERCENT 	= "ЗД: "..HIGHLIGHT_FONT_COLOR_CODE.."%.2f"..FONT_COLOR_CODE_CLOSE;
	TITAN_REGEN_BUTTON_TEXT_MP 			= " МН: "..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
	TITAN_REGEN_BUTTON_TEXT_MP_PERCENT 	= " МН: "..HIGHLIGHT_FONT_COLOR_CODE.."%.2f"..FONT_COLOR_CODE_CLOSE;
	TITAN_REGEN_TOOLTIP1				= "Здоровье: \t"..GREEN_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." / " ..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." ("..RED_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE..")";
	TITAN_REGEN_TOOLTIP2				= "Мана: \t"..GREEN_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." / " ..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." ("..RED_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE..")";
	TITAN_REGEN_TOOLTIP3				= "Лучший ЗД реген: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
	TITAN_REGEN_TOOLTIP4				= "Худший ЗД реген: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
	TITAN_REGEN_TOOLTIP5				= "Лучший МН реген: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
	TITAN_REGEN_TOOLTIP6				= "Худший МН реген: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE;
	TITAN_REGEN_TOOLTIP7				= "МН реген в последней схватке: \t"..HIGHLIGHT_FONT_COLOR_CODE.."%d"..FONT_COLOR_CODE_CLOSE.." ("..GREEN_FONT_COLOR_CODE.."%.2f"..FONT_COLOR_CODE_CLOSE.."%%)";

	TITAN_ITEMBONUSES_TEXT = "Бонусы предметов";
	TITAN_ITEMBONUSES_DISPLAY_NONE = "Показывать отсутствие";
	TITAN_ITEMBONUSES_SHORTDISPLAY = "Сокращенный текст";
	TITAN_ITEMBONUSES_BONUSSCANNER_MISSING = "Необходим аддон BonusScanner";
	TITAN_ITEMBONUSES_AVERAGE_ILVL = "Display average item level";
	TITAN_ITEMBONUSES_RATING_CONVERSION = "Отображать рейтинг как очки/проценты";
	TITAN_ITEMBONUSES_SHOWGEMS = "Отображать количество цветов самоцветов";

	TITAN_ITEMBONUSES_CAT_ATT = "Атрибуты";
	TITAN_ITEMBONUSES_CAT_RES = "Сопротивления";
	TITAN_ITEMBONUSES_CAT_SKILL = "Навыки";
	TITAN_ITEMBONUSES_CAT_BON = "Ближний и дальний бой";
	TITAN_ITEMBONUSES_CAT_SBON = "Заклинания";
	TITAN_ITEMBONUSES_CAT_OBON = "Жизнь и мана";
	TITAN_ITEMBONUSES_CAT_EBON = "Спец бонусы";

	--Titan Repair
	REPAIR_LOCALE["pattern"] = "^Прочность: (%d+) / (%d+)$";
	REPAIR_LOCALE["menu"] = "Инфо о прочности брони";
	REPAIR_LOCALE["tooltip"] = "Информация о прочности амуниции";
	REPAIR_LOCALE["button"] = "Прочность: ";
	REPAIR_LOCALE["normal"] = "Стоимость рестоврации (Стандарт): ";
	REPAIR_LOCALE["friendly"] = "Стоимость рестоврации (Дружелюбие): ";
	REPAIR_LOCALE["honored"] = "Стоимость рестоврации (Уважение): ";
	REPAIR_LOCALE["revered"] = "Стоимость рестоврации (Почтитение): ";
	REPAIR_LOCALE["exalted"] = "Стоимость рестоврации (Восторг): ";
	REPAIR_LOCALE["buttonNormal"] = "Показать Стандарт";
	REPAIR_LOCALE["buttonFriendly"] = "Показать Дружелюбие (5%)";
	REPAIR_LOCALE["buttonHonored"] = "Показать Уважение (10%)";
	REPAIR_LOCALE["buttonRevered"] = "Показать Почтитение (15%)";
	REPAIR_LOCALE["buttonExalted"] = "Показать Восторг (20%)";
	REPAIR_LOCALE["percentage"] = "Показывать в процентах";
	REPAIR_LOCALE["itemnames"] = "Показывать имя предмета";
	REPAIR_LOCALE["mostdamaged"] = "Показывать наибольше повреждённую";
	REPAIR_LOCALE["showdurabilityframe"] = "Показывать фрейм прочности";
	REPAIR_LOCALE["undamaged"] = "Показывать неповреждённые предметы";
	REPAIR_LOCALE["discount"] = "Скидка";
	REPAIR_LOCALE["nothing"] = "Нет поврежденных вещей.";
	REPAIR_LOCALE["confirmation"] = "Ты хочешь отрестоврировать все одетые предметы?";
	REPAIR_LOCALE["badmerchant"] = "Этот торговец не может рестоврировать.";
	REPAIR_LOCALE["popup"] = "Показать всплывающее меню рестоврации";
	REPAIR_LOCALE["showinventory"] = "Подсчет повреждение инвенторя";
	REPAIR_LOCALE["WholeScanInProgress"] = "Обновление...";
	REPAIR_LOCALE["AutoReplabel"] = "Авто-Рестоврация";
	REPAIR_LOCALE["AutoRepitemlabel"] = "Авто-Рестоврация всех предметов";
	REPAIR_LOCALE["ShowRepairCost"] = "Отображать стоимость рестоврации";
	

	TITAN_PLUGINS_MENU_TITLE = "Плагины";
	
end