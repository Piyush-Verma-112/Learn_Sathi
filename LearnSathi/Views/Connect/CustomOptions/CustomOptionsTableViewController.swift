//
//  ConnectTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 16/01/25.
//

import UIKit

class CustomOptionsTableViewController: UITableViewController {
    
    var tutorProfileImage: UIImage?
    var tutorName: String?
    var subjectName: String?
    
    @IBOutlet weak var tutorProfileImageView: UIImageView!
    @IBOutlet weak var tutorNameLabel: UILabel!
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet var connectTableView: UITableView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupTableView()
            updateUI()
        }

        private func setupTableView() {
            tableView.delegate = self
            tableView.dataSource = self
        }

        private func updateUI() {
            tutorProfileImageView.image = tutorProfileImage
            tutorNameLabel.text = tutorName ?? "Unknown Tutor"
            subjectNameLabel.text = subjectName ?? "Unknown Subject"
        }
}
    

