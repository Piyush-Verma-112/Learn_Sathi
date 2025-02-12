//
//  PersonalInformationTableViewController.swift
//  LearnSathi
//
//  Created by iSDP on 23/01/25.
//

import UIKit

class PersonalInformationTableViewController: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var user: UserAuth?
   var currentUserIndex = 0
   var onSave: ((UserAuth) -> Void)?

    
    @IBOutlet var editFirstNameTextField: UITextField!
    @IBOutlet var editLastNameTextField: UITextField!
    @IBOutlet var editBirthDateDatePicker: UIDatePicker!
    @IBOutlet var editPhoneNumberTextField: UITextField!
    @IBOutlet var setNewProfilePhotoImageViewTapped: UIImageView!
    @IBOutlet var editStandardTextField: UITextField!
    
    private var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadUserData()
    }
    
    private func setupUI() {
        // Setup image picker
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // Setup profile image tap gesture
        addTapGestureToProfileImage()

    }
    
    private func loadUserData() {
        let user = users[currentUserIndex]
        editFirstNameTextField.text = user.firstName
        editLastNameTextField.text = user.lastName
        editStandardTextField.text = user.standard
        editPhoneNumberTextField.text = user.number

        if let profileImageName = user.profileImage {
            if let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let imagePath = documentsPath.appendingPathComponent(profileImageName)
                if let image = UIImage(contentsOfFile: imagePath.path) {
                    setNewProfilePhotoImageViewTapped.image = image
                    return
                }
            }
            
            if let image = UIImage(named: profileImageName) {
                setNewProfilePhotoImageViewTapped.image = image
            }
        }
    }
    
    
    
    
    private func saveImageToDocuments(_ image: UIImage) -> String {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".jpg"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        if let imageData = image.jpegData(compressionQuality: 0.8) {
            do {
                try imageData.write(to: fileURL)
                return fileName  // Save only the file name, not the full path
            } catch {
                print("Error saving image: \(error)")
                return user?.profileImage ?? "defaultProfileImage"
            }
        }

        return user?.profileImage ?? "defaultProfileImage"
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
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { [weak self] _ in
                self?.showImagePicker(sourceType: .camera)
            }
            alertController.addAction(cameraAction)
        }
        let galleryAction = UIAlertAction(title: "Choose from Gallery", style: .default) { [weak self] _ in
            self?.showImagePicker(sourceType: .photoLibrary)
        }
        
        alertController.addAction(galleryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
    
        present(alertController, animated: true)
    }
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController,
                                 didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            setNewProfilePhotoImageViewTapped.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            setNewProfilePhotoImageViewTapped.image = originalImage
        }
        picker.dismiss(animated: true)
    }
        
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    
    
    
}
