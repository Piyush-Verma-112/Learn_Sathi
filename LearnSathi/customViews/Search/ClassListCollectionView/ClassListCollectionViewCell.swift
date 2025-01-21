//
//  ClassListCollectionViewCell.swift
//  LearnSathi
//
//  Created by Shahma Ansari on 21/01/25.
//

import UIKit

class ClassListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var standardLbl: UILabel!
    
    
    static let identifier: String = "ClassListCollectionViewCell"
    
    func initialSetup(standard: Standard) {
        standardLbl.text = standard.name
    }
}



