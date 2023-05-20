//
//  SerializationManager.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-18.
//

import Foundation



/// Centralizes the duties of serializing data
public actor SerializationManager<Key: RawRepresentable>: ObservableObject
where Key.RawValue: StringProtocol
{
    
    // TODO: Add a hook here so others can tell when serialized data changes and perform necessary updates
    
    let location: Location
    
    init(location: Location = .userDefaults) {
        self.location = location
    }
}



public extension SerializationManager {
    
    /// Where data can be serialized to/from
    enum Location {
        
        /// Serialize data to/from User Defaults
        ///
        /// - Parameter suiteName: _optional_ - The instance of `UserDefaults` to use. Defaults to `.standard`
        case userDefaults(userDefaults: UserDefaults = .standard)
        
        /// Serialize data to/from User Defaults
        static var userDefaults: Self { .userDefaults() }
    }
}



// MARK: - Storing and fetching

public extension SerializationManager {
    subscript<Value: Decodable>(_ key: Key) -> DeserializationFetchResult<Value> {
        location.deserializer.fetchValue(for: key.rawValue.description)
    }
    
    
    subscript<Value: Codable>(_ key: Key) -> Value? {
        get {
            switch self[key] as DeserializationFetchResult<Value> {
            case .found(value: let value):
                return value
                
            case .wrongType(untypedValue: _),
                    .notFound:
                return nil
            }
        }
        
        set {
            if let newValue {
                try? serialize(newValue, to: key)
            }
            else {
                try? location.serializer.deleteValue(at: key.rawValue.description)
            }
        }
    }
    
    
    func serialize<Value: Encodable>(_ value: Value, to key: Key) throws {
        try location.serializer.serialize(value, to: key.rawValue.description)
    }
    
    
    subscript<Value: Codable>(_ key: Key, default default: @autoclosure () -> Value, serializeDefaultWhenFetchFails: Bool = true) -> Value {
        get {
            switch self[key] as DeserializationFetchResult<Value> {
            case .found(value: let value):
                return value
                
            case .wrongType(untypedValue: _),
                    .notFound:
                
                let backup = `default`()
                
                if serializeDefaultWhenFetchFails {
                    self[key] = backup
                }
                
                return backup
            }
        }
        
        set {
            try? location.serializer.deleteValue(at: key.rawValue.description)
        }
    }
}


/// The semantic result of a fetch operation
public enum DeserializationFetchResult<Value> {
    
    /// The value was found and of the correct type
    /// - Parameter value: The typed value correctly fetched
    case found(value: Value)
    
    /// The value was found but wasn't of the expected type
    /// - Parameter untypedValue: The value which was fetched but wasn't of the expected type
    case wrongType(untypedValue: Any)
    
    /// There was no value in the indicated location
    case notFound
}



// MARK: - Guts



private protocol Serializer {
    func serialize<Value: Encodable>(_ value: Value, to key: String) throws
    func deleteValue(at key: String) throws
}



private protocol Deserializer {
    func fetchValue<Value: Decodable>(for key: String) -> DeserializationFetchResult<Value>
}



private extension SerializationManager.Location {
    
    var serializer: Serializer {
        switch self {
        case .userDefaults(let userDefaults):
            return UserDefaults.Serializer(basis: userDefaults)
        }
    }
    
    
    var deserializer: Deserializer {
        switch self {
        case .userDefaults(let userDefaults):
            return UserDefaults.Serializer(basis: userDefaults)
        }
    }
}



private extension UserDefaults {
    struct Serializer: Bent.Deserializer, Bent.Serializer {
        
        private let _userDefaults: UserDefaults
        
        
        init(basis: UserDefaults) {
            self._userDefaults = basis
        }
        
        
        func serialize<Value: Encodable>(_ value: Value, to key: String) throws {
            self._userDefaults.set(try value.jsonData(), forKey: key)
        }
        
        
        func deleteValue(at key: String) throws {
            self._userDefaults.removeObject(forKey: key)
        }
        
        
        func fetchValue<Value: Decodable>(for key: String) -> DeserializationFetchResult<Value> {
            let fetchResult = _userDefaults.object(forKey: key)
            
            if let fetchResult = fetchResult as? Value {
                return .found(value: fetchResult)
            }
            else if let fetchData = fetchResult as? Data,
                    let fetchResult = try? Value(jsonData: fetchData)
            {
                return .found(value: fetchResult)
            }
            else if let fetchResult {
                return .wrongType(untypedValue: fetchResult)
            }
            else {
                return .notFound
            }
        }
    }
}
