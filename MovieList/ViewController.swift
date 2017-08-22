//
//  ViewController.swift
//  MovieList
//
//  Created by Kacper Kowalski on 22.08.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    static let cellIdentifier = "cellID"
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(MovieCell.self, forCellReuseIdentifier: ViewController.cellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        self.title = "MOVIES"
        MovieService.sharedInstance.getNowPlayingMovies { [weak self] (result) in
            
            guard let strongSelf = self else {
                print("self is been deallocated")
                return
            }
            switch result {
            case .Success(let movies):
                for movie in movies {
                    if let tempMovie = movie {
                        strongSelf.movies.append(tempMovie)
                    }
                }
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            case .Error(let error):
                print(error)
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellIdentifier, for: indexPath) as? MovieCell else {
            fatalError()
        }
            let movie = movies[indexPath.row]
            //this path is provided by the API documentation
            let imagePath = "https://image.tmdb.org/t/p/w342" + movie.posterPath
            cell.movieImageView.loadImageUsingCacheWithURLString(imagePath, placeHolder: nil) { (_) in }
            cell.movieTitleLabel.text = movie.title.uppercased()
            cell.dateLabel.text = "Release Date: " + movie.releaseDate
            cell.descriptionLabel.text =  movie.overview
            if let voteCount = movie.voteCount {
                cell.reviewsCountLabel.text = "Number Of Reviews \(voteCount)"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
}
