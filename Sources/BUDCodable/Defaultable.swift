//
//  Defaultable.swift
//  
//
//  Created by beforeold on 2022/9/23.
//

import Foundation

public protocol Defaultable {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

@propertyWrapper
public struct Default<T: Defaultable> {
    public var wrappedValue: T.Value
    public init(wrappedValue: T.Value) {
        self.wrappedValue = wrappedValue
    }
}

extension Default: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(
        _ type: Default<T>.Type,
        forKey key: Key
    ) throws -> Default<T> where T: Defaultable {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}

extension Int: Defaultable {
    public static var defaultValue = 0
}

extension Double: Defaultable {
    public static var defaultValue = 0
}

extension Bool: Defaultable {
    public static var defaultValue = false
}

extension String: Defaultable {
    public static var defaultValue = ""
}
