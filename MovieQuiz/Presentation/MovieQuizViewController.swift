import UIKit

final class MovieQuizViewController: UIViewController {
    private var currentQuestionIndex = 0
    private var correctAnswers = 0

    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: L10n.questionText,
            correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: L10n.questionText,
            correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            text: L10n.questionText,
            correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            text: L10n.questionText,
            correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            text: L10n.questionText,
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            text: L10n.questionText,
            correctAnswer: true),
        QuizQuestion(
            image: "Old",
            text: L10n.questionText,
            correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: L10n.questionText,
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            text: L10n.questionText,
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            text: L10n.questionText,
            correctAnswer: false),
    ]

    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!

    private struct ViewModel {
        let image: UIImage
        let question: String
        let questionNumber: String
    }

    private struct QuizStepViewModel {
        let image: UIImage
        let question: String
        let questionNumber: String
    }

    private struct QuizResultsViewModel {
        let title: String
        let text: String
        let buttonText: String
    }

    private struct QuizQuestion {
        let image: String
        let text: String
        let correctAnswer: Bool
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibility()
        setupDynamicTypeFonts()
        let currentQuestion = questions[currentQuestionIndex]
        show(quiz: convert(model: currentQuestion))
    }

    // MARK: - Accessibility

    /// Configures VoiceOver labels, hints, and traits for every interactive
    /// and informational UI element. The app's buttons have no visible title
    /// (they live in a custom-themed storyboard) so without explicit labels
    /// VoiceOver users have no way to distinguish the Yes / No answer.
    private func setupAccessibility() {
        // Question label: header so VoiceOver reads it before the question
        // text, and the user can jump to it with the "Headings" rotor.
        textLabel.isAccessibilityElement = true
        textLabel.accessibilityTraits = .header

        // Counter ("1/10"): header, distinct from the question itself.
        counterLabel.isAccessibilityElement = true
        counterLabel.accessibilityTraits = .header

        // Question poster image: a single accessibility element with an
        // .image trait so VoiceOver announces "image" before the label.
        imageView.isAccessibilityElement = true
        imageView.accessibilityTraits = .image
        imageView.accessibilityLabel = L10n.a11yPoster

        // Answer buttons. The storyboard buttons have no visible title, so
        // the accessibility label is the only thing VoiceOver users hear.
        noButton.accessibilityLabel = L10n.a11yNoLabel
        noButton.accessibilityHint = L10n.a11yNoHint

        yesButton.accessibilityLabel = L10n.a11yYesLabel
        yesButton.accessibilityHint = L10n.a11yYesHint
    }

    // MARK: - Dynamic Type

    /// The app uses two custom YS Display fonts (set in the storyboard) and
    /// one magic-number border width. iOS does not automatically scale
    /// custom fonts with the user's preferred text size, so without this
    /// the UI stays fixed-size and becomes unreadable for users who set a
    /// larger Dynamic Type value in Settings.
    ///
    /// UIFontMetrics lets us keep the visual identity of the custom font
    /// while honoring the user's accessibility text-size preference.
    private func setupDynamicTypeFonts() {
        // Counter ("1/10") — display size for an at-a-glance counter.
        applyScaledFont(
            to: counterLabel,
            fontName: "YSDisplay-Medium",
            fallbackSize: 20,
            textStyle: .title3
        )

        // Question text — body size for readability.
        applyScaledFont(
            to: textLabel,
            fontName: "YSDisplay-Medium",
            fallbackSize: 23,
            textStyle: .body
        )

        // Auto-resize label + border when Dynamic Type changes while the
        // app is running.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contentSizeCategoryDidChange),
            name: UIContentSizeCategory.didChangeNotification,
            object: nil
        )
    }

    private func applyScaledFont(
        to label: UILabel,
        fontName: String,
        fallbackSize: CGFloat,
        textStyle: UIFontTextStyle
    ) {
        let baseFont = UIFont(name: fontName, size: fallbackSize) ?? UIFont.systemFont(ofSize: fallbackSize)
        let scaled = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: baseFont)
        label.font = scaled
        label.adjustsFontForContentSizeCategory = true
    }

    @objc private func contentSizeCategoryDidChange() {
        // Re-apply fonts when the user changes the preferred content size
        // while the app is in the background.
        setupDynamicTypeFonts()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Quiz logic (unchanged)

    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
        return questionStep
    }

    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }


        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.showNextQuestionOrResults()
        }
    }

    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1 {
            let text = L10n.resultText(correct: correctAnswers, total: questions.count)
            let viewModel = QuizResultsViewModel(
                title: L10n.resultTitle,
                text: text,
                buttonText: L10n.resultReplay)
            show(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            let nextQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nextQuestion)
            show(quiz: viewModel)
        }
    }

    private func show(quiz step: QuizStepViewModel) {
        let newImage = step.image

        UIView.transition(with: imageView,
                          duration: 0,
                          options: .transitionCrossDissolve,
                          animations: {
            self.imageView.image = newImage
            self.imageView.layer.borderWidth = 8
            self.imageView.layer.borderColor = UIColor.clear.cgColor
        },
                          completion: nil)
        textLabel.text = step.question
        counterLabel.text = L10n.counterText(current: currentQuestionIndex + 1, total: questions.count)
        enableAnswerButtons()
    }

    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)

        let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.currentQuestionIndex = 0
            self.correctAnswers = 0

            let firstQuestion = self.questions[self.currentQuestionIndex]
            let viewModel = self.convert(model: firstQuestion)
            self.show(quiz: viewModel)
        }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

    private func disableAnswerButtons() {
        noButton.isEnabled = false
        yesButton.isEnabled = false
    }

    private func enableAnswerButtons() {
        noButton.isEnabled = true
        yesButton.isEnabled = true
    }

    @IBAction private func noButtonClicked(_ sender: UIButton) {
        disableAnswerButtons()
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = false

        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }

    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        disableAnswerButtons()
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = true

        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
}