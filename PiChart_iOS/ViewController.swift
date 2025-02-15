//
//  ViewController.swift
//  PiChart_iOS
//
//  Created by Atik Hasan on 2/16/25.
//
import UIKit
import Charts
import DGCharts

class ViewController: UIViewController {
    
    let pieView: PieChartView = {
        let chartView = PieChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.drawHoleEnabled = false // No hole in the center
        //chartView.chartDescription?.text = "Survey Results"
        chartView.chartDescription.font = .systemFont(ofSize: 14, weight: .medium)
        chartView.chartDescription.textColor = .black
        chartView.backgroundColor = .white
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Pie Chart"
        
        setupChartView()
        setChartData()
    }
    
    func setupChartView() {
        view.addSubview(pieView)
        NSLayoutConstraint.activate([
            pieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pieView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            pieView.heightAnchor.constraint(equalTo: pieView.widthAnchor, multiplier: 0.8)
        ])
        
        pieView.legend.enabled = false     /// As you wish , u can do true or false
    }
    
    func setChartData() {
        let surveyData: [String: Double] = ["Cat": 20, "Dog": 30, "Both": 10, "Neither": 50]
        
        var dataEntries: [PieChartDataEntry] = []
        for (key, value) in surveyData {
            let entry = PieChartDataEntry(value: value, label: key)
            dataEntries.append(entry)
        }
        
        let dataSet = PieChartDataSet(entries: dataEntries, label: "Survey Results")
        dataSet.colors = ChartColorTemplates.material()
        dataSet.sliceSpace = 2
        dataSet.selectionShift = 5
        dataSet.xValuePosition = .outsideSlice
        dataSet.yValuePosition = .outsideSlice
        dataSet.valueTextColor = .black
        dataSet.valueLineWidth = 1.5
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.4
        dataSet.valueFormatter = PercentageValueFormatter()
        dataSet.drawValuesEnabled = true
        
        let pieData = PieChartData(dataSet: dataSet)
        pieView.data = pieData
    }
}

// Custom Percentage Formatter Class
class PercentageValueFormatter: NSObject, ValueFormatter {
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        return String(format: "%.0f%%", value)
    }
}

