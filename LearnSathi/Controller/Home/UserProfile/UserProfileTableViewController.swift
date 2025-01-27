//
//  UserProfileTableViewController.swift
//  LearnSathi
//
//  Created by iSDP on 21/01/25.
//

import UIKit

class UserProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var changeProfile: UITableViewCell!
    
    @IBOutlet var userProfileImageView: UIImageView!
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var userClassLabel: UILabel!
    
    @IBOutlet var userProfileTableView: UITableView!
    
    @IBOutlet var switchAccount: UITableViewCell!
    
    
//    MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.scrollEdgeAppearance = .init()
        self.tabBarController?.tabBar.barTintColor = .white
                    
        self.tabBarController?.tabBar.isTranslucent = false
        title = "User Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        // Add tap gesture to changeProfile cell
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileTapped))
        changeProfile.addGestureRecognizer(tapGesture)
        changeProfile.isUserInteractionEnabled = true
        
        // Add the edit button to the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        
    }
    
    
    func changeAccount() {
        
    }
    
    
    @objc func editTapped() {
        print("Edit button tapped")
        
        addTapGestureToProfileImage()
        
        let controller = storyboard?.instantiateViewController(identifier: "PersonalInformationTableViewController") as! PersonalInformationTableViewController
//        navigationController?.pushViewController(controller, animated: true)
        present(controller, animated: true)
    }
    
    private func addTapGestureToProfileImage() {
        userProfileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        userProfileImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func profileImageTapped() {
        print("Profile image tapped")
        showImagePickerOptions()
    }
    
    @objc func changeProfileTapped() {
        showImagePickerOptions()
    }
    
    
    func showImagePickerOptions() {
        let alertController = UIAlertController(title: "Change Profile Picture",message: "Choose your option",preferredStyle: .actionSheet)
        // Camera option
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { [weak self] _ in
                self?.showImagePicker(sourceType: .camera)
            }
            alertController.addAction(cameraAction)
        }
        // Gallery option
        let galleryAction = UIAlertAction(title: "Choose from Gallery", style: .default) { [weak self] _ in
            self?.showImagePicker(sourceType: .photoLibrary)
        }
        
        alertController.addAction(galleryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
    
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = changeProfile
            popoverController.sourceRect = changeProfile.bounds
        }
        present(alertController, animated: true)
    }
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    @objc func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            userProfileImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            userProfileImageView.image = originalImage
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}


