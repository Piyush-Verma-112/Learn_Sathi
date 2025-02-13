//
//  ConnectViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//
 
import UIKit

class ConnectViewController: UIViewController {
    var selectedIndexPath: IndexPath?
    
    @IBOutlet weak var tutorListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerConnectCells()
    }
    
    private func registerConnectCells() {
        tutorListCollectionView?.register(UINib(nibName: TutorListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorListCollectionViewCell.identifier)
        tutorListCollectionView?.dataSource = self
        tutorListCollectionView?.delegate = self
    }
}

extension ConnectViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ConnectDataController.shared.getTutors().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorListCollectionViewCell.identifier, for: indexPath) as! TutorListCollectionViewCell
        let tutors = ConnectDataController.shared.getTutors()
        cell.setup(tutor: tutors[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let tutors = ConnectDataController.shared.getTutors()
        let selectedTutor = tutors[indexPath.row]
        let storyboard = UIStoryboard(name: "CustomOptions", bundle: nil)
        
        if let secondaryVc = storyboard.instantiateViewController(withIdentifier: "CustomOptions") as? CustomOptionsTableViewController {
            secondaryVc.tutorProfileImage = UIImage(named: selectedTutor.tutorProfileImage)
            secondaryVc.tutorName = selectedTutor.tutorName
            secondaryVc.subjectName = selectedTutor.subject.joined(separator: ", ")
            navigationController?.pushViewController(secondaryVc, animated: true)
        }
    }
}
