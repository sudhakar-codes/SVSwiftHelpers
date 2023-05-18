//
//  SynchronizedDictionary.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 09/04/21.
//

import Foundation

/// EZSE: This Synchronized Dictionary gets generic key, value types and used for the purpose of read, write on a dictionary Synchronized.
public class SynchronizedDictionary <Key: Hashable, Value> {
    
    fileprivate let queue = DispatchQueue(label: "SynchronizedDictionary", attributes: .concurrent)
    fileprivate var dict = [Key: Value]()
    
    func getValue(for key: Key) -> Value? {
        var value: Value?
        queue.sync {
            value = dict[key]
        }
        return value
    }
    
    func setValue(for key: Key, value: Value) {
        queue.sync {
            dict[key] = value
        }
    }
    
    func getSize() -> Int {
        return dict.count
    }
    
    func containValue(for key: Key) -> Bool {
        return dict.index(forKey: key) != nil
    }
}
