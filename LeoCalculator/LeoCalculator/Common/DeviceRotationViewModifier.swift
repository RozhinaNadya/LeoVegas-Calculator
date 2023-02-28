//
//  DeviceRotationViewModifier.swift
//  LeoCalculator
//
//  Created by Nadya Rozhina on 2023-02-28.
//

import Foundation

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}
