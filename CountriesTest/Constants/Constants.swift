//
//  Constants.swift
//  CountriesTest
//
//  Created by Victor Raul De la Torre Anicama on 19/08/25.
//

import Foundation

enum Endpoints {
    case allCountries
    case countryDetail(String)
    
    var url: String {
        switch self {
        case .allCountries:
            return "https://restcountries.com/v3.1/all?fields=name,flags,capital"
        case .countryDetail(let name):
            return "https://restcountries.com/v3.1/name/\(name)?fullText=false"
        }
    }
}


struct Constanst {
    static var litTitle = "Countries List"
    static var uknowed = "uknowed capital"
    static var errorMessage = "Hubo un error por favor intentalo nuevamente!"
}
