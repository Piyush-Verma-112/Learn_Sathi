//
//  ClassListCollectionViewCell.swift
//  LearnSathi
//
//  Created by Shahma Ansari on 21/01/25.
//

import UIKit

class ClassListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var standardLbl: UILabel!
    @IBOutlet weak var cardView: CardView! 
        
    static let identifier: String = "ClassListCollectionViewCell"
        
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupInitialStyle()
    }
    
    private func setupViews() {
        // Ensure the label is in front of the cardView
        contentView.bringSubviewToFront(standardLbl)
    }
    
    private func setupInitialStyle() {
        // Clear any existing backgrounds
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        // Setup cardView style
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.systemGray5.cgColor
        cardView.clipsToBounds = true
        
        // Initial text color
        standardLbl.textColor = .black
    }
    
    private func updateAppearance() {
        UIView.animate(withDuration: 0.2) {
            if self.isSelected {
                self.cardView.backgroundColor = UIColor(named: "AccentColor")
                self.standardLbl.textColor = .white
                print("Cell selected, text color set to white")
            } else {
                self.cardView.backgroundColor = .white
                self.standardLbl.textColor = .black
                print("Cell deselected, text color set to black")
            }
        }
    }
    
    func setup(standard: String) {
        standardLbl.text = standard
        updateAppearance()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupInitialStyle()
    }
}
