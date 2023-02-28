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
    
    @Published private(set) var activeError: LocalizedError?

    @Published var calculatorValue = CalculatorButtonModel.zero.value
    @Published var currentOperation: Operation = .none
    @Published var previousOperation: Operation = .none
    @Published var runningNumber = 0.0
    
    @Published var upperCalculatorButton : CalculatorButtonModel?
    @Published var topButtons: [CalculatorButtonModel] = [.clear]
    @Published var rightButtons: [CalculatorButtonModel] = [.equal]
    
    @Published var isBackButtonHidden = false
    
    @Published var features = [
        FeatureList(id: CalculatorButtonModel.bitcoin.value, operation: .bitcoin),
        FeatureList(id: CalculatorButtonModel.sin.value, operation: .sin),
        FeatureList(id: CalculatorButtonModel.cos.value, operation: .cos),
        FeatureList(id: CalculatorButtonModel.division.value, operation: .division),
        FeatureList(id: CalculatorButtonModel.multiplication.value, operation: .multiplication),
        FeatureList(id: CalculatorButtonModel.subtraction.value, operation: .subtraction),
        FeatureList(id: CalculatorButtonModel.addition.value, operation: .addition)
    ]
    
    var coreButtons: [[CalculatorButtonModel]] = [
        [.seven, .eight, .nine],
        [.four, .five, .six],
        [.one, .two, .three],
        [.negative, .zero, .decimal]
    ]
    
    var isPresentingAlert: Binding<Bool> {
            return Binding<Bool>(get: {
                return self.activeError != nil
            }, set: { newValue in
                guard !newValue else { return }
                self.activeError = nil
            })
        }
    
    private var cancellables = Set<AnyCancellable>()

    var isDecimalActive = false
    var isNextNumber = true
    
    var isOperationsCountNotEnough: Bool {
        topButtons.count == 1 && rightButtons.count == 1
    }
    
    init() {
        getBitcoinUsdPrice()
        
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
    
    func getBitcoinUsdPrice() {
        BitcoinManager.shared.getBitcoinUsdPrice()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: {
                self.bitcoinUsdModel = $0
            }).store(in: &cancellables)
    }

    func didTapNumber(button: CalculatorButtonModel) {
        if previousOperation != .none, button != .equal {
            let currentValue = Double(calculatorValue) ?? 0.0
            doOperation(currentValue: currentValue, runningValue: runningNumber)
        }
        
        previousOperation = currentOperation
            
        switch button {
        case .decimal:
            currentOperation = .decimal
            isDecimalActive = true
            let number = button.value
            calculatorValue = "\(calculatorValue)\(number)"
            isNextNumber = false

        case .addition, .subtraction, .multiplication, .division, .sin, .cos, .negative, .bitcoin:
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
                doEqualOperation()
            } else if button == .cos {
                currentOperation = .cos
                doEqualOperation()
            } else if button == .negative {
                calculatorValue = "\(runningNumber)"
            } else if button == .bitcoin {
                getBitcoinUsdPrice()
                currentOperation = .bitcoin
                doEqualOperation()
            }
            
            isNextNumber = true
            
        case .equal:
            doEqualOperation()

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
            currentOperation = .none
            previousOperation = .none
            isDecimalActive = false
            isNextNumber = true
        }
    }
    
    private func doEqualOperation() {
        let currentValue = Double(calculatorValue) ?? 0.0
        doOperation(currentValue: currentValue, runningValue: runningNumber)
        currentOperation = .none
        previousOperation = .none
    }

    private func doOperation(currentValue: Double, runningValue: Double) {
        var value = 0.0
        if currentOperation == .decimal {
            currentOperation = previousOperation
        }
        switch currentOperation {
        case .addition:
            value = runningValue + currentValue
            
        case .subtraction:
            value = runningValue - currentValue
            
        case .multiplication:
            value = runningValue * currentValue
            
        case .division:
            if currentValue != 0 {
                value = runningValue / currentValue
            } else {
                activeError = CalculationError.zeroDivisionError
            }
            
        case .sin:
            value = sin(currentValue * Double.pi / 180)
            isDecimalActive = true

        case .cos:
            value = cos(currentValue * Double.pi / 180)
            isDecimalActive = true
            
        case .bitcoin:
            if let bitcoinUsdPrice = bitcoinUsdModel?.bpi.usd.rateFloat {
                value = currentValue * bitcoinUsdPrice
                isDecimalActive = true
            } else {
                activeError = ResponseError.decodeBitcoinPriceError
            }

        default:
            break
        }
        
        calculatorValue = isDecimalActive ? String(format: "%.2f", value) : String(describing: Int(value))
    }
    
    private func removeFeature(feature: FeatureList) {
        guard let featureForRemove = CalculatorButtonModel(rawValue: feature.id) else { return }
        
        switch feature.operation {
        case .sin, .cos:
            if let topButtonIndex = topButtons.firstIndex(where: { $0 == featureForRemove}) {
                topButtons.remove(at: topButtonIndex)
                if shouldAddBitcoin() {
                    topButtons.append(.bitcoin)
                }
            }
            
        case .division, .multiplication, .subtraction, .addition:
            if let rightButtonIndex = rightButtons.firstIndex(where: { $0 == featureForRemove}) {
                rightButtons.remove(at: rightButtonIndex)
                if shouldAddBitcoin() {
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
        
        if isOperationsCountNotEnough {
            activeError = CalculationError.noOperations
            isBackButtonHidden = true
        }
    }
    
    private func shouldAddBitcoin() -> Bool {
        !topButtons.contains(where: {$0 == .bitcoin}) &&
           !rightButtons.contains(where: {$0 == .bitcoin}) &&
           features.contains(where: {
               $0.operation == .bitcoin && $0.isActive == true
           })
    }
    
    private func addFeature(feature: FeatureList) {
        guard let featureForAdd = CalculatorButtonModel(rawValue: feature.id) else { return }
        
        switch feature.operation {
        case .sin, .cos:
            if (topButtons.firstIndex(where: { $0 == featureForAdd}) == nil) {
                topButtons.append(featureForAdd)
                activeError = nil
                isBackButtonHidden = false
            }
            
            if topButtons.count > 3,
               let bitcoinIndex = topButtons.firstIndex(where: { $0 == .bitcoin}) {
                topButtons.remove(at: bitcoinIndex)
                upperCalculatorButton = .bitcoin
            }
            
        case .division, .multiplication, .subtraction, .addition:
            if (rightButtons.firstIndex(where: { $0 == featureForAdd}) == nil) {
                rightButtons.append(featureForAdd)
                activeError = nil
                isBackButtonHidden = false
            }
            
            if rightButtons.count > 5,
               let bitcoinIndex = rightButtons.firstIndex(where: { $0 == .bitcoin}) {
                rightButtons.remove(at: bitcoinIndex)
                upperCalculatorButton = .bitcoin
            }
            
            guard let equalIndex = rightButtons.firstIndex(of: .equal) else { return }
            rightButtons.swapAt(equalIndex, rightButtons.count - 1)
            
        case .bitcoin:
            if rightButtons.count < 5,
               !rightButtons.contains(where: {$0 == .bitcoin}) {
                rightButtons.append(.bitcoin)
            } else if !topButtons.contains(where: {$0 == .bitcoin}) {
                upperCalculatorButton = .bitcoin
            }
            activeError = nil
            isBackButtonHidden = false
            
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
