//
//  JSONString.swift
//
//
//  Created by beforeold on 2021/11/29.
//

import Foundation

@propertyWrapper
public struct JSONString<Base> {
    public var wrappedValue: Base
    public init(wrappedValue: Base) {
        self.wrappedValue = wrappedValue
    }
}

extension JSONString: Decodable where Base: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self),
           let data = string.data(using: .utf8) {
            self.wrappedValue = try JSONDecoder().decode(Base.self, from: data)
            return
        }
        
        self.wrappedValue = try container.decode(Base.self)
    }
}

extension JSONString: Encodable where Base: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let data = try JSONEncoder().encode(wrappedValue)
        if let string = String(data: data, encoding: .utf8) {
            try container.encode(string)
        }
    }
}
