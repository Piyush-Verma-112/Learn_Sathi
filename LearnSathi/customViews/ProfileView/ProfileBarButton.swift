//
//  ProfileBarButton.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 28/01/25.
//

import Foundation
import UIKit

class ProfileBarButton: UIBarButtonItem {

    override init() {
        super.init()
        setupCustomButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCustomButton()
    }

    private func setupCustomButton() {
        let customButton = UIButton(type: .custom)
        customButton.setImage(UIImage(named: "profileImage"), for: .normal) // Set your image
        customButton.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        customButton.layer.cornerRadius = 20// Half of the width/height for circular shape
        customButton.clipsToBounds = true // Ensure the image stays within the bounds

        // Create a container view for the button to manage size
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(customButton)

        // Add constraints to center the button in the container view
        NSLayoutConstraint.activate([
            customButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            customButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            customButton.widthAnchor.constraint(equalToConstant: 40),
            customButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        self.customView = containerView // Set the container view as the custom view
    }
}
