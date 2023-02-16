//
//  CalculatorViewModel.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import Foundation

enum Operation {
    case addition, subtraction, multiplication, division, decimal
    case sin, cos
    case none
}

class CalculatorViewModel: ObservableObject {

    @Published var calculatorValue = CalculatorButton.zero.value
    @Published var currentOperation: Operation = .none
    @Published var perationBeforeDecimal: Operation = .none
    @Published var runningNumber = 0.0

    var isDecimalActive = false

    func didTapNumber(button: CalculatorButton) {
        switch button {
        case .decimal:
            perationBeforeDecimal = currentOperation
            currentOperation = .decimal
            isDecimalActive = true
            let number = button.value
            calculatorValue = "\(calculatorValue)\(number)"

        case .addition, .subtraction, .multiplication, .division, .sin, .cos, .negative, .equal:
            if button == .negative {
                runningNumber = -(Double(calculatorValue) ?? 0.00)
            } else if button != .equal {
                runningNumber = Double(calculatorValue) ?? 0.00
            }

            if button == .addition {
                currentOperation = .addition
            } else if button == .subtraction {
                currentOperation = .subtraction
            } else if button == .multiplication {
                currentOperation = .multiplication
            } else if button == .division {
                currentOperation = .division
            } else if button == .sin {
                currentOperation = .sin
            } else if button == .cos {
                currentOperation = .cos
            } else if button == .negative {
                calculatorValue = "\(runningNumber)"
            } else if button == .equal {
                let currentValue = Double(calculatorValue) ?? 0.0
                doOperation(currentValue: currentValue, runningValue: runningNumber)

                currentOperation = .none
                isDecimalActive = false
            }

        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero :
            let number = button.value
            if (calculatorValue == CalculatorButton.zero.value || currentOperation != .none) &&
                calculatorValue != CalculatorButton.decimal.value && currentOperation != .decimal {
                calculatorValue = number
            } else {
                calculatorValue = "\(calculatorValue)\(number)"
            }

        case .clear:
            calculatorValue = CalculatorButton.zero.value
            isDecimalActive = false
        }
    }

    private func doOperation(currentValue: Double, runningValue: Double) {
        var value = 0.0
        if currentOperation == .decimal {
            currentOperation = perationBeforeDecimal
        }
        switch currentOperation {
        case .addition:
            value = runningValue + currentValue
        case .subtraction:
            value = runningValue - currentValue
        case .multiplication:
            value = runningValue * currentValue
        case .division:
            value = runningValue / currentValue
        case .sin:
            value = sin(currentValue) * (Double.pi / 180)
        case .cos:
            value = cos(currentValue) * (Double.pi / 180)
        default:
            break
        }
        calculatorValue = isDecimalActive ? String(format: "%.2f", value) : String(describing: Int(value))
    }
}
