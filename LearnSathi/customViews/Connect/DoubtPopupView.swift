//
//  DoubtPopupView.swift
//  LearnSathi
//
//  Created by Batch - 2 on 24/01/25.
//

import UIKit

class DoubtPopupView: UIView {
    private let subjectNameLabel = UILabel()
    private let lessonNameLabel = UILabel()
    private let questionLabel = UILabel()
    private let solutionLabel = UILabel()
    private let solutionImageView = UIImageView()
    private let closeButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 10

        // Add and configure labels and image view
        subjectNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        lessonNameLabel.font = .systemFont(ofSize: 16)
        questionLabel.font = .systemFont(ofSize: 14, weight: .medium)
        solutionLabel.font = .systemFont(ofSize: 14)
        solutionLabel.textColor = .darkGray
        solutionImageView.contentMode = .scaleAspectFit

        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.systemBlue, for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [
            subjectNameLabel,
            lessonNameLabel,
            questionLabel,
            solutionLabel,
            solutionImageView,
            closeButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        // Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            solutionImageView.heightAnchor.constraint(equalToConstant: 150), // Adjust as needed
        ])
    }

    func configure(with subject: DoubtsListTableViewController.Subject) {
        subjectNameLabel.text = subject.subjectName
        lessonNameLabel.text = "Lesson: \(subject.lessonName)"
        questionLabel.text = "Q: \(subject.question)"
        solutionLabel.text = "A: \(subject.solution)"
        if let imageName = subject.solutionImage {
            solutionImageView.image = UIImage(named: imageName)
            solutionImageView.isHidden = false
        } else {
            solutionImageView.isHidden = true
        }
    }

    @objc private func closeTapped() {
        self.removeFromSuperview()
    }
}

