//
//  UserdefaultManager.swift
//  CountriesTest
//
//  Created by Victor Raul De la Torre Anicama on 19/08/25.
//

import Foundation

class UserdefaultsManager {
    struct Constants {
        static var favorite = "favoritos"
    }
    
    var defaults: UserDefaults
    
    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }
    
    var countriesStoreList: [UDModel]? {
        get {
            guard let data = defaults.data(forKey: Constants.favorite) else { return nil }
            return decodeEntityFrom(data: data, expectedType: [UDModel].self)
        }
        
        set {
            defaults.set(encodeEntity(entity: newValue), forKey: Constants.favorite)
        }
    }
    
    func saveCountries(countries: [CountriesListModel]) {
        if let countriesStoreList, countriesStoreList.count > 0 {
            return
        } else {
            countriesStoreList = countries.map({ .init(common: $0.name.common, isFavorite: false) })
        }
    }
    
    func setFavorite(common: String) {
        guard var newList = countriesStoreList else { return }
        for i in 0...newList.count-1 {
            if newList[i].common == common {
                newList[i].isFavorite = !newList[i].isFavorite
            }
        }
        countriesStoreList = newList
    }
    
    func getFavorite(common: String) -> Bool {
        guard let favorite = countriesStoreList?.filter({ $0.common == common }).first?.isFavorite else { return false }
        return favorite
    }
    
    func encodeEntity<T: Codable>(entity: T) -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(entity)
    }
    
    func decodeEntityFrom<T: Codable>(data: Data, expectedType: T.Type) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(expectedType, from: data)
    }
}

struct UDModel: Codable {
    var common: String
    var isFavorite: Bool = false
}
