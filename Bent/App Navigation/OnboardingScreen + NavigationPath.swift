//
//  OnboardingScreen + NavigationPath.swift
//  Bent
//
//  Created by Northstar✨System on 2023-05-19.
//

import SwiftUI



extension OnboardingProgress {
    /// Generates a new `NavigationPath` containing all necesary steps to this screen
    var navigationPath: NavigationPath {
        if let idealScreen {
            return .init(OnboardingScreen.allCases.filter { $0 <= idealScreen })
        }
        else {
            return .init([OnboardingScreen.welcome])
        }
    }
}
