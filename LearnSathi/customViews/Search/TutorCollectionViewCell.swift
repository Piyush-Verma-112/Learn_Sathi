//
//  TutorCollectionViewCell.swift
//  LearnSathi
//
//  Created by Shahma Ansari on 16/01/25.
//

import UIKit

class TutorCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "TutorCollectionViewCell"

    @IBOutlet weak var tutorProfileImageView: UIImageView!
    @IBOutlet weak var tutorNameLbl: UILabel!
    @IBOutlet weak var tutorRatingLbl: UILabel!
    @IBOutlet weak var tutorExperienceLbl: UILabel!
    @IBOutlet weak var tutorChargesLbl: UILabel!
    @IBOutlet weak var tutorSubjectsLbl: UILabel!
    @IBOutlet weak var tutorDistance: UILabel!
    
    func setup(search: TutorSearch) {
        tutorProfileImageView.image = UIImage(named: search.tutorProfile)
        tutorNameLbl.text = search.tutorName
        tutorRatingLbl.text = String(search.tutorRating)
        tutorExperienceLbl.text = search.tutorExperience
        tutorChargesLbl.text = String(search.tutorCharges)
        tutorSubjectsLbl.text = search.tutorSubjects
        tutorDistance.text = search.tutorLocation
    }
    

}
