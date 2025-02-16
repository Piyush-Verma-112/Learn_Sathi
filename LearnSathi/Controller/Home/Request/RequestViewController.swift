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
        
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "profileImage", tutorName: "Shahma Ansari", requestStatus: "Pending"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        title = "Requests"
        
        registerCells()
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
