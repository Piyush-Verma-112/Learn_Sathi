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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        loadInitialData()
        
    }
    
    @IBAction func profileButtonAction(_ sender: UIBarButtonItem) {
        
    }
    
    
    private func registerCells() {
        collectionViewOutlet.register(UINib(nibName: LessonsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: LessonsCollectionViewCell.identifier)
        collectionViewOutlet.register(UINib(nibName: TestsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TestsCollectionViewCell.identifier)
        //collectionViewOutlet.register(UINib(nibName: LessonDetailsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier:LessonDetailsCollectionViewCell.identifier)
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
    }
    
    private func loadInitialData() {
        collectionViewOutlet.reloadData()
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        collectionViewOutlet.reloadData()
    }
    
}

extension ProgressViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControlOutlet.selectedSegmentIndex == 0 {
            return progressData.count
        } else {
            return testsData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentedControlOutlet.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonsCollectionViewCell.identifier, for: indexPath) as! LessonsCollectionViewCell
            cell.setup(progress: progressData[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestsCollectionViewCell.identifier, for: indexPath) as! TestsCollectionViewCell
            cell.setup(testProgress: testsData[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if segmentedControlOutlet.selectedSegmentIndex == 0 {
            let storyboard = UIStoryboard(name: "SubjectsDetailViewController", bundle: nil)
            if let primaryVC = storyboard.instantiateViewController(withIdentifier: "SubjectsDetailViewController") as? SubjectsDetailViewController {
                primaryVC.updateNavigationTitle(with: indexPath)
                navigationController?.pushViewController(primaryVC, animated: true)
            }
            //            let selectedProgress = progressData[indexPath.row]
            //            performSegue(withIdentifier: "ProgressToDetail", sender: selectedProgress)
        }
        else {
            let storyboard = UIStoryboard(name: "TestDetailsViewController", bundle: nil)
            if let secondaryVC = storyboard.instantiateViewController(withIdentifier: "TestDetailsViewController") as? TestDetailsViewController {
                secondaryVC.updateData(with: indexPath)
                navigationController?.pushViewController(secondaryVC, animated: true)
            }
        }
    }
}
    

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ProgressToDetail",
//           let destinationVC = segue.destination as? SubjectsDetailViewController,
//           let selectedProgress = sender as? LessonsProgress {
//            destinationVC.subjectName = selectedProgress
//        }
//    }

    

//func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    if segmentedControlOutlet.selectedSegmentIndex == 0 {
//        //selectedIndexPath = indexPath
//        let selectedProgress = progressData[indexPath.row]
//        if selectedProgress.subject == "Mathematics" {
//            performSegue(withIdentifier: "ProgressToDetail", sender: self)
//        } else if selectedProgress.subject == "English" {
//            performSegue(withIdentifier: "ProgressToDetail", sender: self)
//        }
//        
////            performSegue(withIdentifier: "ProgressToDetail", sender: self)
//    }
//}
