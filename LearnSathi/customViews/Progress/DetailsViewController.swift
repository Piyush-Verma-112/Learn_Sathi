//
//  DetailsViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 16/01/25.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    static var identifier: String {
        String(describing: DetailsViewController.self)
    }
    
    @IBOutlet var tableView: UITableView!
    
    var subjectName: LessonsProgress?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        print("subjectName: \(subjectName?.subject ?? "No Subject")")
           navigationItem.title = subjectName?.subject ?? "Subject"
        
        //collectionView.reloadData()

    }
    
    private func registerCells() {
        let nib = UINib(nibName: "LDTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
    }
    
    
    
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        1
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chapterDetails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LDTableViewCell
        cell.setup(subjectDetails: chapterDetails[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        346
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        96
    }
}

