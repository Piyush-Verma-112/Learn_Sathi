//
//  DoubtTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 21/01/25.
//

import UIKit
protocol DoubtDelegate: AnyObject {
    func didAddDoubt(_ newDoubt: DoubtsListTableViewController.Subject)
}
class DoubtTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var delegate: DoubtDelegate?
    var imageStored: [String] = []
    let subjects = ["English", "Hindi", "Mathematics", "Social Science"]
        var lessonsMapping: [String: [String]] = [
            "English": chapterDetailsEnglish.map { $0.chapterName },
            "Hindi": chapterDetailsHindi.map { $0.chapterName },
            "Mathematics": chapterDetailsMaths.map { $0.chapterName },
            "Social Science": chapterDetailsSocialStudies.map { $0.chapterName }
        ]
    var currentLessons: [String] = []
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var lessonLabel: UILabel!
    
    @IBOutlet weak var subjectButton: UIButton!
    
    @IBOutlet weak var lessonButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupMenus()
            setupImageView()
        }

        // MARK: - Setup ImageView Tap Gesture
        private func setupImageView() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uploadButtonTapped(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGesture)
        }

        // MARK: - Camera Action
        @IBAction func uploadButtonTapped(_ sender: UIButton) {
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

            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = sender
                popoverController.sourceRect = sender.bounds
            }

            present(alertController, animated: true, completion: nil)
        }

        // MARK: - UIImagePickerControllerDelegate
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                imageView.image = selectedImage
            }
            dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }

        // MARK: - Setup Menus
        private func setupMenus() {
            var subjectActions: [UIAction] = []
            for subject in subjects {
                let action = UIAction(title: subject) { [weak self] _ in
                    self?.subjectLabel.text = subject
                    self?.updateLessons(for: subject)
                }
                subjectActions.append(action)
            }

            let subjectMenu = UIMenu(title: "Choose Subject", children: subjectActions)
            subjectButton.menu = subjectMenu
            subjectButton.showsMenuAsPrimaryAction = true
            updateLessons(for: subjects.first ?? "")
        }

        private func updateLessons(for subject: String) {
            currentLessons = lessonsMapping[subject] ?? []
            var lessonActions: [UIAction] = []
            for lesson in currentLessons {
                let action = UIAction(title: lesson) { [weak self] _ in
                    self?.lessonLabel.text = lesson
                }
                lessonActions.append(action)
            }
            let lessonMenu = UIMenu(title: "Choose Lesson", children: lessonActions)
            lessonButton.menu = lessonMenu
            lessonButton.showsMenuAsPrimaryAction = true
        }

        // MARK: - Done Button Action
        @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
            guard let subject = subjectLabel.text,
                  let lesson = lessonLabel.text else { return }

            let newDoubt = DoubtsListTableViewController.Subject(
                image: "default_image", 
                subjectName: subject,
                lessonName: lesson,
                status: "Pending",
                date: DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none),
                question: "Sample question text",
                solution: "",
                solutionImage: nil
            )

            delegate?.didAddDoubt(newDoubt)

            let alertController = UIAlertController(
                title: "Request Sent",
                message: "Your request has been sent to the tutor successfully.",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alertController, animated: true, completion: nil)
            print("New doubt added: \(newDoubt)")

        }
    }



