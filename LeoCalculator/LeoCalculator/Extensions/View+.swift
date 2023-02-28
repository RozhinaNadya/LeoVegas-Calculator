//
//  View+.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-28.
//

import Foundation
import SwiftUI

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
