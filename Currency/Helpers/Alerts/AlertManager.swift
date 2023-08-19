//
//  AlertManager.swift
//  Currency
//
//  Created by Ahmed Mahrous on 19/08/2023.
//

import UIKit

class AlertManager {
    
    //MARK: - Properties
    
    static let shared = AlertManager()
        
/*================================================*/
    //MARK: - LifeCycle
    
    private init() {}
        
    
/*===============================================*/
    //MARK: - Services Functions
    
    func showAlert(title: String?, message: String?, viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
