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
    
    //@IBOutlet var averageScore: UILabel!
    
    func setup(testReports: TestDetails) {
        chapterName.text = testReports.chapterName
        date.text = testReports.testDate.formatted()
        totalQuestions.text = testReports.totalQuestions.formatted()
        correctAnswers.text = testReports.correctAnswers.formatted()
        attemptedQuestions.text = testReports.attemptedQuestions.formatted()
        //averageScore.text = "Score: \(String(format: "%.1f", testReports.score))%"
        pieChartView.configure(
               valuesAndColors: [
                   (value: Double(testReports.score), color: testReports.colorCode),
                   (value: Double(100 - testReports.score), color: .systemGray)
               ],
               centerText: "\(String(format: "%.f", testReports.score))%"
           )
    }
}
