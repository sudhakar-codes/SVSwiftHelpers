//
//  UserDefaultsExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 02/05/21.
//

import Foundation

public extension UserDefaults {
    
    subscript(key: String) -> Any? {
        get {
            return object(forKey: key) as Any?
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    fileprivate func setter(key: String, value: Any?) {
        self[key] = value
        synchronize()
    }
    
    /// Is there a object for specific key exist.
    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }

    /// Archive object to NSData to save.
    func archive(object: Any?, forKey key: String) {
        if let value = object {
            
            setter(key: key, value: NSKeyedArchiver.archivedData(withRootObject: value) as Any?)
        } else {
            removeObject(forKey: key)
        }
    }
    
    /// Unarchive object for specific key.
    func unarchivedObject(forKey key: String) -> Any? {
        return data(forKey: key).flatMap { NSKeyedUnarchiver.unarchiveObject(with: $0) as Any }
    }
}
