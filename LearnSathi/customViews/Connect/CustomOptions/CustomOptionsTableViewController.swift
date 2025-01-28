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
        updateUi()
        connectTableView.delegate = self
        connectTableView.dataSource = self
        
    }

    func updateUi() {
        tutorProfileImageView.image = tutorProfileImage
        tutorNameLabel.text = tutorName
        subjectNameLabel.text = subjectName

    }
    
}


