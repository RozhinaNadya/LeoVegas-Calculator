//
//  CalculatorViewModel.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import Foundation

enum Operation {
    case addition, subtraction, multiplication, division
    case sin, cos
    case none
}

class CalculatorViewModel: ObservableObject {

    @Published var calculatorValue = CalculatorButton.zero.value
    @Published var runningNumber = 0

    @Published var currentOperation: Operation = .none

    func didTapNumber(button: CalculatorButton) {
        switch button {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .decimal :
            let number = button.value
            if calculatorValue == CalculatorButton.zero.value || currentOperation != .none {
                calculatorValue = number
            } else {
                calculatorValue = "\(calculatorValue)\(number)"
            }

        case .addition, .subtraction, .multiplication, .division, .sin, .cos, .negative, .equal:
            if button == .negative {
                runningNumber = -(Int(calculatorValue) ?? 0)
            } else if button != .equal {
                runningNumber = Int(calculatorValue) ?? 0
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
                let currentValue = Int(calculatorValue) ?? 0
                doOperation(operation: currentOperation, currentValue: runningNumber, runningValue: currentValue)
                currentOperation = .none
            }

        case .clear:
            calculatorValue = CalculatorButton.zero.value
        }
    }

    func doOperation(operation: Operation, currentValue: Int, runningValue: Int) {
        switch operation {
        case .addition:
            calculatorValue = "\(currentValue + runningValue)"
        case .subtraction:
            calculatorValue = "\(currentValue - runningValue)"
        case .multiplication:
            calculatorValue = "\(currentValue * runningValue)"
        case .division:
            calculatorValue = "\(currentValue / runningValue)"
        case .sin:
            calculatorValue = "\(sin(Double(currentValue) * (Double.pi / 180)))"
        case .cos:
            calculatorValue = "\(cos(Double(currentValue) * (Double.pi / 180)))"
        default:
            break
        }
    }
}
