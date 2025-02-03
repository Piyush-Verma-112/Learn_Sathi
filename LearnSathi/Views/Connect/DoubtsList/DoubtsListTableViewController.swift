//
//  DoubtListTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 23/01/25.
//

import UIKit

class DoubtsListTableViewController: UITableViewController, DoubtDelegate {
    
    // MARK: - Subject Struct
  
    
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
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        return view
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCustomCell")
        setupFilterSegmentedControl()
        applyFilter()
    }

    
    // MARK: - Segmented Control
    private func setupFilterSegmentedControl() {
        let segmentedControl = UISegmentedControl(items: ["All", "Resolved", "Pending"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(filterChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let font = UIFont.systemFont(ofSize: 14)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
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
        switch sender.selectedSegmentIndex {
        case 1:
            filterStatus = "Resolved"
        case 2:
            filterStatus = "Pending"
        default:
            filterStatus = "All"
        }
        applyFilter()
    }
    
    private func applyFilter() {
        if filterStatus == "All" {
            filteredSubjects = doubts
        } else {
            filteredSubjects = doubts.filter { $0.status == filterStatus }
        }
        
        updatePlaceholderMessage()

        if filteredSubjects.isEmpty {
            tableView.backgroundView = placeholderView
        } else {
            tableView.backgroundView = nil
        }
        
        tableView.reloadData()
    }
    private func updatePlaceholderMessage() {
          let message: String
          switch filterStatus {
          case "Resolved":
              message = "No doubts have been resolved yet."
          case "Pending":
              message = "No doubts are pending yet."
          default:
              message = "No doubt asked, add a doubt."
          }
          
          if let label = placeholderView.viewWithTag(1001) as? UILabel {
              label.text = message
          }
      }

    
    // MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSubjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoubtListCardTableViewCell", for: indexPath) as! DoubtListCardTableViewCell
        
        let subject = filteredSubjects[indexPath.row]
        cell.subjectNameLabel.text = subject.subjectName
        cell.lessonNameLabel.text = "\(subject.lessonName)"
        cell.statusLabel.text = subject.status
        cell.dateLabel.text = "Date: \(subject.date)"
        cell.questionLabel.text = subject.question
        
        if subject.status.lowercased() == "pending" {
            cell.statusLabel.textColor = UIColor.systemOrange
        } else if subject.status.lowercased() == "resolved" {
            cell.statusLabel.textColor = UIColor.systemGreen
        }
        
        return cell
    }
    
    // MARK: - DoubtDelegate
    func didAddDoubt(_ newDoubt: Doubts) {
        doubts.insert(newDoubt, at: 0)
        applyFilter()
        print("New doubt added: \(newDoubt.question)")
            tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDoubt = filteredSubjects[indexPath.row]
        
        if selectedDoubt.status.lowercased() == "pending" {
            let alert = UIAlertController(
                title: "Pending",
                message: "This doubt is not yet resolved.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "ShowSolutionSegue", sender: selectedDoubt)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddDoubtSegue" {
            if let destination = segue.destination as? AskDoubtTableViewController {
                destination.delegate = self
            }
        } else if segue.identifier == "ShowSolutionSegue" {
            if let navController = segue.destination as? UINavigationController,
               let destination = navController.topViewController as? SolutionTableViewController,
               let selectedDoubt = sender as? Doubts {
                
                destination.doubt = Doubts(
                    image: "",
                    subjectName: selectedDoubt.subjectName,
                    lessonName: selectedDoubt.lessonName,
                    status: selectedDoubt.status,
                    date: selectedDoubt.date,
                    question: selectedDoubt.question,
                    solution: selectedDoubt.solution,
                    solutionImages: selectedDoubt.solutionImages
                )
            }
        }
    }

}
