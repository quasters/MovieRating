//
//  MovieResponse.swift
//  Movie Rates
//
//  Created by Наиль Буркеев on 16.04.2022.
//

import Foundation

struct MovieResponse: Decodable {
    var posterUrlPreview: String
    
    var nameRu: String
    var slogan: String
    var description: String
    var shortDescription: String
    var year: UInt
    
    var ratingKinopoisk: Double
    var ratingKinopoiskVoteCount: Int
}
