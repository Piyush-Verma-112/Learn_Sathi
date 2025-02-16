//
//  MainHomeViewController.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 16/02/25.
//

import UIKit

class MainHomeViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    

    var schedule : [Schedule] = [
        Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "EnglishLogo", subjectName: "English Grammar", topicName: "Modals", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "10:00 AM", endTime: "11:00 AM", topicDescription: ["Basics", "Usage", "Examples"], lessonNumber: 1),
        Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "2 hr", subjectLogo: "ScienceLogo", subjectName: "Science", topicName: "Photosynthesis", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "11:00 AM", endTime: "1:00 PM", topicDescription: ["Definition", "Process", "Applications"], lessonNumber: 8),
        Schedule(tutorLogo: "person", tutorName: "Pradeep Gupta", duration: "1 hr", subjectLogo: "HindiLogo", subjectName: "Hindi", topicName: "Nibandh Lekhan", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 20))!, startTime: "9:00 AM", endTime: "10:00 AM", topicDescription: ["Format", "Examples", "Practice"], lessonNumber: 3),
        Schedule(tutorLogo: "person", tutorName: "Shahma Ansari", duration: "1.5 hr", subjectLogo: "Maths", subjectName: "Mathematics", topicName: "Algebra Basics", date: Calendar.current.date(from: DateComponents(year: 2025, month: 1, day: 21))!, startTime: "2:00 PM", endTime: "3:30 PM", topicDescription: ["Linear Equations", "Variables", "Graphing"], lessonNumber: 5)
    ]

    
    var requests: [Request] = [
        Request(tutorImage: "user2", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "user2", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "user2", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "user2", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "user2", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "user2", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "user2", tutorName: "Shahma Ansari", requestStatus: "Pending"),
        Request(tutorImage: "user2", tutorName: "Shahma Ansari", requestStatus: "Pending"),
    
    ]
    
    var progress :[Progress] = [
        Progress(progressOne: "Science", progressTwo: "90"),
        Progress(progressOne: "Computer", progressTwo: "78"),
        Progress(progressOne: "English", progressTwo: "76"),
        Progress(progressOne: "SST", progressTwo: "90"),
        Progress(progressOne: "Hindi", progressTwo: "98")
        
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        
    }
    
    private func setupNavigationBar() {
        
        // Set up navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        
        // Apply appearance to all navigation bar states
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        // Hide navigation bar line
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // Set background color
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        // Create single container for both elements with increased height
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create title label
        let titleLabel = UILabel()
        titleLabel.text = "LearnSathi"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        
        // Create profile image view
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "profileImage")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 22.5
        profileImageView.clipsToBounds = true
        profileImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profilImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)

        // Add both to container
        containerView.addSubview(titleLabel)
        containerView.addSubview(profileImageView)
        
        // Setup constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: UIScreen.main.scale * 100),
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            // Title label constraints
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            // Profile image constraints
            profileImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 45),
            profileImageView.heightAnchor.constraint(equalToConstant: 45),
            
        ])
        
        navigationItem.titleView = containerView
    }

    @objc private func profilImageTapped() {
        let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
        if let profileVC = storyboard.instantiateInitialViewController() {
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    
        collectionView.register(UINib(nibName: "ScheduleCollectionViewCell", bundle: nil),
                                       forCellWithReuseIdentifier: ScheduleCollectionViewCell.identifier)

        collectionView.register(UINib(nibName: "ProgressCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "RequestsCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: RequestsCollectionViewCell.identifier)
        
        collectionView.register(SectionHeaderCollectionReusableView.self,
                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                              withReuseIdentifier: "SectionHeaderCollectionReusableView")
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self?.createUpcomingClassesSection()
            case 1:
                return self?.createProgressSection()
            case 2:
                return self?.createRequestsSection()
            default:
                return nil
            }
        }
    }
    
    private func createUpcomingClassesSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .absolute(140))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .absolute(150))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(70))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        section.boundarySupplementaryItems = [header]
    
        return section
    }
    
    private func createProgressSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                            heightDimension: .absolute(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createRequestsSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .estimated(240))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    @objc private func seeMoreTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0: // Upcoming Classes
            // Navigate to all classes
            break
        case 1: // Progress
            // Navigate to progress details
            break
        case 2: // Requests
            let controller = storyboard?.instantiateViewController(identifier: "RequestViewController") as! RequestViewController
            navigationController?.pushViewController(controller, animated: true)
        default:
            break
        }
    }
    

}


// MARK: - UICollectionViewDataSource
extension MainHomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return schedule.count
        case 1: return progress.count
        case 2: return min(requests.count, 4)
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCollectionViewCell.identifier, for: indexPath) as! ScheduleCollectionViewCell
            cell.setup(schedule: schedule[indexPath.row])
            return cell
            
        case 1: // Progress section
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as! ProgressCollectionViewCell
            cell.congfigure(with: progress[indexPath.row])
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequestsCollectionViewCell.identifier, for: indexPath) as! RequestsCollectionViewCell
            cell.configure(with: requests[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: "SectionHeaderCollectionReusableView",
                                                                       for: indexPath) as! SectionHeaderCollectionReusableView
            
            
            let titles = ["Upcoming Classes", "Progress", "Recent Requests"]
            header.headerLabel.text = titles[indexPath.section]
            
            switch indexPath.section {
            case 0:
                header.headerLabel.font = .systemFont(ofSize: 24, weight: .bold)
            case 1:
                header.headerLabel.font = .systemFont(ofSize: 22, weight: .semibold)
            case 2:
                header.headerLabel.font = .systemFont(ofSize: 20, weight: .medium)
            default:
                break
            }

            if indexPath.section == 2 {
                header.button.isHidden = false
                header.button.setTitle("See More", for: .normal)
                header.button.tag = indexPath.section
                header.button.addTarget(self, action: #selector(seeMoreTapped(_:)), for: .touchUpInside)
                header.button.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    header.button.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -10)
                ])
            } else {
                header.button.isHidden = true
            }
            
            return header
        }
        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegate
extension MainHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
