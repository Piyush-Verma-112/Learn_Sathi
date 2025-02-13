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
        
        // Get the current month's first day
        let today = calendar.startOfDay(for: Date())
        
        // Create some dummy schedules for today
        let schedule1 = Schedule(
            tutorLogo: "user2",
            tutorName: "Md Akhlak",
            duration: "1 hour",
            subjectLogo: "Maths",
            subjectName: "Mathematics",
            topicName: "Algebra Basics",
            date: today,
            startTime: "9:00 AM",
            endTime: "10:00 AM",
            topicDescription: ["Introduction to Algebra", "Basic Operations"],
            lessonNumber: 1
        )
        
        let schedule2 = Schedule(
            tutorLogo: "profileImage",
            tutorName: "Jane Doe",
            duration: "1.5 hours",
            subjectLogo: "science",
            subjectName: "Science",
            topicName: "Physics Fundamentals",
            date: today,
            startTime: "11:00 AM",
            endTime: "12:30 PM",
            topicDescription: ["Newton's Laws", "Motion and Forces"],
            lessonNumber: 2
        )
        
        let schedule3 = Schedule(
            tutorLogo: "user2",
            tutorName: "Md Akhlak",
            duration: "2 hours",
            subjectLogo: "Maths",
            subjectName: "Mathematics",
            topicName: "Monthly Test",
            date: today,
            startTime: "2:00 PM",
            endTime: "4:00 PM",
            topicDescription: ["Algebra", "Geometry", "Trigonometry"],
            lessonNumber: 3,
            type: .test
        )
        
        // Add schedules to the array
        schedule = [schedule1, schedule2, schedule3]
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
    func getSchedules(for date: Date) -> [String: [Schedule]] {
        let calendar = Calendar.current
        let daySchedules = schedule.filter { calendar.isDate($0.date, inSameDayAs: date) }
        
        var grouped: [String: [Schedule]] = [
            "Scheduled Class": [],
            "Scheduled Test": []
        ]
        
        // Sort schedules by type
        for schedule in daySchedules {
            if schedule.type == .regularClass {
                grouped["Scheduled Class"]?.append(schedule)
            } else {
                grouped["Scheduled Test"]?.append(schedule)
            }
        }
        
        // Sort schedules within each group by start time
        grouped = grouped.mapValues { schedules in
            schedules.sorted { $0.startTime < $1.startTime }
        }
        
        // Remove empty arrays
        return grouped.filter { !$0.value.isEmpty }
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
