//
//  CurrencyConverterViewController.swift
//  Currency
//
//  Created by Ahmed Mahrous on 19/08/2023.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextField: UITextField!
    @IBOutlet weak var fromCurrencyPickerView: UIPickerView!
    @IBOutlet weak var toCurrencyPickerView: UIPickerView!
    
/*=================================================*/
    //MARK: - Properties
    var fromCurrency = "USD"
    var toCurrency = "EUR"
    var currencies = ["USD", "EUR", "JPY", "GBP", "AUD"]
    
/*=================================================*/
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
    }
    
    
/*================================================*/
    //MARK: - Action Connections
    
    // Action when input text field changes
    @IBAction func inputValueChanged(_ sender: UITextField) {
        convertCurrency(inputText: sender.text ?? "")
    }
    
/*================================================*/
    //MARK: - Support Functions
    
    //This function responsible for everything related with UI
    private func updateUi() {
        setUpNavigationBar()
        setUpPickerViews()
        setUpTextFields()
    }
    
    ///This is a support function (support updateUi function) to set up navigation bar UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.label
        navigationItem.title = "Currency Converter"
    }
    
    ///This is a support function (support updateUi function) to set up  PickerViews UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpPickerViews() {
        fromCurrencyPickerView.dataSource = self
        fromCurrencyPickerView.delegate = self
        toCurrencyPickerView.dataSource = self
        toCurrencyPickerView.delegate = self
    }
    
    ///This is a support function (support updateUi function) to set up  TextFields UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpTextFields() {
        inputTextField.delegate = self
        Utilities.styleTextField(inputTextField)
        Utilities.styleTextField(outputTextField)
    }
    
/*=========================================================*/
    //MARK: - Service Functions
    
    // Perform currency conversion
    func convertCurrency(inputText: String) {
        guard let inputValue = Double(inputText), !inputValue.isNaN else {
            outputTextField.text = ""
            return
        }
        
        // Perform conversion based on currency rates
        // You would fetch real-time rates from an API in a real app
        let conversionRate: Double = 1.2 // Example conversion rate
        
        let convertedValue = inputValue * conversionRate
        outputTextField.text = String(format: "%.2f", convertedValue)
    }
    
}

/*==================================================*/
    //MARK: - PickerView Functions
extension CurrencyConverterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // UIPickerViewDataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    // UIPickerViewDelegate method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fromCurrencyPickerView {
            fromCurrency = currencies[row]
        } else if pickerView == toCurrencyPickerView {
            toCurrency = currencies[row]
        }
    }
}
/*===================================================*/
    //MARK: - TextField Functions
extension CurrencyConverterViewController: UITextFieldDelegate {
    // UITextFieldDelegate method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == inputTextField {
            let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            convertCurrency(inputText: newText)
        }
        return true
    }
}
