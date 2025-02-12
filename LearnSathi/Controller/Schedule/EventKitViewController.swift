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
            calendar.tintColor = .systemBlue
            calendar.backgroundColor = .systemBackground
            calendar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
            
            // Check for calendar access
            if !hasCalendarAccess {
                let alert = UIAlertController(
                    title: "Calendar Access Required",
                    message: "Please grant calendar access in Settings to view events.",
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                })
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                present(alert, animated: true)
                return
            }
            
            let schedules = dataController.getSchedules(for: date)
            
            let event = EKEvent(eventStore: eventStore)
            event.title = "Schedule for \(date.formatted(date: .long, time: .omitted))"
            event.calendar = eventStore.defaultCalendarForNewEvents
            
            
            if let firstSchedule = schedules.first {
                event.startDate = firstSchedule.startTime
                event.endDate = schedules.last?.endTime ?? firstSchedule.endTime
                
                var notes = ""
                for (index, schedule) in schedules.enumerated() {
                    let timeFormatter = DateFormatter()
                    timeFormatter.timeStyle = .short
                    
                    notes += "\n\(index + 1). \(schedule.subjectName)\n"
                    notes += "   Time: \(timeFormatter.string(from: schedule.startTime)) - \(timeFormatter.string(from: schedule.endTime))\n"
                    notes += "   Teacher: \(schedule.tutorName)\n"
                    notes += "   Chapter: \(schedule.chapterName)\n"
                    notes += "   Lesson: \(schedule.lessonNumber)\n"
                }
                event.notes = notes
                
                let eventViewController = EKEventViewController()
                eventViewController.event = event
                navigationController?.pushViewController(eventViewController, animated: true)
            }
        }

}

extension EventKitViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let date = Calendar.current.date(from: dateComponents) else { return nil }
        
        let schedules = dataController.getSchedules(for: date)
        if !schedules.isEmpty {
            return .default(color: .systemBlue)
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

