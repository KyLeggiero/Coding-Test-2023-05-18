//
//  OnboardingProgress.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-18.
//

import Foundation

import BasicMathTools
import CrossKitTypes
import SerializationTools



/// Represents the progress a user has made through the onboarding flow
struct OnboardingProgress: Equatable, Codable {
    
    var userManuallySelectedScreen: OnboardingScreen
    
    var inviteCode: String?
    var selectedCommunityId: CommunityId?
    var userProfile: UserProfile?
    var verificationImage: NativeImage.CodableBridge?
    var userDidAcknowledgePermissionRequests: Bool = false
}



extension OnboardingProgress {
    /// The state of onboarding progress when the user hasn't undergone any yet
    static let fresh = Self(userManuallySelectedScreen: .welcome)
}



extension OnboardingProgress {
    /// Returns the ideal screen to show the user. This might be the one they selected, or a previous one if information is missing.
    ///
    /// - Returns: The ideal current screen, or `nil` if onboarding is not necessart
    var idealScreen: OnboardingScreen? {
        if let autoScreen {
            return userManuallySelectedScreen ??< autoScreen
        }
        else {
            return nil
        }
    }
    
    
    /// The screen that the app would select if the user didn't manually navigate, or `nil` if onboarding is not necessart
    private var autoScreen: OnboardingScreen? {
        if nil == inviteCode {
            return userManuallySelectedScreen ??< .inviteCode
        }
        else if nil == selectedCommunityId {
            // TODO: Does community with this ID exist?
            return .communitySelection
        }
        
        if let userProfile {
            if nil == userProfile.phoneNumber
                || nil == userProfile.emailAddress
                || nil == userProfile.birthdate
            {
                return .createAccount
            }
            else if !userProfile.phoneNubmerIsVerified {
                return .verifyPhone
            }
            else if nil == userProfile.name
                || nil == userProfile.pronouns
                || nil == userProfile.location
            {
                return .createProfile
            }
            else if nil == userProfile.profileImage {
                return .addProfilePic
            }
        }
        else {
            return .createProfile
        }
        
        if nil != userProfile?.profileImage,
           nil == verificationImage
        {
            return .verifyProfilePic
        }
        
        if !userDidAcknowledgePermissionRequests {
            return .requestPermissions
        }
        
        return .none
    }
}



/// Use the left side if it's less than the right.
infix operator ??< : ComparisonPrecedence



public extension Comparable {
    static func ??< (lhs: Self, rhs: Self) -> Self {
        lhs < rhs
            ? lhs
            : rhs
    }
}
