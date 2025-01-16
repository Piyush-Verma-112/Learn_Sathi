//
//  SearchViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func DoneBtnClicked(_ sender: UIButton) {
        
        let controller = storyboard?.instantiateViewController(identifier: "TutorListCollectionViewController") as! TutorListCollectionViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
