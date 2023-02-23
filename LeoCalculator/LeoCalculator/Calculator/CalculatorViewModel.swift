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
    @Published var operationBeforeDecimal: Operation = .none
    @Published var isNextNumber: Bool = true
    @Published var runningNumber = 0.0

    var isDecimalActive = false

    func didTapNumber(button: CalculatorButton) {
        switch button {
        case .decimal:
            operationBeforeDecimal = currentOperation
            currentOperation = .decimal
            isDecimalActive = true
            let number = button.value
            calculatorValue = "\(calculatorValue)\(number)"
            isNextNumber = false

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
            }
            isNextNumber = true

        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero :
            let number = button.value

            if isNextNumber || calculatorValue == CalculatorButton.zero.value {
                calculatorValue = number
            } else {
                calculatorValue = "\(calculatorValue)\(number)"
            }
            
            isNextNumber = false

        case .clear:
            calculatorValue = CalculatorButton.zero.value
            isDecimalActive = false
            isNextNumber = true
        }
    }

    private func doOperation(currentValue: Double, runningValue: Double) {
        var value = 0.0
        if currentOperation == .decimal {
            currentOperation = operationBeforeDecimal
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
        calculatorValue = isDecimalActive ? String(value) : String(describing: Int(value))
    }
}
