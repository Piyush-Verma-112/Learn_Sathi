import Foundation
import UIKit

// MARK: - Data Controller
class ProgressDataController {
    
    // Singleton instance
    static let shared = ProgressDataController()
    
    // Private initializer to prevent direct instantiation
    private init() {}
    
    // MARK: - Lessons Progress Data
    private let lessonsProgress: [LessonProgress] = [
        LessonProgress(subject: "Mathematics", lessonOngoing: 12, lessonStatus: .inProgress, totalLessons: 18, subjectLogo: "Maths", color: .systemGreen),
        LessonProgress(subject: "Science", lessonOngoing: 2, lessonStatus: .completed, totalLessons: 10, subjectLogo: "ScienceLogo", color: .systemOrange),
        LessonProgress(subject: "Social Studies", lessonOngoing: 5, lessonStatus: .inProgress, totalLessons: 12, subjectLogo: "SocialStudiesLogo", color: .quaternaryLabel),
        LessonProgress(subject: "English", lessonOngoing: 4, lessonStatus: .inProgress, totalLessons: 10, subjectLogo: "EnglishLogo", color: .systemBlue),
        LessonProgress(subject: "Hindi", lessonOngoing: 6, lessonStatus: .completed, totalLessons: 14, subjectLogo: "HindiLogo", color: .systemRed)
    ]
    
    // MARK: - Test Progress Data
    private let testProgress: [TestProgress] = [
        TestProgress(subject: "Mathematics", nextTestDate: Date(), attemptedTests: 3, averageScore: 78.9, subjectLogo: "Maths"),
        TestProgress(subject: "Science", nextTestDate: Date(), attemptedTests: 4, averageScore: 89.0, subjectLogo: "ScienceLogo"),
        TestProgress(subject: "Social Studies", nextTestDate: Date(), attemptedTests: 5, averageScore: 90.0, subjectLogo: "SocialStudiesLogo"),
        TestProgress(subject: "English", nextTestDate: Date(), attemptedTests: 6, averageScore: 85.0, subjectLogo: "EnglishLogo"),
        TestProgress(subject: "Hindi", nextTestDate: Date(), attemptedTests: 7, averageScore: 72.0, subjectLogo: "HindiLogo")
    ]
    
