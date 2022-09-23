//
//  JSONStringTests.swift
//  
//
//  Created by beforeold on 2022/9/23.
//

import XCTest
@testable import BUDCodable

class JSONStringTests: XCTestCase {

  
    struct Token: Decodable {
        @JSONString var body: Body?
        
        // var body: String?
    }

    struct Body: Decodable {
        var timestamp: String?
    }

    func test(string: String) {
        do {
            let data = string.data(using: .utf8)!
            let ret = try JSONDecoder().decode(Token.self, from: data)
            XCTAssertEqual(ret.body?.timestamp, "2022-07-08 15:39:30")
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func testJSONStringWithWrongString() {
        do {
            let string = #"""
            {
                "body" : "{\"timestamp\":\"2022-07-08 15:39:30\"}"
            }
            """#
            test(string: string)
        }
    }
    
    func testJSONStringWithRightJSON() {
        do {
            let string = #"""
            {
            "body": {
                    "timestamp":"2022-07-08 15:39:30"
                }
            }
            """#
            test(string: string)
        }
    }

    /*
    {\"ret_code\":\"0\",\"ret_msg\":\"成功\",\"serial_number\":\"20211002115646portal511788\",\"timestamp\":\"2021-10-02 03:56:46\",\"response_data\":{\"token\":\"0765499c-8643-4491-8c8e-50f92a2ea004\",\"expiredMills\":1633751806616}}
    */
    /*
     {
         "body": "{"timestamp":"2021-10-02 03:56:46"}"
     }

     */


}
