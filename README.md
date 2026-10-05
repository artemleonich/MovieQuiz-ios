# MovieQuiz

<a href=".github/assets/light/stack.svg#gh-light-mode-only"><img src=".github/assets/light/stack.svg" height="28" alt="Swift · UIKit · Learning" /></a><a href=".github/assets/stack.svg#gh-dark-mode-only"><img src=".github/assets/stack.svg" height="28" alt="Swift · UIKit · Learning" /></a>

Учебный iOS-квиз о рейтингах фильмов. Постер, вопрос и два ответа — «Да» или «Нет».

[Запуск](#запуск) · [Структура](#структура) · [English](#english)

## Как играть

Приложение показывает постер и спрашивает, превышает ли рейтинг фильма 6 баллов. Выберите ответ: рамка станет зелёной при правильном ответе или красной при ошибке. Через одну секунду появится следующий вопрос.

Раунд состоит из **10 вопросов**. В конце приложение показывает число правильных ответов и предлагает сыграть ещё раз.

## Текущее состояние

В ветке по умолчанию `project_sprint_3_start` реализован квиз со встроенным списком вопросов и локальными постерами. Кнопки ответа блокируются на время показа результата; счётчик вопросов и итог раунда обновляются в контроллере.

Проект выполнен в рамках курса **Яндекс Практикума**. Интерфейс предназначен для iPhone.

## Запуск

Нужны macOS, Xcode с поддержкой Swift 5 и совместимый iOS SDK. В настройках target приложения указан **iOS 13.0**.

```bash
git clone https://github.com/artemleonich/MovieQuiz-ios.git
cd MovieQuiz-ios
open MovieQuiz.xcodeproj
```

В Xcode выберите схему **MovieQuiz**, симулятор iPhone и нажмите **Run** (⌘R). Все вопросы и изображения включены в проект.

Для запуска на физическом устройстве выберите свою команду в **Signing & Capabilities**.

## Структура

```text
MovieQuiz/
├── Presentation/
│   ├── MovieQuizViewController.swift # вопросы, ответы и результат
│   └── Base.lproj/Main.storyboard    # экран квиза
├── Helpers/                          # расширения Array, Date и UIColor
├── Resources/
│   ├── Assets.xcassets/               # постеры, цвета и иконки
│   ├── Fonts/                        # YS Display
│   ├── Base.lproj/LaunchScreen.storyboard
│   └── Info.plist
├── AppDelegate.swift
└── SceneDelegate.swift
MovieQuiz.xcodeproj/
```

Логика текущего квиза находится в [MovieQuizViewController.swift](MovieQuiz/Presentation/MovieQuizViewController.swift). Интерфейс собран с помощью Storyboard и Auto Layout.

## Материалы курса

- [Макет Figma](https://www.figma.com/file/l0IMG3Eys35fUrbvArtwsR/YP-Quiz?node-id=34%3A243)
- [Шрифты MovieQuiz](https://code.s3.yandex.net/Mobile/iOS/Fonts/MovieQuizFonts.zip)
- [Ссылка на IMDb API из задания](https://imdb-api.com/api#Top250Movies-header)

Ссылка на API сохранена как материал задания. Данные текущего квиза хранятся локально.

## English

A Yandex Practicum iOS learning project built with Swift, UIKit, Storyboard and Auto Layout. The current default branch contains ten bundled movie-rating questions and local poster assets.

Choose Yes or No, see the answer highlighted for one second, then continue to the next question. The round ends with a score and a replay action.

Open `MovieQuiz.xcodeproj`, choose the MovieQuiz scheme and an iPhone simulator, then press ⌘R. The app target is iOS 13.0.
