//
//  StringUitl.swift
//  
//
//  Created by beforeold on 2022/9/22.
//

import Foundation

internal struct StringUitl {
    static func isTrue(string: String) -> Bool {
        return string.hasPrefix("T") || string.hasPrefix("t")
    }
}
