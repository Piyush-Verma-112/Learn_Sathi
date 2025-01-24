//
//  DoubtListTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 23/01/25.
//

import UIKit

class DoubtsListTableViewController: UITableViewController, DoubtDelegate {

    // MARK: - Subject Struct
    struct Subject {
        let image: String
        let subjectName: String
        let lessonName: String
        let status: String
        let date: String
        let question: String
        let solution: String
        let solutionImage: String? // Optional image name for the solution
    }
    
    var subjects: [Subject] = [
        Subject(image: "Maths", subjectName: "Mathematics", lessonName: "Algebra Basics", status: "Pending", date: "2025-01-22", question: "What is the value of x in 2x + 3 = 7?", solution: "x = 2", solutionImage: nil),
        Subject(image: "science", subjectName: "Science", lessonName: "Newton's Laws", status: "Complete", date: "2025-01-21", question: "Explain Newton's third law of motion.", solution: "For every action, there is an equal and opposite reaction.", solutionImage: "newtons_law_image"),
        Subject(image: "subjects", subjectName: "History", lessonName: "Ancient Civilizations", status: "Pending", date: "2025-01-20", question: "Who was the first president of the United States?", solution: "George Washington", solutionImage: nil),
        Subject(image: "EnglishLogo", subjectName: "Geography", lessonName: "Countries of the World", status: "Complete", date: "2025-01-19", question: "What is the capital of France?", solution: "Paris", solutionImage: nil)
    ]
    // MARK: - Data
    
    override func viewDidLoad() {
            super.viewDidLoad()
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCustomCell")
        }

        // MARK: - Table View Data Source
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return subjects.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomTableViewCell", for: indexPath) as! MyCustomTableViewCell
            
            let subject = subjects[indexPath.row]
            cell.subjectNameLabel.text = subject.subjectName
            cell.lessonNameLabel.text = "\(subject.lessonName)"
            cell.statusLabel.text = subject.status
            cell.subjectImageView.image = UIImage(named: subject.image)
            cell.dateLabel.text = "Date: \(subject.date)"
            
            if subject.status.lowercased() == "pending" {
                cell.statusLabel.textColor = UIColor.systemOrange
            } else if subject.status.lowercased() == "complete" {
                cell.statusLabel.textColor = UIColor.systemGreen
            }
            
            return cell
        }
        
        // MARK: - Table View Delegate
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedSubject = subjects[indexPath.row]
            
            // Create and configure the popup view
            let popupView = DoubtPopupView()
            popupView.translatesAutoresizingMaskIntoConstraints = false
            popupView.configure(with: selectedSubject)
            
            // Add the popup view to the main view
            if let window = UIApplication.shared.keyWindow {
                window.addSubview(popupView)
                
                NSLayoutConstraint.activate([
                    popupView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
                    popupView.centerYAnchor.constraint(equalTo: window.centerYAnchor),
                    popupView.widthAnchor.constraint(equalTo: window.widthAnchor, multiplier: 0.8),
                    popupView.heightAnchor.constraint(equalToConstant: 400)
                ])
            }
            
            // Add a dimmed background effect
            let dimmedView = UIView()
            dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            dimmedView.translatesAutoresizingMaskIntoConstraints = false
            if let window = UIApplication.shared.keyWindow {
                window.insertSubview(dimmedView, belowSubview: popupView)
                NSLayoutConstraint.activate([
                    dimmedView.topAnchor.constraint(equalTo: window.topAnchor),
                    dimmedView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                    dimmedView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                    dimmedView.trailingAnchor.constraint(equalTo: window.trailingAnchor)
                ])
            }
        }

        // MARK: - DoubtDelegate
        func didAddDoubt(_ newDoubt: Subject) {
            print("Adding new doubt: \(newDoubt)")
            subjects.insert(newDoubt, at: 0)
            print("Subjects count after addition: \(subjects.count)")

            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("Table view reloaded.")
            }
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let doubtVC = segue.destination as? DoubtTableViewController {
            doubtVC.delegate = self
        }
    }
    }
