//
//  LessonsCollectionViewCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 15/01/25.
//

import UIKit

class LessonsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: LessonsCollectionViewCell.self)
    
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var ongoingLesson: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var progressStatus: UILabel!
    @IBOutlet weak var percentageCompleted: UILabel!
    @IBOutlet weak var totalLessons: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    
    func setup(progress: LessonProgress) {
        subjectName.text = progress.subject
        imageLogo.image = UIImage(named: progress.subjectLogo)
        ongoingLesson.text = "\(progress.lessonOngoing)"
        progressStatus.text = "/ \(progress.lessonStatus.rawValue)"
        let completionPercentage = (Double(progress.completedLessons) / Double(progress.totalLessons)) * 100
        percentageCompleted.text = String(format: "%.0f%%", completionPercentage)
        percentageCompleted.textColor = UIColor.systemBlue
        totalLessons.text = "\(progress.totalLessons)"
        progressBar.progress = Float(completionPercentage) / 100
        progressBar.tintColor = progress.color
        percentageCompleted.textColor = progress.color
    }
}

