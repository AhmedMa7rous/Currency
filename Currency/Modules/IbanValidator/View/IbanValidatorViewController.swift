//
//  IbanValidatorViewController.swift
//  Currency
//
//  Created by Ahmed Mahrous on 15/08/2023.
//

import UIKit

class IbanValidatorViewController: UIViewController {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var ibanTextField: UITextField!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var ibanStackView: UIStackView!
    
/*=================================================*/
    //MARK: - Properties
    
    var isStackViewAtTop = false
    var currenciesTableView: UITableView!
    
    //change data with your dataSource and bind it to the table view
    let data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
/*=================================================*/
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
    }
    
/*========================================================*/
    //MARK: - ViewLayout
        
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpTextFields()
        setUpButtons()
    }

/*================================================*/
    //MARK: - Action Connections
    
    @IBAction func validateButtonTapped(_ sender: UIButton) {

        //get iban from the textField
        guard let iban = ibanTextField.text else { return }
        
        startValidatorAnimation()
        showCurrenciesTableViewWithAnimation()
    
    }
    
    @objc func currencyConverterButtonTapped() {
        // Handle button tap
        print("Currency Converter")
    }
    
/*================================================*/
    //MARK: - Support Functions
    
    //This function responsible for everything related with UI
    private func updateUi() {
        setUpNavigationBar()
        setUpButtons()
        setUpTextFields()
        setUpTableView()
    }
    
    ///This is a support function (support updateUi function) to set up navigation bar UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.label
        navigationItem.title = "Iban Validator"
    }
    
    ///This is a support function (support updateUi function) to set up  Buttons UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpButtons() {
        Utilities.styleFilledButton(validateButton)
    }
    
    ///This is a support function (support updateUi function) to set up  TextFields UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpTextFields() {
        Utilities.styleTextField(ibanTextField)
    }
    
    ///This is a support function (support updateUi function) to set up  TableView UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpTableView() {
        // Create the UITableView instance
        currenciesTableView = UITableView()
        let headerView = TableViewHeader(frame: CGRect(x: 0, y: 0, width: validateButton.frame.size.width, height: validateButton.frame.size.height))
        currenciesTableView.tableHeaderView = headerView
        headerView.currencyConverterButton.addTarget(self, action: #selector(currencyConverterButtonTapped), for: .touchUpInside)
        currenciesTableView.separatorStyle = .none
        currenciesTableView.allowsSelection = false
        currenciesTableView.dataSource = self
        currenciesTableView.delegate = self
        currenciesTableView.register(CurrencyTableViewCell.nib, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        currenciesTableView.isHidden = true
        view.addSubview(currenciesTableView)
        setTableViewConstraints()
    }
    
    ///This is a support function to set contstraint for TableView
    private func setTableViewConstraints() {
        // Set up constraints
        currenciesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currenciesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ibanStackView.frame.size.height + 20),
            currenciesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currenciesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currenciesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    ///This support function will move stack view to the top to show details about this iban and change textField interaction or move it back again  to the center when we need to check validation of another iban and change textField interaction again
    private func startValidatorAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Toggle the state of the StackView (center or top)
            if self.isStackViewAtTop {
                // Move the StackView to the center
                UIView.animate(withDuration: 0.3) {
                    self.ibanStackView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
                    self.ibanTextField.isUserInteractionEnabled = true
                    self.ibanTextField.textAlignment = .left
                    self.currenciesTableView.isHidden = true
                }
            } else {
                // Move the StackView to the top
                UIView.animate(withDuration: 0.3) {
                    self.ibanStackView.center = CGPoint(x: self.view.center.x, y: self.ibanStackView.frame.height / 2 + self.view.safeAreaInsets.top)
                    self.ibanTextField.isUserInteractionEnabled = false
                    self.ibanTextField.textAlignment = .center
                }
            }
            
            // Toggle the state
            self.isStackViewAtTop.toggle()
        }
    }
    
    ///This support function will show and hide Currencies tableview with animation
    private func showCurrenciesTableViewWithAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            // Toggle the state of the StackView (center or top)
            if self.isStackViewAtTop {
                // Move the StackView to the center
                UIView.animate(withDuration: 0.3) {
                    self.currenciesTableView.isHidden = false
                }
            }
        }
    }
}
/*==================================================*/
    //MARK: - TableView Functions
extension IbanValidatorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = currenciesTableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as? CurrencyTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: (data[indexPath.row], data[indexPath.row]))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Currencies rates from KWD"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
