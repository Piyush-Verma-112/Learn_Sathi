//
//  ProgressViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit

class ProgressViewController: UIViewController {

    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    
    private var lessonProgress: [LessonProgress] = []
    private var testProgress: [TestProgress] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        loadInitialData()
    }
    
    @IBAction func profileButtonAction(_ sender: UIBarButtonItem) {
        // Profile button action implementation (if needed)
    }
    
    private func registerCells() {
        collectionViewOutlet.register(UINib(nibName: LessonsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: LessonsCollectionViewCell.identifier)
        collectionViewOutlet.register(UINib(nibName: TestsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TestsCollectionViewCell.identifier)
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
    }
    
    private func loadInitialData() {
        lessonProgress = ProgressDataController.shared.getAllLessonsProgress()
        testProgress = ProgressDataController.shared.getAllTestProgress()
        collectionViewOutlet.reloadData()
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        collectionViewOutlet.reloadData()
    }
}

extension ProgressViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentedControlOutlet.selectedSegmentIndex == 0 ? lessonProgress.count : testProgress.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentedControlOutlet.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonsCollectionViewCell.identifier, for: indexPath) as! LessonsCollectionViewCell
            cell.setup(progress: lessonProgress[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestsCollectionViewCell.identifier, for: indexPath) as! TestsCollectionViewCell
            cell.setup(testProgress: testProgress[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboardName = segmentedControlOutlet.selectedSegmentIndex == 0 ? "SubjectsDetailViewController" : "TestDetailsViewController"
        let viewControllerID = segmentedControlOutlet.selectedSegmentIndex == 0 ? "SubjectsDetailViewController" : "TestDetailsViewController"
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        if segmentedControlOutlet.selectedSegmentIndex == 0 {
            if let primaryVC = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? SubjectsDetailViewController {
                primaryVC.updateNavigationTitle(with: indexPath)
                navigationController?.pushViewController(primaryVC, animated: true)
            }
        } else {
            if let secondaryVC = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? TestDetailsViewController {
                secondaryVC.updateData(with: indexPath)
                navigationController?.pushViewController(secondaryVC, animated: true)
            }
        }
    }
}
