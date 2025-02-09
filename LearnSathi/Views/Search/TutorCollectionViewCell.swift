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
    
    func setup(search: TutorId) {
        tutorProfileImageView.image = UIImage(named: search.profileImage)
        tutorNameLbl.text = search.fullName
        tutorRatingLbl.text = String(search.ratings)
        tutorExperienceLbl.text = "Year Of Experience \(search.experience)"
        tutorChargesLbl.text = String(search.charges)
        tutorSubjectsLbl.text = search.subjects.joined(separator: ",")
        tutorDistance.text = "5km"
    }
}
