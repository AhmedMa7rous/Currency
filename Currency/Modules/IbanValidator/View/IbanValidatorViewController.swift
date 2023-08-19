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
    private var viewModel = IbanValidatorViewModel()
    private var dataSource = [String: Double]()
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
        if isStackViewAtTop {
            startValidatorAnimation()
            showCurrenciesTableViewWithAnimation()
        } else {
            //get iban from the textField
            guard let iban = ibanTextField.text else { return }
            viewModel.validateIbanAndFetchCurrencies(for: iban) { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                        print("Success")
                        self?.bindTableView()
                        self?.startValidatorAnimation()
                        self?.showCurrenciesTableViewWithAnimation()
                    } else {
                        self?.showCustomAlert()
                    }
                }
            }
            
        }
    }
    
    @objc func currencyConverterButtonTapped() {
        let vc = CurrencyConverterViewController()
        navigationController?.pushViewController(vc, animated: true)
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
    
/*=========================================================*/
    //MARK: - Service Functions
    
    //Show Alert when iban is uncorrect or network Connection error
    func showCustomAlert() {
        AlertManager.shared.showAlert(
            title: "Invalid IBAN number",
            message: "Please enter a valid IBAN number.",
            viewController: self,
            completion: nil
        )
    }
    
    //Bind tableView DataSource
    func bindTableView() {
        viewModel.tableDataSource.bind { [weak self] currencies in
            DispatchQueue.main.async {
                guard let currencies = currencies else { return }
                self?.dataSource = currencies.rates
                self?.currenciesTableView.reloadData()
            }
        }
    }
}
/*==================================================*/
    //MARK: - TableView Functions
extension IbanValidatorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = currenciesTableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as? CurrencyTableViewCell else { return UITableViewCell() }
        let sortedDataSource = dataSource.sorted { $0.key < $1.key }
        let (name, value) = sortedDataSource[indexPath.row]
        cell.configure(with: name, rate: value)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Currencies rates from KWD"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

