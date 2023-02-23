//
//  CalculatorViewModel.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import Foundation
import Combine

enum Operation {
    case addition, subtraction, multiplication, division, decimal
    case sin, cos, bitcoin
    case none
}

class CalculatorViewModel: ObservableObject {
    @Published var bitcoinUsdModel: BitcoinUsdModel?

    @Published var calculatorValue = CalculatorButton.zero.value
    @Published var currentOperation: Operation = .none
    @Published var operationBeforeDecimal: Operation = .none
    @Published var runningNumber = 0.0

    var isDecimalActive = false
    var isNextNumber = true
    
    private var cancellable: AnyCancellable?

    func didTapNumber(button: CalculatorButton) {
        switch button {
        case .decimal:
            operationBeforeDecimal = currentOperation
            currentOperation = .decimal
            isDecimalActive = true
            let number = button.value
            calculatorValue = "\(calculatorValue)\(number)"
            isNextNumber = false

        case .addition, .subtraction, .multiplication, .division, .sin, .cos, .negative, .bitcoin, .equal:
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
            } else if button == .bitcoin {
                getBitcoinUsdPrice()
                currentOperation = .bitcoin
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
            value = sin(currentValue * Double.pi / 180)
            isDecimalActive = true

        case .cos:
            value = cos(currentValue * Double.pi / 180)
            isDecimalActive = true
            
        case .bitcoin:
            guard let bitcoinUsdPrice = bitcoinUsdModel?.bpi.usd.rateFloat else {
                return
            }
            value = currentValue * bitcoinUsdPrice
            isDecimalActive = true

        default:
            break
        }
        
        calculatorValue = isDecimalActive ? String(format: "%.2f", value) : String(describing: Int(value))
    }
    
    func getBitcoinUsdPrice() {
        self.cancellable = BitcoinManager.shared.getBitcoinUsdPrice()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: {
                self.bitcoinUsdModel = $0
            })
    }
}
