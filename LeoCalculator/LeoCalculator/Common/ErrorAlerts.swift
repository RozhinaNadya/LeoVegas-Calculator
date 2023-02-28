//
//  ErrorAlerts.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-27.
//

import SwiftUI

private typealias myString = L10n.ErrorsText

enum ResponseError: LocalizedError {
    case decodeBitcoinPriceError
    
    var errorDescription: String? {
        switch self {
        case .decodeBitcoinPriceError:
            return myString.Description.decodeBitcoinPrice
        }
    }
    
    var failureReason: String? {
        switch self {
        case .decodeBitcoinPriceError:
            return myString.FailureReason.reasonDefault
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .decodeBitcoinPriceError:
            return myString.RecoverySuggestion.suggestionDefault
        }
    }
}

enum CalculationError: LocalizedError {
    case defaultCalculationError
    case zeroDivisionError
    case noOperations
    
    var errorDescription: String? {
        switch self {
        case .defaultCalculationError, .zeroDivisionError:
            return myString.Description.impossibleCalculation
        case .noOperations:
            return myString.Description.noOperations
        }
    }
    
    var failureReason: String? {
        switch self {
        case .defaultCalculationError:
            return myString.FailureReason.reasonDefault
        case .zeroDivisionError:
            return myString.FailureReason.zeroDivision
        case .noOperations:
            return myString.FailureReason.noOperations
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .defaultCalculationError:
            return myString.RecoverySuggestion.calculationDefault
        case .zeroDivisionError:
            return myString.RecoverySuggestion.zeroDivision
        case .noOperations:
            return myString.RecoverySuggestion.noOperations
        }
    }
}
