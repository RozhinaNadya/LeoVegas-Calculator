//
//  BitcoinManager.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-23.
//

import Foundation
import Combine

protocol IBitcoinManager {
    func getBitcoinUsdPrice() -> AnyPublisher<BitcoinUsdModel, Error>
}

class BitcoinManager: IBitcoinManager {
    static let shared = BitcoinManager()

    private init() { }
    func getBitcoinUsdPrice() -> AnyPublisher<BitcoinUsdModel, Error> {
        guard let url = URL(string: .BitcoinCurrentPriceUrl) else { fatalError("Someting wrong with URL") }

        var urlRequest = URLRequest(url: url)

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap {
                try self.decodeBitcoinUsdJson(response: $0.response, data: $0.data)
            }
            .eraseToAnyPublisher()
    }
    
    private func decodeBitcoinUsdJson(response: URLResponse, data: Data?) throws -> BitcoinUsdModel {
        guard let data else { throw ResponseError.decodeSectionsTitlesError }

        let decodedBitcoinCurrentPrice = try JSONDecoder().decode(BitcoinUsdModel.self, from: data)
        return decodedBitcoinCurrentPrice
    }
}

enum ResponseError: Error {
    case decodeSectionsTitlesError
}

private extension String {
    static let BitcoinCurrentPriceUrl = "https://api.coindesk.com/v1/bpi/currentprice.json"
}
