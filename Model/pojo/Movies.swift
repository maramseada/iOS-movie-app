//
//  Movies.swift
//  project
//
//  Created by Maram Waleed on 08/08/2021.
//

import Foundation
struct Welcome: Codable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
   let id: Int?
    let originalTitle, overview: String?
    let posterPath, releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case cn = "cn"
    case de = "de"
    case en = "en"
    case es = "es"
}

