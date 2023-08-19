//
//  UIView+Extension.swift
//  Currency
//
//  Created by Ahmed Mahrous on 17/08/2023.
//

import UIKit

extension UIView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}
