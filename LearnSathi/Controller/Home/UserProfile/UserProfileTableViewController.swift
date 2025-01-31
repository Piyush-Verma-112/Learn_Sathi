//
//  UserProfileTableViewController.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 21/01/25.
//

import UIKit

class UserProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var userProfileImageView: UIImageView!
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var userClassLabel: UILabel!
    
    @IBOutlet var userProfileTableView: UITableView!
    
    @IBOutlet var switchAccount: UITableViewCell!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
    }
      
    
//    MARK: - ViewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = false
        
        self.tabBarController?.tabBar.scrollEdgeAppearance = .init()
        self.tabBarController?.tabBar.barTintColor = .white
        
        title = "User Profile"
        addTapGestureToProfileImage()
        
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


