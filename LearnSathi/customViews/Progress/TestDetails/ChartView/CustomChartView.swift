//
//  CustomChartView.swift
//  LearnSathi
//
//  Created by Batch - 2 on 22/01/25.
//

import Foundation
import UIKit
import Charts
import DGCharts

@IBDesignable
class CustomChartView: UIView {
    
    private var chartView: LineChartView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    private func setupView() {
        if chartView == nil {
            chartView = LineChartView()
            chartView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(chartView)
            
            NSLayoutConstraint.activate([
                chartView.topAnchor.constraint(equalTo: topAnchor),
                chartView.bottomAnchor.constraint(equalTo: bottomAnchor),
                chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
                chartView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
        
        // Minimal data to ensure it renders
        let dataEntries = [ChartDataEntry(x: 93.3, y: 93.3), ChartDataEntry(x: 60, y: 60)]
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Test Results")
        let lineChartData = LineChartData(dataSet: dataSet)
        //chartView.pinchZoomEnabled = true
        chartView.backgroundColor = .clear
        chartView.data = lineChartData
        
    }
}



