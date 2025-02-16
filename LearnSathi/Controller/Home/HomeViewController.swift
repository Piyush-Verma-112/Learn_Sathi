//
//  HomeViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var ScheduleCollectionView: UICollectionView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet weak var requestTableView: UITableView!
    
    var schedule : [Schedule] = [
        Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "EnglishLogo", subjectName: "English Grammar", topicName: "Modals", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Basics", "Usage", "Examples"], lessonNumber: 1),
        Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "2 hr", subjectLogo: "ScienceLogo", subjectName: "Science", topicName: "Photosynthesis", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "11:00 AM", endTime: "1:00 PM", topicDescription: ["Definition", "Process", "Applications"], lessonNumber: 8),
        Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "HindiLogo", subjectName: "Hindi", topicName: "Nibandh Lekhan", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "9:00 AM", endTime: "10:00 AM", topicDescription: ["Format", "Examples", "Practice"], lessonNumber: 3),
        Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "1.5 hr", subjectLogo: "Maths", subjectName: "Mathematics", topicName: "Algebra Basics", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 21))!, startTime: "2:00 PM", endTime: "3:30 PM", topicDescription: ["Linear Equations", "Variables", "Graphing"], lessonNumber: 5)
    ]
    
    
    var requests: [Request] = [
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGesture()
        registerTableCells()
        registerCells()
        
    }
    
    private func addTapGesture() {
        profileImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped() {
        let controller = storyboard?.instantiateViewController(identifier: "UserProfileTableViewController") as! UserProfileTableViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func registerTableCells() {
        requestTableView.register(UINib(nibName: RequestTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RequestTableViewCell.identifier)
    }
    
    private func registerCells() {
        ScheduleCollectionView.register(UINib(nibName: ScheduleCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ScheduleCollectionViewCell.identifier)
    }

    @IBAction func seeMoreBtnClicked(_ sender: UIButton) {
        
        let controller = storyboard?.instantiateViewController(identifier: "RequestViewController") as! RequestViewController
        
        navigationController?.pushViewController(controller, animated: true)
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = requestTableView.dequeueReusableCell(withIdentifier: RequestTableViewCell.identifier) as! RequestTableViewCell
        
        cell.setup(request: requests[indexPath.row])
        
        return cell
    }
}
