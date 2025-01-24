//
//  CustomPieChartView.swift
//  LearnSathi
//
//  Created by Batch - 2 on 23/01/25.
//

import UIKit
import Charts
import DGCharts

@IBDesignable
class CustomPieChartView: UIView {
    
    private var chartView: PieChartView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        if chartView == nil {
            chartView = PieChartView()
            chartView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(chartView)
            
            NSLayoutConstraint.activate([
                chartView.topAnchor.constraint(equalTo: topAnchor),
                chartView.bottomAnchor.constraint(equalTo: bottomAnchor),
                chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
                chartView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
        chartView.holeColor = .clear
        chartView.holeRadiusPercent = 0.7
        chartView.drawEntryLabelsEnabled = false
        chartView.legend.enabled = false
    }
    

    func configure(valuesAndColors: [(value: Double, color: UIColor)], centerText: String) {
            let dataEntries = valuesAndColors.map { PieChartDataEntry(value: $0.value, label: nil) }
            
            let dataSet = PieChartDataSet(entries: dataEntries, label: "")
            dataSet.colors = valuesAndColors.map { $0.color }
            dataSet.drawValuesEnabled = false
            let pieChartData = PieChartData(dataSet: dataSet)
            chartView.data = pieChartData
            
            chartView.centerText = centerText
            chartView.animate(yAxisDuration: 1.0)
        }
}



