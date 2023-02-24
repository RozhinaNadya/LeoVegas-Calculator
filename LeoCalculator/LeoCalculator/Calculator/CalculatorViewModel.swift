//
//  CalculatorViewModel.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import Combine
import Foundation
import SwiftUI

enum Operation {
    case addition, subtraction, multiplication, division, decimal
    case sin, cos, bitcoin
    case none
}

struct FeatureList: Identifiable {
    var id: String
    var operation: Operation
    var isActive = true
}

class CalculatorViewModel: ObservableObject {
    @Published var bitcoinUsdModel: BitcoinUsdModel?

    @Published var calculatorValue = CalculatorButtonModel.zero.value
    @Published var currentOperation: Operation = .none
    @Published var operationBeforeDecimal: Operation = .none
    @Published var runningNumber = 0.0
    
    private var cancellable: AnyCancellable?
    internal var cancellables = Set<AnyCancellable>()

    var isDecimalActive = false
    var isNextNumber = true
    
    @Published var upperCalculatorButton : CalculatorButtonModel?
    @Published var topButtons: [CalculatorButtonModel] = [.clear]
    @Published var rightButtons: [CalculatorButtonModel] = [.equal]
    
    var coreButtons: [[CalculatorButtonModel]] = [
        [.seven, .eight, .nine],
        [.four, .five, .six],
        [.one, .two, .three],
        [.negative, .zero, .decimal]
    ]
    
    @Published var features = [
        FeatureList(id: "sin", operation: .sin),
        FeatureList(id: "cos", operation: .cos),
        FeatureList(id: "+", operation: .addition),
        FeatureList(id: "-", operation: .subtraction),
        FeatureList(id: "x", operation: .multiplication),
        FeatureList(id: "÷", operation: .division),
        FeatureList(id: "₿", operation: .bitcoin)
    ]
    
    init() {
        $features
            .receive(on: RunLoop.main)
            .sink { [unowned self] featureLits in
                featureLits.forEach { feature in
                    if !feature.isActive {
                        removeFeature(feature: feature)
                    } else {
                        addFeature(feature: feature)
                    }
                    
                    equalAndBitcoinButtonsFixPlace()
                }
            }
            .store(in: &cancellables)
    }

    func didTapNumber(button: CalculatorButtonModel) {
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

            if isNextNumber || calculatorValue == CalculatorButtonModel.zero.value {
                calculatorValue = number
            } else {
                calculatorValue = "\(calculatorValue)\(number)"
            }
            
            isNextNumber = false

        case .clear:
            calculatorValue = CalculatorButtonModel.zero.value
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
    
    private func removeFeature(feature: FeatureList) {
        guard let featureForRemove = CalculatorButtonModel(rawValue: feature.id) else { return }
        
        switch feature.operation {
        case .sin, .cos:
            if let topButtonIndex = topButtons.firstIndex(where: { $0 == featureForRemove}) {
                topButtons.remove(at: topButtonIndex)
                if !topButtons.contains(where: {$0 == .bitcoin}),
                   !rightButtons.contains(where: {$0 == .bitcoin}) {
                    topButtons.append(.bitcoin)
                }
            }
            
        case .division, .multiplication, .subtraction, .addition:
            if let rightButtonIndex = rightButtons.firstIndex(where: { $0 == featureForRemove}) {
                rightButtons.remove(at: rightButtonIndex)
                if !topButtons.contains(where: {$0 == .bitcoin}),
                   !rightButtons.contains(where: {$0 == .bitcoin}) {
                    rightButtons.append(.bitcoin)
                }
            }
            
        case .bitcoin:
            upperCalculatorButton = nil
            if let bitcoinIndex = topButtons.firstIndex(where: { $0 == .bitcoin}) {
                topButtons.remove(at: bitcoinIndex)
            } else if let bitcoinIndex = rightButtons.firstIndex(where: { $0 == .bitcoin}) {
                rightButtons.remove(at: bitcoinIndex)
            }
            
        default:
            break
        }
    }
    
    private func addFeature(feature: FeatureList) {
        guard let featureForAdd = CalculatorButtonModel(rawValue: feature.id) else { return }

        switch feature.operation {
        case .sin, .cos:
            if (topButtons.firstIndex(where: { $0 == featureForAdd}) == nil) {
                topButtons.append(featureForAdd)
            }
            
            if topButtons.count > 3,
               let bitcoinIndex = topButtons.firstIndex(where: { $0 == .bitcoin}) {
                topButtons.remove(at: bitcoinIndex)
                upperCalculatorButton = .bitcoin
            }
            
        case .division, .multiplication, .subtraction, .addition:
            if (rightButtons.firstIndex(where: { $0 == featureForAdd}) == nil) {
                rightButtons.append(featureForAdd)
            }
            
            if rightButtons.count >= 5,
               let bitcoinIndex = rightButtons.firstIndex(where: { $0 == .bitcoin}) {
                rightButtons.remove(at: bitcoinIndex)
                upperCalculatorButton = .bitcoin
            }
            
            guard let equalIndex = rightButtons.firstIndex(of: .equal) else { return }
            rightButtons.swapAt(equalIndex, rightButtons.count - 1)
            
        case .bitcoin:
            if rightButtons.count < 5 {
                rightButtons.append(.bitcoin)
            } else if !topButtons.contains(where: {$0 == .bitcoin}) {
                upperCalculatorButton = .bitcoin

            }
            
        default:
            break
        }
    }
    
    private func equalAndBitcoinButtonsFixPlace() {
        guard let equalIndex = rightButtons.firstIndex(of: .equal) else { return }

        rightButtons.swapAt(equalIndex, rightButtons.count - 1)
        
        if topButtons.contains(where: {$0 == .bitcoin}) ||
            rightButtons.contains(where: {$0 == .bitcoin}) {
            upperCalculatorButton = nil
        }
    }
}
