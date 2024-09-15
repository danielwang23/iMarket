//
//  ContentView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/13/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cartViewModel = CartViewModel()
    var body: some View {
        let favoritesViewModel = FavoritesViewModel()
        let productViewModel = ProductViewModel() // Create product view model
        
        TabView {
            ProductListView(
                onAddToCart: { product in
                        cartViewModel.addToCart(product: product)
                        productViewModel.removeFromProductList(product: product)
                    }
            ) // Product List View for the "Products" tab
                .tabItem {
                    Image(systemName: "carrot.fill") // Replace with carrot icon, you can use SFSymbols or custom icon
                    Text("Products")
                }
            
            MyItemsView() // Placeholder for "My Items" tab
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("My Items")
                }
                
            
            CartView() // Placeholder for "Cart" tab
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }
                
        }
        .environmentObject(cartViewModel)
        .environmentObject(favoritesViewModel)
        .environmentObject(ProductViewModel())
        .accentColor(.blue) // Customize this color to suit your design
    }
}

#Preview {
    ContentView()
}
