//
//  Utilities.swift
//  Currency
//
//  Created by Ahmed Mahrous on 17/08/2023.
//

import UIKit


class Utilities {
    
    static func styleTextField(_ textField: UITextField) {
        DispatchQueue.main.async {
            // Create the bottom line
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 1)
            bottomLine.backgroundColor = UIColor(named: "ButtonBackground")?.cgColor
            
            // Remove border on textfield
            textField.borderStyle = .none
            
            // Add the bottomLine to the textfield
            textField.layer.addSublayer(bottomLine)
            
            // Change Placeholder Color
            if let placeholderText = textField.placeholder {
                let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor(named: "placeHolderColor") ?? UIColor.darkGray,
                ]
                textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
            }
        }
    }
    
    static func styleFilledButton(_ button: UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor(named: "ButtonBackground")
        button.layer.cornerRadius = 20
        button.tintColor = UIColor.white
    }
    
}
