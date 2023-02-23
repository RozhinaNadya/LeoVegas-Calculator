//
//  CalculatorView.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import SwiftUI

struct CalculatorView: View {
    
    @StateObject var viewModel = CalculatorViewModel()
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            
            HStack {
                Spacer()
                Text(viewModel.calculatorValue)
                    .font(.system(size: 50))
            }
            
            CalculatorRow(
                row: viewModel.upperCalculatorButtons,
                isUpperButton: true
            )
            
            HStack {
                VStack {
                    HStack {
                        CalculatorRow(row: viewModel.topButtons)
                    }
                    
                    ForEach(viewModel.coreButtons, id: \.self) { coreRow in
                        HStack {
                            CalculatorRow(row: coreRow)
                        }
                    }
                }
                
                VStack {
                    CalculatorRow(row: viewModel.rightButtons)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    func CalculatorRow(row: [CalculatorButtonModel], isUpperButton: Bool = false) -> some View {
        ForEach(row, id: \.self) { buttonItem in
            CustomCalculatorButton(
                buttonText: buttonItem.value,
                buttonHeight: viewModel.buttonHeight(button: buttonItem),
                buttonColor: buttonItem.buttonColor,
                isUpperButton: isUpperButton,
                action: {
                    viewModel.didTapNumber(button: buttonItem)
                }
            )
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
