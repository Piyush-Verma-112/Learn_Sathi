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
    
    func setup(subjectDetails: SubjectDetails) {
        
        lessonNumber.text = subjectDetails.lessonCount.formatted()
        lessonName.text = subjectDetails.chapterName
        lessonProgress.text = subjectDetails.progressPercentage.formatted()
    }

}
