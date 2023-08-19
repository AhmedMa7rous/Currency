//
//  IbanValidatorViewModel.swift
//  Currency
//
//  Created by Ahmed Mahrous on 18/08/2023.
//

import Foundation
import Moya


class IbanValidatorViewModel {
    
    //MARK: Properties
    
    private let provider = MoyaProvider<NetworkManager>(session: SSLPinningSessionManager.shared)
    private(set) var ibanData: Observable<Validator> = Observable(nil)
    private(set) var tableDataSource: Observable<Currencies> = Observable(nil)
    private(set) var isLoading: Observable<Bool> = Observable(false)
    
/*===================================================================*/
    //MARK: - LifeCycle
    init() {
        
    }
    
/*===================================================================*/
    //MARK: - Intents
    
    // Combine IBAN validation and fetching currencies into a single function
    func validateIbanAndFetchCurrencies(for iban: String, completion: @escaping (Bool) -> Void) {
        
        ///check if we already have the data just return and didn't make the request again
        if isLoading.value ?? false {
            return
        }
        // Set loading state to true
        isLoading.value = true
        
        /// Make the request to validate IBAN
        provider.request(.ibanValidate(iban), callbackQueue: .main) { [weak self] result in
            guard let self = self else { return }
            // Set loading state to false
            self.isLoading.value = false
            
            switch result {
            case .success(let response):
                self.mapIbanResponse(response)
                
                if self.ibanData.value?.valid == true {
                    // If IBAN validation is successful, fetch currencies
                    self.provider.request(.currencies("KWD"), callbackQueue: .main) { [weak self] result in
                        guard let self = self else { return }
                        // Set loading state to false
                        self.isLoading.value = false
                        
                        switch result {
                        case .success(let response):
                            self.mapCurrenciesResponse(response)
                            completion(true)
                        case .failure(let error):
                            completion(false)
                            print("Currencies Fetch Error:", error.localizedDescription)
                        }
                    }
                } else {
                    // IBAN validation failed, complete with false
                    completion(false)
                }
                
            case .failure(let error):
                completion(false)
                print("IBAN Validation Error:", error.localizedDescription)
            }
        }
    }
    
/*======================================================*/
    //MARK: - Support Functions
    
    private func mapIbanResponse(_ response: Response) {
        do {
            let ibanValidationReponse = try response.map(Validator.self)
            if ibanValidationReponse.valid {
                ibanData.value = ibanValidationReponse
            }
        } catch {
            print("IBAN Mapping Error:", error.localizedDescription)
        }
    }
    
    private func mapCurrenciesResponse(_ response: Response) {
        do {
            let currenciesResponse = try response.map(Currencies.self)
            tableDataSource.value = currenciesResponse
        } catch {
            print("Currencies Mapping Error:", error.localizedDescription)
        }
    }
}
