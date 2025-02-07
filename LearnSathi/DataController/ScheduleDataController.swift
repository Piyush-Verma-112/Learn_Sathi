//
//  Schedule.swift
//  LearnSathi
//
//  Created by Shahma Ansari on 06/02/25.
//

import Foundation




class ScheduleDataController {
    private var schedule: [Schedule] = []
    static var shared = ScheduleDataController()
    private init() {
        loadDummyData()
    }
    
    // MARK: - Data Loading
    func loadDummyData() {
        schedule = [
            Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "EnglishLogo", subjectName: "English Grammar", topicName: "Modals", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Basics", "Usage", "Examples"], lessonNumber: 1),
            Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "2 hr", subjectLogo: "ScienceLogo", subjectName: "Science", topicName: "Photosynthesis", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "11:00 AM", endTime: "1:00 PM", topicDescription: ["Definition", "Process", "Applications"], lessonNumber: 8),
            Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "HindiLogo", subjectName: "Hindi", topicName: "Nibandh Lekhan", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "9:00 AM", endTime: "10:00 AM", topicDescription: ["Format", "Examples", "Practice"], lessonNumber: 3),
            Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "1.5 hr", subjectLogo: "Maths", subjectName: "Mathematics", topicName: "Algebra Basics", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 21))!, startTime: "2:00 PM", endTime: "3:30 PM", topicDescription: ["Linear Equations", "Variables", "Graphing"], lessonNumber: 5)
        ]
    }
    
    // MARK: - Data Access
    func allSchedules() -> [Schedule] {
        return schedule
    }
    
    // MARK: - Date Related Methods
    func getDatesForMonth(from date: Date) -> [Date] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let monthStart = calendar.date(from: components) else { return [] }
        
        let range = calendar.range(of: .day, in: .month, for: monthStart) ?? 1..<32
        return range.map { day in
            calendar.date(byAdding: .day, value: day - 1, to: monthStart)!
        }
    }
    
    func getDaysInMonth(for date: Date) -> Int {
        let calendar = Calendar.current
        if let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return 0
    }
    
    // MARK: - Schedule Filtering
    func getSchedules(for date: Date) -> [Schedule] {
        let calendar = Calendar.current
        return schedule.filter { calendar.isDate($0.date, inSameDayAs: date) }
    }
    
    // MARK: - Date Utilities
    func isToday(_ date: Date) -> Bool {
        return Calendar.current.isDate(date, inSameDayAs: Date())
    }
    
    func isSameMonth(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        let comp1 = calendar.dateComponents([.year, .month], from: date1)
        let comp2 = calendar.dateComponents([.year, .month], from: date2)
        return comp1.year == comp2.year && comp1.month == comp2.month
    }
}

