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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == scheduleCollectionView {
            let selectedSchedule = schedule[indexPath.row]
            
            // Create dimming view
            let dimmingView = UIView(frame: self.view.bounds)
            dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            dimmingView.tag = 999
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closePopUp))
            dimmingView.addGestureRecognizer(tapGesture)
            self.view.addSubview(dimmingView)
            
            // Create pop-up view
            let popUpView = SchedulePopUpView(frame: CGRect(x: 0, y: 0, width: 350, height: 502))
            popUpView.center = self.view.center
            popUpView.configure(with: selectedSchedule)
            
            // Add close button
            let closeButton = UIButton(frame: CGRect(x: popUpView.bounds.width - 50, y: 10, width: 40, height: 40))
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

