//
//  Country.swift
//  Countries
//
//  Created by Ivan Redreev on 10.10.2023.
//

import Foundation

struct Country: Codable {
    let name: Name?
    let flags: Flag?
    let currencies: [String: Currency]?
    let capital: [String]?
    let region: String?
    let timezones: [String]?
}
