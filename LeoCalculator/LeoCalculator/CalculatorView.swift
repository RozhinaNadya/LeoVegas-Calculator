//
//  CalculatorView.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import SwiftUI

enum CalculatorButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case addition = "+"
    case subtraction = "-"
    case multiplication = "x"
    case division = "÷"
    case decimal = "."
    case sin = "sin"
    case cos = "cos"
    case equal = "="
    case clear = "AC"
    case negative = "-/+"
    case percent = "%"

    var value: String {
        rawValue
    }
}

struct CalculatorView: View {

    let buttons: [[CalculatorButton]] = [
        [.clear, .percent, .sin, .cos],
        [.seven, .eight, .nine, .multiplication],
        [.four, .five, .six, .division],
        [.one, .two, .three, .addition],
        [.negative, .zero, .decimal, .equal]
    ]
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Spacer()
                Text("0")
                    .font(.title)
            }
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { buttonItem in
                        Button {
                            // TODO: add logic
                        } label: {
                            Text(buttonItem.value)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(buttonItem.value == CalculatorButton.equal.value ? Color.green : Color.orange)
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
