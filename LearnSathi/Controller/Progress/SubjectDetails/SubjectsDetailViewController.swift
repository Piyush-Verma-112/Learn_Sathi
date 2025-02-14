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
    
    var completionStatus = ["All", "Completed", "In Progress", "UpComing"]
    
    var subjectName: String?

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
        let statusMenu = UIMenu(title: "Sorting Menu", options: [], children: sortingAction)
        sortingButton.menu = statusMenu
        sortingButton.showsMenuAsPrimaryAction = true
        sortingLabel.text = "All"
    }
    
    func updateNavigationTitle(with indexPath: IndexPath) {
        let lessonProgress = ProgressDataController.shared.getAllLessonsProgress()
        navigationItem.title = lessonProgress[indexPath.row].subject
        subjectName = lessonProgress[indexPath.row].subject
    }
    
    private func registerCells() {
        let nib = UINib(nibName: "LessonDetailsCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "LessonDetailsCollectionViewCell")
    }
}

extension SubjectsDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let subject = subjectName else { return 0 }
        let allLessons = ProgressDataController.shared.getChapters(for: subject)
        
        if sortingLabel.text == "All" { return allLessons.count }
        return allLessons.filter { getStatus(for: $0) == sortingLabel.text }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LessonDetailsCollectionViewCell", for: indexPath) as! LessonDetailsCollectionViewCell
        
        guard let subject = subjectName else { return cell }
        let allLessons = ProgressDataController.shared.getChapters(for: subject)
        let filteredLessons = (sortingLabel.text == "All") ? allLessons : allLessons.filter { getStatus(for: $0) == sortingLabel.text }
        
        cell.setup(subjectDetails: filteredLessons[indexPath.row])
        return cell
    }
    
    func getStatus(for subjectDetails: SubjectDetails) -> String {
        let progressPercentage = ProgressDataController.shared.getChapterProgress(for: subjectDetails.chapterName)
        
        return progressPercentage == 100 ? "Completed" :
               (progressPercentage == 0 ? "UpComing" : "In Progress")
    }
}
