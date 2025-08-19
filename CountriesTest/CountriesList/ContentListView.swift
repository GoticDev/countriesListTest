//
//  ContentView.swift
//  CountriesTest
//
//  Created by Victor Raul De la Torre Anicama on 19/08/25.
//

import SwiftUI

struct ContentListView: View {
    
    @State var searchText: String = .empty
    @StateObject var viewModel = CountriesListViewModel()
    var userDefaultManager = UserdefaultsManager()
    @State var isFavorite = false
    
    private var filteredCountiesList: [CountriesListModel] {
        if searchText.isEmpty {
            return viewModel.countries
        } else {
            return viewModel.countries.filter { $0.name.common.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        
        NavigationView {
            List(filteredCountiesList) { countrie in
                NavigationLink(destination: CountryDetailView(name: countrie.name.common)) {
                    HStack {
                        AsyncImage(url: URL(string:countrie.flags.png)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 25)
                            case .failure(let error):
                                Image(systemName: "flag.slash.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 50)
                            @unknown default:
                                ProgressView()
                            }
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                Text(countrie.name.common)
                                    .font(.callout)
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: userDefaultManager.getFavorite(common: countrie.name.common) ? "heart.fill" : "heart")
                                    .foregroundStyle(userDefaultManager.getFavorite(common: countrie.name.common) ? .red : .gray)
                            }
                            Text(countrie.name.official)
                                .font(.footnote)
                                .fontWeight(.semibold)
                            Text(countrie.capital.first ?? Constanst.uknowed)
                                .font(.footnote)
                                .fontWeight(.regular)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle(Constanst.litTitle)
        }
        .padding()
        .alert(Constanst.errorMessage, isPresented: $viewModel.showAlert) {
            Button("OK") {
                viewModel.showAlert.toggle()
                viewModel.fetchList()
            }
        }
        .onAppear {
            viewModel.fetchList()
        }
    }
}

#Preview {
    ContentListView(viewModel: CountriesListViewModel())
}


