//
//  Anime.swift
//  capstone
//
//  Created by Vanessa Tang on 11/15/23.
//

import Foundation

struct AnimeFeed: Decodable {
    let data: [Anime]
}

struct Anime: Decodable {
    let title: String
    let synopsis: String
    let imageUrl: String? // Path used to create a URL to fetch the poster image

    // MARK: Additional properties for detail view
    let smallImageUrl: String? // Path used to create a URL to fetch the backdrop image
    let score: Double
//    let releaseDate: Date?
    let malId: Decimal

    // MARK: Custom coding keys
    // Allows us to map the property keys returned from the API that use underscores (i.e. `poster_path`)
    // to a more "swifty" lowerCamelCase naming (i.e. `posterPath` and `backdropPath`)
    enum CodingKeys: String, CodingKey {
        case title
        case synopsis
        case imageUrl = "image_url"
        case smallImageUrl = "small_image_url"
//        case releaseDate = "release_date"
//        case voteAverage = "vote_average"
        case score
        case malId = "mal_id"
    }
}

struct Images: Decodable {
    
}
