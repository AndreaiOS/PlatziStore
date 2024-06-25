//
//  CategoryPicker.swift
//  PlatziStore
//
//  Created by Andrea Murru on 25/06/2024.
//

import SwiftUI

struct CategoryPicker: View {
    @Binding var categoriesLoaded: Bool
    @ObservedObject var viewModel: ProductsViewModel
    
    var body: some View {
        HStack {
            Text("Select category")
                .foregroundColor(Color.primary)
            
            Picker("Category", selection: $viewModel.currentCategoryID) {
                Text("All").tag(Int?.none)
                ForEach(viewModel.categories, id: \.id) { category in
                    Text(category.name).tag(Int?.some(category.id))
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onAppear {
                Task {
                    if (!categoriesLoaded) {
                        await viewModel.fetchCategories()
                        categoriesLoaded = true
                    }
                }
            }
        }
    }
}
