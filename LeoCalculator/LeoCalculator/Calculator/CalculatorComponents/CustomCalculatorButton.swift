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
    var rowType: RowType
    var topButtonsCount: CGFloat = 1
    var rightButtonsCount: CGFloat = 1
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(button.value)
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxHeight: getButtonHeight(buttonsCount: rightButtonsCount))
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
    
    private func getButtonHeight(buttonsCount: CGFloat) -> CGFloat {
        let defaultHeight = (UIScreen.main.bounds.height - 32) / 10

        switch rowType {
        case .core, .top:
            return defaultHeight
            
        case .right:
            // TODO: need to rewrite
            if button == .equal {
                if buttonsCount == 1 {
                    return 5 * defaultHeight
                } else if buttonsCount == 2 {
                    return 4 * defaultHeight
                } else if buttonsCount == 3 {
                    return 3 * defaultHeight
                } else if buttonsCount == 4 {
                    return 2 * defaultHeight
                } else {
                    return defaultHeight
                }
            } else {
               return defaultHeight
            }
            
        case .upper:
            return (UIScreen.main.bounds.height - 32) / 20
        }
    }
}

struct CustomCalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomCalculatorButton(button: .addition, rowType: .core, topButtonsCount: 4, action: {})
    }
}
