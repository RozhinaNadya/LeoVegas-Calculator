//
//  ErrorAlerts.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-27.
//

import SwiftUI

enum ResponseError: LocalizedError {
    case decodeBitcoinPriceError
    
    var errorDescription: String? {
        switch self {
        case .decodeBitcoinPriceError:
            return "The bitcoin price is not found"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .decodeBitcoinPriceError:
            return "Something unexpectable"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .decodeBitcoinPriceError:
            return "Please try again"
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
            return "Calculation is impossible"
        case .noOperations:
            return "Sorry, this is impossible"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .defaultCalculationError:
            return "Something unexpectable"
        case .zeroDivisionError:
            return "It looks like you want to divide by zero..."
        case .noOperations:
            return "It looks like you removed all actions"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .defaultCalculationError:
            return "Please check your calculations and try again"
        case .zeroDivisionError:
            return "Please change 0 to another number and try again"
        case .noOperations:
            return "Please choose at least one operation"
        }
    }
}
