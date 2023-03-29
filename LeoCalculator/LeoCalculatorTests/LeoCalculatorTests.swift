//
//  LeoCalculatorTests.swift
//  LeoCalculatorTests
//
//  Created by Nadya Rozhina on 2023-02-16.
//

import XCTest

final class LeoCalculatorTests: XCTestCase {
    
    private var calculator: CalculatorViewModel!
    
    private let currentTestValue = 10.0
    private let currentTestSinValue = 90.0
    private let currentTestCosValue = 360.0
    private let runningTestValue = 20.0

    override func setUpWithError() throws {
        calculator = CalculatorViewModel()
    }

    override func tearDownWithError() throws {
        calculator = nil
    }

    func test_addition() {
        calculator.currentOperation = .addition
        calculator.doOperation(
            currentValue: currentTestValue,
            runningValue: runningTestValue
        )
        let expected = "30"
        
        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_subtraction() {
        calculator.currentOperation = .subtraction
        calculator.doOperation(
            currentValue: currentTestValue,
            runningValue: runningTestValue
        )
        let expected = "10"
        
        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_multiplication() {
        calculator.currentOperation = .multiplication
        calculator.doOperation(
            currentValue: currentTestValue,
            runningValue: runningTestValue
        )
        let expected = "200"
        
        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_division() {
        calculator.currentOperation = .division
        calculator.doOperation(
            currentValue: currentTestValue,
            runningValue: runningTestValue
        )
        let expected = "2"
        
        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_sin() {
        calculator.currentOperation = .sin
        calculator.doOperation(currentValue: currentTestSinValue)
        let expected = "1.00"
        
        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_cos() {
        calculator.currentOperation = .cos
        calculator.doOperation(currentValue: currentTestCosValue)
        let expected = "1.00"
        
        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_addition_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .four)
        calculator.didTapButton(button: .addition)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "65"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_addition_decimal_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .four)
        calculator.didTapButton(button: .addition)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "16.40"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_addition_two_decimal_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .four)
        calculator.didTapButton(button: .addition)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "6.50"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_subtraction_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .four)
        calculator.didTapButton(button: .subtraction)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "43"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_subtraction_decimal_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .four)
        calculator.didTapButton(button: .subtraction)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "52.90"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_subtraction_two_decimal_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .four)
        calculator.didTapButton(button: .subtraction)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "4.30"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_multiplication_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .four)
        calculator.didTapButton(button: .multiplication)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "594"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_multiplication_decimal_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .four)
        calculator.didTapButton(button: .multiplication)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "59.40"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_multiplication_two_decimal_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .four)
        calculator.didTapButton(button: .multiplication)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "5.94"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_division_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .division)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "5"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_division_with_remainder_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .four)
        calculator.didTapButton(button: .division)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "4.91"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_division_decimal_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .division)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "50.00"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_division_two_decimal_flow() {
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .five)
        calculator.didTapButton(button: .division)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .decimal)
        calculator.didTapButton(button: .one)
        calculator.didTapButton(button: .equal)
        let expected = "5.00"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_sin_flow() {
        calculator.didTapButton(button: .nine)
        calculator.didTapButton(button: .zero)
        calculator.didTapButton(button: .sin)
        let expected = "1.00"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
    
    func test_cos_flow() {
        calculator.didTapButton(button: .three)
        calculator.didTapButton(button: .six)
        calculator.didTapButton(button: .zero)
        calculator.didTapButton(button: .cos)
        let expected = "1.00"

        XCTAssertEqual(calculator.calculatorValue, expected)
    }
}
