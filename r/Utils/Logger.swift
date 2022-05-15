//
//  Logger.swift
//  r
//
//  Created by e on 5/10/22.
//

import Foundation

struct Logger {
    static let prefix = "rapp/v0"
    
    static func debug(_ message: String) {
        NSLog("[\(prefix)] [DEBUG] \(message)")
    }
    
    static func error(_ message: String) {
        NSLog("[\(prefix)] [ERROR] \(message)")
    }
}
