//
//  SafeDouble.swift
//  
//
//  Created by beforeold on 2022/9/22.
//

import Foundation


@propertyWrapper
public struct SafeDouble {
    public var wrappedValue: Double = 0
    
    public init(wrappedValue: Double) {
        self.wrappedValue = wrappedValue
    }
    
    public init() {
        self.wrappedValue = 0
    }
}

extension SafeDouble: Decodable {
    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer() else {
            return
        }
        
        if let val = try? container.decode(Double.self) {
            self.wrappedValue = val
            return
        }
        
        if let val = try? container.decode(Int.self) {
            self.wrappedValue = Double(val)
            return
        }
        
        if let val = try? container.decode(Bool.self) {
            self.wrappedValue = val ? 1 : 0
            return
        }
        
        if let val = try? container.decode(String.self) {
            if let ret = Double(val) {
                self.wrappedValue = ret
            } else if StringUitl.isTrue(string: val) {
                self.wrappedValue = 1
            }
            return
        }
    }
    
    private static func isTrue(string: String) -> Bool {
        return string.hasPrefix("T") || string.hasPrefix("t")
    }
}

extension KeyedDecodingContainer {
    func decode(
        _ type: SafeDouble.Type,
        forKey key: Key
    ) throws -> SafeDouble {
        guard let ret = try decodeIfPresent(type, forKey: key) else {
            return SafeDouble()
        }
        return ret
    }
}

extension SafeDouble: Encodable {
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

