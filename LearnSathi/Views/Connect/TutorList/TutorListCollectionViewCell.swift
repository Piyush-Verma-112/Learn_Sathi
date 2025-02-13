//
//  TutorListCollectionViewCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 15/01/25.
//

import UIKit

class TutorListCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: TutorListCollectionViewCell.self)
    
    
    @IBOutlet var tutorProfilePicImageView: UIImageView!
    @IBOutlet var tutorNameLabel: UILabel!
    @IBOutlet var subjectNameLabel: UILabel!
    @IBOutlet var subjectIconImageView: UIImageView!
    
    func setup(tutor: Tutor) {
        tutorNameLabel.text = tutor.tutorName
        subjectNameLabel.text = tutor.subject.joined(separator: ", ")
        tutorProfilePicImageView.image = UIImage(named: tutor.tutorProfileImage)
        subjectIconImageView.image = UIImage(named: tutor.subjectIcon)
                
        
    }
   
}

