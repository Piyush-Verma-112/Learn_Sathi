//
//  RescheduleTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 20/01/25.
//

import UIKit

class RescheduleTableViewController: UITableViewController{
    
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
            lessonButton.isEnabled = false
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
                self?.lessonButton.isEnabled = true
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
    guard
    let subjectText = subjectLabel.text, subjectText != "Select Subject",
    let lessonText = lessonLabel.text, lessonText != "Select Lesson"
else {
    let missingFields = [
        subjectLabel.text == "Select Subject" ? "Subject" : nil,
        lessonLabel.text == "Select Lesson" ? "Lesson" : nil
    ].compactMap { $0 }.joined(separator: ", ")

    let alertController = UIAlertController(
        title: "Incomplete Information",
        message: "Please select the following: \(missingFields).",
        preferredStyle: .alert
    )
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alertController, animated: true, completion: nil)
    return
}

let successAlert = UIAlertController(
    title: "Request Sent",
    message: "Your reschedule request has been sent successfully.",
    preferredStyle: .alert
)
successAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
    self.navigationController?.popViewController(animated: true)
})

present(successAlert, animated: true, completion: nil)
}
}

