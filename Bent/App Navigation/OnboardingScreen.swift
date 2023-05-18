//
//  OnboardingScreen.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-18.
//

import Foundation



/// A screen in the onboarding process
public enum OnboardingScreen {
    
    /// The initial screen, with the brand introduction and a CTA for signing in or signing up
    case welcome
    
    /// The screen where the user inputs their invitation code
    case inviteCode
    
    /// The screen where the user selects the communities they wishes to start with
    case communitySelection
    
    /// The screen where the user inputs basic info (name, phone, email, ...)
    case createAccount
    
    /// The screen where the user verifies that they owns the phone number they'd input
    case verifyPhone
    
    /// The screen where the user sets up their basic profile information (name, pronouns, location, etc...)
    case createProfile
    
    /// The screen where the user selects their profile picture
    case addProfilePic
    
    /// The screen where the user verifies their profile picture is indeed a photo of themself
    case verifyProfilePic
    
    /// The screen where we request that the user permits us to do things such as send notifications
    case requestPermissions
}
