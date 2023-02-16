//
//  CalculatorViewModel.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import Foundation

class CalculatorViewModel: ObservableObject {

    @Published var calculatorValue = "0"

    func didTapNumber(button: CalculatorButton) {
        switch button {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero :
            let number = button.value
            if calculatorValue == "0" {
                calculatorValue = number
            } else {
                calculatorValue = "\(calculatorValue)\(number)"
            }
        default:
            break
        }
    }
}
