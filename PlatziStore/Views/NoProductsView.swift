//
//  NoProductsView.swift
//  PlatziStore
//
//  Created by Andrea Murru on 25/06/2024.
//

import SwiftUI

struct NoProductsView: View {
    let isSearching: Bool
    let productsLoaded: Bool
    let onTryAgain: () -> Void
    
    var body: some View {
        VStack {
            Text("No products matching your criteria were found; please check your filters and try again")
                .font(.headline)
                .padding()
            if !isSearching && productsLoaded {
                Button("Try again") {
                    onTryAgain()
                }
            }
            Spacer()
        }
    }
}
