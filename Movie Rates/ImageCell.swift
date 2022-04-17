//
//  ImageCell.swift
//  Movie Rates
//
//  Created by Наиль Буркеев on 16.04.2022.
//

import UIKit

final class ImageCell: UITableViewCell {
    
    var posterImageView = UIImageView()
    var movieTitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(posterImageView)
        addSubview(movieTitleLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movies: MovieRatingResponse, index: Int) {
        let movieItem = movies.items[index]
        
        let url = URL(string: movieItem.posterUrlPreview)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data!)
            }
        }
        
        movieTitleLabel.text = (movieItem.nameRu ?? "No name. id:\(movieItem.kinopoiskId)") + " (\(movieItem.year))"
    }
    
    private func configureImageView() {
        posterImageView.clipsToBounds = true
    }
    
    private func configureTitleLabel() {
        movieTitleLabel.numberOfLines = 2
        movieTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setImageConstraints() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: self.bounds.width * 10 / 35 - 2).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: self.bounds.width / 5).isActive = true
    }
    
    private func setTitleConstraints() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 15).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: self.bounds.width * 10 / 35 - 2).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(self.bounds.width * 10 / 35 - 4 - 4 - 15)).isActive = true
    }
}
