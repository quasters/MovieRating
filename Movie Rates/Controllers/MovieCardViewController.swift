//
//  MovieCardViewController.swift
//  Movie Rates
//
//  Created by Наиль Буркеев on 17.04.2022.
//

import UIKit

class MovieCardViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    var movieId: UInt?
    
    var movieResponse: MovieResponse?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //getMovie(id: movieId)
        
        setData()
        
        
    
        
        

        print(self.movieResponse?.nameRu ?? "бля")

    }
    
    
// MARK: - Networking
    func getMovie(id: UInt?) {
        let networkDataFetcher = NetworkDataFetcher()
        guard let id = id else { return }
        
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(id)"
        networkDataFetcher.fetchMovies(urlString: urlString) { (movieResponse: MovieResponse?) in
            
            guard let movieResponse = movieResponse else { return }
            self.movieResponse = movieResponse
            print(self.movieResponse?.nameRu ?? "прикол")
        }
    }
    
    
// MARK: - SetData
    func setData() {
        guard let movieResponse = self.movieResponse else {
            setImage(urlString: "https://dummyimage.com/200x280/000/fff&text=error", imageView: self.posterImageView)
            titleLabel.text = "Not found"
            infoTextView.text = "Not found"
            return
        }
        
        setImage(urlString: movieResponse.posterUrlPreview, imageView: posterImageView)
        titleLabel.text = movieResponse.nameRu
        infoTextView.text = movieResponse.description ?? "lol"
    }
    
    func setImage(urlString: String, imageView: UIImageView) {
        let url = URL(string: urlString)
        let data = try! Data(contentsOf: url!)
        DispatchQueue.main.async {
            imageView.image = UIImage(data: data)
        }
    }
}
