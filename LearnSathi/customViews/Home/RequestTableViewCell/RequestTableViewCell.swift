//
//  RequestTableViewCell.swift
//  LearnSathi
//
//  Created by Batch - 2 on 16/01/25.
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    
    static let identifier = "RequestTableViewCell"
    
    @IBOutlet var tutorProfileImageView: UIImageView!
    @IBOutlet var tutorNameLbl: UILabel!
    
    func setup(request: Request) {
        tutorProfileImageView.image = request.tutorImage
        tutorNameLbl.text = request.tutorName
    }
    
}
