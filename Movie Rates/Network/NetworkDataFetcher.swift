//
//  NetworkDataFetcher.swift
//  Movie Rates
//
//  Created by Наиль Буркеев on 16.04.2022.
//

import Foundation

class NetworkDataFetcher {
    let networkService = NetworkService()
    
    func fetchMovies<T>(urlString: String, response: @escaping (T?) -> Void) where T: Decodable {
        networkService.request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let movies = try JSONDecoder().decode(T.self, from: data)
                    response(movies)
                } catch let jsonError {
                    print("Failed do decode JSON: ", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: ", error.localizedDescription)
                response(nil)
            }
        }
//        do {
//            let movies = try JSONDecoder().decode(T.self, from: data)
//            completion(.success(movies))
//        } catch let jsonError {
//            completion(.failure(jsonError))
//        }
        
        
        
        
//        let net = NetworkService()
//        net.request(urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?order=\(sortBy)&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1985&yearTo=2022&page=1", completion:  { (result: Result<MovieRatingResponse, Error>) in
//            switch result {
//            case .success(let movieRatingResponse):
//                self.movieRatingResponse = movieRatingResponse
//                self.moviesList.reloadData()
//            case .failure(_):
//                print("error:", result)
//            }
//
//        })
    }
}
