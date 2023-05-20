//
//  AppSection.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-18.
//

import Foundation



/// A section of the application (a collection of screens and views which is logically distinct)
enum AppSection: Equatable, Codable {
    
    /// User onboarding brings the user into the app
    case onboarding(progress: OnboardingProgress)
    
    /// A thank-you from Ky for considering their employment at Castro Labs
    case thankYouForYourConsideration
}



extension AppSection {
    
    /// The app section to be presented to the user when no other can be determined (e.g. the first one ever)
    static let `default` = onboarding(progress: .fresh)
}
