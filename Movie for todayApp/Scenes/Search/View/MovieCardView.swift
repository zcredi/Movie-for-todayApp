//
//  MovieCard.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 08.01.2024.
//

import UIKit

class MovieCardView: UIView {
    
    // MARK: Private UI
    private let movieImageView: UIImageView = {
        let movieImage = UIImageView()
        movieImage.backgroundColor = .systemBlue
        movieImage.layer.cornerRadius = 15
        return movieImage
    }()
    private let genreImage: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(systemName: "film.fill")
        picture.sizeToFit()
        return picture
    }()
    private let yearImage: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(systemName: "calendar")
        picture.sizeToFit()
        return picture
    }()
    private let durationImage: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(systemName: "clock.fill")
        picture.sizeToFit()
        return picture
    }()
    
    private let movieName = UILabel(text: "Spider Man", font: .montserratSemiBold16(), textColor: .white)
    private let year = UILabel(text: "2015", font: .montserratMedium12(), textColor: .lightGray)
    private let duration = UILabel(text: "140 minutes", font: .montserratMedium12(), textColor: .lightGray)
    private let genre = UILabel(text: "Action", font: .montserratMedium12(), textColor: .lightGray)
    private let typeOfMovie = UILabel(text: "Movie", font: .montserratMedium12(), textColor: .lightGray)
    private lazy var ratingBlur: VisualBlurEffect = {
         let blur = VisualBlurEffect(style: .systemUltraThinMaterialDark)
         blur.layer.cornerRadius = 12
         blur.clipsToBounds = true
         return blur
     }()
    private lazy var ratingImage = UIImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal))
    private lazy var ratingLabel = UILabel(text: "4.5", font: .systemFont(ofSize: 12), textColor: .systemOrange)
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setupUI() {
        movieImageView.addSubviews(ratingBlur, ratingImage, ratingLabel)
        [movieImageView, movieName, year, duration, genre, typeOfMovie, genreImage, yearImage, durationImage].forEach {
            addSubview($0)
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        
    }
    private func setupConstraints() {
     
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 110),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            
            ratingBlur.heightAnchor.constraint(equalToConstant: 30),
            ratingBlur.widthAnchor.constraint(equalToConstant: 55),
            ratingBlur.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 8),
            ratingBlur.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -8),
       
            ratingImage.heightAnchor.constraint(equalToConstant: 16),
            ratingImage.widthAnchor.constraint(equalToConstant: 16),
            ratingImage.centerYAnchor.constraint(equalTo: ratingBlur.centerYAnchor),
            ratingImage.leadingAnchor.constraint(equalTo: ratingBlur.leadingAnchor, constant: 8),
  
            ratingLabel.centerYAnchor.constraint(equalTo: ratingBlur.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingBlur.trailingAnchor, constant: -8),
            
            movieName.topAnchor.constraint(equalTo: topAnchor, constant: 260),
            movieName.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            year.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 13),
            year.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            yearImage.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            yearImage.topAnchor.constraint(equalTo: year.topAnchor),
            
            duration.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 13),
            duration.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            durationImage.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            durationImage.topAnchor.constraint(equalTo: duration.topAnchor),

            genre.topAnchor.constraint(equalTo: duration.bottomAnchor, constant: 13),
            genre.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            genreImage.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            genreImage.topAnchor.constraint(equalTo: genre.topAnchor),

            typeOfMovie.topAnchor.constraint(equalTo: duration.bottomAnchor, constant: 13),
            typeOfMovie.leadingAnchor.constraint(equalTo: genre.trailingAnchor, constant: 15)
        
        ])
        
    }
    
    
}
