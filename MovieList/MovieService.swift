//
//  MovieService.swift
//  MovieList
//
//  Created by Kacper Kowalski on 22.08.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit

struct MovieService {
    
    static let sharedInstance = MovieService()
    // private init() {}
    
    //
    static let APIKey: String = "34a92f7d77a168fdcd9a46ee1863edf1"
    static let endPoint: String = "https://api.themoviedb.org/3/movie/now_playing?api_key="
    let downloader = JSONDownloader()
    
    typealias MoviesNowPlayingCompletionHanlder = (Result<[Movie?]>) -> ()
    
    func getNowPlayingMovies(completion: @escaping MoviesNowPlayingCompletionHanlder) {
        
        guard let url = URL(string: MovieService.endPoint + MovieService.APIKey) else {
            completion(.Error(.invalidURL))
            return
        }
        
        print(url)
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Error(let error):
                    completion(.Error(error))
                    return
                case .Success(let json):
                    guard let movieJSONFeedArray = json["results"] as? [[String: AnyObject]] else {
                        completion(.Error(.jsonParsingFailure))
                        return
                    }
                    
                    let movieArray = movieJSONFeedArray.map{Movie(json: $0)}
                    completion(.Success(movieArray))
                }
            }
        }
        task.resume()
    }
}
