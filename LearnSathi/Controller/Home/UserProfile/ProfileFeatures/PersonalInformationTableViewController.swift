//
//  PersonalInformationTableViewController.swift
//  LearnSathi
//
//  Created by iSDP on 23/01/25.
//

import UIKit

class PersonalInformationTableViewController: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var editFirstNameTextField: UITextField!
    
    @IBOutlet var editLastNameTextField: UITextField!
    
    @IBOutlet var editBirthDateDatePicker: UIDatePicker!
    
    @IBOutlet var editPhoneNumberTextField: UITextField!
    

    @IBOutlet var setNewProfilePhotoImageViewTapped: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        addTapGestureToProfileImage()
      
    }
    
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    private func addTapGestureToProfileImage() {
        setNewProfilePhotoImageViewTapped.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        setNewProfilePhotoImageViewTapped.addGestureRecognizer(tapGesture)
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
        
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    @objc func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            setNewProfilePhotoImageViewTapped.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            setNewProfilePhotoImageViewTapped.image = originalImage
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
