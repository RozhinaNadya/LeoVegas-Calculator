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
                Spacer()
                
                HStack {
                    Spacer()
                    Text(viewModel.calculatorValue)
                        .font(.system(size: 50))
                }
                
                if let upperCalculatorButton = viewModel.upperCalculatorButton {
                    CustomCalculatorButton(button: upperCalculatorButton,
                                           rowType: .upper,
                                           action: {
                        viewModel.didTapNumber(button: upperCalculatorButton)
                    })
                }
                
                HStack(alignment: .bottom) {
                    VStack {
                        HStack {
                            CalculatorRow(row: viewModel.topButtons, type: .top)
                        }
                        
                        ForEach(viewModel.coreButtons, id: \.self) { coreRow in
                            HStack {
                                CalculatorRow(row: coreRow, type: .core)
                            }
                        }
                    }
                    
                    VStack {
                        CalculatorRow(row: viewModel.rightButtons, type: .right)
                    }
                }
            }
            .padding(.horizontal, 16)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(isActive: $presentSettings) {
                        CalculatorSettingsView()
                    } label: {
                        settingsButton()
                    }
                }
            }
            .alert(isPresented: viewModel.isPresentingAlert, content: {
                Alert(localizedError: viewModel.activeError ?? CalculationError.defaultCalculationError)
            })
        }
    }
    
    @ViewBuilder
    func settingsButton() -> some View {
        Button {
            presentSettings.toggle()
        } label: {
            Image(systemName: "gearshape.fill")
                .resizable()
                .foregroundColor(.orange)
                .frame(width: 30, height: 30)
        }
    }
    
    @ViewBuilder
    func CalculatorRow(row: [CalculatorButtonModel], type: RowType) -> some View {
        ForEach(row, id: \.self) { buttonItem in
            CustomCalculatorButton(
                button: buttonItem,
                rowType: type,
                topButtonsCount: CGFloat(row.count),
                rightButtonsCount: CGFloat(row.count),
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
