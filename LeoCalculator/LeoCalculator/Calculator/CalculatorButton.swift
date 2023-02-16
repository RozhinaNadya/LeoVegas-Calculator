//
//  CalculatorButton.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import Foundation
import SwiftUI

enum CalculatorButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case addition = "+"
    case subtraction = "-"
    case multiplication = "x"
    case division = "÷"
    case decimal = "."
    case sin = "sin"
    case cos = "cos"
    case equal = "="
    case clear = "AC"
    case negative = "-/+"
    case percent = "%"

    var buttonColor: Color {
        switch self {
        case .addition, .division, .multiplication, .percent, .clear, .sin, .cos:
            return .orange
        case .equal:
            return .green
        default:
            return .gray
        }
    }

    var value: String {
        rawValue
    }
}
