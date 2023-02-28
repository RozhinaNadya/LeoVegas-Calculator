// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum ErrorsText {
    internal enum Description {
      /// Localizable.strings
      ///   LeoCalculator
      /// 
      ///   Created by Nadya Rozhina on 2023-02-28.
      internal static let decodeBitcoinPrice = L10n.tr("Localizable", "errorsText.description.decodeBitcoinPrice", fallback: "The bitcoin price is not found")
      /// Calculation is impossible
      internal static let impossibleCalculation = L10n.tr("Localizable", "errorsText.description.impossibleCalculation", fallback: "Calculation is impossible")
      /// Sorry, this is impossible
      internal static let noOperations = L10n.tr("Localizable", "errorsText.description.noOperations", fallback: "Sorry, this is impossible")
    }
    internal enum FailureReason {
      /// It looks like you removed all actions
      internal static let noOperations = L10n.tr("Localizable", "errorsText.failureReason.noOperations", fallback: "It looks like you removed all actions")
      /// Something unexpectable
      internal static let reasonDefault = L10n.tr("Localizable", "errorsText.failureReason.reasonDefault", fallback: "Something unexpectable")
      /// It looks like you want to divide by zero...
      internal static let zeroDivision = L10n.tr("Localizable", "errorsText.failureReason.zeroDivision", fallback: "It looks like you want to divide by zero...")
    }
    internal enum RecoverySuggestion {
      /// Please check your calculations and try again
      internal static let calculationDefault = L10n.tr("Localizable", "errorsText.recoverySuggestion.calculationDefault", fallback: "Please check your calculations and try again")
      /// Please choose at least one operation
      internal static let noOperations = L10n.tr("Localizable", "errorsText.recoverySuggestion.noOperations", fallback: "Please choose at least one operation")
      /// Please try again
      internal static let suggestionDefault = L10n.tr("Localizable", "errorsText.recoverySuggestion.suggestionDefault", fallback: "Please try again")
      /// Please change 0 to another number and try again
      internal static let zeroDivision = L10n.tr("Localizable", "errorsText.recoverySuggestion.zeroDivision", fallback: "Please change 0 to another number and try again")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
