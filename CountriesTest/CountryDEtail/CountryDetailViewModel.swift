//
//  CountryDetailViewModel.swift
//  CountriesTest
//
//  Created by Victor Raul De la Torre Anicama on 19/08/25.
//

import Foundation

class CountryDetailViewModel: ObservableObject {
    @Published var countriDetail: CountryDetailModel?
    @Published var showAlert = false
    
    func fetchCountryDetail(name: String) {
        let url = Endpoints.countryDetail(name).url
        guard let urlRequest = URL(string: url) else {
            showAlert = true
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data, error == nil else {
                self.showAlert = true
                return
            }
            DispatchQueue.main.async {
                do {
                    let json = try JSONDecoder().decode([CountryDetailModel].self, from: data)
                    self.countriDetail = json.first
                } catch {
                    self.showAlert = true
                }
            }
        }.resume()
    }
}

