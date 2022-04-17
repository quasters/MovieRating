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
    
    var movie: Movie?
 
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }
    

// MARK: - SetData
    func setData() {
        guard let movie = self.movie else {
            setImage(urlString: "https://dummyimage.com/200x280/000/fff&text=error", imageView: self.posterImageView)
            titleLabel.text = "Not found"
            infoTextView.text = "Not found"
            return
        }
        
        setImage(urlString: movie.posterUrlPreview, imageView: posterImageView)
        titleLabel.text = movie.nameRu
        infoTextView.text = movie.description ?? "lol"
    }
    
    func setImage(urlString: String, imageView: UIImageView) {
        let url = URL(string: urlString)
        let data = try! Data(contentsOf: url!)
        DispatchQueue.main.async {
            imageView.image = UIImage(data: data)
        }
    }

    
}
