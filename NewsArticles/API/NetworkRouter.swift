    //
    //  NetworkRouter.swift
    //  NewsArticles
    //
    //  Created by Anastasia Kholod on 18.06.2022.
    //

import Foundation

enum Router {
    case getTopHeadlines
    case getSearchResults
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        default:
            return "gnews.io"
        }
    }
    
    var path: String {
        switch self {
        case .getTopHeadlines:
            return "/api/v4/top-headlines"
        case .getSearchResults:
            return "/api/v4/search"
        }
    }
    
    var parameters: [URLQueryItem] {
        let accessToken = "b374470e3362515c855f32de7dd466dd"
        switch self {
        case .getTopHeadlines:
            return [URLQueryItem(name: "lang", value: "uk"),
                    URLQueryItem(name: "token", value: accessToken)]
        case .getSearchResults:
            return [URLQueryItem(name: "lang", value: "uk"),
                    URLQueryItem(name: "token", value: accessToken)]
        }
    }
    
    var method: String {
        switch self {
        case .getTopHeadlines, .getSearchResults:
            return "GET"
        }
    }
}

