//
//  File.swift
//  
//
//  Created by beforeold on 2022/8/25.
//

import Foundation

@propertyWrapper
public struct SafeInt {
    public var wrappedValue: Int = 0
    
    public init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
    }
    
    public init() {
        self.wrappedValue = 0
    }
}

extension SafeInt: Decodable {
    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer() else {
            return
        }
        
        if let val = try? container.decode(Int.self) {
            self.wrappedValue = val
            return
        }
        
        if let val = try? container.decode(Double.self) {
            self.wrappedValue = Int(val)
            return
        }
        
        if let val = try? container.decode(Bool.self) {
            self.wrappedValue = val ? 1 : 0
            return
        }
        
        if let val = try? container.decode(String.self) {
            if let ret = Int(val) {
                self.wrappedValue = ret
            } else if StringUitl.isTrue(string: val) {
                self.wrappedValue = 1
            }
            return
        }
    }
}

extension KeyedDecodingContainer {
    func decode(
        _ type: SafeInt.Type,
        forKey key: Key
    ) throws -> SafeInt {
        guard let ret = try decodeIfPresent(type, forKey: key) else {
            return SafeInt()
        }
        return ret
    }
}

extension SafeInt: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try? container.encode(self.wrappedValue)
    }
}
