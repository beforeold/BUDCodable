//
//  SafeArrayTests.swift
//  
//
//  Created by beforeold on 2022/9/23.
//

import XCTest
@testable import BUDCodable

class SafeArrayTests: XCTestCase {
    struct Example: Codable {
        @SafeArray<Int> var key
        
        /*
        init(from decoder: Decoder) throws {
            let keyed = try decoder.container(keyedBy: CodingKeys.self)
            self._key = try keyed.decode(SafeArray<Int>.self, forKey: .key)
        }
        */
    }
    
    func testInt() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
      
        func testBool() {
            let data = #"""
    {"key":[true]}
    """#.data(using: .utf8)!
            let example = try! JSONDecoder().decode(Example.self, from: data)
            XCTAssertEqual(example.key, [1])
            
            let data2 = #"""
    {"key":[false]}
    """#.data(using: .utf8)!
            let example2 = try! JSONDecoder().decode(Example.self, from: data2)
            XCTAssertEqual(example2.key, [0])
        }
        
        func testInt() {
            let data = #"""
    {"key":[3]}
    """#.data(using: .utf8)!
            let example = try! JSONDecoder().decode(Example.self, from: data)
            XCTAssertEqual(example.key, [3])
            
            let data2 = #"""
    {"key":[0]}
    """#.data(using: .utf8)!
            let example2 = try! JSONDecoder().decode(Example.self, from: data2)
            XCTAssertEqual(example2.key, [0])
        }
        
        func testString() {
            let data = #"""
    {"key":"true"}
    """#.data(using: .utf8)!
            let example = try! JSONDecoder().decode(Example.self, from: data)
            XCTAssertEqual(example.key, [1])
            
            let data2 = #"""
    {"key":"false"}
    """#.data(using: .utf8)!
            let example2 = try! JSONDecoder().decode(Example.self, from: data2)
            XCTAssertEqual(example2.key, [0])
        }
        
        func testDouble() {
            let data = #"""
    {"key":[1.00]}
    """#.data(using: .utf8)!
            let example = try! JSONDecoder().decode(Example.self, from: data)
            XCTAssertEqual(example.key, [1])
            
            let data2 = #"""
    {"key":[-1.0]}
    """#.data(using: .utf8)!
            let example2 = try! JSONDecoder().decode(Example.self, from: data2)
            XCTAssertEqual(example2.key, [-1])
        }
        
        testInt()
        testBool()
        testString()
        testDouble()
    }
    
    func testNotArray() {
        let data = #"""
{"key":3}
"""#.data(using: .utf8)!
        let example = try! JSONDecoder().decode(Example.self, from: data)
        XCTAssertEqual(example.key, [])
    }
    
    func testNull() {
        let data = #"""
{"key":null}
"""#.data(using: .utf8)!
        let example = try! JSONDecoder().decode(Example.self, from: data)
        XCTAssertEqual(example.key, [])
    }
    
    func testNil() {
        let data = #"""
{}
"""#.data(using: .utf8)!
        do {
            let example = try JSONDecoder().decode(Example.self, from: data)
            XCTAssertEqual(example.key, [])
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func testMix() {
        let data = #"""
{"key":[null, 3, 1.0, "2", true, "false"]}
"""#.data(using: .utf8)!
        let example = try! JSONDecoder().decode(Example.self, from: data)
        XCTAssertEqual(example.key, [0, 3, 1, 2, 1, 0])
    }
}
