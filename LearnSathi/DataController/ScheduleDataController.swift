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
    
    func loadDummyData() {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let today = calendar.startOfDay(for: Date())
        let scheduleDates = (0...10).map { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: today)!
        }
        
        schedule = []
        
        let scheduleTemplates = [
            ("Pradeep Gupta", "English Grammar", "Modals", "EnglishLogo", "9:00 AM", "10:00 AM", ["Basics", "Usage", "Examples"]),
            ("Shahma Ansari", "Science", "Photosynthesis", "ScienceLogo", "11:00 AM", "1:00 PM", ["Definition", "Process", "Applications"]),
            ("Ayush Singh", "Physics", "Newton's Laws", "PhysicsLogo", "2:00 PM", "3:00 PM", ["First Law", "Second Law", "Third Law"])
        ]

        for (index, date) in scheduleDates.enumerated() {
            let template = scheduleTemplates[index % scheduleTemplates.count]
            
            schedule.append(
                Schedule(tutorLogo: "person",
                         tutorName: template.0,
                         duration: "1 hr",
                         subjectLogo: template.3,
                         subjectName: template.1,
                         topicName: template.2,
                         date: date,
                         startTime: template.4,
                         endTime: template.5,
                         topicDescription: template.6,
                         lessonNumber: index + 1)
            )
        }
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
        let schedules = schedule.filter { calendar.isDate($0.date, inSameDayAs: date) }
        
        return schedules.sorted { $0.startTime < $1.startTime }
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

