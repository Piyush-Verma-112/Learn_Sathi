//
//  SearchViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    var searchResults: [TutorSearch] = [
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
    ]
    
    @IBOutlet var searchResultcollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
    }
    private func registerCells() {
        searchResultcollectionView.register(UINib(nibName: TutorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorCollectionViewCell.identifier)
    }
    
    
    @IBAction func DoneBtnClicked(_ sender: UIButton) {
        
        let controller = storyboard?.instantiateViewController(identifier: "TutorListViewController") as! TutorListViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorCollectionViewCell.identifier, for: indexPath) as! TutorCollectionViewCell
        
        cell.setup(search: searchResults[indexPath.row])
        
        return cell
    }
}
