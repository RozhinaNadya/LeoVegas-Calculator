//
//  CalculatorSettingsView.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-23.
//

import SwiftUI

struct FeatureList: Identifiable {
    var id: String
    var operation: Operation
    var isActive = true
}

struct CalculatorSettingsView: View {
    
    @State var lists = [
        FeatureList(id: "sine", operation: .sin),
        FeatureList(id: "cosine", operation: .cos),
        FeatureList(id: "addition", operation: .addition),
        FeatureList(id: "subtraction", operation: .subtraction),
        FeatureList(id: "multiplication", operation: .multiplication),
        FeatureList(id: "division", operation: .division),
        FeatureList(id: "bitcoin", operation: .bitcoin)
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Select features")
            Form {
                Section {
                    ForEach($lists) { $list in
                        Toggle(list.id, isOn: $list.isActive)
                    }
                }
            }
        }
    }
}

struct CalculatorSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorSettingsView()
    }
}
