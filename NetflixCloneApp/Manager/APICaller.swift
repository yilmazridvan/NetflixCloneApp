//
//  APICaller.swift
//  NetflixCloneApp
//
//  Created by Rıdvan Yılmaz on 3.11.2022.
//

import Foundation

struct Constants {
    static let API_KEY = "017c21f4d5d4f246fd1de3e678b76809"
    static let baseURL = "https://api.themoviedb.org"
}

class APICaller {
    
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (String) -> Void ) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                print(results)
            } catch {
                print(String(describing: error))
            }
        }
        
        task.resume()
    }
}