    // MARK: - Chapter Details Data
    private let chapterDetails: [String: [SubjectDetails]] = [
        "Mathematics": [
            SubjectDetails(chapterName: "Algebra", lessonCount: 1, status: .inProgress, progressPercentage: 42.9),
            SubjectDetails(chapterName: "Geometry", lessonCount: 2, status: .inProgress, progressPercentage: 0.0),
            SubjectDetails(chapterName: "Simple Equations", lessonCount: 3, status: .inProgress, progressPercentage: 82.9),
            SubjectDetails(chapterName: "Lines and Angles", lessonCount: 4, status: .inProgress, progressPercentage: 92.9),
            SubjectDetails(chapterName: "Rational Numbers", lessonCount: 5, status: .completed, progressPercentage: 100.0)
        ],
        "Science": [
            SubjectDetails(chapterName: "Nutrition in Plants", lessonCount: 1, status: .inProgress, progressPercentage: 71.0),
            SubjectDetails(chapterName: "Nutrition in Animals", lessonCount: 2, status: .inProgress, progressPercentage: 69.9),
            SubjectDetails(chapterName: "Fibre to Fabric", lessonCount: 3, status: .inProgress, progressPercentage: 25.25),
            SubjectDetails(chapterName: "Heat and Energy", lessonCount: 4, status: .inProgress, progressPercentage: 72.4),
            SubjectDetails(chapterName: "Acid Bases and Salts", lessonCount: 5, status: .inProgress, progressPercentage: 7.9),
            SubjectDetails(chapterName: "Water Cycle", lessonCount: 6, status: .completed, progressPercentage: 100.0)
        ],
        "Social Studies": [
            SubjectDetails(chapterName: "Ancient Civilizations", lessonCount: 1, status: .inProgress, progressPercentage: 42.9),
            SubjectDetails(chapterName: "World History", lessonCount: 2, status: .inProgress, progressPercentage: 62.9),
            SubjectDetails(chapterName: "Air", lessonCount: 3, status: .inProgress, progressPercentage: 82.9),
            SubjectDetails(chapterName: "Water", lessonCount: 4, status: .inProgress, progressPercentage: 24.0),
            SubjectDetails(chapterName: "Democracy", lessonCount: 5, status: .inProgress, progressPercentage: 7.3)
        ],
        "Hindi": [
            SubjectDetails(chapterName: "हम पंछी उन्मुक्त गगन के", lessonCount: 1, status: .inProgress, progressPercentage: 42.3),
            SubjectDetails(chapterName: "हिमालय की बेटियां", lessonCount: 2, status: .inProgress, progressPercentage: 0.0),
            SubjectDetails(chapterName: "रक्त और हमारा शरीर", lessonCount: 3, status: .inProgress, progressPercentage: 23),
            SubjectDetails(chapterName: "भोर और बरखा", lessonCount: 4, status: .inProgress, progressPercentage: 34),
            SubjectDetails(chapterName: "शाम एक किशान", lessonCount: 5, status: .inProgress, progressPercentage: 45.6)
        ],
        "English": [
            SubjectDetails(chapterName: "A gift of Chappals the Rebel", lessonCount: 1, status: .inProgress, progressPercentage: 74.0),
            SubjectDetails(chapterName: "Quality Trees", lessonCount: 2, status: .inProgress, progressPercentage: 83.0),
            SubjectDetails(chapterName: "A Story of Cricket", lessonCount: 3, status: .inProgress, progressPercentage: 56.7),
            SubjectDetails(chapterName: "Three questions", lessonCount: 4, status: .inProgress, progressPercentage: 0.0),
            SubjectDetails(chapterName: "A bicycle in good repair", lessonCount: 5, status: .inProgress, progressPercentage: 8.9),
            SubjectDetails(chapterName: "A gift of Chappals the Rebel", lessonCount: 1, status: .inProgress, progressPercentage: 74.0),
            SubjectDetails(chapterName: "Quality Trees", lessonCount: 2, status: .inProgress, progressPercentage: 83.0),
            SubjectDetails(chapterName: "A Story of Cricket", lessonCount: 3, status: .inProgress, progressPercentage: 56.7),
            SubjectDetails(chapterName: "Three questions", lessonCount: 4, status: .inProgress, progressPercentage: 0.0),
            SubjectDetails(chapterName: "A bicycle in good repair", lessonCount: 5, status: .inProgress, progressPercentage: 8.9)
        ]
    ]
    
