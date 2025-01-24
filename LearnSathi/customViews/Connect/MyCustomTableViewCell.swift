//
//  MyCustomCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 24/01/25.
//

import UIKit

class MyCustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var subjectNameLabel: UILabel!
   
    @IBOutlet weak var lessonNameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var subjectImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
