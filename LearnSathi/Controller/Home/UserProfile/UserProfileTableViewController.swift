//
//  UserProfileTableViewController.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 21/01/25.
//

import UIKit

class UserProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var users: [UserAuth] = [
            UserAuth(id: UUID(), firstName: "Ayush", lastName: "Singh", standard: "7", email: "xyz@gmail.com", number: "203232302039", profileImage: "profileImage"),
            UserAuth(id: UUID(), firstName: "Md", lastName: "Akhlak", standard: "8", email: "xyz@gmail.com", number: "203232302039", profileImage: "user2")
        ]
        
        var currentUserIndex: Int = 0
    
    @IBOutlet var userProfileImageView: UIImageView!
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var userClassLabel: UILabel!
    
    @IBOutlet var userProfileTableView: UITableView!
    
    @IBOutlet var switchAccount: UITableViewCell!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        updateProfileUI()
        
        // Add observer for profile updates
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(handleProfileUpdate),
                                             name: NSNotification.Name("ProfileUpdated"),
                                             object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleProfileUpdate() {
        updateProfileUI()
        tableView.reloadData()
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
    
    
    // MARK: - Switch Account Functionality
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath), cell == switchAccount {
            switchUser()
        }

    }
    
    func openEditProfile() {
        func openEditProfile() {
                print("Opening edit profile with user:", users[currentUserIndex]) // Debug print
                
                guard let editVC = storyboard?.instantiateViewController(withIdentifier: "PersonalInformationTableViewController") as? PersonalInformationTableViewController else {
                    print("Failed to instantiate PersonalInformationTableViewController")
                    return
                }

                // Pass the current user as a direct reference
                let currentUser = users[currentUserIndex]
                editVC.user = currentUser
                editVC.currentUserIndex = currentUserIndex

                // Set the onSave closure
                editVC.onSave = { [weak self] updatedUser in
                    guard let self = self else { return }
                    print("Saving updated user in UserProfileTableViewController") // Debug print
                    
                    // Update both arrays
                    self.users[self.currentUserIndex] = updatedUser
                    users[self.currentUserIndex] = updatedUser // Update global array
                    
                    // Update UI
                    DispatchQueue.main.async {
                        self.updateProfileUI()
                        self.tableView.reloadData()
                    }
                }
                
                // Present the view controller
                let navController = UINavigationController(rootViewController: editVC)
                present(navController, animated: true)
            }
    }

    
    private func switchUser() {
        currentUserIndex = (currentUserIndex + 1) % users.count
        updateProfileUI()
    }
    
    
    
    private func updateProfileUI() {
        let user = users[currentUserIndex]
        userNameLabel.text = "\(user.firstName) \(user.lastName)"
        userClassLabel.text = "Class \(user.standard)"

        if let profileImageName = user.profileImage {
            // First try to load from documents directory
            if let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let imagePath = documentsPath.appendingPathComponent(profileImageName)
                if let image = UIImage(contentsOfFile: imagePath.path) {
                    userProfileImageView.image = image
                    return
                }
            }
            // If not found in documents, try loading from assets
            if let image = UIImage(named: profileImageName) {
                userProfileImageView.image = image
            }
        } else {
            userProfileImageView.image = UIImage(named: "defaultProfileImage")
        }
    }
}
