//
//  CustomCalculatorButton.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-23.
//

import SwiftUI

struct CustomCalculatorButton: View {
    var buttonText: String
    var buttonHeight: CGFloat
    var buttonColor: Color = .gray
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
                .frame(height: buttonHeight)
                .frame(maxWidth: .infinity)
                .background(buttonColor)
                .cornerRadius(40)
                .padding(.horizontal, 2)
        }
    }
}

struct CustomCalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomCalculatorButton(buttonText: "1", buttonHeight: 70, action: {})
    }
}
