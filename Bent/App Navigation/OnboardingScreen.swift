//
//  OnboardingScreen.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-18.
//

import Foundation



/// Identifies a screen in the onboarding process
public enum OnboardingScreen: UInt8, Hashable, Codable, CaseIterable {
    
    /// The initial screen, with the brand introduction and a CTA for signing in or signing up
    case welcome = 0x0
    
    /// The screen where the user inputs their invitation code
    case inviteCode = 0x10
    
    /// The screen where the user selects the communities they wishes to start with
    case communitySelection = 0x20
    
    /// The screen where the user inputs basic info (name, phone, email, ...)
    case createAccount = 0x30
    
    /// The screen where the user verifies that they owns the phone number they'd input
    case verifyPhone = 0x40
    
    /// The screen where the user sets up their basic profile information (name, pronouns, location, etc...)
    case createProfile = 0x50
    
    /// The screen where the user selects their profile picture
    case addProfilePic = 0x60
    
    /// The screen where the user verifies their profile picture is indeed a photo of themself
    case verifyProfilePic = 0x70
    
    /// The screen where we request that the user permits us to do things such as send notifications
    case requestPermissions = 0x80
}



extension OnboardingScreen: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
