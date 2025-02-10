//
//  SolutionTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 27/01/25.
//

import UIKit
import QuickLook

class SolutionTableViewController: UITableViewController, QLPreviewControllerDataSource {
    
    var doubt: Doubts?
    private var selectedImageURL: URL?

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var lessonLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var solutionLabel: UILabel!
    @IBOutlet weak var solutionImageCollectionView: UICollectionView!

    // MARK: - Populate Data
    private func populateData() {
        guard let doubt = doubt else { return }
        subjectLabel.text = doubt.subjectName
        lessonLabel.text = doubt.lessonName
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

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }

    // MARK: - QLPreviewController DataSource
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return selectedImageURL != nil ? 1 : 0
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return selectedImageURL! as QLPreviewItem
    }

    // MARK: - Open Image in Fullscreen using QuickLook
    private func openImageInFullScreen(_ image: UIImage) {
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempImage.jpg")
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: tempURL)
            selectedImageURL = tempURL

            let previewController = QLPreviewController()
            previewController.dataSource = self
            present(previewController, animated: true)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let image = doubt?.solutionImages[indexPath.item] else { return }
        openImageInFullScreen(image)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

