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
    private var viewModel =  CurrencyConverterViewModel()
    var fromCurrency: String
    var toCurrency: String
    var currencies: [String]
    
/*=================================================*/
    //MARK: - LifeCycle
    init(currencies: [String]) {
        self.currencies = currencies
        fromCurrency = currencies[0]
        toCurrency = currencies[1]
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        bindOutputTextField()
    }
    
/*========================================================*/
    //MARK: - ViewLayout
            
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpTextFields()
    }
    
/*================================================*/
    //MARK: - Action Connections
    

    
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
    private func convertCurrency() {
        guard let inputValue = inputTextField.text, !inputValue.isEmpty else {
            outputTextField.text = ""
            return
        }
        
        // Perform conversion
        viewModel.convertCurrency(from: fromCurrency, to: toCurrency, amount: inputValue)
    }
    
    //Bind outputTextField with result
    private func bindOutputTextField() {
        viewModel.convertedCurrency.bind { [weak self] result in
            guard let result = result else { return }
            DispatchQueue.main.async {
                print(result.success)
                self?.outputTextField.text = String(format: "%.2f", result.result)
            }
        }
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
            if textField == self.inputTextField {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
                    self?.convertCurrency()
                }
            }
        
        return true
    }
}
