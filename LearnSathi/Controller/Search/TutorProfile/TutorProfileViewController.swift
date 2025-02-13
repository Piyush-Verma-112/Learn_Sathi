//
//  TutorProfileViewController.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 06/02/25.
//

import UIKit

class TutorProfileViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {
    
    var selectedTutor: TutorId?
    
    
    @IBOutlet weak var achievementsCollectionView: UICollectionView!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var monthlyChargesLabel: UILabel!
    @IBOutlet weak var subjectTechesLabel: UILabel!
    @IBOutlet weak var graduationCollageLabel: UILabel!
    @IBOutlet weak var tutorBio: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tutorNameLabel: UILabel!
    @IBOutlet weak var tutorDistanceFromYou: UILabel!
    @IBOutlet weak var tutorProfileImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
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
    
    func configure(with tutor : TutorId) {
        tutorNameLabel.text = tutor.fullName
        ratingLabel.text = "\(tutor.ratings)"
        experienceLabel.text = "Year of Experience \(tutor.experience)"
        monthlyChargesLabel.text = "₹\(tutor.charges)/month"
        subjectTechesLabel.text = tutor.subjects.joined(separator: ", ")
        tutorBio.text = tutor.bio
        graduationCollageLabel.text = tutor.gradInstitute
        tutorDistanceFromYou.text = "5km"
        locationLabel.text = tutor.address
        tutorProfileImageView.image = UIImage(named: tutor.profileImage)
        
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


