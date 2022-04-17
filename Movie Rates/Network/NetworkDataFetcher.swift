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
                    print("decode: OK")
                } catch let jsonError {
                    print("Failed do decode JSON: ", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: ", error.localizedDescription)
                response(nil)
            }
        }
    }
}
