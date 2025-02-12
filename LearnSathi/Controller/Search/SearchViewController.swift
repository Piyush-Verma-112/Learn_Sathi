//
//  SearchViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController, CLLocationManagerDelegate{

    private let dataController = SearchDataController.shared
    
    var selectedSubjects: [String] = []
    var selectedClassIndex: IndexPath?

    private let locationManager = CLLocationManager()
    @IBOutlet weak var locationTextField: UISearchBar!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var subjectTableView: UITableView!
    
    @IBOutlet weak var searchResultcollectionView: UICollectionView!
    @IBOutlet weak var classCollectionView: UICollectionView!
    @IBOutlet weak var subjectBubbleCollectionView: UICollectionView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var standardTop: NSLayoutConstraint!
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjectBubbleCollectionView.isHidden = true
        configureCollectionViewLayout()
        classCollectionViewConfig()
        subjectTableViewDelegates()
        subjectTableViewConfig()
        registerCells()

        // Set up location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Configure activity indicator
        activityIndicator.color = .gray
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        print("SearchViewController appeared") // Debug print
        searchResultcollectionView.reloadData()
    }
    
    @objc private func handleDataUpdate() {
        // Reload all collection views when data is updated
        searchResultcollectionView.reloadData()
        classCollectionView.reloadData()
        subjectBubbleCollectionView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 25
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        subjectBubbleCollectionView.collectionViewLayout = layout
    }
    
    private func registerCells() {
        searchResultcollectionView.register(UINib(nibName: TutorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TutorCollectionViewCell.identifier)
        classCollectionView.register(UINib(nibName: ClassListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ClassListCollectionViewCell.identifier)
        subjectBubbleCollectionView.register(UINib(nibName: SubjectBubbleCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SubjectBubbleCollectionViewCell.identifier)
    }
    
    @IBAction func DoneBtnClicked(_ sender: UIButton) {
        
        // Show activity indicator on the main thread
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        // Fetch tutors data
        dataController.fetchTutors { [weak self] result in
            guard let self = self else { return }
            
            // Hide activity indicator on the main thread
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            switch result {
            case .success(let tutors):
                // Navigate to TutorListViewController on the main thread
                DispatchQueue.main.async {
                    let controller = self.storyboard?.instantiateViewController(identifier: "TutorListViewController") as! TutorListViewController
                    controller.tutors = tutors // Pass the fetched data
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                self.searchResultcollectionView.reloadData()
                
            case .failure(let error):
                // Show error message on the main thread
                DispatchQueue.main.async {
                    self.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func enterLocationButtonTapped(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Geocoding error: \(error.localizedDescription)")
                    return
                }
                
                if let placemark = placemarks?.first {
                    let locality = placemark.locality ?? ""
                    let administrativeArea = placemark.administrativeArea ?? ""
                    let country = placemark.country ?? ""
                    
                    // Update the text field with the location
                    self.locationTextField.text = "\(locality), \(administrativeArea), \(country)"
                    
                    // Stop updating location to save battery
                    self.locationManager.stopUpdatingLocation()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            // Handle the case where the user denies location permissions
            print("Location access denied")
        }
    }
}
// MARK: - Collection View Delegates
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func classCollectionViewConfig() {
        classCollectionView.allowsSelection = true // Enable selection
        classCollectionView.allowsMultipleSelection = false // Only allow one selection
        
        classCollectionView.layer.cornerRadius = 10
        classCollectionView.layer.shadowColor = UIColor.black.cgColor
        classCollectionView.layer.shadowOpacity = 0.1
        classCollectionView.layer.shadowOffset = .zero
        classCollectionView.layer.masksToBounds = false
        classCollectionView.layer.cornerRadius = 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case classCollectionView:
            return dataController.getAllStandards().count
        case subjectBubbleCollectionView:
            return selectedSubjects.count
        default:
            let count = dataController.allSearchResults().count
            print("Number of tutors in searchResultCollectionView: \(count)") // Debug print
            return count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case classCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassListCollectionViewCell.identifier, for: indexPath) as! ClassListCollectionViewCell
            cell.setup(standard: dataController.getAllStandards()[indexPath.row])
            return cell
            
        case subjectBubbleCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubjectBubbleCollectionViewCell.identifier, for: indexPath) as! SubjectBubbleCollectionViewCell
            cell.setup(subject: selectedSubjects[indexPath.row])
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorCollectionViewCell.identifier, for: indexPath) as! TutorCollectionViewCell
            cell.setup(search: dataController.allSearchResults()[indexPath.row]) // Use the updated searchResults
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == classCollectionView {
            // Store the selected index
            selectedClassIndex = indexPath
            
            // Trigger any additional actions you want when a class is selected
            let _ = dataController.getAllStandards()[indexPath.row]
            // Handle the selected standard (e.g., filter tutors, update UI, etc.)
            
        } else if collectionView == searchResultcollectionView {
            let selectedTutor = dataController.allSearchResults()[indexPath.row]
            navigateToTutorProfile(with: selectedTutor)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == classCollectionView {
            selectedClassIndex = nil
            // Handle deselection if needed
        }
    }
    
    private func navigateToTutorProfile(with tutor: TutorId) {
        if let tutorProfileVC = storyboard?.instantiateViewController(withIdentifier: "TutorProfileViewController") as? TutorProfileViewController {
            tutorProfileVC.selectedTutor = tutor
            navigationController?.pushViewController(tutorProfileVC, animated: true)
        }
    }
}

// MARK: - TableView and TextField Delegates
extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    private func subjectTableViewDelegates() {
        subjectTextField.delegate = self
        subjectTableView.delegate = self
        subjectTableView.dataSource = self
    }
    
    private func subjectTableViewConfig() {
        view.bringSubviewToFront(subjectTableView)
        subjectTableView.isHidden = true
        subjectTableView.register(UITableViewCell.self, forCellReuseIdentifier: "suggestionCell")
        
        subjectTableView.layer.cornerRadius = 10
        subjectTableView.layer.shadowColor = UIColor.black.cgColor
        subjectTableView.layer.shadowOpacity = 0.2
        subjectTableView.layer.shadowOffset = CGSize(width: 0, height: 2)
        subjectTableView.layer.shadowRadius = 5
        subjectTableView.layer.masksToBounds = false
    }
    
    func updateTableViewHeight() {
        let cellHeight: CGFloat = 44.0
        let maxVisibleCells = 5
        let totalHeight = CGFloat(min(dataController.getFilteredSubjects().count, maxVisibleCells)) * cellHeight
        
        tableViewHeight.constant = totalHeight
        subjectTableView.isScrollEnabled = dataController.getFilteredSubjects().count > maxVisibleCells
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        
        dataController.filterSubjects(for: updatedText)
        subjectTableView.isHidden = dataController.getFilteredSubjects().isEmpty
        subjectTableView.reloadData()
        updateTableViewHeight()
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            dataController.addNewSubject(text)
            textField.text = ""
            subjectTableView.reloadData()
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.getFilteredSubjects().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionCell", for: indexPath)
        cell.textLabel?.text = dataController.getFilteredSubjects()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSubject = dataController.getFilteredSubjects()[indexPath.row]
        if !selectedSubjects.contains(selectedSubject) {
            selectedSubjects.append(selectedSubject)
        }
        subjectTextField.text = selectedSubject
        tableView.isHidden = true
        subjectBubbleCollectionView.reloadData()
        
        subjectBubbleCollectionView.isHidden = false
        let collectionViewHeight = subjectBubbleCollectionView.frame.height
        
        UIView.animate(withDuration: 0.3) {
            self.standardTop.constant = collectionViewHeight + 10
            self.view.layoutIfNeeded()
        }
    }
}


