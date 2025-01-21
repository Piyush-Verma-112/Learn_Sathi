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
    
    
    var requests: [Request] = [
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari"),
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
        let controller = storyboard?.instantiateViewController(identifier: "UserProfileViewController") as! UserProfileViewController
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
