//
//  ProductModel.swift
//  iMarket
//
//  Created by Daniel Wang on 9/13/24.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    let thumbnail: String
}

class ProductViewModel: ObservableObject {
    @Published var products = [Product]()
    
    func fetchProducts() {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let productList = try? decoder.decode([Product].self, from: data) {
                    DispatchQueue.main.async {
                        self.products = productList
                    }
                }
            }
        }.resume()
    }
}
