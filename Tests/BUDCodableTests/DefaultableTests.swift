//
//  DefaultableTests.swift
//  
//
//  Created by beforeold on 2022/9/23.
//

import XCTest
@testable import BUDCodable

class DefaultableTests: XCTestCase {
    func testNilForDefault() {
        struct Example: Decodable {
            @Default<Int> var key: Int
        }
        
        let data = #"""
   {}
   """#.data(using: .utf8)!
        let example = try! JSONDecoder().decode(Example.self, from: data)
        XCTAssertEqual(example.key, 0)
    }
}
