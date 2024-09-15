//
//  ProductListView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("What are you looking for?", text: $searchText)
                    .padding(.horizontal)
                    .frame(height: 40)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal) // Ensure the search bar stays at the top with padding
                
                // Scrollable content
                ScrollView {
                    let filteredProducts = productViewModel.products.filter { product in
                        searchText.isEmpty || product.title.localizedCaseInsensitiveContains(searchText)
                    }

                    if filteredProducts.isEmpty {
                        // Show a message when no products match the search
                        Text("No products found")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center) // Center the text
                    } else {
                        // List of products
                        LazyVStack {
                            ForEach(filteredProducts) { product in
                                ProductCardView(product: product)
                                    .environmentObject(cartViewModel)
                                    .environmentObject(productViewModel) // Pass productViewModel to ProductCardView
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Products")
            .onAppear {
                if productViewModel.products.isEmpty {
                    productViewModel.fetchProducts()
                }
                // Debugging statement
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Give it some time to fetch
                    print("Total fetched products: \(productViewModel.products.count)")
                    let filteredProducts = productViewModel.products.filter { product in
                        searchText.isEmpty || product.title.localizedCaseInsensitiveContains(searchText)
                    }
                    print("Filtered products count: \(filteredProducts.count)") // Debugging count
                }
            }
        }
    }
}

#Preview {
    ProductListView()
        .environmentObject(CartViewModel())
        .environmentObject(FavoritesViewModel())
        .environmentObject(ProductViewModel())
}
