//
//  TutorProfileViewController.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 06/02/25.
//

import UIKit

class TutorProfileViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {
    
    var tutors : [TutorSearch] = []
    
    
    @IBOutlet var achievementsCollectionView: UICollectionView!
    
    
    @IBOutlet var experienceLabel: UILabel!
    
    @IBOutlet var monthlyChargesLabel: UIStackView!
    
    @IBOutlet var subjectTechesLabel: UILabel!
    
    @IBOutlet var graudationCollageLabel: UILabel!
    
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var tutorNameLabel: UILabel!
    
    @IBOutlet var tutorProfileImageView: UIImageView!
    
    @IBOutlet var ratingLabel: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        // Do any additional setup after loading the view.
        register()
    }
    
    func setUpUI(){
        
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


