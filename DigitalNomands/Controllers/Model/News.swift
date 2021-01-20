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
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}
