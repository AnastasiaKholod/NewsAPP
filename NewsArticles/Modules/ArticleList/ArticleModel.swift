//
//  ArticleModel.swift
//  NewsArticles
//
//  Created by Anastasia Kholod on 29.05.2022.
//

import Foundation

struct ArticlesResponse: Codable {
    var totalArticles: Int
    var articles: [Article]
}

struct Article: Codable {
    var title: String
    var description: String
    var content: String
    var image: String
    var publishedAt: String
    var source: Source
}

struct Source: Codable {
    var name: String
    var url: String
}
 
