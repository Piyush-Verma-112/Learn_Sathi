//
//  SearchViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchResults: [TutorSearch] = [
        TutorSearch(tutorProfile: "user2", tutorName: "Md Akhlak", tutorRating: 5.0, tutorExperience: 5, tutorCharges: 8000, tutorSubjects: ["Biology, Science, Math"], tutorDistance: "10Km", tutorLocation: "Dav malighat"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: 5, tutorCharges: 4000, tutorSubjects: ["Physics, Science, Maths"], tutorDistance: "10Km", tutorLocation: "Dav malighat"),
        TutorSearch(tutorProfile: "user2", tutorName: "Abu Shahma", tutorRating: 5.0, tutorExperience: 5, tutorCharges: 3000, tutorSubjects: ["Math, Science, Hindi"], tutorDistance: "10Km", tutorLocation: "Dav malighat")
    ]
    
    var allSubjects = ["Mathematics", "Science", "History", "Geography", "English", "Computer Science", "Biology", "Physics", "Chemistry"]
    
    var filteredSubjects: [String] = []
    var selectedSubjects: [String] = []
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var subjectTableView: UITableView!
    
    @IBOutlet var searchResultcollectionView: UICollectionView!
    @IBOutlet var classCollectionView: UICollectionView!
    @IBOutlet var subjectBubbleCollectionView: UICollectionView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var standardTop: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjectBubbleCollectionView.isHidden = true
        
        configureCollectionViewLayout()
        classCollectionViewConfig()
        subjectTableViewDelegates()
        subjectTableViewConfig()
        registerCells()
        
        
    }
    
    private func configureCollectionViewLayout() {
        // Create and configure the flow layout
        let layout = UICollectionViewFlowLayout()
        
        // Set the spacing between items and sections
        layout.minimumInteritemSpacing = 25
        layout.minimumLineSpacing = 10
        
        // Set the section insets to start from the left edge
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Set the scroll direction to horizontal
        layout.scrollDirection = .vertical
        
        // Apply the layout to the collection view
        subjectBubbleCollectionView.collectionViewLayout = layout
    }

    
    private func registerCells() {
        searchResultcollectionView.register(UINib(nibName: TutorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorCollectionViewCell.identifier)
        classCollectionView.register(UINib(nibName: ClassListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ClassListCollectionViewCell.identifier)
        subjectBubbleCollectionView.register(UINib(nibName: SubjectBubbleCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SubjectBubbleCollectionViewCell.identifier)
        
        
    }
    
    @IBAction func DoneBtnClicked(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(identifier: "TutorListViewController") as! TutorListViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func classCollectionViewConfig() {
        classCollectionView.layer.cornerRadius = 10
        classCollectionView.layer.shadowColor = UIColor.black.cgColor
        classCollectionView.layer.shadowOpacity = 0.1
        classCollectionView.layer.shadowOffset = .zero
        classCollectionView.layer.masksToBounds = false
        classCollectionView.layer.cornerRadius = 10
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case classCollectionView:
            return standards.count
        case subjectBubbleCollectionView:
            return selectedSubjects.count
        default:
            return searchResults.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case classCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassListCollectionViewCell.identifier, for: indexPath) as! ClassListCollectionViewCell
            cell.setup(standard: standards[indexPath.row])
            return cell

        case subjectBubbleCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubjectBubbleCollectionViewCell.identifier, for: indexPath) as! SubjectBubbleCollectionViewCell
            cell.setup(subject: selectedSubjects[indexPath.row])
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorCollectionViewCell.identifier, for: indexPath) as! TutorCollectionViewCell
            cell.setup(search: searchResults[indexPath.row])
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == searchResultcollectionView {
            let selectedTutor = searchResults[indexPath.row]
            navigateToTutorProfile(with: selectedTutor)
        }
    }
        
    
    private func navigateToTutorProfile(with tutor: TutorSearch) {
        if let tutorProfileVC = storyboard?.instantiateViewController(withIdentifier: "TutorProfileViewController") as? TutorProfileViewController {
            tutorProfileVC.selectedTutor = tutor
            navigationController?.pushViewController(tutorProfileVC, animated: true)
        }
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
        subjectTableView.layer.cornerRadius = 10
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
        
        let selectedSubject = filteredSubjects[indexPath.row]
        if !selectedSubjects.contains(selectedSubject) {
            selectedSubjects.append(selectedSubject)
        }
        subjectTextField.text = selectedSubject
        tableView.isHidden = true
        subjectBubbleCollectionView.reloadData()
        
        subjectBubbleCollectionView.isHidden = false
        let collectionViewHeight = subjectBubbleCollectionView.frame.height
        
        UIView.animate(withDuration: 0.3) {
            self.standardTop.constant = collectionViewHeight + 10
            self.view.layoutIfNeeded()
        }
    }
}

