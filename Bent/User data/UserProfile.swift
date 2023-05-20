//
//  UserProfile.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-18.
//

import Foundation
import CoreLocation

import CrossKitTypes
import GenderTools
import SerializationTools



/// Data about a user.
///
/// This might have been validated form user input on the device, downloaded from our servers, implied by other knowledge, etc.
public struct UserProfile: Equatable, Codable {
    let id: UUID
    
    var name: String?
    var pronouns: [Pronouns]?
    var profileImage: NativeImage.CodableBridge?
    
    var phoneNumber: String?
    var phoneNubmerIsVerified: Bool
    var emailAddress: String?
    var birthdate: Date?
    var location: CLPlacemark.CodableBridge?
}
