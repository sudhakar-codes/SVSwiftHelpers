//
//  ArrayExtensions.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 18/05/21.
//

import Foundation

public extension Array {
    
    mutating func remove(elementsAtIndices indicesToRemove: [Int]) -> [Element] {
        let removedElements = indicesToRemove.map { self[$0] }
        for indexToRemove in indicesToRemove.sorted(by: >) {
            remove(at: indexToRemove)
        }
        return removedElements
    }
}

public extension Array where Element: Equatable {
    
    /// Returns the indexes of the object
    func indexes(of element: Element) -> [Int] {
        return enumerated().compactMap { ($0.element == element) ? $0.offset : nil }
    }
    
    /// Returns an array consisting of the unique elements in the array
    var unique:Array {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }

}
