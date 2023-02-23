//
//  BitcoinUsdModel.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-23.
//

import Foundation

struct BitcoinUsdModel: Decodable {
    var bpi: Bpi
    
    struct Bpi: Decodable {
        var usd: Usd
        
        struct Usd: Decodable {
            var rateFloat: Double
            
            enum CodingKeys: String, CodingKey{
                case rateFloat = "rate_float"
            }
        }
    }
}
