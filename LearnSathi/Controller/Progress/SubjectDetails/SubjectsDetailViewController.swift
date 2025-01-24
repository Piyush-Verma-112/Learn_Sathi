//
//  SubjectsDetailViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 20/01/25.
//

import UIKit

class SubjectsDetailViewController: UIViewController {
    
    static var identifier = String(describing: SubjectsDetailViewController.self)
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var sortingButton: UIButton!
    @IBOutlet var sortingLabel: UILabel!
    
    var completionStatus = ["In Progress", "Completed", "UpComing"]
    
    var subjectName: LessonsProgress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        sortData()
        self.tabBarController?.tabBar.scrollEdgeAppearance = .init()
        self.tabBarController?.tabBar.barTintColor = .white
    }
    
    private func sortData() {
        var sortingAction: [UIAction] = []
        for status in completionStatus {
            let action = UIAction(title: status, handler: { [weak self] _ in
                self?.sortingLabel.text = status
                self?.collectionView.reloadData()
            })
            sortingAction.append(action)
        }
        let statusMenu = UIMenu(title: "Sorting", options: [], children: sortingAction)
        sortingButton.menu = statusMenu
        sortingButton.showsMenuAsPrimaryAction = true
    }
    
    func updateNavigationTitle(with indexPath: IndexPath) {
        navigationItem.title = progressData[indexPath.row].subject
    }
    
    private func registerCells() {
        let nib = UINib(nibName: "LessonDetailsCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "LessonDetailsCollectionViewCell")
    }

}
extension SubjectsDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let selectedStatus = sortingLabel.text, completionStatus.contains(selectedStatus) else {
            switch navigationItem.title {
            case "Mathematics":
                return chapterDetailsMaths.count
            case "English":
                return chapterDetailsEnglish.count
            case "Science":
                return chapterDetailsScience.count
            case "Social Studies":
                return chapterDetailsSocialStudies.count
            case "Hindi":
                return chapterDetailsHindi.count
            default:
                return 0
            }
        }
        
        switch navigationItem.title {
            case "Mathematics":
                return chapterDetailsMaths.filter { getStatus(for: $0) == selectedStatus }.count
            case "English":
                return chapterDetailsEnglish.filter { getStatus(for: $0) == selectedStatus }.count
            case "Science":
                return chapterDetailsScience.filter { getStatus(for: $0) == selectedStatus }.count
            case "Social Studies":
                return chapterDetailsSocialStudies.filter { getStatus(for: $0) == selectedStatus }.count
            case "Hindi":
                return chapterDetailsHindi.filter { getStatus(for: $0) == selectedStatus }.count
            default:
                return 0
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LessonDetailsCollectionViewCell", for: indexPath) as! LessonDetailsCollectionViewCell
        
        guard let selectedStatus = sortingLabel.text, completionStatus.contains(selectedStatus) else {
            switch navigationItem.title {
            case "Mathematics":
                cell.setup(subjectDetails: chapterDetailsMaths[indexPath.row])
            case "English":
                cell.setup(subjectDetails: chapterDetailsEnglish[indexPath.row])
            case "Science":
                cell.setup(subjectDetails: chapterDetailsScience[indexPath.row])
            case "Social Studies":
                cell.setup(subjectDetails: chapterDetailsSocialStudies[indexPath.row])
            case "Hindi":
                cell.setup(subjectDetails: chapterDetailsHindi[indexPath.row])
            default:
                break
            }
            return cell
        }
        
        // Filter data after sorting
        var filteredData: [SubjectDetails] = []
            switch navigationItem.title {
            case "Mathematics":
                filteredData = chapterDetailsMaths.filter { getStatus(for: $0) == selectedStatus }
            case "English":
                filteredData = chapterDetailsEnglish.filter { getStatus(for: $0) == selectedStatus }
            case "Science":
                filteredData = chapterDetailsScience.filter { getStatus(for: $0) == selectedStatus }
            case "Social Studies":
                filteredData = chapterDetailsSocialStudies.filter { getStatus(for: $0) == selectedStatus }
            case "Hindi":
                filteredData = chapterDetailsHindi.filter { getStatus(for: $0) == selectedStatus }
            default:
                break
            }
            cell.setup(subjectDetails: filteredData[indexPath.row])
            return cell
    }
    private func getStatus(for subjectDetails: SubjectDetails) -> String {
        let progress = Float(subjectDetails.progressPercentage) / 100
        if progress == 1 {
            return "Completed"
        } else if progress == 0 {
            return "UpComing"
        } else {
            return "In Progress"
        }
    }
}
