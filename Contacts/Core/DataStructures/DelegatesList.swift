//
//  DelegatesList.swift
//  Contacts
//
//  Created by v.ampilogov on 17/01/2019.
//

import Foundation

class WeakList<T>: Sequence {

    private let hashTable = NSHashTable<AnyObject>.weakObjects()

    func append(_ element: T) {
        hashTable.add(element as AnyObject)
    }
    
    func remove(_ element: T) {
        hashTable.remove(element as AnyObject)
    }
    
    var count: Int {
        return hashTable.count
    }
    
    // MARK: - Sequence

    func makeIterator() -> Array<T>.Iterator {
        let allObjects = hashTable.allObjects.compactMap { $0 as? T }
        return allObjects.makeIterator()
    }
}
