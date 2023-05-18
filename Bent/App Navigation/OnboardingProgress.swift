//
//  OnboardingProgress.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-18.
//

import Foundation

import CrossKitTypes



struct OnboardingProgress {
    
    var userManuallySelectedScreen: OnboardingScreen
    
    var inviteCode: String?
    var selectedCommunityId: CommunityId?
    var userProfile: UserProfile?
    var validationImage: NativeImage?
}



extension OnboardingProgress {
    /// The state of onboarding progress when the user hasn't undergone any yet
    static let fresh = Self(userManuallySelectedScreen: .welcome)
}
