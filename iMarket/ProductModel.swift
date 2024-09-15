//
//  ProductModel.swift
//  iMarket
//
//  Created by Daniel Wang on 9/13/24.
//

import Foundation

// Product struct
struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    let thumbnail: String
}

// Response struct for API
struct ProductResponse: Codable {
    let products: [Product]
}

// ViewModel class to fetch data from API
class ProductViewModel: ObservableObject {
    @Published var products = [Product]()
    
    func fetchProducts() {
        
        //        let mockProducts = [
        //                    Product(id: 1, title: "Sample Product 1", price: 10.99, category: "Category 1", thumbnail: "https://via.placeholder.com/150"),
        //                    Product(id: 2, title: "Sample Product 2", price: 12.99, category: "Category 2", thumbnail: "https://via.placeholder.com/150"),
        //                    Product(id: 3, title: "Sample Product 3", price: 8.99, category: "Category 3", thumbnail: "https://via.placeholder.com/150")
        //                ]
        //
        //                DispatchQueue.main.async {
        //                    self.products = mockProducts
        //                }
                
        guard let url = URL(string: "https://dummyjson.com/products") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
                   if let data = data {
                       let decoder = JSONDecoder()
                       if let productList = try? decoder.decode(ProductResponse.self, from: data) {
                           DispatchQueue.main.async {
                               self.products = productList.products
                           }
                       }
                   }
               }.resume()
    }
    
    func removeFromProductList(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products.remove(at: index)
        }
    }
}

