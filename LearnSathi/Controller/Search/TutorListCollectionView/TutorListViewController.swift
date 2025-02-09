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
    
    var searchResults: [TutorId] = [
        TutorId(id: UUID(), fullName: "Md Akhlak", gender: Gender.Male, profileImage: "profileImage", bio: "The best science and maths teacher in your nearby locality.", experience: "3yrs", charges: 5000, subjects: ["Science", "Maths"], Standard: [5, 6, 1, 2], gradInstitute: "Galgotias University", address: "Greater Noida, UP", ratings: 4.7),
        
        TutorId(id: UUID(), fullName: "Rohit Sharma", gender: Gender.Male, profileImage: "profileImage1", bio: "Passionate about making learning fun and effective.", experience: "5yrs", charges: 6000, subjects: ["English", "Social Science"], Standard: [3, 4, 5, 6], gradInstitute: "Delhi University", address: "New Delhi, DL", ratings: 4.8),

        TutorId(id: UUID(), fullName: "Anjali Verma", gender: Gender.Female, profileImage: "profileImage2", bio: "Dedicated tutor with a knack for simplifying complex topics.", experience: "4yrs", charges: 5500, subjects: ["Maths", "Physics"], Standard: [7, 8, 9, 10], gradInstitute: "IIT Kanpur", address: "Lucknow, UP", ratings: 4.6),

        TutorId(id: UUID(), fullName: "Suresh Patil", gender: Gender.Male, profileImage: "profileImage3", bio: "Expert in conceptual learning with hands-on experience.", experience: "6yrs", charges: 7000, subjects: ["Chemistry", "Biology"], Standard: [9, 10, 11, 12], gradInstitute: "Mumbai University", address: "Mumbai, MH", ratings: 4.9)
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

//MARK:- Extension functions
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
    
    private func navigateToTutorProfile(with tutor: TutorId) {
        if let tutorProfileVC = storyboard?.instantiateViewController(withIdentifier: "TutorProfileViewController") as? TutorProfileViewController {
            tutorProfileVC.selectedTutor = tutor 
            navigationController?.pushViewController(tutorProfileVC, animated: true)
        }
    }

    
}

