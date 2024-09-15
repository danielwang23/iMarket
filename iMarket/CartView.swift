//
//  CartView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartViewModel: CartViewModel // [NEW] Use CartViewModel to manage cart items

    var body: some View {
        VStack {
            if cartViewModel.cartItems.isEmpty {
                // [NEW] Display message if cart is empty
                Text("Your cart is empty.")
                    .font(.headline)
                    .padding()
            } else {
                // List the cart items
                List {
                    ForEach(cartViewModel.cartItems) { item in
                        HStack {
                            Text(item.title)
                            Spacer()
                            Text("$\(item.price, specifier: "%.2f")")
                        }
                    }
                }
                .navigationTitle("Cart")

                // Display the total price
                Text("Total: $\(cartViewModel.cartItems.reduce(0) { $0 + $1.price }, specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
        }
    }
}

#Preview {
    CartView().environmentObject(CartViewModel()) //
}
