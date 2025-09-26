# app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and# 🌤️ Flutter Weather App

Современное мобильное приложение для получения актуальной информации о погоде с красивым интерфейсом и расширенной функциональностью.

## 📱 Особенности

- **Актуальная погода**: Получение текущих погодных условий для любого города
- **Детальный прогноз**: Почасовой и ежедневный прогноз погоды
- **Избранные города**: Сохранение любимых городов для быстрого доступа
- **Умный поиск**: Автодополнение при поиске городов
- **Детальная информация**: Температура, влажность, скорость ветра, видимость и многое другое
- **Красивый интерфейс**: Современный Material Design
- **Кросс-платформенность**: Поддержка Android, iOS, Web, Windows, macOS, Linux

## 🛠️ Технологии и архитектура

### Основные технологии
- **Flutter 3.8.1+** - UI фреймворк
- **Dart** - язык программирования
- **OpenWeatherMap API** - источник данных о погоде

### Архитектурные решения
- **Clean Architecture** - четкое разделение слоев
- **BLoC Pattern** - управление состоянием
- **Repository Pattern** - абстракция источников данных
- **Dependency Injection** - внедрение зависимостей через GetIt

### Ключевые библиотеки
- `flutter_bloc` - управление состоянием
- `dio` - HTTP клиент для API запросов
- `hive` - локальное хранилище для избранных городов
- `get_it` - контейнер зависимостей
- `flutter_map` - картографические функции
- `talker_flutter` - логирование и отладка
- `equatable` - сравнение объектов
- `intl` - интернационализация и форматирование

## 🏗️ Структура проекта

```
lib/
├── core/                          # Основные компоненты
│   ├── constants/                 # Константы (API URLs, ключи)
│   └── theme/                     # Темы оформления
├── features/                      # Основные функции
│   └── weather/                   # Модуль погоды
│       ├── data/                  # Слой данных
│       │   ├── data_source/       # Источники данных (API)
│       │   ├── models/            # Модели данных
│       │   └── repository/        # Реализация репозиториев
│       ├── domain/                # Бизнес-логика
│       │   └── repository/        # Интерфейсы репозиториев
│       └── presentation/          # UI слой
│           ├── logic/             # BLoC'и
│           ├── pages/             # Экраны
│           └── widgets/           # Переиспользуемые виджеты
├── services/                      # Сервисы
├── injection.dart                 # Настройка DI
└── main.dart                      # Точка входа
```

## 🚀 Установка и запуск

### Предварительные требования
- Flutter SDK 3.8.1 или выше
- Dart SDK
- Android Studio / VS Code
- API ключ от OpenWeatherMap

### Шаги установки

1. **Клонирование репозитория**
   ```bash
   git clone https://github.com/Beg1sJR/flutter_weather.git
   cd flutter_weather
   ```

2. **Установка зависимостей**
   ```bash
   flutter pub get
   ```

3. **Настройка API ключа**
   
   Создайте файл `.env` в корне проекта:
   ```env
   BASE_URL=https://api.openweathermap.org
   API_KEY=ваш_api_ключ_openweathermap
   ```
   
   Получить API ключ можно на [OpenWeatherMap](https://openweathermap.org/api)

4. **Генерация кода (если необходимо)**
   ```bash
   flutter packages pub run build_runner build
   ```

5. **Запуск приложения**
   ```bash
   flutter run
   ```

## 📋 Основные экраны

### Главный экран
- Отображение избранных городов
- Быстрый доступ к поиску
- Карточки с основной информацией о погоде

### Экран поиска
- Автодополнение названий городов
- Быстрый переход к детальной информации
- Интуитивный интерфейс поиска

### Детальный экран города
- Текущая температура и описание погоды
- Почасовой прогноз на 48 часов
- Ежедневный прогноз на 8 дней
- Детальная информация: ощущается как, ветер, влажность, давление, видимость
- Возможность добавления в избранное

## 🔧 Конфигурация

### Настройка API
Приложение использует два типа API от OpenWeatherMap:
- **Current Weather API** (v2.5) - для текущей погоды
- **One Call API** (v3.0) - для прогнозов

### Локализация
- Поддержка русского языка
- Использование системной локали устройства
- Форматирование дат и времени согласно региону


## 📦 Сборка для продакшена

### Android
```bash
flutter build apk --release
# или для bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Desktop
```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```


## 👨‍💻 Автор

**Beg1sJR**
- GitHub: [@Beg1sJR](https://github.com/Beg1sJR)

⭐ **Если вам понравился проект, поставьте звездочку!**
 a full API reference.
