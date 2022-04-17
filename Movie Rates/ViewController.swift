//
//  ViewController.swift
//  Movie Rates
//
//  Created by Наиль Буркеев on 15.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moviesList: UITableView!
    @IBOutlet weak var sortingSegment: UISegmentedControl!
    var movieRatingResponse: MovieRatingResponse?
    var sortBy: String = "RATING"
    
    struct Cells {
        static let imageCell = "ImageCell"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortingSegment.addTarget(self, action: #selector(ratesBy(target:)), for: .valueChanged)
        configureTable()
        getMovies()
    }


    
// MARK: - UITableView configuration
    func configureTable() {
        setTableDelegates()
        moviesList.register(ImageCell.self,  forCellReuseIdentifier: Cells.imageCell)
        moviesList.rowHeight = view.bounds.width * 10 / 35
    }
    
    func setTableDelegates()
    {
        moviesList.delegate = self
        moviesList.dataSource = self
    }
    
    
// MARK: - Networking
    @objc func ratesBy(target: UISegmentedControl) {
        if target == sortingSegment {
            switch target.selectedSegmentIndex {
            case 0: sortBy = "RATING"
            case 1: sortBy = "NUM_VOTE"
            case 2: sortBy = "YEAR"
            default: sortBy = "RATING"
            }
            getMovies()
        }
    }
        
    func getMovies() {
        let networkDataFetcher = NetworkDataFetcher()
        networkDataFetcher.fetchMovies(urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?order=\(sortBy)&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1985&yearTo=2022&page=1") { (movieRatingResponse: MovieRatingResponse?) in
            guard let movieRatingResponse = movieRatingResponse else { return }
            self.movieRatingResponse = movieRatingResponse
            self.moviesList.reloadData()
        }
    }
    
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieRatingResponse?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesList.dequeueReusableCell(withIdentifier: Cells.imageCell, for: indexPath) as! ImageCell
        guard let movies = movieRatingResponse else { return cell }
        cell.set(movies: movies, index: indexPath.row)
        return cell
    }

}


