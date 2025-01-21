//
//  DoubtTableViewController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 21/01/25.
//

import UIKit

class DoubtTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var lessonLabel: UILabel!
    
    @IBOutlet weak var subjectButton: UIButton!
    
    @IBOutlet weak var lessonButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func cameraAction(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButtonAction = UIAlertAction(title: "Camera", style: .default, handler:{ action in imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)})
            alertController.addAction(cameraButtonAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryButtonAction = UIAlertAction(title: "Photo Library", style: .default, handler:{ action in imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)})
            alertController.addAction(photoLibraryButtonAction)
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        popoverPresentationController?.sourceView = sender
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    

}
