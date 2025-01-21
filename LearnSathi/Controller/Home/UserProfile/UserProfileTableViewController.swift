//
//  UserProfileTableViewController.swift
//  LearnSathi
//
//  Created by iSDP on 21/01/25.
//

import UIKit

class UserProfileTableViewController: UITableViewController {
 
    
    @IBOutlet var userProfileImageView: UIImageView!
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var userClassLabel: UILabel!
    
    
    @IBOutlet var userProfileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "User Profile"
        

        
    }
    
}


