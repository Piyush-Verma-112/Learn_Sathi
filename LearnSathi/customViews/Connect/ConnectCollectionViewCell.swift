//
//  ConnectCollectionViewCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 15/01/25.
//

import UIKit

class ConnectCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: ConnectCollectionViewCell.self)
    
    
    @IBOutlet var tutorProfilePicImageView: UIImageView!
    @IBOutlet var tutorNameLabel: UILabel!
    
    @IBOutlet var subjectNameLabel: UILabel!
    
    @IBOutlet var subjectIconImageView: UIImageView!
    
    func setup(tutor: Tutor) {
        tutorNameLabel.text = tutor.tutorName
        subjectNameLabel.text = tutor.subject
        tutorProfilePicImageView.image = UIImage(named: tutor.tutorProfileImage)
        subjectIconImageView.image = UIImage(named: tutor.subjectIcon)
        
    }
   
}
