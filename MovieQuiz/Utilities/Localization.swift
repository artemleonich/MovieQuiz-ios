//
//  Localization.swift
//  MovieQuiz
//
//  Convenience helpers around ``NSLocalizedString``.
//
//  Why this exists:
//  - Centralizes the keys used by ``MovieQuizViewController`` so the
//    call sites stay readable (``L10n.a11yNoLabel`` vs.
//    ``NSLocalizedString("a11y.no.label", comment: ...)``).
//  - Provides a single place to wire up plurals / device-language
//    overrides / accessibility-specific string variants in the future.
//
//  Two structs are exposed: ``L10n`` for the production strings
//  used in this PR, and ``L10n.Question`` for question text so that
//  individual ``QuizQuestion`` entries can stay data-driven in a
//  later PR (today they all share the same ``question.text`` key).
//

import Foundation

enum L10n {

    /// The accessibility label for the movie poster ``UIImageView``.
    static let a11yPoster = NSLocalizedString(
        "a11y.poster",
        value: "Movie poster",
        comment: "VoiceOver label for the question's movie poster image"
    )

    /// "No" answer button accessibility label.
    static let a11yNoLabel = NSLocalizedString(
        "a11y.no.label",
        value: "No",
        comment: "VoiceOver label for the No answer button"
    )

    /// "No" answer button accessibility hint.
    static let a11yNoHint = NSLocalizedString(
        "a11y.no.hint",
        value: "Answer that the film's rating is less than or equal to 6",
        comment: "VoiceOver hint for the No answer button"
    )

    /// "Yes" answer button accessibility label.
    static let a11yYesLabel = NSLocalizedString(
        "a11y.yes.label",
        value: "Yes",
        comment: "VoiceOver label for the Yes answer button"
    )

    /// "Yes" answer button accessibility hint.
    static let a11yYesHint = NSLocalizedString(
        "a11y.yes.hint",
        value: "Answer that the film's rating is higher than 6",
        comment: "VoiceOver hint for the Yes answer button"
    )

    /// Result alert title.
    static let resultTitle = NSLocalizedString(
        "result.title",
        value: "This round is over!",
        comment: "Title shown in the alert after the last question"
    )

    /// Result alert body text, with two integer format specifiers
    /// (correctAnswers, totalQuestions).
    static func resultText(correct: Int, total: Int) -> String {
        String(
            format: NSLocalizedString(
                "result.text",
                value: "Your score: %lld/%lld",
                comment: "Body text of the result alert. %lld %lld are correctAnswers and totalQuestions respectively."
            ),
            correct, total
        )
    }

    /// Result alert "play again" button label.
    static let resultReplay = NSLocalizedString(
        "result.replay",
        value: "Play again",
        comment: "Button label on the result alert that restarts the quiz"
    )

    /// Storyboard text for the question prefix label (e.g. "Question: 1/10").
    static let questionPrefix = NSLocalizedString(
        "label.question.prefix",
        value: "Question:",
        comment: "Prefix shown next to the question counter (e.g. 'Question: 1/10')"
    )

    /// Storyboard counter text. Format args: currentQuestionIndex+1, totalQuestions.
    static func counterText(current: Int, total: Int) -> String {
        String(
            format: NSLocalizedString(
                "label.counter.format",
                value: "%lld/%lld",
                comment: "Counter text shown in the upper-right. %lld %lld are currentQuestionIndex+1 and totalQuestions."
            ),
            current, total
        )
    }

    /// Question text shared by every entry in the hardcoded quiz.
    /// Future PRs can vary this per entry — see PR #7 in the roadmap.
    static let questionText = NSLocalizedString(
        "question.text",
        value: "Is this film's rating higher than 6?",
        comment: "Question text shown for every quiz entry. The current quiz is a single repeated question; per-entry text is a follow-up."
    )
}
