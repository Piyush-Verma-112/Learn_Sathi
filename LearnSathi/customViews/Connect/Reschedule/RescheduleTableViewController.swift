//
//  RescheduleTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 20/01/25.
//

import UIKit

class RescheduleTableViewController: UITableViewController{
    
    let subjects = ["English", "Hindi", "Mathematics", "Social Science"]
        var lessonsMapping: [String: [String]] = [
            "English": chapterDetailsEnglish.map { $0.chapterName },
            "Hindi": chapterDetailsHindi.map { $0.chapterName },
            "Mathematics": chapterDetailsMaths.map { $0.chapterName },
            "Social Science": chapterDetailsSocialStudies.map { $0.chapterName }
        ]
        var currentLessons: [String] = []
    
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var lessonButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var lessonLabel: UILabel!

    
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.rowHeight = UITableView.automaticDimension
            tableView.separatorStyle = .none
            setupMenus()
        }
   
        
        override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 0.3 
        }
    // MARK: - Setup Menus
    private func setupMenus() {
        var subjectActions: [UIAction] = []
        for subject in subjects {
            let action = UIAction(title: subject, handler: { [weak self] _ in
                self?.subjectLabel.text = subject
                self?.updateLessons(for: subject)
            })
            subjectActions.append(action)
        }
        let subjectMenu = UIMenu(title: "", children: subjectActions)
        subjectButton.menu = subjectMenu
        subjectButton.showsMenuAsPrimaryAction = true
        updateLessons(for: subjects.first ?? "")
    }
    
    private func updateLessons(for subject: String) {
        currentLessons = lessonsMapping[subject] ?? []
        var lessonActions: [UIAction] = []
        for lesson in currentLessons {
            let action = UIAction(title: lesson, handler: { [weak self] _ in
                self?.lessonLabel.text = lesson
            })
            lessonActions.append(action)
        }
        let lessonMenu = UIMenu(title: "", children: lessonActions)
        lessonButton.menu = lessonMenu
        lessonButton.showsMenuAsPrimaryAction = true
    }
@IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(
            title: "Request Sent",
            message: "Your reschedule request has been sent successfully.",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alertController, animated: true, completion: nil)
    }

}

