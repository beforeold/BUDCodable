//
//  JSONString.swift
//  OOCodable
//
//  Created by beforeold on 2021/11/29.
//  Copyright © 2021 OOCodable. All rights reserved.
//

import Foundation

@propertyWrapper
public struct JSONString<Base: Codable>: Codable {
    public var wrappedValue: Base
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self),
           let data = string.data(using: .utf8) {
            self.wrappedValue = try JSONDecoder().decode(Base.self, from: data)
            return
        }
        
        self.wrappedValue = try container.decode(Base.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let data = try LionCoderFactory.newJSONEncoder().encode(wrappedValue)
        if let string = String(data: data, encoding: .utf8) {
            try container.encode(string)
        }
    }
}
