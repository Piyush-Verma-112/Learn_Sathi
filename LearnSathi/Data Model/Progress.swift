//
//  Progress.swift
//  LearnSathi
//
//  Created by Batch - 2 on 13/01/25.
//

import Foundation

struct LessonsProgress {
    var subject: String
    var lessonOngoing: Int
    var lessonStatus: String
    var totalLessons: Int
    var completedPercentage: Double
    var subjectLogo: String
    init (subject: String, lessonOngoing: Int, lessonStatus: String, totalLessons: Int, completedPercentage: Double, subjectLogo: String) {
        self.subject = subject
        self.lessonOngoing = lessonOngoing
        self.lessonStatus = lessonStatus
        self.totalLessons = totalLessons
        self.completedPercentage = completedPercentage
        self.subjectLogo = subjectLogo
    }
}
let progressData : [LessonsProgress] = [
    LessonsProgress(subject: "Mathematics", lessonOngoing: 12, lessonStatus: "In Progress", totalLessons: 18, completedPercentage: 66.6, subjectLogo: "Maths"),
    LessonsProgress(subject: "Science", lessonOngoing: 2, lessonStatus: "Completed", totalLessons: 10, completedPercentage: 20.0, subjectLogo: "ScienceLogo"),
    LessonsProgress(subject: "Social Studies", lessonOngoing: 5, lessonStatus: "In Progress", totalLessons: 12, completedPercentage: 41.7, subjectLogo: "SocialStudiesLogo"),
    LessonsProgress(subject: "English", lessonOngoing: 4, lessonStatus: "In Progress", totalLessons: 10, completedPercentage: 45.0, subjectLogo: "EnglishLogo"),
    LessonsProgress(subject: "Hindi", lessonOngoing: 6, lessonStatus: "COmpleted", totalLessons: 14, completedPercentage: 42.9, subjectLogo: "HindiLogo")
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
//    init(chapterName: String, lessonCount: Int, progressPercentage: Double) {
//        self.chapterName = chapterName
//        self.lessonCount = lessonCount
//        self.progressPercentage = progressPercentage
//    }
}

let chapterDetails : [SubjectDetails] = [
    SubjectDetails(chapterName: "Algebra", lessonCount: 1, progressPercentage: 42.9),
    SubjectDetails(chapterName: "Geometry", lessonCount: 2, progressPercentage: 62.9),
    SubjectDetails(chapterName: "Simple Equations", lessonCount: 3, progressPercentage: 82.9),
    SubjectDetails(chapterName: "Lines and Angles", lessonCount: 4, progressPercentage: 92.9),
    SubjectDetails(chapterName: "Rational Numbers", lessonCount: 6, progressPercentage: 100.0)
]
