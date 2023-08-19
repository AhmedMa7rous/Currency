//
//  Validator.swift
//  Currency
//
//  Created by Ahmed Mahrous on 18/08/2023.
//

import Foundation

// MARK: - Validator
struct Validator: Codable {
    let valid: Bool
    let message, iban: String
   

    enum CodingKeys: String, CodingKey {
        case valid, message, iban
        
    }
}


