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


let scheduleData: [Schedule] = [
    Schedule(tutorLogo: "tutor1", tutorName: "Tutor 1", duration: "1 hour", subjectLogo: "subject1", subjectName: "Subject 1", date: Date(), startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Topic 1", "Topic 2", "Topic    3"], lessonNumber: 1),
]



