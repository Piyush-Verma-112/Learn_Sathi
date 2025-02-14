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
    
    var subjectName: String?

    func updateData(with indexPath: IndexPath) {
        let testProgress = ProgressDataController.shared.getAllTestProgress()
        navigationItem.title = testProgress[indexPath.row].subject
        subjectName = testProgress[indexPath.row].subject
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
            flowLayout.minimumLineSpacing = 10 // Set space between cells
            flowLayout.itemSize = CGSize(width: 150, height: graphsCollectionView.frame.height) // Adjust width as needed
        }
    }
}

extension TestDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let subject = subjectName else { return 0 }
        let testDetails = ProgressDataController.shared.getTests(for: subject)
        return testDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let subject = subjectName else { return UICollectionViewCell() }
        let testDetails = ProgressDataController.shared.getTests(for: subject)

        if collectionView == collectionViewTestReports {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestReportsCollectionViewCell", for: indexPath) as! TestReportsCollectionViewCell
            cell.setup(testReports: testDetails[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestGraphCollectionViewCell", for: indexPath) as! TestGraphCollectionViewCell
            cell.setup(subjectsData: [testDetails])
            return cell
        }
    }
}
