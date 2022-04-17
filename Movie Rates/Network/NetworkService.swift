//
//  NetworkService.swift
//  Movie Rates
//
//  Created by Наиль Буркеев on 16.04.2022.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var requestUrl = URLRequest(url: url)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        requestUrl.httpMethod = "GET"
        requestUrl.addValue("38a9ae00-f275-48ef-9e6e-75dccf0d54dc", forHTTPHeaderField: "X-API-KEY")
        requestUrl.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: requestUrl) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error getting data", error)
                    completion(.failure(error))
                }
                guard let data = data else { return }
                print("getting data: OK")
                completion(.success(data))
            }
        }.resume()
    }
    
}
