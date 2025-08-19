//
//  CountryDetailViewModel.swift
//  CountriesTest
//
//  Created by Victor Raul De la Torre Anicama on 19/08/25.
//

import Foundation

class CountryDetailViewModel: ObservableObject {
    @Published var countriDetail: CountryDetailModel?
    
    func fetchCountryDetail(name: String) {
        let url = "https://restcountries.com/v3.1/name/\(name)?fullText=false"
        guard let urlRequest = URL(string: url) else {
            //error
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data, error == nil else {
                //error
                return
            }
            do {
                let json = try JSONDecoder().decode([CountryDetailModel].self, from: data)
                print(json)
                DispatchQueue.main.async {
                    self.countriDetail = json.first
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

struct CountryDetailModel: Codable {
    let name: CountryDetailName
    let flags: CountriesFlags
    let coatOfArms: CountryCoatOfArms
    let population: Int
    let area: Double
    let region: String
    let subregion: String
    let languages: CountryLanguages
    let car: CarDrivenSide
    let capital: [String]
    let currencies: CountryCurrencies
    let timezones: [String]
}

struct CountryDetailName: Codable {
    let common: String
    let official: String
}

struct CountryCoatOfArms: Codable {
    let png: String
}

struct CountryLanguages: Codable {
    let spa: String?
    let eng: String?
    let gle: String?
}

struct CarDrivenSide: Codable {
    let side: String
    
    var drivenSide: CardDrive {
        side == "left" ? .left : .right
    }
    
    enum CardDrive: String {
        case right = "RIGHT"
        case left = "LEFT"
    }
}

struct CountryCurrencies: Codable {
    let eur: Currencie?
    let gbp: Currencie?
    let ars: Currencie?
    let pen: Currencie?
    
    enum CodingKeys: String, CodingKey {
        case eur = "EUR"
        case gbp = "GBP"
        case ars = "ARS"
        case pen = "PEN"
    }
}

struct Currencie: Codable {
    let symbol: String?
    let name: String?
}
