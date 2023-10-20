//
//  NetworkService.swift
//  Countries
//
//  Created by Ivan Redreev on 11.10.2023.
//

import Foundation

public class NetworkService {
    
    public init() {}
    
    func requestCountriesData(url: String = Endpoints.baseURL, filter: String = Endpoints.all,
                              completion: @escaping ((Result<[Country], NetworkError>)) -> Void) {
        
        guard let url = URL(string: "\(url)\(filter)") else {
            completion(.failure(.badFormatURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.transportError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}
