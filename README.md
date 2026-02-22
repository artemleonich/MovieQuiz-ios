# MovieQuiz

[Русский](#русский) | [English](#english)

---

<a id="русский"></a>

## 🇷🇺 Русский

### Описание

MovieQuiz — iOS-приложение с квизами о фильмах из топ-250 рейтинга и самых популярных фильмов по версии IMDb. Пользователь отвечает на вопросы о рейтинге фильмов, а приложение ведёт статистику правильных ответов и лучших результатов. Проект выполнен в рамках курса Яндекс Практикума.

### Как играть

Приложение показывает постер фильма и задаёт вопрос о его IMDb-рейтинге (например, «Рейтинг этого фильма больше 6?»). Игрок выбирает «Да» или «Нет». После каждого ответа рамка постера подсвечивается зелёным (верно) или красным (неверно). Раунд состоит из 10 вопросов, после чего показывается статистика.

### Функциональность

- Сплеш-скрин при запуске
- Вопросы на основе IMDb-рейтинга по 10-балльной шкале
- Визуальная обратная связь: рамка постера меняет цвет в зависимости от правильности ответа
- Автоматический переход к следующему вопросу через 1 секунду
- Статистика после каждого раунда: результат, количество игр, рекорд, средняя точность
- Возможность начать новый раунд
- Обработка сетевых ошибок с возможностью повторного запроса

### Технические требования

- iOS 13+, только iPhone, портретный режим
- Вёрстка адаптирована под экраны iPhone начиная с X
- UI соответствует макету Figma

### Структура проекта

```
MovieQuiz-ios/
├── MovieQuiz/
│   ├── Helpers/                        # Вспомогательные утилиты
│   ├── Presentation/
│   │   ├── Base.lproj/                 # Storyboard
│   │   └── MovieQuizViewController.swift  # Главный контроллер квиза
│   ├── Resources/                      # Ресурсы (Assets, шрифты, Info.plist)
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── MovieQuiz.xcodeproj
└── README.md
```

### Ссылки

- [Макет Figma](https://www.figma.com/file/l0IMG3Eys35fUrbvArtwsR/YP-Quiz?node-id=34%3A243)
- [API IMDb](https://imdb-api.com/api#Top250Movies-header)
- [Шрифты](https://code.s3.yandex.net/Mobile/iOS/Fonts/MovieQuizFonts.zip)

### Технологии

- Swift, UIKit
- Storyboard (Auto Layout)
- URLSession (сетевые запросы к IMDb API)
- UserDefaults (хранение статистики)
- MVC архитектура

---

<a id="english"></a>

## 🇬🇧 English

### Description

MovieQuiz is an iOS quiz app about movies from the IMDb Top 250 and most popular films. Users answer questions about movie ratings while the app tracks correct answers and best results. Built as part of the Yandex Practicum iOS development course.

### How to Play

The app displays a movie poster and asks a question about its IMDb rating (e.g., "Is the rating of this movie higher than 6?"). The player chooses "Yes" or "No." After each answer, the poster frame highlights green (correct) or red (incorrect). A round consists of 10 questions, followed by a statistics summary.

### Features

- Splash screen on launch
- Questions based on IMDb ratings (10-point scale)
- Visual feedback: poster frame changes color based on answer correctness
- Automatic transition to next question after 1 second
- Round statistics: current result, total games played, best score, average accuracy
- Option to start a new round
- Network error handling with retry option

### Technical Requirements

- iOS 13+, iPhone only, portrait mode
- Layout adapted for iPhone screens starting from X
- UI matches the Figma design mockup

### Project Structure

```
MovieQuiz-ios/
├── MovieQuiz/
│   ├── Helpers/                        # Utility helpers
│   ├── Presentation/
│   │   ├── Base.lproj/                 # Storyboard
│   │   └── MovieQuizViewController.swift  # Main quiz view controller
│   ├── Resources/                      # Assets, fonts, Info.plist
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── MovieQuiz.xcodeproj
└── README.md
```

### Links

- [Figma Mockup](https://www.figma.com/file/l0IMG3Eys35fUrbvArtwsR/YP-Quiz?node-id=34%3A243)
- [IMDb API](https://imdb-api.com/api#Top250Movies-header)
- [Fonts](https://code.s3.yandex.net/Mobile/iOS/Fonts/MovieQuizFonts.zip)

### Tech Stack

- Swift, UIKit
- Storyboard (Auto Layout)
- URLSession (networking with IMDb API)
- UserDefaults (statistics persistence)
- MVC architecture
