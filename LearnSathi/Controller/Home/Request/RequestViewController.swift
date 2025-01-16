//
//  RequestViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 16/01/25.
//

import UIKit

class RequestViewController: UIViewController {

    @IBOutlet var requestTableView: UITableView!
    
    
    var requests: [Request] = [
        
        Request(tutorImage: #imageLiteral(resourceName: "profileImage.png"), tutorName: "Shahma Ansari"),
        Request(tutorImage: #imageLiteral(resourceName: "profileImage.png"), tutorName: "Shahma Ansari"),
        Request(tutorImage: #imageLiteral(resourceName: "profileImage.png"), tutorName: "Shahma Ansari"),
        Request(tutorImage: #imageLiteral(resourceName: "profileImage.png"), tutorName: "Shahma Ansari"),
        Request(tutorImage: #imageLiteral(resourceName: "profileImage.png"), tutorName: "Shahma Ansari"),
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func registerCells() {
        requestTableView.register(UINib(nibName: RequestTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RequestTableViewCell.identifier)
    }
}


extension RequestViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = requestTableView.dequeueReusableCell(withIdentifier: RequestTableViewCell.identifier) as! RequestTableViewCell
        
        cell.setup(request: requests[indexPath.row])
        
        return cell
    }
    
}
