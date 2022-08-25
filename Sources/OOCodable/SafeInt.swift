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
        
        if let int = try? container.decode(Int.self) {
            self.wrappedValue = int
        }
        else if let bool = try? container.decode(Bool.self) {
            self.wrappedValue = bool ? 1 : 0
        }
        else if let double = try? container.decode(Double.self) {
            self.wrappedValue = Int(double)
        }
        else if let string = try? container.decode(String.self) {
            if let int = Int(string) {
                self.wrappedValue = int
            } else if SafeInt.isTrue(string: string) {
                self.wrappedValue = 1
            }
        }
    }
    
    private static func isTrue(string: String) -> Bool {
        return string.hasPrefix("T") || string.hasPrefix("t")
    }
}

extension SafeInt: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try? container.encode(self.wrappedValue)
    }
}
