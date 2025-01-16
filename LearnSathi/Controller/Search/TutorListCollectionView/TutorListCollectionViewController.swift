//
//  TutorListCollectionViewController.swift
//  LearnSathi
//
//  Created by Shahma Ansari on 16/01/25.
//

import UIKit

class TutorListCollectionViewController: UICollectionViewController{

    
    var searchResults: [TutorSearch] = [
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
    ]
    
    @IBOutlet var searchResultcollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: TutorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorCollectionViewCell.identifier)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchResultcollectionView.dequeueReusableCell(withReuseIdentifier: "TutorCollectionViewCell", for: indexPath) as? TutorCollectionViewCell else {
            fatalError("Failed to dequeue TutorCollectionViewCell")
        }
        
        cell.setup(search: searchResults[indexPath.row])
        
        return cell
    }

}
