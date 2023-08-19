//
//  CurrencyConverterViewModel.swift
//  Currency
//
//  Created by Ahmed Mahrous on 19/08/2023.
//

import Foundation
import Moya

class CurrencyConverterViewModel {
    
    //MARK: Properties
    
    private let provider = MoyaProvider<NetworkManager>(session: SSLPinningSessionManager.shared)
    private(set) var convertedCurrency: Observable<Converter> = Observable(nil)
    private(set) var isLoading: Observable<Bool> = Observable(false)
    
/*===================================================================*/
    //MARK: - LifeCycle
    init() {
        
    }
    
/*===================================================================*/
    //MARK: - Intents
    
    // Convert amount of a Currency to another one
    func convertCurrency(from: String, to: String, amount: String) {
        
        ///check if we already have the data just return and didn't make the request again
        if isLoading.value ?? false {
            return
        }
        // Set loading state to true
        isLoading.value = true
        
        /// Make the request to Convert the currency
        provider.request(.convertCurrency(to, from, amount), callbackQueue: .main) { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
        
            switch result {
            case .success(let response):
                self.mapConvertedCurrencyResponse(response)
            case .failure(let error):
                print("Convert Currency Error:", error.localizedDescription)
            }
        }
    }
    
/*======================================================*/
    //MARK: - Support Functions
    
    private func mapConvertedCurrencyResponse(_ response: Response) {
        do {
            let convertedCurrencyResponse = try response.map(Converter.self)
            convertedCurrency.value = convertedCurrencyResponse
        } catch {
            print("Mapping Error:", error)
        }
    }
    
}


