//
//  subjectBubbleCollectionViewCell.swift
//  LearnSathi
//
//  Created by Shahma Ansari on 21/01/25.
//

import UIKit

protocol SubjectBubbleCellDelegate: AnyObject {
    func didTapRemoveButton(cell: SubjectBubbleCollectionViewCell)
}

class SubjectBubbleCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "SubjectBubbleCollectionViewCell"
    
    @IBOutlet weak var subjectNameLbl: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    weak var delegate: SubjectBubbleCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    func setup(subject: String) {
        subjectNameLbl.text = subject
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        print("Remove button is tapped")
        delegate?.didTapRemoveButton(cell: self)
    }
}