    // MARK: - Test Details Data
    private let testDetails: [String: [TestDetails]] = [
        "Mathematics": [
            TestDetails(chapterName: "Algebra", lessonCount: 1, testDate: Date(), totalQuestions: 15, correctAnswers: 14, attemptedQuestions: 15, color: .systemTeal),
            TestDetails(chapterName: "Geometry", lessonCount: 2, testDate: Date(), totalQuestions: 15, correctAnswers: 9, attemptedQuestions: 20, color: .systemIndigo),
            TestDetails(chapterName: "Simple Equations", lessonCount: 3, testDate: Date(), totalQuestions: 10, correctAnswers: 9, attemptedQuestions: 10, color: .magenta),
            TestDetails(chapterName: "Lines and Angles", lessonCount: 4, testDate: Date(), totalQuestions: 12, correctAnswers: 11, attemptedQuestions: 12, color: .systemMint)
        ],
        "Science": [
            TestDetails(chapterName: "Nutrition in Plants", lessonCount: 1, testDate: Date(), totalQuestions: 15, correctAnswers: 13, attemptedQuestions: 15, color: .systemTeal),
            TestDetails(chapterName: "Nutrition in Animals", lessonCount: 2, testDate: Date(), totalQuestions: 20, correctAnswers: 18, attemptedQuestions: 20, color: .systemIndigo),
            TestDetails(chapterName: "Fibre to Fabric", lessonCount: 3, testDate: Date(), totalQuestions: 10, correctAnswers: 9, attemptedQuestions: 10, color: .magenta),
            TestDetails(chapterName: "Water Cycle", lessonCount: 4, testDate: Date(), totalQuestions: 12, correctAnswers: 11, attemptedQuestions: 12, color: .systemMint)
        ],
        "Social Studies": [
            TestDetails(chapterName: "Ancient Civilizations", lessonCount: 1, testDate: Date(), totalQuestions: 15, correctAnswers: 13, attemptedQuestions: 15, color: .systemTeal),
            TestDetails(chapterName: "World History", lessonCount: 2, testDate: Date(), totalQuestions: 20, correctAnswers: 18, attemptedQuestions: 20, color: .systemIndigo),
            TestDetails(chapterName: "Air", lessonCount: 3, testDate: Date(), totalQuestions: 10, correctAnswers: 9, attemptedQuestions: 10, color: .magenta),
            TestDetails(chapterName: "Water", lessonCount: 4, testDate: Date(), totalQuestions: 12, correctAnswers: 11, attemptedQuestions: 12, color: .systemMint)
        ],
        "English": [
            TestDetails(chapterName: "A gift of Chappals the Rebel", lessonCount: 1, testDate: Date(), totalQuestions: 15, correctAnswers: 13, attemptedQuestions: 15, color: .systemTeal),
            TestDetails(chapterName: "Quality Trees", lessonCount: 2, testDate: Date(), totalQuestions: 20, correctAnswers: 18, attemptedQuestions: 20, color: .systemIndigo),
            TestDetails(chapterName: "A Story of Cricket", lessonCount: 3, testDate: Date(), totalQuestions: 10, correctAnswers: 9, attemptedQuestions: 10, color: .magenta),
            TestDetails(chapterName: "Three questions", lessonCount: 4, testDate: Date(), totalQuestions: 12, correctAnswers: 11, attemptedQuestions: 12, color: .systemMint)
        ],
        "Hindi": [
            TestDetails(chapterName: "हम पंछी उन्मुक्त गगन के", lessonCount: 1, testDate: Date(), totalQuestions: 15, correctAnswers: 13, attemptedQuestions: 15, color: .systemTeal),
            TestDetails(chapterName: "शाम एक किशान", lessonCount: 2, testDate: Date(), totalQuestions: 20, correctAnswers: 18, attemptedQuestions: 20, color: .systemIndigo),
            TestDetails(chapterName: "भोर और बरखा", lessonCount: 3, testDate: Date(), totalQuestions: 10, correctAnswers: 9, attemptedQuestions: 10, color: .magenta),
            TestDetails(chapterName: "रक्त और हमारा शरीर", lessonCount: 4, testDate: Date(), totalQuestions: 12, correctAnswers: 11, attemptedQuestions: 12, color: .systemMint)
        ]
    ]
    
    // MARK: - Public Methods
    
    /// Fetch all lesson progress
    func getAllLessonsProgress() -> [LessonProgress] {
        return lessonsProgress
    }
    
    /// Fetch all test progress
    func getAllTestProgress() -> [TestProgress] {
        return testProgress
    }
    
    /// Fetch chapters for a specific subject
    func getChapters(for subject: String) -> [SubjectDetails] {
        return chapterDetails[subject] ?? []
    }
    
    /// Fetch tests for a specific subject
    func getTests(for subject: String) -> [TestDetails] {
        return testDetails[subject] ?? []
    }
    
    /// Fetch lesson progress for a specific subject
    func getLessonProgress(for subject: String) -> LessonProgress? {
        return lessonsProgress.first { $0.subject == subject }
    }
    
    /// Fetch test progress for a specific subject
    func getTestProgress(for subject: String) -> TestProgress? {
        return testProgress.first { $0.subject == subject }
    }
    
    /// Fetch upcoming tests
    func getUpcomingTests() -> [TestProgress] {
        return testProgress.filter { $0.nextTestDate > Date() }
    }
    
    /// Fetch completed chapters
    func getCompletedChapters() -> [SubjectDetails] {
        return chapterDetails.values.flatMap { $0 }.filter { $0.status == .completed }
    }
    
    func getChapterProgress(for chapter: String) -> Double? {
        return chapterDetails.values
            .flatMap { $0 }
            .first { $0.chapterName == chapter }?
            .progressPercentage
    }
    
    func getAllLessonsMapping() -> [String: [String]] {
        return chapterDetails.mapValues { chapters in
            chapters.map { $0.chapterName }
        }
    }
}
