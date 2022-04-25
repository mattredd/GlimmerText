//
//  File.swift
//  
//
//  Created by Matthew Reddin on 28/06/2021.
//

import Foundation

@propertyWrapper
struct ClampedValue<Value: Comparable> {
    
    let wrappedValue: Value
    
    init(wrappedValue: Value, clampedRange: ClosedRange<Value>) {
        self.wrappedValue = max(min(wrappedValue, clampedRange.upperBound), clampedRange.lowerBound)
    }
    
}
