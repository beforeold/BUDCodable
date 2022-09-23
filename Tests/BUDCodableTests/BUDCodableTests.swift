import XCTest
@testable import BUDCodable

final class BUDCodableTests: XCTestCase {
    struct Example: Codable {
        @SafeInt var age
    }

    func testInt() throws {
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
    
    func testNull() {
        let data = #"""
{"age":null}
"""#.data(using: .utf8)!
        let example = try! JSONDecoder().decode(Example.self, from: data)
        XCTAssertEqual(example.age, 0)
    }
    
    func testNil() {
        let data = #"""
{}
"""#.data(using: .utf8)!
        let example = try! JSONDecoder().decode(Example.self, from: data)
        XCTAssertEqual(example.age, 0)
    }
}

