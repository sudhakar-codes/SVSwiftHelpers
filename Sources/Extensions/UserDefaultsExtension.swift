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
            guard let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) else { return }
            setter(key: key, value: data as Any?)
        } else {
            removeObject(forKey: key)
        }
    }
    
    /// Unarchive object for specific key.
    func unarchivedObject(forKey key: String) -> Any? {
        
        if let data = data(forKey: key) {
            guard let data = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSObject.self], from: data) else { return nil }
            return data
        } else {
            return nil
        }
    }
}
