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
            
            ForEach(viewModel.getCalculatorButtons(), id: \.self) { row in
                HStack {
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
        }
        .padding(.horizontal, 16)
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
