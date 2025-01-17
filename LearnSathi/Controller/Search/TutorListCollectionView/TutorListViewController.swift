//
//  TutorListViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 17/01/25.
//

import UIKit

class TutorListViewController: UIViewController {

    @IBOutlet var tutorListCollectionView: UICollectionView!
    
    var searchResults: [TutorSearch] = [
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        registerCells()
    }
    
    private func registerCells() {
        tutorListCollectionView.register(UINib(nibName: TutorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorCollectionViewCell.identifier)
    }
}


extension TutorListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tutorListCollectionView.dequeueReusableCell(withReuseIdentifier: TutorCollectionViewCell.identifier, for: indexPath) as? TutorCollectionViewCell
        
        cell?.setup(search: searchResults[indexPath.row])
        
        return cell ?? nil ?? UICollectionViewCell()
    }
}
