//
//  Currencies.swift
//  Currency
//
//  Created by Ahmed Mahrous on 18/08/2023.
//

import Foundation

// MARK: - Currencies
struct Currencies: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}

