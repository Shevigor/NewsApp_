//
//  DataModel.swift
//  NewsApp_
//
//  Created by user on 14.06.2023.
//

import Foundation

struct NewsApi: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Identifiable {
    var id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let datePublished: Date
    let content: String
    
    
    enum CodingKeys: String, CodingKey {
        case source
        case author = "author"
        case title
        case description
        case url
        case urlToImage
        case datePublished = "publishedAt"
        case content
    }
}

struct Source: Codable {
    let id: String?
    let name: String
}
