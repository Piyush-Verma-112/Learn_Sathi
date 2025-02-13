//
//  ScheduleTestCollectionViewCell.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 13/02/25.
//

import UIKit

class ScheduleTestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var tutorNameLabel: UILabel!
    
    @IBOutlet var testDateLabel: UILabel!
    
    @IBOutlet var testSubjectLabel: UILabel!
    
    @IBOutlet var subjectLogoImageView: UIImageView!
    
    @IBOutlet var testStartTimeLabel: UILabel!
    
    @IBOutlet var lessonNumberLabel: UILabel!
    
    
    func setup(schedule: Schedule) {
        tutorNameLabel.text = schedule.tutorName
        testSubjectLabel.text = schedule.subjectName
        subjectLogoImageView.image = UIImage(named: schedule.subjectLogo)
        lessonNumberLabel.text = String(schedule.lessonNumber)
        
        // Format the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        testDateLabel.text = dateFormatter.string(from: schedule.date)
        
        // Format the time
        dateFormatter.dateFormat = "h:mm a"
        testStartTimeLabel.text = dateFormatter.string(from: schedule.startTime)
    }
    

}
