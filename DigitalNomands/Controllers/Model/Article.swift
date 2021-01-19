//
//  Article.swift
//  DigitalNomands
//
//  Created by Viktor on 18.01.2021.
//

import Foundation

struct Article: Codable {
    let source: Source
    let author: String?
    let title, articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
