//
//  Progress.swift
//  LearnSathi
//
//  Created by Batch - 2 on 13/01/25.
//

import Foundation
import UIKit

struct LessonsProgress {
    var subject: String
    var lessonOngoing: Int
    var lessonStatus: String
    var totalLessons: Int
    var completedPercentage: Double
    var subjectLogo: String
    var color: UIColor
    init (subject: String, lessonOngoing: Int, lessonStatus: String, totalLessons: Int, completedPercentage: Double, subjectLogo: String, color: UIColor) {
        self.subject = subject
        self.lessonOngoing = lessonOngoing
        self.lessonStatus = lessonStatus
        self.totalLessons = totalLessons
        self.completedPercentage = completedPercentage
        self.subjectLogo = subjectLogo
        self.color = color
    }
}

let progressData : [LessonsProgress] = [
    LessonsProgress(subject: "Mathematics", lessonOngoing: 12, lessonStatus: "In Progress", totalLessons: 18, completedPercentage: 66.6, subjectLogo: "Maths", color: .systemGreen),
    LessonsProgress(subject: "Science", lessonOngoing: 2, lessonStatus: "Completed", totalLessons: 10, completedPercentage: 20.0, subjectLogo: "ScienceLogo", color: .systemOrange),
    LessonsProgress(subject: "Social Studies", lessonOngoing: 5, lessonStatus: "In Progress", totalLessons: 12, completedPercentage: 41.7, subjectLogo: "SocialStudiesLogo", color: .quaternaryLabel),
    LessonsProgress(subject: "English", lessonOngoing: 4, lessonStatus: "In Progress", totalLessons: 10, completedPercentage: 45.0, subjectLogo: "EnglishLogo", color: .systemBlue),
    LessonsProgress(subject: "Hindi", lessonOngoing: 6, lessonStatus: "COmpleted", totalLessons: 14, completedPercentage: 42.9, subjectLogo: "HindiLogo", color: .systemRed)
]


struct TestsProgress {
    var subject: String
    var nextTest: Date
    var averageScore: Double
    var subjectLogo: String
    var attemptedTests: Int
    init(subject: String, nextTest: Date, averageScore: Double, subjectLogo: String, attemptedTests: Int) {
        self.subject = subject
        self.nextTest = nextTest
        self.averageScore = averageScore
        self.subjectLogo = subjectLogo
        self.attemptedTests = attemptedTests
    }
}
let testsData : [TestsProgress] = [
    TestsProgress(subject: "Mathematics", nextTest: Date(), averageScore: 78.9, subjectLogo: "Maths", attemptedTests: 3),
    TestsProgress(subject: "Science", nextTest: Date(), averageScore: 89.0, subjectLogo: "ScienceLogo", attemptedTests: 4),
    TestsProgress(subject: "Social Studies", nextTest: Date(), averageScore: 90.0, subjectLogo: "SocialStudiesLogo", attemptedTests: 5),
    TestsProgress(subject: "English", nextTest: Date(), averageScore: 85.0, subjectLogo: "EnglishLogo", attemptedTests: 6),
    TestsProgress(subject: "Hindi", nextTest: Date(), averageScore: 72.0, subjectLogo: "HindiLogo", attemptedTests: 7)
]


struct SubjectDetails {
    var chapterName: String
    var lessonCount: Int
    var progressPercentage: Double
    var chapterStatus: Status
    init(chapterName: String, lessonCount: Int, progressPercentage: Double, chapterStatus: Status) {
        self.chapterName = chapterName
        self.lessonCount = lessonCount
        self.progressPercentage = progressPercentage
        self.chapterStatus = chapterStatus
    }
}

enum Status: String {
    case inProgress = "In Progress"
    case completed = "Completed"
    case upcoming = "UpComing"
}

let chapterDetailsMaths : [SubjectDetails] = [
    SubjectDetails(chapterName: "Algebra", lessonCount: 1, progressPercentage: 42.9, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Geometry", lessonCount: 2, progressPercentage: 0.0, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Simple Equations", lessonCount: 3, progressPercentage: 82.9, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Lines and Angles", lessonCount: 4, progressPercentage: 92.9, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Rational Numbers", lessonCount: 5, progressPercentage: 100.0, chapterStatus: .completed)
]

