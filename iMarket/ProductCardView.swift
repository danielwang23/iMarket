//
//  ProductCardView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

struct ProductCardView: View {
    let product: Product // Constant product variable of type Product from productmodel holds all relevant product data
    
    // Environment functionality allows shared access to view model across multiple views
    @EnvironmentObject var cartViewModel: CartViewModel // Cart model manages cart items and keeps track of added products
    @EnvironmentObject var productViewModel: ProductViewModel // Product model to manage product list
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel // View model to manage favorites
    @State private var isFavorited = false // Track the heart button state confined only within this view

    var body: some View {
        HStack(alignment: .top) {
            // Hstack aligns pic and product details horizontally
            // Async remotely loads image without interfereing with UI
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView() // Temp. img placeholder spinner if pic doesn't load
            }

            VStack(alignment: .leading, spacing: 8) {
                
                // Product title and price aligned to left, 8 spacing between
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                
                // Fetch product price to 2 decimal points
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                // Displays the Category tag
                Text(product.category.capitalized)
                    .font(.caption)
                    .padding(5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)

                // Buttons: Add to Cart and Heart horizontally stacked
                HStack {
                    // Add to Cart button
                    Button(action: {
                        // Add product to cart
                        cartViewModel.addToCart(product: product)
                        // Remove product from product list
                        productViewModel.removeFromProductList(product: product)
                    }) {
                        Text("Add to Cart")
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity) // Button expands to available space
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    // Heart button for favorite
                    Button(action: {
                        isFavorited.toggle()
                        if isFavorited {
                            favoritesViewModel.addToFavorites(product: product)
                        } else {
                            favoritesViewModel.removeFromFavorites(product: product)
                        }
                    }) {
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
                            .foregroundColor(isFavorited ? .red : .gray) // Red when favorited, gray otherwise
                            .padding()
                    }
                }
            }
        }
        .padding(.vertical, 10) // vertical adding for each product card from each other
        .onAppear {
            // Sets initial isFavorited state based on if product already favorited or not based on function in FavoritesViewModel
            isFavorited = favoritesViewModel.isFavorited(product: product)
        }
    }
}

#Preview {
    // Create a sample product
    let sampleProduct = Product(id: 1, title: "Sample Product", price: 19.99, category: "Beauty", thumbnail: "https://via.placeholder.com/50")

    // Return the ProductCardView inside a view
    return Group {
    // Group allows for displaying multiple previews without creating a new view layer.
        ProductCardView(product: sampleProduct)
            // EnvObj's for similuating sampleProduct's functions as an actual object
            .environmentObject(CartViewModel())
            .environmentObject(ProductViewModel())
            .environmentObject(FavoritesViewModel())
    }
}
