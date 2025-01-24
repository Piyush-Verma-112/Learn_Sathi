//
//  YouTutorListTableViewController.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 24/01/25.
//

import UIKit

class YouTutorListTableViewController: UITableViewController {

    @IBOutlet var tutorListTableView: UITableView!
    
    let lessons = ["Current Tutor", "Past Tutor"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Tutors"
        registerCell()
    }
    
    private func registerCell() {
        tutorListTableView.register(UINib(nibName:YouTutorListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: YouTutorListTableViewCell.identifier)
    }
    
//    private func setupMenus() {
//        var subjectActions: [UIAction] = []
//        
//        
//        
//        var lessonActions: [UIAction] = []
//        for lesson in lessons {
//            let action = UIAction(title: lesson, handler: { [weak self] _ in
//                self?.lessonLabel.text = "\(lesson)"
//            })
//            lessonActions.append(action)
//        }
//        let lessonMenu = UIMenu(title: "Choose Lesson", children: lessonActions)
//        lessonButton.menu = lessonMenu
//        lessonButton.showsMenuAsPrimaryAction = true
//    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Current Tutors"
        }
        return "Past Tutors"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tutors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YouTutorListTableViewCell.identifier, for: indexPath) as? YouTutorListTableViewCell else {
            fatalError("Error while dequing cell")
        }
        cell.setup(tutors: tutors[indexPath.row])
        return cell
    }
}
