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
        setupUI()
    }
    
    private func setupUI() {
        setupMenus()
        setupCollectionView()
        setupTextView()
        lessonButton.isEnabled = false
        addImageButton.isEnabled = false
    }
    
    private func setupTextView() {
        questionTextView.delegate = self
        questionTextView.text = "Type your question here..."
        questionTextView.textColor = .lightGray
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: "QuestionImageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupMenus() {
        let subjectActions = ConnectDataController.shared.lessonsMapping.keys.map { subject in
            UIAction(title: subject) { [weak self] _ in
                self?.subjectLabel.text = subject
                self?.updateLessons(for: subject)
                self?.lessonButton.isEnabled = true
            }
        }
        subjectButton.menu = UIMenu(title: "", children: subjectActions)
        subjectButton.showsMenuAsPrimaryAction = true
    }
    
    private func updateLessons(for subject: String) {
        currentLessons = ConnectDataController.shared.lessonsMapping[subject] ?? []
        let lessonActions = currentLessons.map { lesson in
            UIAction(title: lesson) { [weak self] _ in
                self?.lessonLabel.text = lesson
                self?.addImageButton.isEnabled = true
            }
        }
        lessonButton.menu = UIMenu(title: "", children: lessonActions)
        lessonButton.showsMenuAsPrimaryAction = true
    }
    
    @IBAction func addImageTapped(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true)
            })
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alertController.addAction(UIAlertAction(title: "Photo Library", style: .default) { _ in
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true)
            })
        }
        
        present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            selectedImages.append(selectedImage)
            collectionView.reloadData()
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let subjectText = subjectLabel.text, subjectText != "Select Subject",
                  let lessonText = lessonLabel.text, lessonText != "Select Lesson",
                  let questionText = questionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  !questionText.isEmpty,
                  questionText != "Type your question here..." else {
                
                let missingFields = [
                    subjectLabel.text == "Select Subject" ? "Subject" : nil,
                    lessonLabel.text == "Select Lesson" ? "Lesson" : nil,
                    (questionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || questionTextView.text == "Type your question here...") ? "Question" : nil
                ].compactMap { $0 }.joined(separator: ", ")
                
                let alertController = UIAlertController(
                    title: "Incomplete Information",
                    message: "Please select or fill in the following: \(missingFields).",
                    preferredStyle: .alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                present(alertController, animated: true)
                return
            }
         let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "d MMM YY"
               let currentDate = dateFormatter.string(from: Date())
            let newDoubt = Doubts(
                subjectName: subjectText,
                lessonName: lessonText,
                status: "Pending",
                date: currentDate,
                question: questionText,
                solution: "Solution will be added later",
                solutionImages: []
            )

            delegate?.didAddDoubt(newDoubt)
            showConfirmationAlert()
        }
    
    private func showConfirmationAlert() {
        let confirmationAlert = UIAlertController(
            title: "Request Sent",
            message: "Your request has been sent to the tutor.",
            preferredStyle: .alert
        )
        confirmationAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(confirmationAlert, animated: true)
    }
}

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
    
    @objc private func removeImage(_ sender: UIButton) {
        selectedImages.remove(at: sender.tag)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

extension AskDoubtTableViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type your question here..." {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "Type your question here..."
            textView.textColor = .lightGray
        }
    }
}
