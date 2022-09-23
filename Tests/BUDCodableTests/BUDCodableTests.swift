import XCTest
@testable import BUDCodable

final class OOCodableTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        struct Example: Codable {
            @SafeInt var age
        }
        
        func testBool() {
            let data = #"""
    {"age":true}
    """#.data(using: .utf8)!
            let example = try! JSONDecoder().decode(Example.self, from: data)
            XCTAssertEqual(example.age, 1)
            
            let data2 = #"""
    {"age":false}
    """#.data(using: .utf8)!
            let example2 = try! JSONDecoder().decode(Example.self, from: data2)
            XCTAssertEqual(example2.age, 0)
        }
        
        func testInt() {
            let data = #"""
    {"age":3}
    """#.data(using: .utf8)!
            let example = try! JSONDecoder().decode(Example.self, from: data)
            XCTAssertEqual(example.age, 3)
            
            let data2 = #"""
    {"age":0}
    """#.data(using: .utf8)!
            let example2 = try! JSONDecoder().decode(Example.self, from: data2)
            XCTAssertEqual(example2.age, 0)
        }
        
        func testString() {
            let data = #"""
    {"age":"true"}
    """#.data(using: .utf8)!
            let example = try! JSONDecoder().decode(Example.self, from: data)
            XCTAssertEqual(example.age, 1)
            
            let data2 = #"""
    {"age":"false"}
    """#.data(using: .utf8)!
            let example2 = try! JSONDecoder().decode(Example.self, from: data2)
            XCTAssertEqual(example2.age, 0)
        }
        
        func testDouble() {
            let data = #"""
    {"age":1.00}
    """#.data(using: .utf8)!
            let example = try! JSONDecoder().decode(Example.self, from: data)
            XCTAssertEqual(example.age, 1)
            
            let data2 = #"""
    {"age":-1.0}
    """#.data(using: .utf8)!
            let example2 = try! JSONDecoder().decode(Example.self, from: data2)
            XCTAssertEqual(example2.age, -1)
        }
        
        testInt()
        testBool()
        testString()
        testDouble()
    }
    
    func testNullOrNil() {
        struct Example: Codable {
            @SafeInt var age
        }
        
        let data = #"""
{"age":null}
"""#.data(using: .utf8)!
        let example = try! JSONDecoder().decode(Example.self, from: data)
        XCTAssertEqual(example.age, 0)
        
        let data2 = #"""
{}
"""#.data(using: .utf8)!
        let example2 = try! JSONDecoder().decode(Example.self, from: data2)
        XCTAssertEqual(example2.age, 0)
    }
}
