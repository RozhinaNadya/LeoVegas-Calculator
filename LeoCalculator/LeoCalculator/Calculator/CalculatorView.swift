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
            ForEach(viewModel.getCalculatorButtons(), id: \.self) { coreRow in
                HStack {
                    CalculatorRow(row: coreRow)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    func CalculatorRow(row: [CalculatorButtonModel]) -> some View {
        ForEach(row, id: \.self) { buttonItem in
            CustomCalculatorButton(
                buttonText: buttonItem.value,
                buttonHeight: viewModel.buttonHeight(button: buttonItem),
                buttonColor: buttonItem.buttonColor,
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
