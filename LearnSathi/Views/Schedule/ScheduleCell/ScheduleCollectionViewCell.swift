//
//  ScheduleCollectionViewCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 13/01/25.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = String(describing: ScheduleCollectionViewCell.self)
    
    @IBOutlet weak var tutorNameLbl: UILabel!
    @IBOutlet weak var subjectNameLbl: UILabel!
    @IBOutlet weak var subjectLogoImageView: UIImageView!
    @IBOutlet weak var classDurationLbl: UILabel!
    @IBOutlet weak var lessonNumberLbl: UILabel!
    @IBOutlet weak var startTimeLbl: UILabel!
    
    func setup(schedule: Schedule) {
        tutorNameLbl.text = schedule.tutorName
        subjectNameLbl.text = schedule.subjectName
        subjectLogoImageView.image = UIImage(named: schedule.subjectLogo)
        classDurationLbl.text = schedule.duration
        lessonNumberLbl.text =  String(schedule.lessonNumber)
        startTimeLbl.text = schedule.startTime
    }

}
