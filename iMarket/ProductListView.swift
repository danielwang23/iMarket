//
//  ProductListView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel = ProductViewModel()
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var searchText = ""
    
    var onAddToCart: (Product) -> Void

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
                        let filteredProducts = viewModel.products.filter { product in
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
                                    ProductCardView(
                                        product: product,
                                        onAddToCart: {
                                            cartViewModel.addToCart(product: product)
                                            viewModel.removeFromProductList(product: product)
                                        }
                                    )
                                    .environmentObject(cartViewModel)
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Products")
                .onAppear {
                    viewModel.fetchProducts() // Fetch products from API

                    // Debugging statement
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Give it some time to fetch
                            print("Total fetched products: \(viewModel.products.count)")
                            let filteredProducts = viewModel.products.filter { product in
                                searchText.isEmpty || product.title.localizedCaseInsensitiveContains(searchText)
                            }
                            print("Filtered products count: \(filteredProducts.count)") // Debugging count
                        }
                }
            }
        }
}

#Preview {
    ProductListView(onAddToCart: { product in
            print("Added \(product.title) to the cart in preview.")
        })
        .environmentObject(CartViewModel())
        .environmentObject(FavoritesViewModel())
        .environmentObject(ProductViewModel())
}
