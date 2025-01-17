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


struct CalendarData {
    var date: Int
    var day : String
    
    init(date: Int, day: String) {
        self.date = date
        self.day = day
    }
}

var calendar: [CalendarData] = [
        CalendarData(date: 04, day: "SUN"),
        CalendarData(date: 05, day: "MON"),
        CalendarData(date: 06, day: "TUE"),
        CalendarData(date: 04, day: "SUN"),
        CalendarData(date: 05, day: "MON"),
        CalendarData(date: 06, day: "TUE"),
        CalendarData(date: 04, day: "SUN"),
        CalendarData(date: 05, day: "MON"),
        CalendarData(date: 06, day: "TUE"),
        CalendarData(date: 04, day: "SUN"),
        CalendarData(date: 05, day: "MON"),
        CalendarData(date: 06, day: "TUE"),
        CalendarData(date: 04, day: "SUN"),
        CalendarData(date: 05, day: "MON"),
        CalendarData(date: 06, day: "TUE"),
        CalendarData(date: 04, day: "SUN"),
        CalendarData(date: 05, day: "MON"),
]



var schedule: [Schedule] = [
    Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "EnglishLogo", subjectName: "English Grammer", date: Date(), startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Topic 1", "Topic 2", "Topic    3"], lessonNumber: 1),
    Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "2 hr", subjectLogo: "science", subjectName: "Science", date: Date(), startTime: "10:00 AM", endTime: "5:00 PM", topicDescription: ["Topic 1", "Topic 2", "Topic    3"], lessonNumber: 8),
    Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "hindi", subjectName: "Hindi", date: Date(), startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Topic 1", "Topic 2", "Topic    3"], lessonNumber: 1),
    Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "EnglishLogo", subjectName: "English Grammer", date: Date(), startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Topic 1", "Topic 2", "Topic    3"], lessonNumber: 1),
]
