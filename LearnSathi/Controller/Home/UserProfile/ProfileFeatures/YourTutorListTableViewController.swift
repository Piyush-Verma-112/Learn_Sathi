//
//  YouTutorListTableViewController.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 24/01/25.
//

import UIKit

class YourTutorListTableViewController: UITableViewController {

    @IBOutlet var tutorListTableView: UITableView!
    
    let lessons = ["Current Tutor", "Past Tutor"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Tutors"
        registerCell()
    }
    
    private func registerCell() {
        tutorListTableView.register(UINib(nibName: YouTutorListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: YouTutorListTableViewCell.identifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Current Tutors" : "Past Tutors"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConnectDataController.shared.getTutors().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YouTutorListTableViewCell.identifier, for: indexPath) as? YouTutorListTableViewCell else {
            fatalError("Error while dequeuing cell")
        }
        let tutors = ConnectDataController.shared.getTutors()
        cell.setup(tutors: tutors[indexPath.row])
        return cell
    }
}
