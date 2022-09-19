//
//  EncodableWrapper.swift
//  
//
//  Created by beforeold on 2022/9/19.
//

import Foundation

/// erase Encodable value in collection types
///
/// transform example: [1, "2", 3.0].map(EncodableWrapper.init)
///
@propertyWrapper
public struct EncodableWrapper {
    private var value: Encodable
    
    public init(wrappedValue: Encodable) {
        self.value = wrappedValue
    }
    
    public var wrappedValue: Encodable {
        set {
            value = newValue
        }
        
        get {
            return value
        }
    }
    
    public var projectedValue: EncodableWrapper {
        return self
    }
}

extension EncodableWrapper: Encodable {
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}
