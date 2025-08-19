//
//  CountriesListViewModel.swift
//  CountriesTest
//
//  Created by Victor Raul De la Torre Anicama on 19/08/25.
//

import SwiftUI

class CountriesListViewModel: ObservableObject {
    @Published var countries: [CountriesListModel] = []
    @Published var showAlert = false
    var userDefaultManager = UserdefaultsManager()
    
    func fetchList() {
        let url = Endpoints.allCountries.url
        guard let urlRequest = URL(string: url) else {
            self.showAlert = true
            return }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data, error == nil else {
                self.showAlert = true
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let json = try JSONDecoder().decode([CountriesListModel].self, from: data)
                    self.countries = json.sorted(by: { $0.name.common < $1.name.common })
                    self.userDefaultManager.saveCountries(countries: json)
                } catch {
                    self.showAlert = true
                }
            }
        }.resume()
    }
}
