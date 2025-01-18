//
//  ScheduleViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit
import FSCalendar


class ScheduleViewController: UIViewController {
    

    @IBOutlet var scheduleCollectionView: UICollectionView!
    
    @IBOutlet var calendarCollectionView: UICollectionView!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var isSelected : Bool = false
    
    var currentMonthDates: [Date] = [] // Store all dates of the selected month
    var lastSelectedMonth: Int = -1
    private var hasInitialScroll = false

    
//  viewDidLoad
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        registerCalendarCells()
        registerCells()
        customizeCollectionView()
        scrollToToday()
        setupDatePicker()
        updateDatesForSelectedMonth()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !hasInitialScroll {
            scrollToToday()
            hasInitialScroll = true
        }
    }
    
    private func setupDatePicker() {
            // Set date picker to start of today
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            datePicker.date = today
            lastSelectedMonth = calendar.component(.month, from: today)
            
            datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
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
            
            // Get start of the selected month, removing time components
            let components = calendar.dateComponents([.year, .month], from: datePicker.date)
            guard let monthStart = calendar.date(from: components) else { return }
            
            let range = calendar.range(of: .day, in: .month, for: monthStart) ?? 1..<32
            
            // Create dates for the entire month
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
            
            if selectedMonth != lastSelectedMonth {
                lastSelectedMonth = selectedMonth
                updateDatesForSelectedMonth()
            }
        }
    

}


//Extension function
extension ScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == scheduleCollectionView{
            return schedule.count
        }else {
            print(getMonth())
            return getMonth()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == scheduleCollectionView {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCollectionViewCell.identifier, for: indexPath) as! ScheduleCollectionViewCell
                cell.setup(schedule: schedule[indexPath.row])
                return cell
            } else if collectionView == calendarCollectionView {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as! CalendarCollectionViewCell
                
                let calendar = Calendar.current
                let cellDate = currentMonthDates[indexPath.row]
                let today = calendar.startOfDay(for: Date())
                
                // Configure date label
                let day = calendar.component(.day, from: cellDate)
                cell.dateLabel.text = String(day)
                
                // Configure day label
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEE"
                let dayName = dateFormatter.string(from: cellDate).uppercased()
                cell.dayLabel.text = dayName
                
                // Reset cell styling
                cell.contentView.layer.shadowColor = UIColor.clear.cgColor
                cell.contentView.layer.shadowOffset = .zero
                cell.contentView.layer.shadowOpacity = 0
                cell.contentView.layer.cornerRadius = 0
                cell.contentView.backgroundColor = .clear
                
                // Apply styling only for today's date
                if calendar.isDate(cellDate, inSameDayAs: today) {
                    cell.contentView.layer.shadowColor = UIColor.black.cgColor
                    cell.contentView.layer.shadowOffset = .zero
                    cell.contentView.layer.cornerRadius = 10
                    cell.contentView.layer.shadowOpacity = 0.1
                    cell.contentView.backgroundColor = .systemBlue.withAlphaComponent(0.1)
                }
                
                return cell
            }
            return UICollectionViewCell()
        }
        

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == scheduleCollectionView {
            let selectedSchedule = schedule[indexPath.row]

            let dimmingView = UIView(frame: self.view.bounds)
            dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            dimmingView.tag = 999
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closePopUp))
            dimmingView.addGestureRecognizer(tapGesture)
            self.view.addSubview(dimmingView)
            
            
            let popUpView = SchedulePopUpView(frame: CGRect(x: 0, y: 0, width: 350, height: 502))
            popUpView.center = self.view.center
            popUpView.configure(with: selectedSchedule)
            
            
            let closeButton = UIButton(frame: CGRect(x: popUpView.bounds.width - 40, y: 5, width: 40, height: 40))
            closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            closeButton.tintColor = .systemGray
            closeButton.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
            popUpView.addSubview(closeButton)
            
            self.view.addSubview(popUpView)
            self.view.bringSubviewToFront(popUpView)
        }
        
    }

    @objc func closePopUp() {
        // Remove dimming view
        if let dimmingView = self.view.viewWithTag(999) {
            dimmingView.removeFromSuperview()
        }
        
        // Remove pop-up view
        if let popUpView = self.view.subviews.first(where: { $0 is SchedulePopUpView }) {
            popUpView.removeFromSuperview()
        }
    }

    
    
    
}

