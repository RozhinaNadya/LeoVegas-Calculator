//
//  CustomCalculatorButton.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-23.
//

import SwiftUI

struct CustomCalculatorButton: View {
    var button: CalculatorButtonModel
    var isUpperButton = false
    var maxHeight = (UIScreen.main.bounds.height - 48) / 10
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(button.value)
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxHeight: maxHeight)
                .frame(maxWidth: getButtonWidth())
                .background(button.buttonColor)
                .cornerRadius(40)
                .padding(.horizontal, 2)
        }
    }
    
    private func getButtonWidth() -> CGFloat {
        isUpperButton ? .infinity  : (UIScreen.main.bounds.width - 56) / 4
    }
}

struct CustomCalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomCalculatorButton(button: .addition, action: {})
    }
}
