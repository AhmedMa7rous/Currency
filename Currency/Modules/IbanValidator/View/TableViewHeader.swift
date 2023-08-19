//
//  TableViewHeader.swift
//  Currency
//
//  Created by Ahmed Mahrous on 18/08/2023.
//

import UIKit

class TableViewHeader: UIView {

/*=============================================*/
    //MARK: - Properties
    var currencyConverterButton: UIButton = {
        // Create a UIButton for the custom UIBarButtonItem
        let currencyConverterButton = UIButton(type: .system)
        currencyConverterButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        currencyConverterButton.setTitle("Currency Converter", for: .normal)
        currencyConverterButton.setTitleColor(.white, for: .normal)
        return currencyConverterButton
    }()
  
/*============================================*/
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(currencyConverterButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
/*============================================*/
    //MARK: - Support Functions
    
    ///This function responsible for every thing related with UI
    private func updateUi() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            Utilities.styleFilledButton(currencyConverterButton)
            // Set up constraints
            self.currencyConverterButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.currencyConverterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                self.currencyConverterButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                self.currencyConverterButton.widthAnchor.constraint(equalToConstant: self.frame.size.width - 80),
                self.currencyConverterButton.heightAnchor.constraint(equalToConstant: self.frame.size.height)
            ])
        }
        
    }
/*============================================*/
    //MARK: - Action Functions
    
}
