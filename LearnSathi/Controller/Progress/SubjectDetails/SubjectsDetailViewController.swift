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
    
    var subjectName: LessonsProgress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
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
        switch navigationItem.title {
        case "Mathematics" :
            return chapterDetailsMaths.count
        case "English" :
            return chapterDetailsEnglish.count
        case "Science" :
            return chapterDetailsScience.count
        case "Social Studies" :
            return chapterDetailsSocialStudies.count
        case "Hindi" :
            return chapterDetailsHindi.count
        default :
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LessonDetailsCollectionViewCell", for: indexPath) as! LessonDetailsCollectionViewCell
        switch navigationItem.title {
        case "Mathematics" :
            cell.setup(subjectDetails: chapterDetailsMaths[indexPath.row])
        case "English" :
            cell.setup(subjectDetails: chapterDetailsEnglish[indexPath.row])
        case "Science" :
            cell.setup(subjectDetails: chapterDetailsScience[indexPath.row])
        case "Social Studies" :
            cell.setup(subjectDetails: chapterDetailsSocialStudies[indexPath.row])
        case "Hindi" :
            cell.setup(subjectDetails: chapterDetailsHindi[indexPath.row])
        default :
            break
        }
        return cell
    }
}
