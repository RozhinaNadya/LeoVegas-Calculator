//
//  LeoCalculatorApp.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import SwiftUI

@main
struct LeoCalculatorApp: App {
    var calculatorViewModel = CalculatorViewModel()

    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .environmentObject(calculatorViewModel)
        }
    }
}
