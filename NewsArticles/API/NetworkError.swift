//
//  NetworkError.swift
//  NewsArticles
//
//

import Foundation

enum NetworkError: Error {
    case errorSerializationJson
    case errorParsingJson
    case networkIsUnavailable
    case serverIsUnavailable
    case technicalErrorOnClientSide
    case requestTimedOut
    case unknown
    case tokenIsDead
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .technicalErrorOnClientSide:
            return "technical_error_on_client_side"
        case .errorParsingJson:
            return "error_parsing_json"
        case .errorSerializationJson:
            return "error_serialization_json"
        case .networkIsUnavailable:
            return "network_is_unavailable"
        case .serverIsUnavailable:
            return "server_is_unavailable"
        case .requestTimedOut:
            return "request_timed_out"
        case .tokenIsDead:
            return "token_is_dead"
        case .unknown:
            return "unknown_error"
        }
    }
}
