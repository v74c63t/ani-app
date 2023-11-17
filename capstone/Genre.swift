//
//  Genre.swift
//  capstone
//
//  Created by Vanessa Tang on 11/16/23.
//

import Foundation

struct GenreFeed: Decodable {
    let data: [Genre]
}

struct Genre: Decodable {
    let name: String
    let malId: Decimal

    // MARK: Custom coding keys
    // Allows us to map the property keys returned from the API that use underscores (i.e. `poster_path`)
    // to a more "swifty" lowerCamelCase naming (i.e. `posterPath` and `backdropPath`)
    enum CodingKeys: String, CodingKey {
        case name
        case malId = "mal_id"
    }
}
