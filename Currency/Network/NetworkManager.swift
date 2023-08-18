//
//  NetworkManager.swift
//  Currency
//
//  Created by Ahmed Mahrous on 15/08/2023.
//

import Foundation
//MARK: - You have to make pod install to get Moya and reopen the project
import Moya

public enum NetworkManager {
    case ibanValidate(String)
    case currencies(String)
    case convertCurrency(String, String, String)
}

extension NetworkManager: TargetType {
    public var baseURL: URL {
            return URL(string: "https://api.apilayer.com/")!
        }
    
    public var path: String {
        switch self {
        case .ibanValidate:
            return "bank_data/iban_validate"
        case .currencies:
            return "exchangerates_data/latest"
        case .convertCurrency:
            return "fixer/convert"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .ibanValidate:
            return .get
        case .currencies:
            return .get
        case .convertCurrency:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .ibanValidate(let iban):
            return .requestParameters(parameters: ["iban_number": iban], encoding: URLEncoding.default)
        case .currencies(let baseCurrency):
            return .requestParameters(parameters: ["base": baseCurrency], encoding: URLEncoding.default)
        case .convertCurrency(let to, let from, let amout):
            return .requestParameters(parameters: ["to": to, "from": from, "amout": amout], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["apiKey": "vSogQS1TCBrIZyHmXTG6eXio4615Sp7g"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
