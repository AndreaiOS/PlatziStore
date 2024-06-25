//
//  ProductDetailView.swift
//  PlatziStore
//
//  Created by Andrea Murru on 24/06/2024.
//

import SwiftUI

struct ProductDetailView: View {
    let productId: Int
    @ObservedObject var viewModel: ProductsViewModel
    @State private var currentTab = 0

    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.selectedProduct == nil {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else if let product = viewModel.selectedProduct {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(product.title)
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal)
                            .padding(.top)
                            .multilineTextAlignment(.center)
                        
                        TabView(selection: $currentTab) {
                            ForEach(product.images, id: \.self) { imageUrl in
                                if let url = URL(string: imageUrl) {
                                    CachedAsyncImage(url: url)
                                        .ignoresSafeArea()
                                        .tag(product.images.firstIndex(of: imageUrl) ?? 0)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 300)
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        .onAppear {
                            animateTabView()
                        }
                        
                        HStack {
                            Spacer()
                            Text(product.price.formatted(.number.precision(.fractionLength(2))) + "$")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Text(product.description)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle("Product Detail")
        .onAppear {
            Task {
                await viewModel.fetchProduct(id: productId)
            }
        }
        .background(Color(UIColor.systemBackground))
    }
    
    private func animateTabView() {
        if let product = viewModel.selectedProduct {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                withAnimation {
                    currentTab = (currentTab + 1) % product.images.count
                }
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                    withAnimation {
                        currentTab = 0
                    }
                }
            }
        }
    }
}
