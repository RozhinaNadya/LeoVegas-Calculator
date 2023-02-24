//
//  CalculatorSettingsView.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-23.
//

import SwiftUI

struct CalculatorSettingsView: View {
    
    @EnvironmentObject var viewModel: CalculatorViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            Form {
                Section {
                    ForEach($viewModel.features) { $feature in
                        Toggle(feature.id, isOn: $feature.isActive)
                    }
                }
            }
            .navigationTitle("Select features")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CalculatorSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorSettingsView()
    }
}
