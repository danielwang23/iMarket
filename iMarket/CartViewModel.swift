//
//  CartViewModel.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cartItems: [Product] = [] // Array to store the cart items

    // Function to add a product to the cart
    func addToCart(product: Product) {
        cartItems.append(product)
    }

    // Function to remove a product from the cart (optional)
    func removeFromCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
            cartItems.remove(at: index)
        }
    }
}
