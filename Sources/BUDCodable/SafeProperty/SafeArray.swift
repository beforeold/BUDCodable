//
//  SafeArray.swift
//  
//
//  Created by beforeold on 2022/9/23.
//

import Foundation

@propertyWrapper
public struct SafeArray<T> where T: Decodable {
    public var wrappedValue: [T] = []
    
    public init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
    
    public init() {
        self.wrappedValue = []
    }
}

extension SafeArray: Decodable  {
    public init(from decoder: Decoder) throws {
        guard var unkeyedContainer = try? decoder.unkeyedContainer() else {
            return
        }
        var temp = [T]()
        while !unkeyedContainer.isAtEnd {
            if T.self == Int.self {
                if let val = try? unkeyedContainer.decode(SafeInt.self) {
                    temp.append(val.wrappedValue as! T)
                }
                continue
            }
            
            if T.self == Double.self {
                if let val = try? unkeyedContainer.decode(SafeDouble.self) {
                    temp.append(val.wrappedValue as! T)
                }
                continue
            }
            
            if T.self == Bool.self {
                if let val = try? unkeyedContainer.decode(SafeBool.self) {
                    temp.append(val.wrappedValue as! T)
                }
                continue
            }
            
            if T.self == String.self {
                if let val = try? unkeyedContainer.decode(SafeString.self) {
                    temp.append(val.wrappedValue as! T)
                }
                continue
            }
            
            if let item = try? unkeyedContainer.decode(T.self) {
                temp.append(item)
                continue
            }
        }
        self.wrappedValue = temp
    }
}

extension KeyedDecodingContainer {
    func decode<T>(
        _ type: SafeArray<T>.Type,
        forKey key: Key
    ) throws -> SafeArray<T> {
        guard let ret = try decodeIfPresent(type, forKey: key) else {
            return SafeArray()
        }
        return ret
    }
}

extension SafeArray: Encodable where T: Encodable {
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

