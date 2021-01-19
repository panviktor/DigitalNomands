//
//  News.swift
//  DigitalNomands
//
//  Created by Viktor on 18.01.2021.
//

import Foundation
import Combine

// MARK: - News
struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

enum NewsAPI {
    static let maxPage = 5
    static func searchRepos(page: Int) -> AnyPublisher<[Article], Error> {
        let url = URL(string: "https://newsapi.org/v2/everything?q=ios&from=2019-04-00&sortBy=publishedAt&apiKey=26eddb253e7840f988aec61f2ece2907&page\(page)")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: {
                            print(NSString(data: $0.data,
                                           encoding: String.Encoding.utf8.rawValue)!)
            })
            .tryMap { try JSONDecoder().decode(News.self, from: $0.data).articles }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
