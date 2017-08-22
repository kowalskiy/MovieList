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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(MovieCell.self, forCellReuseIdentifier: ViewController.cellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        self.title = "MOVIES"
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellIdentifier, for: indexPath) as? MovieCell else {
            fatalError()
        }
        
        return cell
    }
    
}

