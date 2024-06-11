//
//  APIAccess.swift
//  WordCreate
//
//  Created by Jon Iger on 6/10/24.
//

import Foundation

struct APIAccess {
    static func getAPIKey() -> String {
        if let key = ProcessInfo.processInfo.environment["serpAPIKey"] {
            return key
        }
        return String()
    }
}
