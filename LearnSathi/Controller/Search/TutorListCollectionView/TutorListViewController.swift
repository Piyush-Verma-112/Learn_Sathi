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
        TutorSearch(tutorProfile: "user2", tutorName: "Md Akhlak", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 6000, tutorSubjects: "English, Science, Hindi,Mathemtics ", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Ashish Singh", tutorRating: 5.0, tutorExperience: "Experience 5yrs", tutorCharges: 5000, tutorSubjects: "Physics, Science, Biology", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "user2", tutorName: "Shahnawaz", tutorRating: 4.5, tutorExperience: "Experience 5yrs", tutorCharges: 4000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Abu Shahma", tutorRating: 4.0, tutorExperience: "Experience 5yrs", tutorCharges: 3000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "user2", tutorName: "Abu Shahma", tutorRating: 3.9, tutorExperience: "Experience 5yrs", tutorCharges: 2000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
        TutorSearch(tutorProfile: "profileImage", tutorName: "Abu Shahma", tutorRating: 3.5, tutorExperience: "Experience 5yrs", tutorCharges: 1000, tutorSubjects: "English, Science, Maths", tutorLocation: "10Km"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tutors"
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
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == tutorListCollectionView {
                let selectedTutor = searchResults[indexPath.row]
                navigateToTutorProfile(with: selectedTutor)
    
            }
        }
    
    private func navigateToTutorProfile(with tutor: TutorSearch) {
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tutorProfileVC = storyboard?.instantiateViewController(withIdentifier: "TutorProfileViewController") as? TutorProfileViewController {
            navigationController?.pushViewController(tutorProfileVC, animated: true)
        }
    }
    
}

