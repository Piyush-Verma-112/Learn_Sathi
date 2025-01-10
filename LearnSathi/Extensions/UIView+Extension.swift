//
//  UIView+Extension.swift
//  ProjectX
//
//  Created by Shahma Ansari on 06/01/25.
//

import UIKit

extension UIView {
    @IBInspectable var cornarRadius: CGFloat {
        get{ return cornarRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
