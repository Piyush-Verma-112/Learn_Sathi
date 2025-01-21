//
//  SearchViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    var searchResults: [TutorSearch] = [
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km")
    ]
    var allSubjects = ["Mathematics", "Science", "History", "Geography", "English", "Computer Science", "Biology", "Physics", "Chemistry"]
    var filteredSubjects: [String] = []
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var subjectTableView: UITableView!
    @IBOutlet var searchResultcollectionView: UICollectionView!
    @IBOutlet weak var subjectBubbleCollectionView: UICollectionView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjectTableViewDelegates()
        subjectTableViewConfig()
        registerCells()
        
        
    }
    
    private func registerCells() {
        searchResultcollectionView.register(UINib(nibName: TutorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorCollectionViewCell.identifier)
    }
    
    

    
    @IBAction func DoneBtnClicked(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(identifier: "TutorListViewController") as! TutorListViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorCollectionViewCell.identifier, for: indexPath) as! TutorCollectionViewCell
        
        cell.setup(search: searchResults[indexPath.row])
        
        return cell
    }
}



extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    private func subjectTableViewDelegates() {
        subjectTextField.delegate = self
        subjectTableView.delegate = self
        subjectTableView.dataSource = self
    }
    
    private func subjectTableViewConfig() {
        view.bringSubviewToFront(subjectTableView)
        subjectTableView.isHidden = true
        subjectTableView.register(UITableViewCell.self, forCellReuseIdentifier: "suggestionCell")
        
        subjectTableView.layer.cornerRadius = 10
        subjectTableView.layer.shadowColor = UIColor.black.cgColor
        subjectTableView.layer.shadowOpacity = 0.2
        subjectTableView.layer.shadowOffset = CGSize(width: 0, height: 2)
        subjectTableView.layer.shadowRadius = 5
        subjectTableView.layer.masksToBounds = false
        subjectTableView.cornarRadius = 20
    }
    
    
    
    func updateTableViewHeight() {
        let cellHeight: CGFloat = 44.0 // Approximate height of one cell (adjust as needed)
        let maxVisibleCells = 5 // Maximum number of cells to show without scrolling
        let totalHeight = CGFloat(min(filteredSubjects.count, maxVisibleCells)) * cellHeight

        tableViewHeight.constant = totalHeight
        subjectTableView.isScrollEnabled = filteredSubjects.count > maxVisibleCells
    }

    
    // MARK: - UITextFieldDelegate
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Update the text in the text field
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        
        filterSubjects(for: updatedText)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Add the new subject if it's not already in the list
        if let text = textField.text, !text.isEmpty, !allSubjects.contains(text) {
            allSubjects.append(text)
            textField.text = ""
            subjectTableView.reloadData()
        }
        return true
    }
    
    
    // MARK: - Filter and Update
        
    private func filterSubjects(for query: String) {
        if query.isEmpty {
            filteredSubjects = []
            subjectTableView.isHidden = true
        } else {
            filteredSubjects = allSubjects.filter { $0.lowercased().contains(query.lowercased()) }
            subjectTableView.isHidden = filteredSubjects.isEmpty
        }
        subjectTableView.reloadData()
        updateTableViewHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredSubjects.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionCell", for: indexPath)
            cell.textLabel?.text = filteredSubjects[indexPath.row]
            return cell
        }
        
        // MARK: - UITableViewDelegate
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Set the selected subject in the text field
            subjectTextField.text = filteredSubjects[indexPath.row]
            tableView.isHidden = true
        }
}

