//
//  CartView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartViewModel: CartViewModel // Use CartViewModel to manage cart items

    var body: some View {
        VStack {
            if cartViewModel.cartItems.isEmpty {
                // Display message if cart is empty
                Text("Your cart is empty.")
                    .font(.headline)
                    .padding()
            } else {
                List {
                    ForEach(cartViewModel.cartItems) { item in
                        HStack {
                            // Hstack to display row of each product in cart
                            AsyncImage(url: URL(string: item.thumbnail)) { image in image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                            } placeholder: {
                                ProgressView() // Placeholder while the image loads
                            }
                            
                            Text(item.title)
                                .font(.headline)
                                .lineLimit(1) // Limit title to one line
                            
                            Spacer()
                        
                            Text("$\(item.price, specifier: "%.2f")")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.primary)
                        
                        }
                        .padding(.vertical, 5) // Padding around each cart item so rows are spaced out evenly
                    }
                }
                .navigationTitle("Cart")

                // Calculate and display the total price with reduce function
                Text("Total: $\(cartViewModel.cartItems.reduce(0) { $0 + $1.price }, specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
        }
    }
}

#Preview {
    CartView().environmentObject(CartViewModel())
}
