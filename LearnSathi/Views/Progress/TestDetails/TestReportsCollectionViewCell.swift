//
//  TestReportsCollectionViewCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 21/01/25.
//

import UIKit

class TestReportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var chapterName: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var totalQuestions: UILabel!
    @IBOutlet var correctAnswers: UILabel!
    @IBOutlet var attemptedQuestions: UILabel!
    
    @IBOutlet var pieChartView: CustomPieChartView!
    
    func setup(testReports: TestDetails) {
        chapterName.text = testReports.chapterName
        date.text = testReports.testDate.formatted()
        totalQuestions.text = "\(testReports.totalQuestions)"
        correctAnswers.text = "\(testReports.correctAnswers)"
        attemptedQuestions.text = "\(testReports.attemptedQuestions)"
        
        let scorePercentage = Double(testReports.score)
        
        pieChartView.configure(
            valuesAndColors: [
                (value: scorePercentage, color: testReports.color),
                (value: 100 - scorePercentage, color: .systemGray)
            ],
            centerText: "\(String(format: "%.f", scorePercentage))%"
        )
    }
}

