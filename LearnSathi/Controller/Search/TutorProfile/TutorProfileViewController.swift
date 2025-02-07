//
//  TutorProfileViewController.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 06/02/25.
//

import UIKit

class TutorProfileViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {
    
    var selectedTutor: TutorSearch?
    
    
    @IBOutlet var achievementsCollectionView: UICollectionView!

    @IBOutlet var experienceLabel: UILabel!
    
    @IBOutlet var monthlyChargesLabel: UILabel!
    
    @IBOutlet var subjectTechesLabel: UILabel!
    
    @IBOutlet var graudationCollageLabel: UILabel!
    
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var tutorNameLabel: UILabel!
    
    @IBOutlet var tutorDistanceFromYou: UILabel!
    
    
    @IBOutlet var tutorProfileImageView: UIImageView!
    
    @IBOutlet var ratingLabel: UILabel!
    
    
//    MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        register()
        
        if let tutor = selectedTutor {
            configure(with: tutor)
        } else {
            print("Error: selectedTutor is nil")
        }
    }
    
    func configure(with tutor : TutorSearch) {
        tutorNameLabel.text = tutor.tutorName
        ratingLabel.text = "\(tutor.tutorRating)"
        experienceLabel.text = "Year of Experience \(tutor.tutorExperience)"
        monthlyChargesLabel.text = "₹\(tutor.tutorCharges)/month"
        subjectTechesLabel.text = tutor.tutorSubjects.joined(separator: ", ")
        tutorDistanceFromYou.text = "\(tutor.tutorDistance)"
        locationLabel.text = tutor.tutorLocation
        tutorProfileImageView.image = UIImage(named: tutor.tutorProfile)
        
    }

    
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.tutorProfileImageView.image = image
                }
            }
        }
    }
    
    func register(){
        achievementsCollectionView.register(UINib(nibName: TutorAchievementsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorAchievementsCollectionViewCell.identifier)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: TutorAchievementsCollectionViewCell.identifier, for: indexPath) as! TutorAchievementsCollectionViewCell)
    
        return cell
    }
     
    
}


