//
//  TutorsFilterCollectionViewCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 24/01/25.
//

import UIKit

class TutorsFilterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TutorsFilterCollectionViewCell"

    @IBOutlet var tutorFilterLbl: UILabel!

    func setup(filter: FilterTutor) {
        tutorFilterLbl.text = filter.label
    }
}
