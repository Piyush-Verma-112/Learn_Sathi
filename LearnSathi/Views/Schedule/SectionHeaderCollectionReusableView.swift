//
//  SectionHeaderCollectionReusableView.swift
//  GDPCompositionalLayout
//
//  Created by Batch - 1 on 08/01/25.
//

import UIKit

class SectionHeaderCollectionReusableView: UICollectionReusableView {
    var headerLabel = UILabel()
    var button = UIButton(type: .system)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateSectionHeader()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        updateSectionHeader()
    }
    
    
    func updateSectionHeader() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(headerLabel)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 300),
            button.trailingAnchor.constraint(equalTo: trailingAnchor)
            
            
        ])
       
    }
    
}
