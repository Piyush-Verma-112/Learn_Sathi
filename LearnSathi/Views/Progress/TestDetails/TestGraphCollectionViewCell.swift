//
//  TestGraphCollectionViewCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 21/01/25.
//

import UIKit

class TestGraphCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var presentResult: UILabel!
    @IBOutlet var barGraph: CustomChartView!
    @IBOutlet var weekSelection: UILabel!
    
    func setup(subjectsData: [[TestDetails]]) {
        weekSelection.text = "Last Week"
        var valuesAndColors: [(value: Double, color: UIColor)] = []
        var xAxisLabels: [String] = []
            
        for subject in subjectsData {
            for test in subject {
                valuesAndColors.append((value: Double(test.score), color: test.colorCode))
                xAxisLabels.append(test.chapterName)
            }
        }
            
        if let firstTest = subjectsData.first?.first {
            presentResult.text = "\(String(format: "%.f", firstTest.score))% Marks"
        }
            
        barGraph.configure(valuesAndColors: valuesAndColors, xAxisLabels: xAxisLabels)
    }
}
