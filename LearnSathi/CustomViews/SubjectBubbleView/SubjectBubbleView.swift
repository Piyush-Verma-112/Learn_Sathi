//
//  SubjectBubbleView.swift
//  LearnSathi
//
//  Created by Batch - 2 on 23/01/25.
//

import Foundation
import UIKit

class SubjectBubbleView: UIView {
    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .blue
        layer.cornerRadius = 12
        addSubview(subjectLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let labelSize = subjectLabel.sizeThatFits(bounds.size)
        subjectLabel.frame = CGRect(
            x: 16,
            y: (bounds.height - labelSize.height) / 2,
            width: labelSize.width + 16,
            height: labelSize.height
        )
        bounds = CGRect(
            x: frame.origin.x,
            y: frame.origin.y,
            width: labelSize.width + 32,
            height: bounds.height
        )
    }

    func setSubject(_ text: String) {
        subjectLabel.text = text
    }
}
