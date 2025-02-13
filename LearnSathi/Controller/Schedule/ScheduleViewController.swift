//
//  ScheduleViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit
import EventKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet var profileBarButtonItem: UIBarButtonItem!

    @IBOutlet var scheduleCollectionView: UICollectionView!
    
    @IBOutlet var calendarCollectionView: UICollectionView!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    // MARK: - Properties
    private let dataController = ScheduleDataController.shared
    
    var isSelected: Bool = true
    var currentMonthDates: [Date] = []
    var lastSelectedMonth: Int = -1
    private var hasInitialScroll = false
    var filteredSchedules: [String: [Schedule]] = [:]
    var selectedDate: Date?
    var noScheduleLabel: UILabel?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !hasInitialScroll {
            scrollToToday()
            hasInitialScroll = true
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
//  MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        selectedDate = Calendar.current.startOfDay(for: Date())
        filterSchedules(for: selectedDate!)
        
        _ = UIContextMenuInteraction(delegate: self)
        profileBarButtonItem.menu = self.contextMenu()
    }
    
    
    @IBAction func calendarButtonTapped(_ sender: Any) {
        let eventKitVC = EventKitViewController()
        let navigationController = UINavigationController(rootViewController: eventKitVC)
        present(navigationController, animated: true)
    }
    
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        registerCells()
        customizeCollectionView()
        setupNoScheduleLabel()
        setupDatePicker()
        updateDatesForSelectedMonth()
    }
    
    private func setupNoScheduleLabel() {
        noScheduleLabel = UILabel()
        noScheduleLabel?.text = "Nothing scheduled for today"
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
    
    private func registerCells() {
        calendarCollectionView.register(UINib(nibName: CalendarCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        
        scheduleCollectionView.register(UINib(nibName: ScheduleCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: ScheduleCollectionViewCell.identifier)
        
        scheduleCollectionView.register(UINib(nibName: "ScheduleTestCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "ScheduleTestCollectionViewCell")
        
        scheduleCollectionView.register(SectionHeaderCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: "header")
    }

    
    private func customizeCollectionView() {
        calendarCollectionView.layer.shadowColor = UIColor.black.cgColor
        calendarCollectionView.layer.shadowOffset = .zero
        calendarCollectionView.layer.shadowOpacity = 0.1
        
        if let layout = scheduleCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.headerReferenceSize = CGSize(width: view.frame.width, height: 50)
        }
    }
    
    // MARK: - Data Update Methods
    private func updateDatesForSelectedMonth() {
        currentMonthDates = dataController.getDatesForMonth(from: datePicker.date)
        calendarCollectionView.reloadData()
    }
    
    private func filterSchedules(for date: Date) {
        filteredSchedules = dataController.getSchedules(for: date)
        scheduleCollectionView.reloadData()
        let isEmpty = filteredSchedules.values.allSatisfy { $0.isEmpty }
        noScheduleLabel?.isHidden = !isEmpty
    }
    
    // MARK: - Navigation Methods
    private func scrollToToday() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let index = currentMonthDates.firstIndex(where: {
            calendar.isDate($0, inSameDayAs: today)
        }) {
            let indexPath = IndexPath(item: index, section: 0)
            calendarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    //MARK: Actions
    @IBAction func profileBarButtonItemTapped(_ sender: Any) {
        _ = UIContextMenuInteraction(delegate: self)
        profileBarButtonItem.menu = self.contextMenu()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let calendar = Calendar.current
        let selectedMonth = calendar.component(.month, from: sender.date)
        selectedDate = calendar.startOfDay(for: sender.date)
        
        if selectedMonth != lastSelectedMonth {
            lastSelectedMonth = selectedMonth
            updateDatesForSelectedMonth()
        }
        
        updateCalendarSelection()
        filterSchedules(for: selectedDate!)
    }
    
    private func updateCalendarSelection() {
        guard let selectedDate = selectedDate else { return }
        if let index = currentMonthDates.firstIndex(where: {
            Calendar.current.isDate($0, inSameDayAs: selectedDate)
        }) {
            let indexPath = IndexPath(item: index, section: 0)
            calendarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        calendarCollectionView.reloadData()
    }
    
    @objc func closePopUp() {
        if let dimmingView = self.view.viewWithTag(999) {
            UIView.animate(withDuration: 0.3, animations: {
                dimmingView.alpha = 0
            }) { _ in
                dimmingView.removeFromSuperview()
            }
        }
        
        if let popUpView = self.view.subviews.first(where: { $0 is SchedulePopUpView }) {
            UIView.animate(withDuration: 0.3, animations: {
                popUpView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                popUpView.alpha = 0
            }) { _ in
                popUpView.removeFromSuperview()
            }
        }
    }
}



//MARK: -  Extension function
extension ScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == scheduleCollectionView {
            return filteredSchedules.keys.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == scheduleCollectionView {
            let sectionKey = Array(filteredSchedules.keys).sorted()[section]
            return filteredSchedules[sectionKey]?.count ?? 0
        } else {
            return dataController.getDaysInMonth(for: datePicker.date)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == scheduleCollectionView {
               let sectionKey = Array(filteredSchedules.keys).sorted()[indexPath.section]
               guard let schedules = filteredSchedules[sectionKey] else {
                   return UICollectionViewCell()
               }
               let schedule = schedules[indexPath.row]
               
               switch schedule.type {
               case .regularClass:
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCollectionViewCell.identifier,
                                                               for: indexPath) as! ScheduleCollectionViewCell
                   cell.setup(schedule: schedule)
                   return cell
                   
               case .test:
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleTestCollectionViewCell",
                                                               for: indexPath) as! ScheduleTestCollectionViewCell
                   cell.setup(schedule: schedule)
                   return cell
               }
           } else if collectionView == calendarCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier,
                                                        for: indexPath) as! CalendarCollectionViewCell
            
            let cellDate = currentMonthDates[indexPath.row]
            let isToday = dataController.isToday(cellDate)
            let isSelectedDate = Calendar.current.isDate(cellDate, inSameDayAs: selectedDate ?? Date())
            let isCurrentMonth = dataController.isSameMonth(cellDate, datePicker.date)
            
            configureCellAppearance(cell, date: cellDate, isToday: isToday,isSelected: isSelectedDate, isCurrentMonth: isCurrentMonth)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    private func configureCellAppearance(_ cell: CalendarCollectionViewCell, date: Date,
                                           isToday: Bool, isSelected: Bool, isCurrentMonth: Bool) {
            // Reset cell styles
            cell.contentView.alpha = 1.0
            cell.contentView.backgroundColor = .clear
            cell.contentView.layer.shadowOpacity = 0
            cell.contentView.layer.cornerRadius = 0
            cell.dayLabel.textColor = UIColor(named: "DefaultLabelColor")
            cell.dateLabel.textColor = .systemGray
            
            // Set day and date labels
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            cell.dateLabel.text = String(day)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            let dayName = dateFormatter.string(from: date).uppercased()
            cell.dayLabel.text = dayName
            
            // Apply conditional styling
            if !isCurrentMonth {
                cell.contentView.alpha = 0.3
            } else if isSelected {
                cell.contentView.layer.shadowColor = UIColor.black.cgColor
                cell.contentView.layer.shadowOffset = .zero
                cell.contentView.layer.shadowOpacity = 0.1
                cell.contentView.layer.cornerRadius = 10
                cell.contentView.backgroundColor = .black.withAlphaComponent(0.1)
                cell.dayLabel.textColor = .systemBlue
                cell.dateLabel.textColor = .systemBlue
            } else if isToday {
                cell.dayLabel.textColor = .systemGreen
                cell.dateLabel.textColor = .systemGreen
            } else if self.isSelected && date > (selectedDate ?? Date()) {
                cell.contentView.alpha = 0.5
                cell.dayLabel.textColor = .gray
                cell.dateLabel.textColor = .gray
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == scheduleCollectionView {
            showSchedulePopUp(for: indexPath)
        } else if collectionView == calendarCollectionView {
            selectedDate = currentMonthDates[indexPath.row]
            datePicker.setDate(selectedDate!, animated: true)
            filterSchedules(for: selectedDate!)
            collectionView.reloadData()
        }
    }
    
    private func showSchedulePopUp(for indexPath: IndexPath) {
        let sectionKey = Array(filteredSchedules.keys).sorted()[indexPath.section]
        guard let schedules = filteredSchedules[sectionKey] else {
            return
        }
        let selectedSchedule = schedules[indexPath.row]
        let selectedCell = scheduleCollectionView.cellForItem(at: indexPath)
        
        // Create dimming view
        let dimmingView = UIView(frame: self.view.bounds)
        dimmingView.backgroundColor = .systemBackground
        dimmingView.tag = 999
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closePopUp))
        dimmingView.addGestureRecognizer(tapGesture)
        self.view.addSubview(dimmingView)
        
        // Create and configure pop-up view
        let popUpView = SchedulePopUpView(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 502))
        popUpView.center = self.view.center
        popUpView.configure(with: selectedSchedule)
        
        // Add close button
        let closeButton = UIButton(frame: CGRect(x: popUpView.bounds.width - 40, y: 10, width: 30, height: 30))
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .systemGray
        closeButton.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
        popUpView.addSubview(closeButton)
        
        // Animation setup
        let startFrame = selectedCell?.convert(selectedCell?.bounds ?? .zero, to: self.view) ?? .zero
        popUpView.frame = startFrame
        popUpView.layer.cornerRadius = 12
        popUpView.clipsToBounds = true
        self.view.addSubview(popUpView)
        
        // Animate
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0,
                      initialSpringVelocity: 0.7, options: .beginFromCurrentState) {
            popUpView.frame = CGRect(x: 20, y: self.view.center.y - 220,
                                   width: self.view.bounds.width - 40, height: 440)
            dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
}

//MARK: - EXTENSION - UIContextMenuInteractionDelegate
extension ScheduleViewController: UIContextMenuInteractionDelegate {
    func contextMenu() -> UIMenu {
        let akhlakAction = UIAction(title: "Ayush Singh", image: UIImage(named: "profileImage"), identifier: nil, state: .on) { _ in
            // Handle Akhlak action
        }

        let samarAction = UIAction(title: "Md Akhlak", image: UIImage(named: "user2")) { _ in
            // Handle Samar action
        }

        let addChildAction = UIAction(title: "Add Child", image: UIImage(systemName: "plus")) { _ in
            // Handle Add Child action
        }

        return UIMenu(title: "", children: [akhlakAction, samarAction, addChildAction])
    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { [weak self] _ in
            return self?.contextMenu()
        }
    }
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "header",
                for: indexPath) as! SectionHeaderCollectionReusableView
            
            let sectionKey = Array(filteredSchedules.keys).sorted()[indexPath.section]
            if sectionKey == "Scheduled Class" {
                headerView.headerLabel.text = "Scheduled Classes"
                headerView.headerLabel.textColor = .darkGray
            } else {
                headerView.headerLabel.text = "Scheduled Tests"
                headerView.headerLabel.textColor = .systemBlue
            }
            headerView.headerLabel.font = .systemFont(ofSize: 20, weight: .semibold)
            
            
            return headerView
        }
        return UICollectionReusableView()
    }
}
