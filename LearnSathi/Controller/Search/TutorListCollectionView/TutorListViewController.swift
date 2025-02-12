//
//  TutorListViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 17/01/25.
//

import UIKit

class TutorListViewController: UIViewController {

    var tutors: [TutorId] = [] // Add this property
    
    @IBOutlet var tutorSearchBar: UISearchBar!
    @IBOutlet var tutorListCollectionView: UICollectionView!
    @IBOutlet var tutorsFilterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tutors"
        registerCells()
        
        // Reload collection view to display the passed data
        tutorListCollectionView.reloadData()
    }
    
    @objc private func handleDataUpdate() {
        DispatchQueue.main.async {
            self.tutorListCollectionView.reloadData()
        }
    }
        
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func registerCells() {
        tutorListCollectionView.register(UINib(nibName: TutorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorCollectionViewCell.identifier)
        tutorsFilterCollectionView.register(UINib(nibName: TutorsFilterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorsFilterCollectionViewCell.identifier)
    }
}

//MARK:- Extension functions
extension TutorListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tutorListCollectionView {
            return tutors.count
        }else if collectionView == tutorsFilterCollectionView {
            return filterTutor.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tutorListCollectionView {
            guard let cell = tutorListCollectionView.dequeueReusableCell(withReuseIdentifier: TutorCollectionViewCell.identifier, for: indexPath) as? TutorCollectionViewCell else {
                fatalError("Unable to dequeue TutorCollectionViewCell")
            }
            cell.setup(search: tutors[indexPath.row])
            return cell
        }
        
        guard let cell = tutorsFilterCollectionView.dequeueReusableCell(withReuseIdentifier: TutorsFilterCollectionViewCell.identifier, for: indexPath) as? TutorsFilterCollectionViewCell else {
            fatalError("Unable to dequeue TutorsFilterCollectionViewCell")
        }
        cell.setup(filter: filterTutor[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tutorListCollectionView {
            let selectedTutor = tutors[indexPath.row]
            navigateToTutorProfile(with: selectedTutor)
        }
    }
    
    private func navigateToTutorProfile(with tutor: TutorId) {
        if let tutorProfileVC = storyboard?.instantiateViewController(withIdentifier: "TutorProfileViewController") as? TutorProfileViewController {
            tutorProfileVC.selectedTutor = tutor 
            navigationController?.pushViewController(tutorProfileVC, animated: true)
        }
    }

    
}

