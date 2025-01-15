//
//  HomeViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var ScheduleCollectionView: UICollectionView!
    
    
    var schedule: [Schedule] = [
        Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "EnglishLogo", subjectName: "English Grammer", date: Date(), startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Topic 1", "Topic 2", "Topic    3"], lessonNumber: 1),
        Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "2 hr", subjectLogo: "EnglishLogo", subjectName: "Mathematics", date: Date(), startTime: "10:00 AM", endTime: "5:00 PM", topicDescription: ["Topic 1", "Topic 2", "Topic    3"], lessonNumber: 8),
        Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "EnglishLogo", subjectName: "English Grammer", date: Date(), startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Topic 1", "Topic 2", "Topic    3"], lessonNumber: 1),
        Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "EnglishLogo", subjectName: "English Grammer", date: Date(), startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Topic 1", "Topic 2", "Topic    3"], lessonNumber: 1),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        
    }
    
    private func registerCells() {
        ScheduleCollectionView.register(UINib(nibName: ScheduleCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ScheduleCollectionViewCell.identifier)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schedule.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCollectionViewCell.identifier, for: indexPath) as! ScheduleCollectionViewCell
        
        cell.setup(schedule: schedule[indexPath.row])
        
        return cell
    }
}
