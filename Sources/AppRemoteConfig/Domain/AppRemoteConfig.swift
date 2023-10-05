//
//  SecurityConfig.swift
//  SecurityUpdate
//
//  Created by balachandran on 24/08/23.
//

import Foundation

struct AppRemoteConfig: Codable {
    let agsense: SecurityConfig
}

struct SecurityConfig: Codable {
    let security: ForcePasswordUpdateModel
}

struct ForcePasswordUpdateModel: Codable {
    let interval: String
    let isLaterAllowed: Bool
    let isTurnedOff: Bool
}
