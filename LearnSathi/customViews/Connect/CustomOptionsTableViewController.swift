//
//  ConnectTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 16/01/25.
//

import UIKit

class CustomOptionsTableViewController: UITableViewController {
    
    static let identifier = "CustomOptionsTableViewController"
    var tutorProfileImage: UIImage?
    var tutorName: String?
    var subjectName: String?
    @IBOutlet weak var tutorProfileImageView: UIImageView!
    
    @IBOutlet weak var tutorNameLabel: UILabel!
    
    
    @IBOutlet weak var subjectNameLabel: UILabel!
    
    
    @IBOutlet var connectTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
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


