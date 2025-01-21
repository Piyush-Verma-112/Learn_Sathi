//
//  ConnectViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit

class ConnectViewController: UIViewController {

    var selectedIndexPath: IndexPath?
    
    
        
        
        @IBOutlet weak var collectionView: UICollectionView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            registerConnectCells()
            self.tabBarController?.tabBar.scrollEdgeAppearance = .init()
            self.tabBarController?.tabBar.barTintColor = .white
            
//            self.tabBarController?.tabBar.isTranslucent = false
            
        }
        
        private func registerConnectCells() {
            collectionView?.register(UINib(nibName: ConnectCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ConnectCollectionViewCell.identifier)
            collectionView?.dataSource = self
            collectionView?.delegate = self
        }
    }


        extension ConnectViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return tutors.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConnectCollectionViewCell.identifier, for: indexPath) as! ConnectCollectionViewCell
            cell.setup(tutor: tutors[indexPath.row])
            return cell
        }
            
            
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            selectedIndexPath = indexPath
            let selectedTutor = tutors[indexPath.row]
            let storyboard = UIStoryboard(name: "CustomOptions", bundle: nil)
            if let secondaryVc = storyboard.instantiateViewController(withIdentifier: "CustomOptions") as? CustomOptionsTableViewController {
                secondaryVc.tutorProfileImage = UIImage(named: selectedTutor.tutorProfileImage)
                secondaryVc.tutorName = selectedTutor.tutorName
                secondaryVc.subjectName = selectedTutor.subject
                            navigationController?.pushViewController(secondaryVc, animated: true)
            }
//
         
            
//            let selectedTutor = tutorsData[indexPath.row]
//            
//            let vc = storyboard?.instantiateViewController(withIdentifier: CustomOptionsTableViewController.identifier) as? CustomOptionsTableViewController
//            
//            
//            vc?.tutorProfileImage = UIImage(named: selectedTutor.imageName)
//            vc?.tutorName = selectedTutor.name
//            vc?.subjectName = selectedTutor.subjects
//            print("tapped")
        }
}
