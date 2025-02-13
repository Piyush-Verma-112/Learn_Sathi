import UIKit
import EventKit
import EventKitUI

class EventKitViewController: UIViewController {
    
    private let eventStore = EKEventStore()
    private var calendar: UICalendarView!
    private var selectedDate: DateComponents?
    private let dataController = ScheduleDataController.shared
    private var hasCalendarAccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        setupNavigationBar()
        requestCalendarAccess()
    }
    
    private func requestCalendarAccess() {
        eventStore.requestAccess(to: .event) { [weak self] granted, error in
            DispatchQueue.main.async {
                self?.hasCalendarAccess = granted
            }
        }
    }
    
    private func setupCalendarView() {
        calendar = UICalendarView(frame: view.bounds)
        calendar.calendar = .current
        calendar.delegate = self
        calendar.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        calendar.tintColor = .red
        calendar.backgroundColor = .systemBackground
        calendar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        calendar.fontDesign = .rounded
        calendar.layer.cornerRadius = 12
        
        let currentDate = Date()
        var dateComponents = Calendar.current.dateComponents([.year], from: currentDate)
        dateComponents.year = dateComponents.year! - 2
        let startDate = Calendar.current.date(from: dateComponents)!
        dateComponents.year = dateComponents.year! + 4
        let endDate = Calendar.current.date(from: dateComponents)!
        calendar.visibleDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
        calendar.availableDateRange = DateInterval(start: startDate, end: endDate)
        
        view.addSubview(calendar)
    }
    
    private func setupNavigationBar() {
        title = "Calendar"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(dismissCalendar)
        )
    }
    
    @objc private func dismissCalendar() {
        dismiss(animated: true)
    }
    
    private func showEvents(for date: DateComponents) {
        guard let date = Calendar.current.date(from: date) else { return }
        
        let schedulesDict = dataController.getSchedules(for: date)
        
        if !schedulesDict.isEmpty {
            let event = EKEvent(eventStore: eventStore)
            event.title = "Schedule for \(date.formatted(date: .long, time: .omitted))"
            event.calendar = eventStore.defaultCalendarForNewEvents
            
            var allSchedules: [Schedule] = []
            schedulesDict.values.forEach { allSchedules.append(contentsOf: $0) }
            
            if let firstSchedule = allSchedules.min(by: { $0.startTime < $1.startTime }),
               let lastSchedule = allSchedules.max(by: { $0.endTime < $1.endTime }) {
                event.startDate = firstSchedule.startTime
                event.endDate = lastSchedule.endTime
                
                var notes = ""
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "h:mm a"
                
                for (sectionTitle, schedules) in schedulesDict {
                    notes += "\n\(sectionTitle):\n"
                    
                    for (index, schedule) in schedules.enumerated() {
                        notes += "\n\(index + 1). \(schedule.subjectName)\n"
                        notes += "  Time: \(timeFormatter.string(from: schedule.startTime)) - \(timeFormatter.string(from: schedule.endTime))\n"
                        notes += "  Teacher: \(schedule.tutorName)\n"
                        notes += "  Topic: \(schedule.subjectName)\n"
                        notes += "  Lesson: \(schedule.lessonNumber)\n"
                    }
                    notes += "\n"
                }
                
                event.notes = notes
                
                let eventViewController = EKEventViewController()
                eventViewController.event = event
                eventViewController.allowsEditing = false
                navigationController?.pushViewController(eventViewController, animated: true)
            }
        }
    }
}

extension EventKitViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let date = Calendar.current.date(from: dateComponents) else { return nil }
        
        let schedules = dataController.getSchedules(for: date)
        if !schedules.isEmpty {
            let defaultColor: UIColor = .systemRed
            let customDecoration = UICalendarView.Decoration.customView {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 6))
                view.backgroundColor = defaultColor
                view.layer.cornerRadius = 3
                return view
            }
            return customDecoration
        }
        return nil
    }
}

extension EventKitViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents else { return }
        selectedDate = dateComponents
        showEvents(for: dateComponents)
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
}
