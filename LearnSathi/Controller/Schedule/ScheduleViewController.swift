//
//  ScheduleViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit
import FSCalendar
import EventKit

class ScheduleViewController: UIViewController {
    

    @IBOutlet var scheduleCollectionView: UICollectionView!
    
    @IBOutlet var calendarCollectionView: UICollectionView!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var isSelected: Bool = true
    var currentMonthDates: [Date] = []
    var lastSelectedMonth: Int = -1
    private var hasInitialScroll = false
    var filteredSchedules: [Schedule] = []
    var selectedDate: Date?
    var noScheduleLabel: UILabel?
    
    
//  MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCalendarCells()
        registerCells()
        customizeCollectionView()
        setupNoScheduleLabel()
        setupDatePicker()
        updateDatesForSelectedMonth()
        
        // Initialize with today's date
        selectedDate = Calendar.current.startOfDay(for: Date())
        filterSchedules(for: selectedDate!)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !hasInitialScroll {
            scrollToToday()
            hasInitialScroll = true
        }
    }
    
    //MARK: -  setUp function
    private func setupNoScheduleLabel() {
        noScheduleLabel = UILabel()
        noScheduleLabel?.text = "No classes scheduled for today"
        noScheduleLabel?.textAlignment = .center
        noScheduleLabel?.textColor = .gray
        noScheduleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        noScheduleLabel?.isHidden = true
        
        if let label = noScheduleLabel {
            scheduleCollectionView.backgroundView = label
        }
    }
 
    private func setupDatePicker() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        datePicker.date = today
        lastSelectedMonth = calendar.component(.month, from: today)
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    func filterSchedules(for date: Date) {
        let calendar = Calendar.current
        filteredSchedules = schedule.filter { calendar.isDate($0.date, inSameDayAs: date) }
        scheduleCollectionView.reloadData()
        
        // Show/hide no schedule label
        noScheduleLabel?.isHidden = !filteredSchedules.isEmpty
    }
    
    private func scrollToToday() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Find today's index
        if let index = currentMonthDates.firstIndex(where: {
            calendar.isDate($0, inSameDayAs: today)
        }) {
            let indexPath = IndexPath(item: index, section: 0)
            calendarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    
    func customizeCollectionView() {
        calendarCollectionView.layer.shadowColor = UIColor.black.cgColor
        calendarCollectionView.layer.shadowOffset = .zero
        calendarCollectionView.layer.shadowOpacity = 0.1
    }

    
    private func registerCalendarCells() {
        calendarCollectionView.register(UINib(nibName: CalendarCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
    }
    
    func updateDatesForSelectedMonth() {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month], from: datePicker.date)
        guard let monthStart = calendar.date(from: components) else { return }
        
        let range = calendar.range(of: .day, in: .month, for: monthStart) ?? 1..<32
        
        currentMonthDates = range.map { day in
            calendar.date(byAdding: .day, value: day - 1, to: monthStart)!
        }
        
        calendarCollectionView.reloadData()
    }
    
    private func registerCells() {
        scheduleCollectionView.register(UINib(nibName: ScheduleCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ScheduleCollectionViewCell.identifier)
    }
    
    
    func getMonth() -> Int {
        let selectedDate = datePicker.date
        let calendar = Calendar.current
        var numberOfDays: Int = 0
        
        if let range = calendar.range(of: .day, in: .month, for: selectedDate) {
            numberOfDays = range.count
        }
        return numberOfDays
    }
        
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let calendar = Calendar.current
        let selectedMonth = calendar.component(.month, from: sender.date)
        
        // Update the selected date
        selectedDate = calendar.startOfDay(for: sender.date)
        
        // Update month if changed
        if selectedMonth != lastSelectedMonth {
            lastSelectedMonth = selectedMonth
            updateDatesForSelectedMonth()
        }
        
        // Find and scroll to the selected date in calendar
        if let index = currentMonthDates.firstIndex(where: {
            calendar.isDate($0, inSameDayAs: selectedDate!)
        }) {
            let indexPath = IndexPath(item: index, section: 0)
            calendarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        // Update UI
        calendarCollectionView.reloadData()
        filterSchedules(for: selectedDate!)
        
    }
    
    @objc func closePopUp() {
        if let dimmingView = self.view.viewWithTag(999) {
            // Fade out the dimming view
            UIView.animate(withDuration: 0.3, animations: {
                dimmingView.alpha = 0
            }) { _ in
                dimmingView.removeFromSuperview() // Remove the dimming view after the fade-out animation
            }
        }

        if let popUpView = self.view.subviews.first(where: { $0 is SchedulePopUpView }) {
            // Animate the pop-up view to scale down and fade out
            UIView.animate(withDuration: 0.3, animations: {
                popUpView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) // Shrink the pop-up
                popUpView.alpha = 0 // Fade out
            }) { _ in
                popUpView.removeFromSuperview() // Remove the pop-up view after the animation
            }
        }
    }
}


