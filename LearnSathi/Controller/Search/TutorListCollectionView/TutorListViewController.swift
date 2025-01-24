//
//  TutorListViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 17/01/25.
//

import UIKit

class TutorListViewController: UIViewController {

    @IBOutlet var tutorSearchBar: UISearchBar!
    @IBOutlet var tutorListCollectionView: UICollectionView!
    @IBOutlet var tutorsFilterCollectionView: UICollectionView!
    
    var searchResults: [TutorSearch] = [
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    private func registerCells() {
        tutorListCollectionView.register(UINib(nibName: TutorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorCollectionViewCell.identifier)
        tutorsFilterCollectionView.register(UINib(nibName: TutorsFilterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorsFilterCollectionViewCell.identifier)
    }
}


extension TutorListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tutorListCollectionView {
            return searchResults.count
        }
        
        return filterTutor.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tutorListCollectionView {
            guard let cell = tutorListCollectionView.dequeueReusableCell(withReuseIdentifier: TutorCollectionViewCell.identifier, for: indexPath) as? TutorCollectionViewCell else {
                fatalError("Unable to dequeue TutorCollectionViewCell")
            }
            cell.setup(search: searchResults[indexPath.row])
            return cell
        }
        
        guard let cell = tutorsFilterCollectionView.dequeueReusableCell(withReuseIdentifier: TutorsFilterCollectionViewCell.identifier, for: indexPath) as? TutorsFilterCollectionViewCell else {
            fatalError("Unable to dequeue TutorsFilterCollectionViewCell")
        }
        cell.setup(filter: filterTutor[indexPath.row])
        return cell
    }
}
