//
//  RescheduleTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 20/01/25.
//

import UIKit

class RescheduleTableViewController: UITableViewController {
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
        let subjects = ConnectDataController.shared.lessonsMapping.keys
        let subjectActions = subjects.map { subject in
            UIAction(title: subject) { [weak self] _ in
                self?.subjectLabel.text = subject
                self?.updateLessons(for: subject)
                self?.lessonButton.isEnabled = true
            }
        }
        subjectButton.menu = UIMenu(title: "", children: subjectActions)
        subjectButton.showsMenuAsPrimaryAction = true
    }

    private func updateLessons(for subject: String) {
        let currentLessons = ConnectDataController.shared.lessonsMapping[subject] ?? []
        let lessonActions = currentLessons.map { lesson in
            UIAction(title: lesson) { [weak self] _ in
                self?.lessonLabel.text = lesson
            }
        }
        lessonButton.menu = UIMenu(title: "", children: lessonActions)
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
