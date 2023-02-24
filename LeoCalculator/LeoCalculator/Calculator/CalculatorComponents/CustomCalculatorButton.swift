//
//  CustomCalculatorButton.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-23.
//

import SwiftUI

enum RowType {
    case core
    case top
    case right
    case upper
}

struct CustomCalculatorButton: View {
    var button: CalculatorButtonModel
    var maxHeight = (UIScreen.main.bounds.height - 48) / 10
    var rowType: RowType
    var topButtonsCount: CGFloat = 1
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(button.value)
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxHeight: maxHeight)
                .frame(maxWidth: getButtonWidth(buttonsCount: topButtonsCount))
                .background(button.buttonColor)
                .cornerRadius(40)
                .padding(.horizontal, 2)
        }
    }
    
    private func getButtonWidth(buttonsCount: CGFloat) -> CGFloat {
        let defaultWidth = (UIScreen.main.bounds.width - 56) / 4
        switch rowType {
        case .core, .right:
            return defaultWidth
        case .top:
            return ((UIScreen.main.bounds.width - defaultWidth) / buttonsCount)
        case .upper:
            return .infinity
        }
    }
}

struct CustomCalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomCalculatorButton(button: .addition, rowType: .core, topButtonsCount: 4, action: {})
    }
}
