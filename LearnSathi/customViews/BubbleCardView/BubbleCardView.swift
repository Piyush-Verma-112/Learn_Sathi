//
//  CardView.swift
//  LearnSathi
//
//  Created by Shahma Ansari on 14/01/25.
//

import UIKit

class BubbleCardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
        cornarRadius = 12

    }
}

class ButtonStyle: UIButton {
    
}
