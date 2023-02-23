//
//  CalculatorView.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import SwiftUI

struct CalculatorView: View {
    
    @StateObject var viewModel = CalculatorViewModel()
    
    @State private var presentSettings = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                HStack {
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
    }
    
    @ViewBuilder
    func CalculatorRow(row: [CalculatorButtonModel], isUpperButton: Bool = false) -> some View {
        ForEach(row, id: \.self) { buttonItem in
            CustomCalculatorButton(
                button: buttonItem,
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
