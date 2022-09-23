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
    public var wrappedValue: Encodable
    
    public init(wrappedValue: Encodable) {
        self.wrappedValue = wrappedValue
    }
    
    public var projectedValue: Self {
        return self
    }
}

extension EncodableWrapper: Encodable {
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}


public extension EncodableWrapper {
    static func wrap(array: [Encodable]) -> [Self] {
        return array.map(Self.init)
    }
    
    static func wrap<Key>(dictionary: [Key: Encodable]) -> [Key: Self] {
        return dictionary.mapValues(Self.init)
    }
}

#if swift(>=5.7)
public extension Array where Element == any Encodable {
    func encodableWrapped() -> [EncodableWrapper] {
        return map(EncodableWrapper.init)
    }
}

public extension Dictionary where Value == any Encodable {
    func encodableWrapped() -> [Key: EncodableWrapper] {
        return mapValues(EncodableWrapper.init)
    }
}

#endif
