import Foundation
import UIKit

protocol SubjectIdentifiable {
    var subject: String { get }
    var subjectLogo: String { get }
}

protocol Progressable {
    var progressPercentage: Double { get }
}

protocol Scorable {
    var score: Double { get }
    func formattedScore() -> String
}

enum LessonStatus: String {
    case inProgress = "In Progress"
    case completed = "Completed"
    case upcoming = "Upcoming"
}

struct LessonProgress: SubjectIdentifiable, Progressable {
    let subject: String
    let lessonOngoing: Int
    let lessonStatus: LessonStatus
    let totalLessons: Int
    let subjectLogo: String
    let color: UIColor
    
    var completedLessons: Int {
        max(lessonOngoing , 0)
    }
    
    var progressPercentage: Double {
        totalLessons > 0 ? (Double(completedLessons) / Double(totalLessons)) * 100 : 0
    }
}

struct TestProgress: SubjectIdentifiable, Scorable {
    let subject: String
    let nextTestDate: Date
    let attemptedTests: Int
    let averageScore: Double
    let subjectLogo: String
    
    var score: Double {
        averageScore
    }
    
    func formattedScore() -> String {
        String(format: "%.1f%%", score)
    }
}

struct SubjectDetails: Progressable {
    let chapterName: String
    let lessonCount: Int
    let status: LessonStatus
    let progressPercentage : Double
    
    var completedLessons: Int {
        lessonCount
    }
}

struct TestDetails: Scorable {
    let chapterName: String
    let lessonCount: Int
    let testDate: Date
    let totalQuestions: Int
    let correctAnswers: Int
    let attemptedQuestions: Int
    let color: UIColor
    
    var score: Double {
        totalQuestions > 0 ? (Double(correctAnswers) / Double(totalQuestions)) * 100 : 0
    }
    
    var completionRate: Double {
        totalQuestions > 0 ? (Double(attemptedQuestions) / Double(totalQuestions)) * 100 : 0
    }
    
    func formattedScore() -> String {
        String(format: "%.1f%%", score)
    }
    
    var isUpcoming: Bool {
        testDate > Date()
    }
}

extension LessonProgress {
    var formattedProgress: String {
        String(format: "%.1f%%", progressPercentage)
    }
}

extension TestDetails {
    var formattedCompletionRate: String {
        String(format: "%.1f%%", completionRate)
    }
}
