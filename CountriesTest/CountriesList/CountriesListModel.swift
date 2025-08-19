//
//  CountriesListModel.swift
//  CountriesTest
//
//  Created by Victor Raul De la Torre Anicama on 19/08/25.
//

import Foundation

struct CountriesListModel: Identifiable, Codable {
    let id = UUID()
    let name: CountriesName
    let flags: CountriesFlags
    let capital: [String]
}

struct CountriesName: Codable {
    let common: String
    let official: String
}

struct CountriesFlags: Codable {
    let png: String
}
