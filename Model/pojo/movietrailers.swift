//
//  movietrailers.swift
//  project
//
//  Created by Maram Waleed on 10/08/2021.
//

import Foundation


struct Trailer: Codable {
    let iso639_1, iso3166_1: String?
    let name: String?
    let key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
