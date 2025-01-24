//
//  LessonDetailsCollectionViewCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 16/01/25.
//

import UIKit

class LessonDetailsCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: LessonDetailsCollectionViewCell.self)
                                   
    @IBOutlet weak var lessonNumber: UILabel!
    @IBOutlet weak var lessonName: UILabel!
    @IBOutlet weak var lessonProgress: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var chapterStatus: UILabel!
    
    func setup(subjectDetails: SubjectDetails) {
        
        lessonNumber.text = "Lesson: " + subjectDetails.lessonCount.formatted()
        lessonName.text = subjectDetails.chapterName
        lessonProgress.text = subjectDetails.progressPercentage.formatted() + "%"
        progressBar.progress = Float(subjectDetails.progressPercentage)/100
        if progressBar.progress == 1 {
            chapterStatus.text = "Completed"
            chapterStatus.textColor = .systemGreen
        }
        else if progressBar.progress == 0 {
            chapterStatus.text = "UpComing"
            chapterStatus.textColor = .red
        } else {
            chapterStatus.text = "In Progress"
            chapterStatus.textColor = .systemOrange
        }
    }

}
