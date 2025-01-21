//
//  DetailsViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 16/01/25.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    static var identifier: String {String(describing: DetailsViewController.self)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch navigationItem.title {
        case "Mathematics" :
            return chapterDetailsMaths.count
        case "English" :
            return chapterDetailsEnglish.count
        case "Science" :
            return chapterDetailsScience.count
        case "Social Studies" :
            return chapterDetailsSocialStudies.count
        case "Hindi" :
            return chapterDetailsHindi.count
        default :
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LDTableViewCell
        switch navigationItem.title {
        case "Mathematics" :
            cell.setup(subjectDetails: chapterDetailsMaths[indexPath.row])
        case "English" :
            cell.setup(subjectDetails: chapterDetailsEnglish[indexPath.row])
        case "Science" :
            cell.setup(subjectDetails: chapterDetailsScience[indexPath.row])
        case "Social Studies" :
            cell.setup(subjectDetails: chapterDetailsSocialStudies[indexPath.row])
        case "Hindi" :
            cell.setup(subjectDetails: chapterDetailsHindi[indexPath.row])
        default :
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        346
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        96
    }
}

