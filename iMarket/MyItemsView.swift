//
//  MyItemsView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

struct MyItemsView: View {
    // EnvObj is a shared instance of FavoritesViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel

    var body: some View {
        NavigationView {
            VStack {
                if favoritesViewModel.favoriteItems.isEmpty {
                    Text("No favorite items.")
                        .font(.headline)
                        .padding()
                } else {
                    List(favoritesViewModel.favoriteItems) { product in
                        HStack {
                            AsyncImage(url: URL(string: product.thumbnail)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .cornerRadius(5)
                            } placeholder: {
                                ProgressView()
                            }

                            VStack(alignment: .leading) {
                                Text(product.title)
                                    .font(.headline)
                                Text("$\(product.price, specifier: "%.2f")")
                                    .font(.subheadline)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("My Items")
        }
    }
}
#Preview {
    MyItemsView()
        .environmentObject(FavoritesViewModel())
}
