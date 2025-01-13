//
//  Progress.swift
//  LearnSathi
//
//  Created by Batch - 2 on 13/01/25.
//

import Foundation

struct Progress {
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
let progressMaths : [Progress] = [Progress(subject: "Mathematics", lessonOngoing: 12, lessonStatus: "In Progress", totalLessons: 18, completedPercentage: 66.6, subjectLogo: "Maths")]
