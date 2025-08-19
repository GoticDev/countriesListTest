//
//  CountriesListViewModel.swift
//  CountriesTest
//
//  Created by Victor Raul De la Torre Anicama on 19/08/25.
//

import Foundation

//protocol CountriesListProtocol: AnyObject {
//    func fetchList()
//    var countries: [CountriesListModel] { get set }
//}

class CountriesListViewModel: ObservableObject {
    @Published var countries: [CountriesListModel] = []
    
    @MainActor
    func fetchList() {
        
        let url = "https://restcountries.com/v3.1/all?fields=name,flags,capital"
        guard let urlRequest = URL(string: url) else {
            //send error
            return }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data, error == nil else {
                //send error
                return
            }
            
            do {
                let json = try JSONDecoder().decode([CountriesListModel].self, from: data)
                print(json)
                DispatchQueue.main.async {
                    self.countries = json.sorted(by: { $0.name.common < $1.name.common })
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}

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
