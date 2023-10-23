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
    
    /**
     Returns an array containing the elements at the specified indexes from the array.
     
     This function takes an array and an array of indexes and returns a new array containing the elements from the array at the specified indexes. The function filters out any invalid indexes (i.e., indexes that are out of bounds) and includes only the elements corresponding to the valid indexes.
     
     - Parameters:
     - indexes: An array of integers representing the indexes of elements to be retrieved from the array.
     
     - Returns: An array containing the elements from the array at the specified indexes. The order of elements in the output array corresponds to the order of indexes in the `indexes` array.
     
     - Complexity: The time complexity of this function is O(m), where m is the count of valid indexes in the `indexes` array. The function iterates through the `indexes` array to filter out invalid indexes and creates a new array with the desired elements. The space complexity of the function is also O(m), as it returns a new array containing the valid elements.
     
     - Note: If the array is empty or the `indexes` array is empty, the function will return an empty array as well.
     
     - Example:
     ```swift
     let stringArray = ["Apple", "Banana", "Orange", "Grape", "Mango"]
     let indexes = [0, 2, 4]
     
     let elements = stringArray.elements(atIndexes: indexes)
     // elements is ["Apple", "Orange", "Mango"]
     ```
     */
    func elements(atIndexes indexes: [Int]) -> [Element] {
        return indexes.compactMap { index in
            index < count ? self[index] : nil
        }
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
