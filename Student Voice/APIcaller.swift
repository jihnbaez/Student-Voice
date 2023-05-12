//
//  APICaller.swift
//  NewsApp
//
//  Created by Afraz Siddiqui on 5/12/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()

    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=schools&apiKey=b300d636aa8b4ba895ec11d18d842458")
        static let searchUrlString = "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=b300d636aa8b4ba895ec11d18d842458"
    }

    private init() {}

    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {

                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)

                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    public func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }

        let urltring = Constants.searchUrlString + query
        guard let url = URL(string: urltring) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {

                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)

                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}

// Models

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
