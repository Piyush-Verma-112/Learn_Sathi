//
//  subjectBubbleCollectionViewCell.swift
//  LearnSathi
//
//  Created by Shahma Ansari on 21/01/25.
//

import UIKit

class SubjectBubbleCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "SubjectBubbleCollectionViewCell"
    
    @IBOutlet weak var subjectNameLbl: UILabel!
    
    func setup(subject: String) {
        subjectNameLbl.text = subject
    }
    
}
