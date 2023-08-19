//
//  Converter.swift
//  Currency
//
//  Created by Ahmed Mahrous on 19/08/2023.
//

import Foundation

// MARK: - Converter
struct Converter: Codable {
    let success: Bool
    let result: Double
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case success = "success"
    }
}

