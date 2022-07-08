//
//  main.swift
//  TestJSONString
//
//  Created by Brook16 on 2022/7/8.
//

import Foundation

struct Token: Codable {
    @JSONString var body: Body?
    // var body: String?
}

struct Body: Codable {
    var timestamp: String?
}

var badJsonString = #"""
{"body":"{\"timestamp\":\"2022-07-08 15:39:30\"}"}
"""#


func foo(string: String) throws {
    let data = string.data(using: .utf8)!
    let ret = try JSONDecoder().decode(Token.self, from: data)
    print("timestamp:", ret.body?.timestamp ?? "null")

    let obj = try JSONSerialization.jsonObject(with: data)
    print(obj)
}

let value = """
{\"timestamp\":\"2022\"}
"""

func bar() -> String {
    let obj = ["body": value]
    let data = try! JSONSerialization.data(withJSONObject: obj, options: [.fragmentsAllowed])
    let string = String(data: data, encoding: .utf8)!
    print(string)
    
    return string
}

// _ = bar()

do {
    try foo(string: badJsonString)
} catch {
    print(error)
}

/*
{\"ret_code\":\"0\",\"ret_msg\":\"成功\",\"serial_number\":\"20211002115646portal511788\",\"timestamp\":\"2021-10-02 03:56:46\",\"response_data\":{\"token\":\"0765499c-8643-4491-8c8e-50f92a2ea004\",\"expiredMills\":1633751806616}}
*/
/*
 {
     "body": "{"timestamp":"2021-10-02 03:56:46"}"
 }

 */
