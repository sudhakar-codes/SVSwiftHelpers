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
    /// Gets the object at the specified index, if it exists.
    func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    /// Returns a random element from the array.
    func random() -> Element? {
        guard count > 0 else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    /// Repeat the elements of the given array into a new array.
    /// - Parameter count: Number of times array repeats (count must be greater than 0)
    /// - Returns: New repeated array
    func repeated(count: Int) -> Array<Element> {
        assert(count > 0, "count must be greater than 0")
        
        var result = self
        for _ in 0 ..< count - 1 {
            result += self
        }
        
        return result
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
