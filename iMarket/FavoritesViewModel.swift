//
//  FavoritesViewModel.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

// Instantiated as Observable object to update and refresh UI automatically when changed
class FavoritesViewModel: ObservableObject {
    @Published var favoriteItems: [Product] = [] // Array to store favorited items, updates automatically
       
    // Function to add a product to favorites
    func addToFavorites(product: Product) {
        if !favoriteItems.contains(where: { $0.id == product.id }) {
            favoriteItems.append(product)
        }
    }

    // Function to remove a product from favorites
    func removeFromFavorites(product: Product) {
        if let index = favoriteItems.firstIndex(where: { $0.id == product.id }) {
            favoriteItems.remove(at: index)
        }
    }

    // Check if a product is favorited. Function used in the OnAppear part of the ProductCardView file.
    func isFavorited(product: Product) -> Bool {
        return favoriteItems.contains(where: { $0.id == product.id })
    }
}
