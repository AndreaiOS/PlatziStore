//
//  FiltersView.swift
//  PlatziStore
//
//  Created by Andrea Murru on 25/06/2024.
//

import SwiftUI

struct FiltersView: View {
    @Binding var showFilters: Bool
    @ObservedObject var viewModel: ProductsViewModel
    @Binding var categoriesLoaded: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Filters")
                .font(.largeTitle)
                .foregroundColor(Color.primary)
            
            Divider()
            
            Text("Search")
                .foregroundColor(Color.primary)
            
            TextField("Search", text: $viewModel.searchText)
                .foregroundColor(Color.primary)
                .textFieldStyle(.roundedBorder)
            
            Divider()
            
            CategoryPicker(categoriesLoaded: $categoriesLoaded, viewModel: viewModel)
            
            Divider()
            
            PriceRangeSlider(label: "PriceMin", value: $viewModel.priceMin)
            PriceRangeSlider(label: "PriceMax", value: $viewModel.priceMax)
            
            Divider()
            
            Button {
                showFilters = false
            } label: {
                Text("Done")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
            .background(Color.blue)
            .cornerRadius(25)
            
            Button {
                clearFilters()
            } label: {
                Text("Clear")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.green, lineWidth: 2)
                    )
            }
            .background(Color.green)
            .cornerRadius(25)
            
            Spacer()
        }
        .padding()
    }
    
    private func clearFilters() {
        viewModel.currentCategoryID = nil
        viewModel.searchText = ""
        viewModel.priceMin = 0
        viewModel.priceMax = 1000
    }
}
