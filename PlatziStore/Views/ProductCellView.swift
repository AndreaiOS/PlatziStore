//
//  ProductCellView.swift
//  PlatziStore
//
//  Created by Andrea Murru on 24/06/2024.
//

import SwiftUI

struct ProductCellView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading) {
            if let imageString = product.images.first, let url = URL(string: imageString) {
                CachedAsyncImage(url: url)
                    .frame(height: 150)
                    .cornerRadius(8)
                    .padding(.bottom, 8)
            }
            
            Text(product.title)
                .multilineTextAlignment(.leading)
                .font(.headline)
                .foregroundColor(Color.primary)
                .lineLimit(2)
                .frame(minHeight: 40)
                .padding(.bottom, 4)

            Text(product.description)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .foregroundColor(Color.secondary)
                .lineLimit(2)
                .frame(minHeight: 40)
                .padding(.bottom, 4)

            HStack {
                Spacer()
                Text(product.price.formatted(.number.precision(.fractionLength(2))) + "$")
                    .font(.headline)
                    .foregroundColor(Color.primary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}
