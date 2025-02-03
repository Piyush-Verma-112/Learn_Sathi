import UIKit
import Charts
import DGCharts

@IBDesignable
class CustomChartView: UIView {
    
    private var chartView: BarChartView!
    
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
            chartView = BarChartView()
            chartView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(chartView)
            
            NSLayoutConstraint.activate([
                chartView.topAnchor.constraint(equalTo: topAnchor),
                chartView.bottomAnchor.constraint(equalTo: bottomAnchor),
                chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
                chartView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
        
        // Default bar chart setup
        chartView.legend.enabled = true
        chartView.rightAxis.enabled = true
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.axisMinimum = 0
    }
    
    func configure(valuesAndColors: [(value: Double, color: UIColor)], xAxisLabels: [String]) {
        // Prepare the bar chart data entries
        let dataEntries = valuesAndColors.enumerated().map { index, item in
            BarChartDataEntry(x: Double(index), y: item.value)
        }
        
        // Create the dataset for the bar chart
        let dataSet = BarChartDataSet(entries: dataEntries, label: "")
        dataSet.colors = valuesAndColors.map { $0.color }
        dataSet.valueColors = [.black] // Set color for values
        dataSet.valueFont = .systemFont(ofSize: 12)
        
        
        // Create the bar chart data
        let barChartData = BarChartData(dataSet: dataSet)
        barChartData.barWidth = 0.3
        chartView.fitBars = true
        chartView.data = barChartData
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisLabels)
        chartView.xAxis.granularity = 1
        chartView.xAxis.granularityEnabled = true
        chartView.xAxis.labelFont = .systemFont(ofSize: 8)
        chartView.animate(yAxisDuration: 1.5)
    }
}
