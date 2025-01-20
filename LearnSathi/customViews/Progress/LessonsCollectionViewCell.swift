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
    
    func setup(progress: LessonsProgress) {
        subjectName.text = progress.subject
        imageLogo.image = UIImage(named: progress.subjectLogo)
        ongoingLesson.text = progress.lessonOngoing.formatted()
        progressStatus.text = "/ " + progress.lessonStatus
        percentageCompleted.text = progress.completedPercentage.formatted() + "%"
        totalLessons.text = progress.totalLessons.formatted()
        progressBar.progress = Float(progress.completedPercentage) / 100
    }
}
