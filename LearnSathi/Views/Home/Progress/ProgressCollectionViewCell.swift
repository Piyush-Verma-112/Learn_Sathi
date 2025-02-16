//
//  ProgressCollectionViewCell.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 16/02/25.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ProgressCollectionViewCell.self)

    
    @IBOutlet var progressOne: UILabel!
    
    @IBOutlet var progressTwo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func congfigure(with progress: Progress){
        progressOne.text = progress.progressOne
        progressTwo.text = progress.progressTwo
        
    }

}

struct Progress{
    var progressOne : String
    var progressTwo : String
    
}
