//
//  ContentView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/13/24.
//

import SwiftUI

struct ContentView: View {
    // State Object to manage and create the lifecycle of the CartViewModel and ProductViewModel
    // Can then be passed into EnvObj as shown below in lines 41-44
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
            
            MyItemsView() // "My Items" tab
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("My Items")
                }
                
            
            CartView() // "Cart" tab
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }
                
        }
        // Child views can now access viewmodels without recreating them.
        .environmentObject(cartViewModel)
        .environmentObject(favoritesViewModel)
        .environmentObject(productViewModel)
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
}
