//
//  TestsCollectionViewCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 15/01/25.
//

import UIKit

class TestsCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: TestsCollectionViewCell.self)
    
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var nextTestDate: UILabel!
    @IBOutlet weak var averageScore: UILabel!
    @IBOutlet weak var attemptedTests: UILabel!
    @IBOutlet weak var subjectLogo: UIImageView!
    
    func setup(testProgress: TestProgress) {
        subjectName.text = testProgress.subject
        averageScore.text = "\(testProgress.averageScore)%"
        attemptedTests.text = testProgress.attemptedTests.formatted()
        subjectLogo.image = UIImage(named: testProgress.subjectLogo)
    }
}
