//
//  PersonalInformationTableViewController.swift
//  LearnSathi
//
//  Created by iSDP on 23/01/25.
//

import UIKit

class PersonalInformationTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    
    @IBAction func unwindToUserProfileTableViewController(segue: UIStoryboardSegue) {
        dismiss(animated: true,completion: nil)
    }
    
    
    @IBAction func unwindToUserProfile(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    

}
