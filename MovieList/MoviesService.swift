////
////  MoviesService.swift
////  MovieList
////
////  Created by Kacper Kowalski on 24.08.2017.
////  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit
import Alamofire

var request: Alamofire.Request?

class Movies {
    
    private var _title: String
    private var _overview: String
    private var _releaseDate: String
    private var _voteCount: NSNumber?
    private var _posterPath: String?
    
//MARK: Getters
    
    var title: String { return _title }
    var overview: String { return _overview }
    var releaseDate: String { return _releaseDate }
    var voteCount: NSNumber? { return _voteCount }
    var posterPath: String? { return _posterPath }

    private static var _movieList = [Movies]()
    static var movieList: [Movies] { return _movieList }
 
//MARK: Constructor
    
    init(title: String, overview: String, releaseDate: String, voteCount: NSNumber, posterPath: String?) {
        
        _title = title
        _overview = overview
        _releaseDate = releaseDate
        _voteCount = voteCount
        _posterPath = posterPath
    }
    
    
    static let APIKey: String = "80e25c5cf03b58abdaa9b93d556f1168"
    static let endPoint: String = "https://api.themoviedb.org/3/movie/now_playing?api_key="
    
    typealias MoviesNowPlayingCompletionHandler = () -> ()
    
    class func downloadMovieList(_completed: @escaping MoviesNowPlayingCompletionHandler) {
        
        var movies = [Movies]()
        
        let url = URL(string: Movies.endPoint + Movies.APIKey)!
        
        request = Alamofire.request(url).responseJSON { response in
            debugPrint(response)
            
            DispatchQueue.global().async {
                if let json = response.result.value {
                    print("JSON: \(json)")
                    
                    if let result = response.result.value as? Dictionary <String, AnyObject> {
                        if let list = result["results"] as? [Dictionary<String,AnyObject>] {
                            for obj in list {
                                guard let title = obj["title"] else { return }
                                guard let overview = obj["overview"] else { return }
                                guard let releaseDate = obj["release_date"] else { return }
                                guard let voteCount = obj["vote_count"] else { return }
                                guard let posterPath = obj["poster_path"] else { return }
                                
                                movies.append(Movies(title: title as! String, overview: overview as! String, releaseDate: releaseDate as! String,voteCount: voteCount as! NSNumber, posterPath: (posterPath as! String)))
                                self._movieList = movies
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        _completed()
                    }
                }
            }
        }
    }
}
