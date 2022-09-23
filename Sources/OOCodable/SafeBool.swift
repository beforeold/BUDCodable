//
//  SafeBool.swift
//  
//
//  Created by beforeold on 2022/9/23.
//

import Foundation


@propertyWrapper
public struct SafeBool {
    public var wrappedValue: Bool = false
    
    public init(wrappedValue: Bool) {
        self.wrappedValue = wrappedValue
    }
    
    public init() {
        self.wrappedValue = false
    }
}

extension SafeBool: Decodable {
    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer() else {
            return
        }
        
        if let val = try? container.decode(Bool.self) {
            self.wrappedValue = val
            return
        }
        
        if let val = try? container.decode(Int.self) {
            self.wrappedValue = val != 0
            return
        }
        
        if let val = try? container.decode(Double.self) {
            self.wrappedValue = val != 0
            return
        }
        
        if let val = try? container.decode(String.self) {
            self.wrappedValue = StringUitl.isTrue(string: val)
            return
        }
    }
    
    private static func isTrue(string: String) -> Bool {
        return string.hasPrefix("T") || string.hasPrefix("t")
    }
}

extension KeyedDecodingContainer {
    func decode(
        _ type: SafeBool.Type,
        forKey key: Key
    ) throws -> SafeBool {
        guard let ret = try decodeIfPresent(type, forKey: key) else {
            return SafeBool()
        }
        return ret
    }
}

extension SafeBool: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try? container.encode(self.wrappedValue)
    }
}

