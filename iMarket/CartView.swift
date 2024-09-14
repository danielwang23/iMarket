//
//  CartView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

struct CartView: View {
    @State private var cartItems = [Product]()

    var body: some View {
        VStack {
            List {
                ForEach(cartItems) { item in
                    HStack {
                        Text(item.title)
                        Spacer()
                        Text("$\(item.price, specifier: "%.2f")")
                    }
                }
            }
            .navigationTitle("Cart")
            Text("Total: $\(cartItems.reduce(0) { $0 + $1.price }, specifier: "%.2f")")
                .padding()
        }
    }
}

#Preview {
    CartView()
}