let chapterDetailsScience : [SubjectDetails] = [
    SubjectDetails(chapterName: "Nutrition in Plants", lessonCount: 1, progressPercentage: 71.0, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Nutrition in Animals", lessonCount: 2, progressPercentage: 69.9, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Fibre to Fabric", lessonCount: 3, progressPercentage: 25.25, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Heat and Energy", lessonCount: 4, progressPercentage: 72.4, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Acid Bases and Salts", lessonCount: 5, progressPercentage: 7.9, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Water Cycle", lessonCount: 6, progressPercentage: 100.0, chapterStatus: .completed)
    ]

let chapterDetailsSocialStudies : [SubjectDetails] = [
    SubjectDetails(chapterName: "Ancient Civilizations", lessonCount: 1, progressPercentage: 42.9, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "World History", lessonCount: 2, progressPercentage: 62.9, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Air", lessonCount: 3, progressPercentage: 82.9, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Water", lessonCount: 4, progressPercentage: 24.0, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Democracy", lessonCount: 5, progressPercentage: 7.3, chapterStatus: .inProgress)
    ]

let chapterDetailsEnglish : [SubjectDetails] = [
    SubjectDetails(chapterName: "A gift of Chappals the Rebel", lessonCount: 1, progressPercentage: 74.0, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Quality Trees", lessonCount: 2, progressPercentage: 83.0, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "A Story of Cricket", lessonCount: 3, progressPercentage: 56.7, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Three questions", lessonCount: 4, progressPercentage: 0.0, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "A bicycle in good repair", lessonCount: 5, progressPercentage: 8.9, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "A gift of Chappals the Rebel", lessonCount: 1, progressPercentage: 74.0, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Quality Trees", lessonCount: 2, progressPercentage: 83.0, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "A Story of Cricket", lessonCount: 3, progressPercentage: 56.7, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "Three questions", lessonCount: 4, progressPercentage: 7.2, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "A bicycle in good repair", lessonCount: 5, progressPercentage: 8.9, chapterStatus: .inProgress)
    ]

let chapterDetailsHindi : [SubjectDetails] = [
    SubjectDetails(chapterName: "हम पंछी उन्मुक्त गगन के", lessonCount: 1, progressPercentage: 42.3, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "हिमालय की बेटियां", lessonCount: 2, progressPercentage: 0.0, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "रक्त और हमारा शरीर", lessonCount: 3, progressPercentage: 23, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "भोर और बरखा", lessonCount: 4, progressPercentage: 34, chapterStatus: .inProgress),
    SubjectDetails(chapterName: "शाम एक किशान", lessonCount: 5, progressPercentage: 45.6, chapterStatus: .inProgress)
    ]


struct TestDetails {
    var chapterName: String
    var lessonCount: Int
    var testDate: Date
    var totalQuestions: Int
    var correctAnswers: Int
    var attemptedQuestions: Int
    var score: Float
    var colorCode : UIColor
    init(chapterName: String, lessonCount: Int, testDate: Date, totalQuestions: Int, correctAnswers: Int, attemptedQuestions: Int, colorCode: UIColor) {
        self.chapterName = chapterName
        self.lessonCount = lessonCount
        self.testDate = testDate
        self.totalQuestions = totalQuestions
        self.correctAnswers = correctAnswers
        self.attemptedQuestions = attemptedQuestions
        self.colorCode = colorCode
        if totalQuestions > 0 {
            self.score = (Float(correctAnswers) / Float(totalQuestions)) * 100
        } else {
            self.score = 0.0
        }
        func formattedScore() -> String {
                return String(format: "%.2f", score)
            }
    }
}

//let colorPalette: [UIColor] = [.systemRed, .systemBlue, .systemGreen, .systemOrange]


let testDetailsMaths : [TestDetails] = [
    TestDetails(chapterName: "Algebra", lessonCount: 1, testDate: Date(), totalQuestions: 15, correctAnswers: 14, attemptedQuestions: 15, colorCode: .systemTeal),
    TestDetails(chapterName: "Geometry", lessonCount: 2, testDate: Date(), totalQuestions: 15, correctAnswers: 9, attemptedQuestions: 20, colorCode: .systemIndigo),
    TestDetails(chapterName: "Simple Equations", lessonCount: 3, testDate: Date(), totalQuestions: 10, correctAnswers: 9, attemptedQuestions: 10, colorCode: .magenta),
    TestDetails(chapterName: "Lines and Angles", lessonCount: 4, testDate: Date(), totalQuestions: 12, correctAnswers: 11, attemptedQuestions: 12, colorCode: .systemMint)
]

let testDetailsScience : [TestDetails] = [
    TestDetails(chapterName: "Nutrition in Plants", lessonCount: 1, testDate: Date(), totalQuestions: 15, correctAnswers: 13, attemptedQuestions: 15, colorCode: .systemTeal),
    TestDetails(chapterName: "Nutrition in Animals", lessonCount: 2, testDate: Date(), totalQuestions: 20, correctAnswers: 18, attemptedQuestions: 20, colorCode: .systemIndigo),
    TestDetails(chapterName: "Fibre to Fabric", lessonCount: 3, testDate: Date(), totalQuestions: 10, correctAnswers: 9, attemptedQuestions: 10, colorCode: .magenta),
    TestDetails(chapterName: "Water Cycle", lessonCount: 4, testDate: Date(), totalQuestions: 12, correctAnswers: 11, attemptedQuestions: 12, colorCode: .systemMint)
]

let testDetailsSocialStudies : [TestDetails] = [
    TestDetails(chapterName: "Ancient Civilizations", lessonCount: 1, testDate: Date(), totalQuestions: 15, correctAnswers: 13, attemptedQuestions: 15, colorCode: .systemTeal),
    TestDetails(chapterName: "World History", lessonCount: 2, testDate: Date(), totalQuestions: 20, correctAnswers: 18, attemptedQuestions: 20, colorCode: .systemIndigo),
    TestDetails(chapterName: "Air", lessonCount: 3, testDate: Date(), totalQuestions: 10, correctAnswers: 9, attemptedQuestions: 10, colorCode: .magenta),
    TestDetails(chapterName: "Water", lessonCount: 4, testDate: Date(), totalQuestions: 12, correctAnswers: 11, attemptedQuestions: 12, colorCode: .systemMint)
]

let testDetailsEnglish : [TestDetails] = [
    TestDetails(chapterName: "A gift of Chappals the Rebel", lessonCount: 1, testDate: Date(), totalQuestions: 15, correctAnswers: 13, attemptedQuestions: 15, colorCode: .systemTeal),
    TestDetails(chapterName: "Quality Trees", lessonCount: 2, testDate: Date(), totalQuestions: 20, correctAnswers: 18, attemptedQuestions: 20, colorCode: .systemIndigo),
    TestDetails(chapterName: "A Story of Cricket", lessonCount: 3, testDate: Date(), totalQuestions: 10, correctAnswers: 9, attemptedQuestions: 10, colorCode: .magenta),
    TestDetails(chapterName: "Three questions", lessonCount: 4, testDate: Date(), totalQuestions: 12, correctAnswers: 11, attemptedQuestions: 12, colorCode: .systemMint)
]

let testDetailsHindi : [TestDetails] = [
    TestDetails(chapterName: "हम पंछी उन्मुक्त गगन के", lessonCount: 1, testDate: Date(), totalQuestions: 15, correctAnswers: 13, attemptedQuestions: 15, colorCode: .systemTeal),
    TestDetails(chapterName: "शाम एक किशान", lessonCount: 2, testDate: Date(), totalQuestions: 20, correctAnswers: 18, attemptedQuestions: 20, colorCode: .systemIndigo),
    TestDetails(chapterName: "भोर और बरखा", lessonCount: 3, testDate: Date(), totalQuestions: 10, correctAnswers: 9, attemptedQuestions: 10, colorCode: .magenta),
    TestDetails(chapterName: "रक्त और हमारा शरीर", lessonCount: 4, testDate: Date(), totalQuestions: 12, correctAnswers: 11, attemptedQuestions: 12, colorCode: .systemMint)
]

struct ChartDataModel {
    let category: String
    let value: Double
    let color: UIColor
}
