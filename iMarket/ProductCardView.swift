//
//  ProductCardView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

struct ProductCardView: View {
    let product: Product
    @State private var isFavorited = false // Track the heart button state
    @EnvironmentObject var cartViewModel: CartViewModel // Cart model to manage cart items
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @EnvironmentObject var productViewModel: ProductViewModel // Product model to manage product list
    var onAddToCart: () -> Void // Closure to remove product from product list
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100) // Adjust image height
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading, spacing: 8) {
                // Product title and price
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                // Category tag
                Text(product.category.capitalized)
                    .font(.caption)
                    .padding(5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)

                // Buttons: Add to Cart and Heart (for favorite)
                HStack {
                    // Add to Cart button
                    Button(action: {
                        // Only add product to cart on this button tap
                        cartViewModel.addToCart(product: product)
                        onAddToCart() // Trigger the removal of the product
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
                        // Only fill heart when this button is pressed
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
        .padding(.vertical, 10) // Padding for the product card
        .onAppear {
                    isFavorited = favoritesViewModel.isFavorited(product: product)
                }
    }
}
#Preview {
    // Create a sample product
    let sampleProduct = Product(id: 1, title: "Sample Product", price: 19.99, category: "Beauty", thumbnail: "https://via.placeholder.com/50")

    // Return the ProductCardView inside a view (like Group)
    return Group {
        ProductCardView(product: sampleProduct,
            onAddToCart: {
                // For preview, you can just print a message
                print("Add to cart tapped for preview")
            }
        )
        .environmentObject(CartViewModel()) // Attach CartViewModel for preview
            .environmentObject(FavoritesViewModel())
            .environmentObject(ProductViewModel())
    }
}