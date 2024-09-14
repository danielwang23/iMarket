//
//  ContentView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView {
                ProductListView()
                    .tabItem {
                        Label("Products", systemImage: "list.bullet")
                    }
                CartView()
                    .tabItem {
                        Label("Cart", systemImage: "cart")
                    }
            }
        }
}

#Preview {
    ContentView()
}
