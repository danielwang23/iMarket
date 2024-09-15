//
//  ContentView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/13/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cartViewModel = CartViewModel()
    @StateObject var productViewModel = ProductViewModel()

    var body: some View {
        let favoritesViewModel = FavoritesViewModel()
        
        TabView {
           // Product List View for the "Products" tab
           ProductListView()
                .tabItem {
                    Image(systemName: "carrot.fill")
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
        .environmentObject(productViewModel)
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
}
