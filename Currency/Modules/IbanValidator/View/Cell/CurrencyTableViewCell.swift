//
//  CurrencyTableViewCell.swift
//  Currency
//
//  Created by Ahmed Mahrous on 15/08/2023.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var currencySymbolLabel: UILabel!
    @IBOutlet weak var currencyRateLabel: UILabel!
/*===========================================*/
    //MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUi()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
    }
    
/*=============================================*/
    //MARK: - Support Functions
    
    ///This function responsible for every thing related with UI
    func updateUi() {
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1).cgColor
        self.contentView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)
        self.contentView.layer.shadowRadius = 10
        self.contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.contentView.layer.shadowOpacity = 1
        self.layer.masksToBounds = true
    }
    
    ///This function responsible for set the data to cell components
    func configure(with name: String, rate: Double) {
        currencySymbolLabel.text = name
        currencyRateLabel.text = String(format: "%.3f", rate)
    }
}
