//
//  ProductListView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

struct ProductListView: View {
    // Again, EnvOBj allows the observable object models to be shared on this view
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    // State var that will trigger UI updates to serach bar when changed
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
                    .padding(.horizontal)
                
                // Scrollable content
                ScrollView {
                    // Makes a filtered list of products based on search text OR if search text is empty (stores all products in this case)
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
                        // List products based on search
                        LazyVStack {
                        // LazyVStack only renders visible items. (Better performance)
                            ForEach(filteredProducts) { product in
                                ProductCardView(product: product)
                                    .environmentObject(cartViewModel)
                                    .environmentObject(productViewModel)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Products") //Title of the view page
            .onAppear {
                if productViewModel.products.isEmpty {
                    productViewModel.fetchProducts()
                }
                
                // Debugging statement to see if products actually fetched (I copied from GPT)
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
