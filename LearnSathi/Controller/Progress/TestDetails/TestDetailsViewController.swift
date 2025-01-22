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

    @IBOutlet var collectionViewTestReports: UICollectionView!
    
    func updateData(with indexPath: IndexPath) {
        navigationItem.title = progressData[indexPath.row].subject
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewTestReports.delegate = self
        collectionViewTestReports.dataSource = self
        registerCells()
    }
    private func registerCells() {
        let nib = UINib(nibName: "TestReportsCollectionViewCell", bundle: nil)
        collectionViewTestReports.register(nib, forCellWithReuseIdentifier: "TestReportsCollectionViewCell")
      
    }

}
extension TestDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
}

