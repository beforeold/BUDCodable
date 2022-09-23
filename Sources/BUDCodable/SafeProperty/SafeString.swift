//
//  SafeString.swift
//  
//
//  Created by beforeold on 2022/9/23.
//

import Foundation


@propertyWrapper
public struct SafeString {
    public var wrappedValue: String = ""
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
    
    public init() {
        self.wrappedValue = ""
    }
}

extension SafeString: Decodable {
    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer() else {
            return
        }
        
        if let val = try? container.decode(String.self) {
            self.wrappedValue = val
            return
        }
        
        if let val = try? container.decode(Int.self) {
            self.wrappedValue = String(val)
            return
        }
        
        if let val = try? container.decode(Double.self) {
            self.wrappedValue = String(val)
            return
        }
        
        if let val = try? container.decode(Bool.self) {
            self.wrappedValue = val ? "1" : "0"
            return
        }
    }
    
    private static func isTrue(string: String) -> Bool {
        return string.hasPrefix("T") || string.hasPrefix("t")
    }
}

extension KeyedDecodingContainer {
    func decode(
        _ type: SafeString.Type,
        forKey key: Key
    ) throws -> SafeString {
        guard let ret = try decodeIfPresent(type, forKey: key) else {
            return SafeString()
        }
        return ret
    }
}

extension SafeString: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try? container.encode(self.wrappedValue)
    }
}

