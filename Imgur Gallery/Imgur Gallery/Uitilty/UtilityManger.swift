//
//  UtilityManger.swift
//  Imgur Gallery
//
//  Created by Jigar Shethia on 11/01/24.
//

import Foundation
struct URLManager {
    static let baseURL = URL(string: "https://api.imgur.com")!
    static func topWeek() -> URL {
        return baseURL.appendingPathComponent("/3/gallery/top/week")
    }
}

// keychain can be used instead
struct UserDetails {
    static let clientID = "0c8678d11c586a4" 
}

