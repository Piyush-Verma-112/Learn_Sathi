import Foundation

enum ScheduleType {
    case regularClass
    case test
}

struct Schedule {
    var tutorLogo, tutorName, duration, subjectLogo, subjectName, chapterName: String
    var date : Date
    var startTime: Date
    var endTime: Date
    var topicDescription: [String]
    var lessonNumber: Int
    var type: ScheduleType

    init(tutorLogo: String, tutorName: String, duration: String, subjectLogo: String, subjectName: String, topicName: String, date: Date, startTime: String, endTime: String, topicDescription: [String], lessonNumber: Int, type: ScheduleType = .regularClass) {
        self.tutorLogo = tutorLogo
        self.tutorName = tutorName
        self.duration = duration
        self.subjectLogo = subjectLogo
        self.subjectName = subjectName
        self.chapterName = topicName
        self.date = date
        self.type = type

        // Convert string times to Date objects
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        let calendar = Calendar.current
        self.startTime = formatter.date(from: startTime) ?? date
        self.endTime = formatter.date(from: endTime) ?? date
        
        // Set the dates to the same day as the schedule date
        let startComponents = calendar.dateComponents([.hour, .minute], from: self.startTime)
        let endComponents = calendar.dateComponents([.hour, .minute], from: self.endTime)
        
        self.startTime = calendar.date(bySettingHour: startComponents.hour ?? 0,
                                      minute: startComponents.minute ?? 0,
                                      second: 0,
                                      of: date) ?? date
        self.endTime = calendar.date(bySettingHour: endComponents.hour ?? 0,
                                    minute: endComponents.minute ?? 0,
                                    second: 0,
                                    of: date) ?? date
        
        self.topicDescription = topicDescription
        self.lessonNumber = lessonNumber
    }
}
