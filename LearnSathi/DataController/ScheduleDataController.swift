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
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: today)
        
        // Today's classes
        let todayClasses = [
            Schedule(
                tutorLogo: "person",
                tutorName: "Dr. Smith",
                duration: "1 hr",
                subjectLogo: "EnglishLogo",
                subjectName: "English",
                topicName: "Advanced Grammar",
                date: calendar.date(from: DateComponents(year: todayComponents.year, month: todayComponents.month, day: todayComponents.day, hour: 9))!,
                startTime: "9:00 AM",
                endTime: "10:00 AM",
                topicDescription: ["Verb Tenses", "Modals", "Conditionals"],
                lessonNumber: 1
            ),
            
            Schedule(
                tutorLogo: "person",
                tutorName: "Prof. Johnson",
                duration: "1.5 hr",
                subjectLogo: "Maths",
                subjectName: "Mathematics",
                topicName: "Calculus Basics",
                date: calendar.date(from: DateComponents(year: todayComponents.year, month: todayComponents.month, day: todayComponents.day, hour: 11))!,
                startTime: "11:00 AM",
                endTime: "12:30 PM",
                topicDescription: ["Derivatives", "Limits", "Integration"],
                lessonNumber: 2
            ),
            
            Schedule(
                tutorLogo: "person",
                tutorName: "Dr. Wilson",
                duration: "2 hr",
                subjectLogo: "ScienceLogo",
                subjectName: "Science",
                topicName: "Physics Fundamentals",
                date: calendar.date(from: DateComponents(year: todayComponents.year, month: todayComponents.month, day: todayComponents.day, hour: 14))!,
                startTime: "2:00 PM",
                endTime: "4:00 PM",
                topicDescription: ["Mechanics", "Thermodynamics", "Waves"],
                lessonNumber: 3
            )
        ]
        
        let febTestData = [
            // English Test - First Sunday
            Schedule(
                tutorLogo: "person",
                tutorName: "English Proctor",
                duration: "2 hr",
                subjectLogo: "EnglishLogo",
                subjectName: "English",
                topicName: "Monthly English Assessment",
                date: calendar.date(from: DateComponents(year: 2025, month: 2, day: 2, hour: 10))!,
                startTime: "10:00 AM",
                endTime: "12:00 PM",
                topicDescription: ["Grammar", "Comprehension", "Writing"],
                lessonNumber: 1,
                type: .test
            ),
            
            // Mathematics Test - Second Sunday
            Schedule(
                tutorLogo: "person",
                tutorName: "Math Proctor",
                duration: "2 hr",
                subjectLogo: "Maths",
                subjectName: "Mathematics",
                topicName: "Monthly Math Assessment",
                date: calendar.date(from: DateComponents(year: 2025, month: 2, day: 9, hour: 10))!,
                startTime: "10:00 AM",
                endTime: "12:00 PM",
                topicDescription: ["Algebra", "Geometry", "Arithmetic"],
                lessonNumber: 2,
                type: .test
            ),
            
            // Science Test - Third Sunday
            Schedule(
                tutorLogo: "person",
                tutorName: "Science Proctor",
                duration: "2 hr",
                subjectLogo: "ScienceLogo",
                subjectName: "Science",
                topicName: "Monthly Science Assessment",
                date: calendar.date(from: DateComponents(year: 2025, month: 2, day: 16, hour: 10))!,
                startTime: "10:00 AM",
                endTime: "12:00 PM",
                topicDescription: ["Physics", "Chemistry", "Biology"],
                lessonNumber: 3,
                type: .test
            ),
            
            // Hindi Test - Fourth Sunday
            Schedule(
                tutorLogo: "person",
                tutorName: "Hindi Proctor",
                duration: "2 hr",
                subjectLogo: "HindiLogo",
                subjectName: "Hindi",
                topicName: "Monthly Hindi Assessment",
                date: calendar.date(from: DateComponents(year: 2025, month: 2, day: 23, hour: 10))!,
                startTime: "10:00 AM",
                endTime: "12:00 PM",
                topicDescription: ["Vyakaran", "Sahitya", "Nibandh"],
                lessonNumber: 4,
                type: .test
            )
        ]
        

        
        schedule = (todayClasses + febTestData).sorted { firstSchedule, secondSchedule in
                    // First sort by date
            if !calendar.isDate(firstSchedule.date, inSameDayAs: secondSchedule.date) {
                return firstSchedule.date < secondSchedule.date
            }
            
            // If same date, sort by comparing the dates which include hours
            return firstSchedule.date < secondSchedule.date
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
