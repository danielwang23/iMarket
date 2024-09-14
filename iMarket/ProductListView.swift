//
//  ProductListView.swift
//  iMarket
//
//  Created by Daniel Wang on 9/14/24.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel = ProductViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.products.filter { product in
                    searchText.isEmpty || product.title.localizedCaseInsensitiveContains(searchText)
                }) { product in
                    HStack {
                        AsyncImage(url: URL(string: product.thumbnail))
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                        Spacer()
                        Button("Add to Cart") {
                            // Add to cart logic
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Products")
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}

#Preview {
    ProductListView()
}
