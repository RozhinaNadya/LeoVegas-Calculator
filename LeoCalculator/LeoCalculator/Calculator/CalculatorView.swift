//
//  CalculatorView.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import SwiftUI

struct CalculatorView: View {
    
    @EnvironmentObject var viewModel: CalculatorViewModel
    
    @State private var presentSettings = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                HStack(alignment: .top) {
                    NavigationLink(isActive: $presentSettings) {
                        CalculatorSettingsView()
                    } label: {
                        Button {
                            presentSettings.toggle()
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .foregroundColor(.orange)
                                .frame(width: 30, height: 30)
                        }
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Text(viewModel.calculatorValue)
                        .font(.system(size: 50))
                }
                
                if let upperCalculatorButton = viewModel.upperCalculatorButton {
                    CustomCalculatorButton(button: upperCalculatorButton,
                                           isUpperButton: true,
                                           maxHeight: (UIScreen.main.bounds.height - 48) / 20,
                                           action: {
                        viewModel.didTapNumber(button: upperCalculatorButton)
                    })
                }
                
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
    }
    
    @ViewBuilder
    func CalculatorRow(row: [CalculatorButtonModel]) -> some View {
        ForEach(row, id: \.self) { buttonItem in
            CustomCalculatorButton(
                button: buttonItem,
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
