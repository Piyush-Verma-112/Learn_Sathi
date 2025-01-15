//
//  Schedule.swift
//  LearnSathi
//
//  Created by Batch - 2 on 13/01/25.
//

import Foundation

struct Schedule {
    var tutorLogo, tutorName, duration, subjectLogo, subjectName: String
    var date : Date
    var startTime, endTime: String
    var topicDescription: [String]
    var lessonNumber: Int
    
    init(tutorLogo: String, tutorName: String, duration: String, subjectLogo: String, subjectName: String, date: Date, startTime: String, endTime: String, topicDescription: [String], lessonNumber: Int) {
        self.tutorLogo = tutorLogo
        self.tutorName = tutorName
        self.duration = duration
        self.subjectLogo = subjectLogo
        self.subjectName = subjectName
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.topicDescription = topicDescription
        self.lessonNumber = lessonNumber
    }
}




