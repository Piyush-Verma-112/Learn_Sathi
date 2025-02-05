

import Foundation

struct Schedule {
    var tutorLogo, tutorName, duration, subjectLogo, subjectName, chapterName: String
    var date : Date
    var startTime, endTime: String
    var topicDescription: [String]
    var lessonNumber: Int
    
    init(tutorLogo: String, tutorName: String, duration: String, subjectLogo: String, subjectName: String, topicName: String, date: Date, startTime: String, endTime: String, topicDescription: [String], lessonNumber: Int) {
        self.tutorLogo = tutorLogo
        self.tutorName = tutorName
        self.duration = duration
        self.subjectLogo = subjectLogo
        self.subjectName = subjectName
        self.chapterName = topicName
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.topicDescription = topicDescription
        self.lessonNumber = lessonNumber
    }
}


var schedule: [Schedule] = [
    Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "EnglishLogo", subjectName: "English Grammar", topicName: "Modals", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Basics", "Usage", "Examples"], lessonNumber: 1),
    Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "2 hr", subjectLogo: "ScienceLogo", subjectName: "Science", topicName: "Photosynthesis", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "11:00 AM", endTime: "1:00 PM", topicDescription: ["Definition", "Process", "Applications"], lessonNumber: 8),
    Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "HindiLogo", subjectName: "Hindi", topicName: "Nibandh Lekhan", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "9:00 AM", endTime: "10:00 AM", topicDescription: ["Format", "Examples", "Practice"], lessonNumber: 3),
    Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "1.5 hr", subjectLogo: "Maths", subjectName: "Mathematics", topicName: "Algebra Basics", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 21))!, startTime: "2:00 PM", endTime: "3:30 PM", topicDescription: ["Linear Equations", "Variables", "Graphing"], lessonNumber: 5),
    Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "2 hr", subjectLogo: "ScienceLogo", subjectName: "Science", topicName: "Photosynthesis", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 21))!, startTime: "11:00 AM", endTime: "1:00 PM", topicDescription: ["Definition", "Process", "Applications"], lessonNumber: 8),
    Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "HindiLogo", subjectName: "Hindi", topicName: "Nibandh Lekhan", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 22))!, startTime: "9:00 AM", endTime: "10:00 AM", topicDescription: ["Format", "Examples", "Practice"], lessonNumber: 3),
    Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "1.5 hr", subjectLogo: "Maths", subjectName: "Mathematics", topicName: "Algebra Basics", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 22))!, startTime: "2:00 PM", endTime: "3:30 PM", topicDescription: ["Linear Equations", "Variables", "Graphing"], lessonNumber: 5),
    Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "EnglishLogo", subjectName: "English Grammar", topicName: "Modals", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 22))!, startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Basics", "Usage", "Examples"], lessonNumber: 1),
    Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "HindiLogo", subjectName: "Hindi", topicName: "Nibandh Lekhan", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 23))!, startTime: "9:00 AM", endTime: "10:00 AM", topicDescription: ["Format", "Examples", "Practice"], lessonNumber: 3),
    Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "1.5 hr", subjectLogo: "Maths", subjectName: "Mathematics", topicName: "Algebra Basics", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 23))!, startTime: "2:00 PM", endTime: "3:30 PM", topicDescription: ["Linear Equations", "Variables", "Graphing"], lessonNumber: 5),
]
