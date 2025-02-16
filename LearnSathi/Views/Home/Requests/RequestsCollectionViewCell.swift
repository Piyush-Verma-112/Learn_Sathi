//
//  RequestsCollectionViewCell.swift
//  LearnSathi
//
//  Created by Akhlak iSDP on 16/02/25.
//

import UIKit

class RequestsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: RequestsCollectionViewCell.self)
    
    @IBOutlet var tutorName: UILabel!
    
    @IBOutlet var requestStatus: UILabel!
    
    @IBOutlet var profile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with request: Request) {
        profile.image = UIImage(named: "profileImage")
        tutorName.text = request.tutorName
        requestStatus?.text = request.requestStatus
        
    }

}
