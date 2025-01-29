//
//  DoubtTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 27/01/25.
//

import UIKit

protocol DoubtDelegate: AnyObject {
    func didAddDoubt(_ newDoubt: Doubts)
}


class AskDoubtTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var delegate: DoubtDelegate?
    var selectedImages: [UIImage] = []
    var currentLessons: [String] = []

    @IBOutlet weak var subjectLabel: UILabel!
    
    
    @IBOutlet weak var lessonLabel: UILabel!
    
    @IBOutlet weak var subjectButton: UIButton!
    
    @IBOutlet weak var lessonButton: UIButton!
    
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var addImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenus()
        let nib = UINib(nibName: "QuestionImageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ImageCell")
        setupCollectionView()
        lessonButton.isEnabled = false
        addImageButton.isEnabled = false
        questionTextView.delegate = self
            questionTextView.text = "Type your question here..."
            questionTextView.textColor = UIColor.lightGray
        
        }
    private func setupMenus() {
        var subjectActions: [UIAction] = []
        for subject in subjects {
            let action = UIAction(title: subject) { [weak self] _ in
                self?.subjectLabel.text = subject
                self?.updateLessons(for: subject)
                self?.lessonButton.isEnabled = true
            }
            subjectActions.append(action)
        }

        let subjectMenu = UIMenu(title: "", children: subjectActions)
        subjectButton.menu = subjectMenu
        subjectButton.showsMenuAsPrimaryAction = true
    }

    private func updateLessons(for subject: String) {
        currentLessons = lessonsMapping[subject] ?? []
        var lessonActions: [UIAction] = []
        
        for lesson in currentLessons {
            let action = UIAction(title: lesson) { [weak self] _ in
                self?.lessonLabel.text = lesson
                self?.addImageButton.isEnabled = true
            }
            lessonActions.append(action)
        }
        
        let lessonMenu = UIMenu(title: "", children: lessonActions)
        lessonButton.menu = lessonMenu
        lessonButton.showsMenuAsPrimaryAction = true
    }
    // MARK: - Setup CollectionView
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // MARK: - Add Image
    @IBAction func addImageTapped(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
        }

        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            selectedImages.append(selectedImage)
            collectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Done Button Action
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard
               let subjectText = subjectLabel.text, subjectText != "Select Subject",
               let lessonText = lessonLabel.text, lessonText != "Select Lesson",
               let questionText = questionTextView.text, !questionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
           else {
               let missingFields = [
                   subjectLabel.text == "Select Subject" ? "Subject" : nil,
                   lessonLabel.text == "Select Lesson" ? "Lesson" : nil,
                   questionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Question" : nil
               ].compactMap { $0 }.joined(separator: ", ")

               let alertController = UIAlertController(
                   title: "Incomplete Information",
                   message: "Please select or fill in the following: \(missingFields).",
                   preferredStyle: .alert
               )
               alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alertController, animated: true, completion: nil)
               return
           }
           
        let newDoubt = Doubts(
            image: "defaultImage",
            subjectName: subjectText,
            lessonName: lessonText,
            status: "Pending",
            date: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none),
            question: questionText,
            solution: "Solution will be added later",
            solutionImages: []
        )
          delegate?.didAddDoubt(newDoubt)

          navigationController?.popViewController(animated: true)
      }
    }


// MARK: - UICollectionView DataSource and Delegate
extension AskDoubtTableViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! QuestionImageCollectionViewCell
        cell.imageView.image = selectedImages[indexPath.item]
        cell.removeButton.tag = indexPath.item
        cell.removeButton.addTarget(self, action: #selector(removeImage(_:)), for: .touchUpInside)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenVC = FullScreenImageViewController()
        fullScreenVC.image = selectedImages[indexPath.item]
        present(fullScreenVC, animated: true, completion: nil)
    }

    @objc private func removeImage(_ sender: UIButton) {
        selectedImages.remove(at: sender.tag)
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}


class FullScreenImageViewController: UIViewController {
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.view.addSubview(imageView)
        
        let closeButton = UIButton(frame: CGRect(x: 20, y: 50, width: 50, height: 50))
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
    
    @objc private func closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension AskDoubtTableViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type your question here..." {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "Type your question here..."
            textView.textColor = UIColor.lightGray
        }
    }
}
