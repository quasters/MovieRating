//
//  MovieRatingResponse.swift
//  Movie Rates
//
//  Created by Наиль Буркеев on 16.04.2022.
//

import Foundation

struct MovieRatingResponse: Decodable {
    var total: Int
    var totalPages: Int
    var items = [Movie]()
}

struct Movie: Decodable {
    var kinopoiskId: Int
    var nameRu: String?
    var year: UInt
    
    var posterUrlPreview: String
    var description: String?
    var shortDescription: String?
    
    var ratingKinopoisk: Double?
    var ratingKinopoiskVoteCount: Int?
}
