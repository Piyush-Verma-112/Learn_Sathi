//
//  TestDetailsViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 21/01/25.
//

//
//  TestDetailsViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 21/01/25.
//

import UIKit
import Charts
import DGCharts

@IBDesignable
class TestDetailsViewController: UIViewController {

    @IBOutlet var graphsCollectionView: UICollectionView!
    @IBOutlet var collectionViewTestReports: UICollectionView!
    
    func updateData(with indexPath: IndexPath) {
        navigationItem.title = progressData[indexPath.row].subject
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewTestReports.delegate = self
        collectionViewTestReports.dataSource = self
        graphsCollectionView.dataSource = self
        graphsCollectionView.delegate = self
        
        registerCells()
    }
    private func registerCells() {
        let nib = UINib(nibName: "TestReportsCollectionViewCell", bundle: nil)
        collectionViewTestReports.register(nib, forCellWithReuseIdentifier: "TestReportsCollectionViewCell")
        let nib2 = UINib(nibName: "TestGraphCollectionViewCell", bundle: nil)
        graphsCollectionView.register(nib2, forCellWithReuseIdentifier: "TestGraphCollectionViewCell")
        if let flowLayout = graphsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal  // Set the scroll direction to horizontal
            flowLayout.minimumLineSpacing = 10 // Set space between cells (you can adjust this value as needed)
            flowLayout.itemSize = CGSize(width: 150, height: graphsCollectionView.frame.height) // Set item size, adjust width as needed
        }
    }

}
extension TestDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewTestReports{
            switch navigationItem.title {
            case "Mathematics" :
                return testDetailsMaths.count
            case "English" :
                return testDetailsEnglish.count
            case "Science" :
                return testDetailsScience.count
            case "Social Studies" :
                return testDetailsSocialStudies.count
            case "Hindi" :
                return testDetailsHindi.count
            default :
                return 0
            }
        } else {
            switch navigationItem.title {
            case "Mathematics" :
                return testDetailsMaths.count
            case "English" :
                return testDetailsEnglish.count
            case "Science" :
                return testDetailsScience.count
            case "Social Studies" :
                return testDetailsSocialStudies.count
            case "Hindi" :
                return testDetailsHindi.count
            default :
                return 0
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewTestReports{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestReportsCollectionViewCell", for: indexPath) as! TestReportsCollectionViewCell
            switch navigationItem.title {
            case "Mathematics" :
                cell.setup(testReports: testDetailsMaths[indexPath.row])
            case "English" :
                cell.setup(testReports: testDetailsEnglish[indexPath.row])
            case "Science" :
                cell.setup(testReports: testDetailsScience[indexPath.row])
            case "Social Studies" :
                cell.setup(testReports: testDetailsSocialStudies[indexPath.row])
            case "Hindi" :
                cell.setup(testReports: testDetailsHindi[indexPath.row])
            default :
                break
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestGraphCollectionViewCell", for: indexPath) as! TestGraphCollectionViewCell
            var subjectsData: [[TestDetails]] = []
            
            switch navigationItem.title {
            case "Mathematics" :
                subjectsData = [testDetailsMaths]
            case "English" :
                subjectsData = [testDetailsEnglish]
            case "Science" :
                subjectsData = [testDetailsScience]
            case "Social Studies" :
                subjectsData = [testDetailsSocialStudies]
            case "Hindi" :
                subjectsData = [testDetailsHindi]
            default :
                break
            }
            
            if !subjectsData.isEmpty {
                cell.setup(subjectsData: subjectsData)
            }
            
            return cell
        }
    }
}

