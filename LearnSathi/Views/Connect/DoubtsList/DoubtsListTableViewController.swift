//
//  DoubtListTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 23/01/25.
//

import UIKit

class DoubtsListTableViewController: UITableViewController, DoubtDelegate {
    
    var filteredSubjects: [Doubts] = []
    var filterStatus: String = "All"
    
    private let placeholderView: UIView = {
        let view = UIView()
        let label = UILabel()
        label.tag = 1001
        label.text = "No doubt asked, add a doubt."
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCustomCell")
        setupFilterSegmentedControl()
        applyFilter()
    }
    
    private func setupFilterSegmentedControl() {
        let segmentedControl = UISegmentedControl(items: ["All", "Resolved", "Pending"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(filterChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerView.backgroundColor = tableView.backgroundColor
        headerView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.9)
        ])
        tableView.tableHeaderView = headerView
    }
    
    @objc private func filterChanged(_ sender: UISegmentedControl) {
        filterStatus = sender.selectedSegmentIndex == 1 ? "Resolved" : sender.selectedSegmentIndex == 2 ? "Pending" : "All"
        applyFilter()
    }
    
    private func applyFilter() {
        let allDoubts = ConnectDataController.shared.getDoubts()
        filteredSubjects = filterStatus == "All" ? allDoubts : allDoubts.filter { $0.status == filterStatus }
        updatePlaceholderMessage()
        tableView.backgroundView = filteredSubjects.isEmpty ? placeholderView : nil
        tableView.reloadData()
    }
    
    private func updatePlaceholderMessage() {
        let message = filterStatus == "Resolved" ? "No doubts have been resolved yet." : filterStatus == "Pending" ? "No doubts are pending yet." : "No doubt asked, add a doubt."
        (placeholderView.viewWithTag(1001) as? UILabel)?.text = message
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { filteredSubjects.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoubtListCardTableViewCell", for: indexPath) as! DoubtListCardTableViewCell
        let subject = filteredSubjects[indexPath.row]
        cell.subjectNameLabel.text = subject.subjectName
        cell.lessonNameLabel.text = subject.lessonName
        cell.statusLabel.text = subject.status
        cell.dateLabel.text = subject.date
        cell.questionLabel.text = subject.question
        cell.statusLabel.textColor = subject.status.lowercased() == "pending" ? .systemOrange : .systemGreen
        return cell
    }
    
    func didAddDoubt(_ newDoubt: Doubts) {
        ConnectDataController.shared.addDoubt(newDoubt)
        applyFilter()
        print("New doubt added: \(newDoubt.question)")
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedDoubt = filteredSubjects[indexPath.row]
        if selectedDoubt.status.lowercased() == "pending" {
            let alert = UIAlertController(title: "Pending", message: "This doubt is not yet resolved.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "ShowSolutionSegue", sender: selectedDoubt)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddDoubtSegue", let destination = segue.destination as? AskDoubtTableViewController {
            destination.delegate = self
        } else if segue.identifier == "ShowSolutionSegue", let navController = segue.destination as? UINavigationController, let destination = navController.topViewController as? SolutionTableViewController, let selectedDoubt = sender as? Doubts {
            destination.doubt = selectedDoubt
        }
    }
}