//MARK: -  Extension function
extension ScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == scheduleCollectionView {
            return filteredSchedules.count
        } else {
            return getMonth()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == scheduleCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCollectionViewCell.identifier, for: indexPath) as! ScheduleCollectionViewCell
            cell.setup(schedule: filteredSchedules[indexPath.row])
            
            return cell
            
        } else if collectionView == calendarCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as! CalendarCollectionViewCell
            
            let calendar = Calendar.current
            let cellDate = currentMonthDates[indexPath.row]
            let currentMonth = calendar.component(.month, from: datePicker.date)
            let cellMonth = calendar.component(.month, from: cellDate)
            let isToday = calendar.isDate(cellDate, inSameDayAs: Date())
            let isSelectedDate = calendar.isDate(cellDate, inSameDayAs: selectedDate ?? Date())

            // Reset cell styles
            cell.contentView.alpha = 1.0
            cell.contentView.backgroundColor = .clear
            cell.contentView.layer.shadowOpacity = 0
            cell.contentView.layer.cornerRadius = 0
            cell.dayLabel.textColor = UIColor(named: "DefaultLabelColor")
            cell.dateLabel.textColor = .systemGray

            // Set day and date labels
            let day = calendar.component(.day, from: cellDate)
            cell.dateLabel.text = String(day)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            let dayName = dateFormatter.string(from: cellDate).uppercased()
            cell.dayLabel.text = dayName

            // Style based on conditions
            if cellMonth != currentMonth {
                // Dim cells not in the current month
                cell.contentView.alpha = 0.3
            } else if isSelectedDate {
                // Highlight the selected date
                cell.contentView.layer.shadowColor = UIColor.black.cgColor
                cell.contentView.layer.shadowOffset = .zero
                cell.contentView.layer.shadowOpacity = 0.1
                cell.contentView.layer.cornerRadius = 10
                cell.contentView.backgroundColor = .black.withAlphaComponent(0.1)
                cell.dayLabel.textColor = .systemBlue
                cell.dateLabel.textColor = .systemBlue
            } else if isToday {
                // Highlight today's date (optional)
                cell.dayLabel.textColor = .systemGreen
                cell.dateLabel.textColor = .systemGreen
            } else if isSelected {
                // Dim future dates
                if cellDate > (selectedDate ?? Date()) {
                    cell.contentView.alpha = 0.5
                    cell.dayLabel.textColor = .gray
                    cell.dateLabel.textColor = .gray
                }
            }

            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == scheduleCollectionView {
            let selectedSchedule = filteredSchedules[indexPath.row]
            let selectedCell = collectionView.cellForItem(at: indexPath)
            
            // Create dimming view
            let dimmingView = UIView(frame: self.view.bounds)
            dimmingView.backgroundColor = .systemBackground
            dimmingView.tag = 999
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closePopUp))
            dimmingView.addGestureRecognizer(tapGesture)
            self.view.addSubview(dimmingView)
            
            // Create pop-up view
            let popUpView = SchedulePopUpView(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 502))
            popUpView.center = self.view.center
            popUpView.configure(with: selectedSchedule)
            
            // Add close button
            let closeButton = UIButton(frame: CGRect(x: popUpView.bounds.width - 40, y: 10, width: 30, height: 30))
            closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            closeButton.tintColor = .systemGray
            closeButton.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
            popUpView.addSubview(closeButton)
            
            // Get the starting frame from the selected cell
            let startFrame = selectedCell?.convert(selectedCell?.bounds ?? .zero, to: self.view) ?? .zero
            
            // Set initial state of pop-up
            popUpView.frame = startFrame
            popUpView.layer.cornerRadius = 12
            popUpView.clipsToBounds = true
            self.view.addSubview(popUpView)
            
            // Animate
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: .beginFromCurrentState) {
                
                // Final state
                popUpView.frame = CGRect(x: 20, y: self.view.center.y - 220,
                                       width: self.view.bounds.width - 40, height: 440)
                dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
            
        } else if collectionView == calendarCollectionView {
            selectedDate = currentMonthDates[indexPath.row]
            // Update the date picker to match the selected date
            datePicker.setDate(selectedDate!, animated: true)
            filterSchedules(for: selectedDate!)
            collectionView.reloadData()
        }
        
    }

}

