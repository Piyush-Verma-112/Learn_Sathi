//
//  PoPUpView.swift
//  LearnSathi
//
//  Created by Batch - 1 on 16/01/25.
//

import UIKit

class SchedulePopUpView: UIView {


        private let tutorLogoImageView = UIImageView()
        private let tutorNameLabel = UILabel()
        private let durationLabel = UILabel()
        private let subjectLogoImageView = UIImageView()
        private let subjectNameLabel = UILabel()
        private let startTimeLabel = UILabel()
        private let endTimeLabel = UILabel()
        private let topicDescriptionLabel = UILabel()
        private let lessonNumberLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupUI()
        }
        
        private func setupUI() {
            self.backgroundColor = .white
            self.layer.cornerRadius = 10
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            
            // Configure UI elements
            configureLabels()
            configureImageViews()
            
            // Add and layout subviews
            let stackView = UIStackView(arrangedSubviews: [
                tutorLogoImageView,
                tutorNameLabel,
                durationLabel,
                subjectLogoImageView,
                subjectNameLabel,
                startTimeLabel,
                endTimeLabel,
                topicDescriptionLabel,
                lessonNumberLabel
            ])
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.alignment = .center
            stackView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(stackView)
            
            // Constraints for stack view
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
            ])
        }
        
        private func configureLabels() {
            tutorNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            durationLabel.font = UIFont.systemFont(ofSize: 16)
            subjectNameLabel.font = UIFont.systemFont(ofSize: 16)
            startTimeLabel.font = UIFont.systemFont(ofSize: 14)
            endTimeLabel.font = UIFont.systemFont(ofSize: 14)
            topicDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
            topicDescriptionLabel.numberOfLines = 0
            lessonNumberLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        }
        
        private func configureImageViews() {
            tutorLogoImageView.contentMode = .scaleAspectFit
            tutorLogoImageView.layer.cornerRadius = 25
            tutorLogoImageView.clipsToBounds = true
            tutorLogoImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            tutorLogoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            subjectLogoImageView.contentMode = .scaleAspectFit
            subjectLogoImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            subjectLogoImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
    func configure(with schedule: Schedule) {
        tutorLogoImageView.image = UIImage(named: schedule.tutorLogo)
        tutorNameLabel.text = schedule.tutorName
        durationLabel.text = "Duration: \(schedule.duration)"
        subjectLogoImageView.image = UIImage(named: schedule.subjectLogo)
        subjectNameLabel.text = "Subject: \(schedule.subjectName)"
        startTimeLabel.text = "Start Time: \(schedule.startTime)"
        endTimeLabel.text = "End Time: \(schedule.endTime)"
        topicDescriptionLabel.text = "Topics: \(schedule.topicDescription.joined(separator: ", "))"
        lessonNumberLabel.text = "Lesson \(schedule.lessonNumber)"
    }

}
