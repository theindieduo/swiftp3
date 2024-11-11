//
//  MyLibrary222.swift
//  Pods
//
//  Created by Anshuman Patel on 11/11/24.
//

import Foundation

public class MyLibrary {
    public init() {}

    public func fetchQuotes(completion: @escaping (Result<[Quote], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/quotes") else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        print("Starting API request to \(url)")

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error during API request: \(error.localizedDescription)")
//                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data received")
//                completion(.failure(NSError(domain: "Data error", code: 0, userInfo: nil)))
                return
            }

            do {
                let quotesResponse = try JSONDecoder().decode(QuotesResponse.self, from: data)
                print("Successfully decoded response")
                print("decoded response : \(quotesResponse.quotes)")
//                completion(.success(quotesResponse.quotes))
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
//                completion(.failure(error))
            }
        }

        task.resume()
    }

    public func sayHello() {
        print("Hello")
    }
}

public struct Quote: Codable, Identifiable {
    public let id: Int
    public let quote: String
    public let author: String
}

public struct QuotesResponse: Codable {
    let quotes: [Quote]
}
