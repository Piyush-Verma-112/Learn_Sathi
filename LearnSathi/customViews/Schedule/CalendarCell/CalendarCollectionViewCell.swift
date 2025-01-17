//
//  CalendarCollectionViewCell.swift
//  LearnSathi
//
//  Created by Batch - 1 on 13/01/25.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: CalendarCollectionViewCell.self)
    
    @IBOutlet var dayLabel: UILabel!

    @IBOutlet var dateLabel: UILabel!

    
    func setup(calendar: CalendarData) {
        dayLabel.text = calendar.day
        dateLabel.text = calendar.date.formatted()
        
    }

}
