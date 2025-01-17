//
//  LDTableViewCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 17/01/25.
//

import UIKit

class LDTableViewCell: UITableViewCell {

    @IBOutlet var chapterNum: UILabel!
    @IBOutlet var chapterName: UILabel!
    @IBOutlet var progressPercentage: UILabel!
    
    
    
    func setup(subjectDetails: SubjectDetails){
        chapterNum.text = "Lesson: " + subjectDetails.lessonCount.formatted()
        chapterName.text = subjectDetails.chapterName
        progressPercentage.text = subjectDetails.progressPercentage.formatted() + "%"
    }
    
}
