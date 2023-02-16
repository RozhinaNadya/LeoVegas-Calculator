//
//  CalculatorView.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import SwiftUI

struct CalculatorView: View {

    @StateObject var viewModel = CalculatorViewModel()
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .percent, .sin, .cos],
        [.seven, .eight, .nine, .multiplication],
        [.four, .five, .six, .division],
        [.one, .two, .three, .addition],
        [.negative, .zero, .decimal, .equal]
    ]
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            
            HStack {
                Spacer()
                Text(viewModel.calculatorValue)
                    .font(.system(size: 50))
            }
            
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { buttonItem in
                        Button {
                            viewModel.didTapNumber(button: buttonItem)
                        } label: {
                            Text(buttonItem.value)
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(height: 80)
                                .frame(maxWidth: .infinity)
                                .background(buttonItem.buttonColor)
                                .cornerRadius(25)
                        }
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
