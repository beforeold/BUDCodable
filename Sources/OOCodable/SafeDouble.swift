//
//  SafeDouble.swift
//  
//
//  Created by beforeold on 2022/9/22.
//

import Foundation


@propertyWrapper
public struct SafeDouble {
    public typealias Wrapped = Int
    public var wrappedValue: Wrapped = 0
    
    public init(wrappedValue: Wrapped) {
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
        
        if let double = try? container.decode(Double.self) {
            self.wrappedValue = Int(double)
            return
        }
        
        if let int = try? container.decode(Int.self) {
            self.wrappedValue = int
            return
        }
        
        if let bool = try? container.decode(Bool.self) {
            self.wrappedValue = bool ? 1 : 0
            return
        }
        
        if let string = try? container.decode(String.self) {
            if let int = Int(string) {
                self.wrappedValue = int
            } else if StringUitl.isTrue(string: string) {
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
        var container = encoder.singleValueContainer()
        try? container.encode(self.wrappedValue)
    }
}

