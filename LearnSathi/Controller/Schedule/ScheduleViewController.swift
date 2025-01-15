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
    
    
    
//  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarCollectionView.layer.shadowColor = UIColor.black.cgColor
        calendarCollectionView.layer.shadowOffset = .zero
        calendarCollectionView.layer.shadowOpacity = 0.1
        registerCalendarCells()
        registerCells()
    }
    
    private func registerCalendarCells() {
        calendarCollectionView.register(UINib(nibName: CalendarCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
    }
    
    private func registerCells() {
        scheduleCollectionView.register(UINib(nibName: ScheduleCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ScheduleCollectionViewCell.identifier)
    }

}


//Extension function
extension ScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == scheduleCollectionView {
            return schedule.count
        } else if collectionView == calendarCollectionView {
            return calendar.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == scheduleCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCollectionViewCell.identifier, for: indexPath) as! ScheduleCollectionViewCell
            cell.setup(schedule: schedule[indexPath.row])
            return cell
        } else if collectionView == calendarCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as! CalendarCollectionViewCell
            cell.setup(calendar: calendar[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

