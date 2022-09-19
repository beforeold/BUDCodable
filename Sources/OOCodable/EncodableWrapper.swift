//
//  EncodableWrapper.swift
//  
//
//  Created by beforeold on 2022/9/19.
//

import Foundation

/// erase Encodable value in collection types
///
/// transform example: [1, "2", 3.0].map(EncodableWrapper.init)
public struct EncodableWrapper {
    public let wrapped: Encodable
    
    public init(_ wrapped: Encodable) {
        self.wrapped = wrapped
    }
}

extension EncodableWrapper: Encodable {
    public func encode(to encoder: Encoder) throws {
        try wrapped.encode(to: encoder)
    }
}
