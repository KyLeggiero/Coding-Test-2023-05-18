//
//  UserDefaults + conveniences.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-18.
//

import Foundation



public extension UserDefaults {
    
    /// Whether a value exists in this User Defaults store at the given key
    ///
    /// - Parameter key: The key to test for an associated value
    /// - Returns: `true` iff there is a value stored for the given key
    func valueExists(forKey key: String) -> Bool {
        nil != object(forKey: key)
    }
}
