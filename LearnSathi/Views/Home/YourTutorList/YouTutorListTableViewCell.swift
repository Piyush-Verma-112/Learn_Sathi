//
//  YouTutorListTableViewCell.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 24/01/25.
//

import UIKit

class YouTutorListTableViewCell: UITableViewCell {
    
    static let identifier = "YouTutorListTableViewCell"
    
    @IBOutlet weak var tutorImageView: UIImageView!
    @IBOutlet weak var tutorNameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var subjectImageView: UIImageView!

    
    func setup(tutors: Tutor) {
        tutorImageView.image = UIImage(named: tutors.tutorProfileImage)
        tutorNameLabel.text = tutors.tutorName
        subjectLabel.text = tutors.subject.joined(separator: ", ")
        subjectImageView.image = UIImage(named: tutors.subjectIcon)
        
    }
    
}
