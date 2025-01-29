//
//  SolutionTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 27/01/25.
//

import UIKit

class SolutionTableViewController: UITableViewController {
    // MARK: - Doubt Data Model
    struct Doubt {
        let subject: String
        let lesson: String
        let question: String
        let status: String
        let solution: String
        let solutionImages: [UIImage]
    }

    var doubt: Doubt?
    
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var lessonLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var solutionLabel: UILabel!
    
    @IBOutlet weak var solutionImageCollectionView: UICollectionView!
    
    
    // MARK: - Populate Data
        private func populateData() {
            guard let doubt = doubt else { return }
            subjectLabel.text = doubt.subject
            lessonLabel.text = doubt.lesson
            questionLabel.text = doubt.question
            solutionLabel.text = doubt.solution
            print("Doubt passed successfully: \(doubt)")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            setupCollectionView()
            populateData()
        }
        
        // MARK: - Setup CollectionView
        private func setupCollectionView() {
            solutionImageCollectionView.dataSource = self
            solutionImageCollectionView.delegate = self
            let nib = UINib(nibName: "SolutionImageCollectionViewCell", bundle: nil)
            solutionImageCollectionView.register(nib, forCellWithReuseIdentifier: "SolutionImageCell")
        }
    }

    // MARK: - UICollectionView DataSource & Delegate
    extension SolutionTableViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return doubt?.solutionImages.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SolutionImageCell", for: indexPath) as! SolutionImageCollectionViewCell
            if let image = doubt?.solutionImages[indexPath.item] {
                cell.solutionImageView.image = image
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height: 100)
        }

    }

