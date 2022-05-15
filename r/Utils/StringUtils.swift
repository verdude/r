//
//  StringUtils.swift
//  r
//
//  Created by e on 5/10/22.
//

import Foundation

func replaceHTMLEncoding(for: String) -> String {
    return `for`.replacingOccurrences(of: "&amp;", with: "&")
}
