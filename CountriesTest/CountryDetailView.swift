//
//  CountryDetailView.swift
//  CountriesTest
//
//  Created by Victor Raul De la Torre Anicama on 19/08/25.
//

import SwiftUI

struct CountryDetailView: View {
    let name: String
    @StateObject var viewModel = CountryDetailViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                HStack {
                    AsyncImage(url: URL(string: viewModel.countriDetail?.flags.png ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 40)
                        case .failure(let error):
                            Image(systemName: "flag.slash.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 50)
                        @unknown default:
                            ProgressView()
                        }
                    }
                    Spacer()
                }
               
                Text(viewModel.countriDetail?.name.common ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 20)
                Text(viewModel.countriDetail?.name.official ?? "")
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Cost of Arms")
                            .font(.body)
                            .fontWeight(.semibold)
                        
                        AsyncImage(url: URL(string: viewModel.countriDetail?.coatOfArms.png ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            case .failure(let error):
                                Image(systemName: "flag.slash.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 50)
                            @unknown default:
                                ProgressView()
                            }
                        }
                        
                        Text("Region")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        Text(viewModel.countriDetail?.region ?? "")
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Text("Subregion")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        Text(viewModel.countriDetail?.subregion ?? "")
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Text("Capital")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        Text(viewModel.countriDetail?.capital.first ?? "")
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Text("Area")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        Text("\(viewModel.countriDetail?.area ?? 0)")
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Spacer()
                    }
                    
                    VStack {
                        Text("Population")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        Text("\(viewModel.countriDetail?.area ?? 0)")
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Text("Language(s)")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        Text(viewModel.countriDetail?.languages.eng ?? "English")
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Text("Car Driver Side")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        HStack {
                            Spacer()
                            Text("LEFT")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundStyle(viewModel.countriDetail?.car.drivenSide == .left ? .gray : .black)
                            Image(systemName: "car.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("RIGHT")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundStyle(viewModel.countriDetail?.car.drivenSide == .right ? .gray : .black)
                            
                            
                        }
                        .padding(.trailing, 30)
                        
                        Text("Currencie(s)")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        Text("\(viewModel.countriDetail?.currencies.eur?.name ?? "Dol") (\(viewModel.countriDetail?.currencies.eur?.symbol ?? "$") \(viewModel.countriDetail?.currencies.eur?.name ?? "dolar"))")
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Spacer()
                    }
                }
                .padding(.top, 20)
                
                
                Spacer()
            }
            .padding(.leading, 40)
            .padding(.top, 40)
        }
        
        .onAppear {
            viewModel.fetchCountryDetail(name: self.name)
        }
    }
}

#Preview {
    CountryDetailView(name: "Peru")
}
