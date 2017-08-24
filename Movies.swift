////
////  Movies.swift
////  MovieList
////
////  Created by Kacper Kowalski on 23.08.2017.
////  Copyright © 2017 Kacper Kowalski. All rights reserved.
////
//
//import UIKit
//import Alamofire
//
//class Movie {
////
////    //
////    private var _title: String!
////    private var _posterPath: String!
////    private var _overview: String!
////    private var _releaseDate: String!
////    private var _voteCount: String?
////    
////    var title: String {
////        if _title == nil {
////            _title = ""
////        }
////        return _title
////    }
////    
////    var posterPath: String {
////        if _posterPath == nil {
////            _posterPath = ""
////        }
////        return _posterPath
////    }
////    
////    var overview: String {
////        if _overview == nil {
////            _overview = ""
////        }
////        return _overview
////    }
////    
////    var releaseDate: String {
////        if _releaseDate == nil {
////            _releaseDate = ""
////        }
////        return _releaseDate
////    }
////    
////    var voteCount: String? {
////        if _voteCount == nil {
////            _voteCount = ""
////        }
////        return _voteCount
////    }
////    
////    static let sharedInstance = Movies()
////    private static var _movieList = [Movie]()
////    static var movieList: [Movie] { return _movieList }
////    
////
////    static let APIKey: String = "80e25c5cf03b58abdaa9b93d556f1168"
////    static let endPoint: String = "https://api.themoviedb.org/3/movie/now_playing?api_key="
////    
////    typealias MoviesNowPlayingCompletionHandler = () -> ()
////    
////    func downloadMovies(_completed: @escaping MoviesNowPlayingCompletionHandler) {
////        
////        var movies = [Movie]()
////        
////        let url = URL(string: Movies.endPoint + Movies.APIKey)!
////        
////        Alamofire.request(url).responseJSON { response in
////            debugPrint(response)
////            if let json = response.result.value {
////                print("JSON: \(json)")
////                
////                if let dict = response.result.value as? Dictionary <String, AnyObject> {
////                    
////                    if let moviesDict = dict["results"] as? [Dictionary<String, AnyObject>] {
////                        
////                        if let title = moviesDict[0]["title"] as? String {
////                            self._title = title
////                        }
////                        
////                        if let overview = moviesDict[0]["overview"] as? String {
////                            self._overview = overview
////                        }
////                        
////                        if let releaseDate = moviesDict[0]["release_date"] as? String {
////                            self._releaseDate = releaseDate
////                        }
////                        
////                        if let posterPath = moviesDict[0]["poster_path"] as? String {
////                            self._posterPath = posterPath
////                        }
////                        
////                        print(self._title)
////                        print(self._overview)
////                        print(self._releaseDate)
////                        print(self._posterPath)
////                        
////                    }
////                    
////                }
////                
////            }
////            
////            DispatchQueue.main.async {
////                _completed()
////                
////            }
////        }
////    }
//}
