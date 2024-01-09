//
//  MovieCard.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 08.01.2024.
//

import UIKit

class MovieCardView: UIView {
    
    // MARK: Private UI
     private lazy var movieImageView: UIImageView = {
        let movieImage = UIImageView()
        movieImage.backgroundColor = .systemBlue
        movieImage.contentMode = .scaleAspectFit
        movieImage.layer.cornerRadius = 10
        return movieImage
    }()
    private lazy var genreImage: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(systemName: "film.fill")
        picture.tintColor = .lightGray
        picture.sizeToFit()
        return picture
    }()
    private lazy var yearImage: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(systemName: "calendar")
        picture.tintColor = .lightGray
        picture.sizeToFit()
        return picture
    }()
    private lazy var durationImage: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(systemName: "clock.fill")
        picture.tintColor = .lightGray
        picture.sizeToFit()
        return picture
    }()
    
    private lazy var crossLabel: UIImageView = {
        let picture = UIImageView()
        picture.image = UIImage(named: "crossLabel")
        return picture
    }()
    private lazy var movieName = UILabel(text: "Spider Man", font: .montserratSemiBold16(), textColor: .lightGray)
    private lazy var year = UILabel(text: "2015", font: .montserratMedium12(), textColor: .lightGray)
    private lazy var duration = UILabel(text: "140 minutes", font: .montserratMedium12(), textColor: .lightGray)
    private lazy var genre = UILabel(text: "Action", font: .montserratMedium12(), textColor: .lightGray)
    private lazy var typeOfMovie = UILabel(text: "Movie", font: .montserratMedium12(), textColor: .lightGray)
    
     lazy var ratingBlur: VisualBlurEffect = {
         let blur = VisualBlurEffect(style: .systemUltraThinMaterialDark)
         blur.layer.cornerRadius = 12
         blur.clipsToBounds = true
         return blur
     }()
     lazy var ratingImage = UIImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal))
     lazy var ratingLabel = UILabel(text: "4.5", font: .systemFont(ofSize: 12), textColor: .systemOrange)
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
        self.clipsToBounds = false

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setupUI() {
         [ratingBlur, ratingLabel, ratingImage].forEach {
             movieImageView.addSubview($0)
             $0.translatesAutoresizingMaskIntoConstraints = false
         }
         [movieImageView, movieName, year, duration, genre, typeOfMovie, genreImage, yearImage, durationImage, crossLabel].forEach {
             addSubview($0)
             $0.translatesAutoresizingMaskIntoConstraints = false
         }
         
    }
    private func setupConstraints() {
     
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: self.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 110),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            
            ratingBlur.heightAnchor.constraint(equalToConstant: 30),
            ratingBlur.widthAnchor.constraint(equalToConstant: 55),
            ratingBlur.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 8),
            ratingBlur.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: 8),
       
            ratingImage.heightAnchor.constraint(equalToConstant: 16),
            ratingImage.widthAnchor.constraint(equalToConstant: 16),
            ratingImage.centerYAnchor.constraint(equalTo: ratingBlur.centerYAnchor),
            ratingImage.leadingAnchor.constraint(equalTo: ratingBlur.leadingAnchor, constant: 8),
  
            ratingLabel.centerYAnchor.constraint(equalTo: ratingBlur.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingBlur.trailingAnchor, constant: -8),
        
            movieName.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            movieName.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),

            year.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 13),
            year.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 40),

            yearImage.trailingAnchor.constraint(equalTo: year.leadingAnchor, constant: -5),
            yearImage.topAnchor.constraint(equalTo: year.topAnchor),
            yearImage.widthAnchor.constraint(equalToConstant: 20),

            duration.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 13),
            duration.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 40),

            durationImage.trailingAnchor.constraint(equalTo: duration.leadingAnchor, constant: -5),
            durationImage.topAnchor.constraint(equalTo: duration.topAnchor),
            durationImage.widthAnchor.constraint(equalToConstant: 20),

            genre.topAnchor.constraint(equalTo: duration.bottomAnchor, constant: 13),
            genre.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 40),

            genreImage.trailingAnchor.constraint(equalTo: genre.leadingAnchor, constant: -5),
            genreImage.topAnchor.constraint(equalTo: genre.topAnchor),
            genreImage.widthAnchor.constraint(equalToConstant: 20),

            typeOfMovie.topAnchor.constraint(equalTo: genre.topAnchor),
            typeOfMovie.leadingAnchor.constraint(equalTo: genre.trailingAnchor, constant: 15),
            
            crossLabel.topAnchor.constraint(equalTo: genre.topAnchor),
            crossLabel.leadingAnchor.constraint(equalTo: genre.trailingAnchor, constant: 8),
            crossLabel.trailingAnchor.constraint(equalTo: typeOfMovie.leadingAnchor, constant: -8),
            crossLabel.widthAnchor.constraint(equalToConstant: 1),
            crossLabel.heightAnchor.constraint(equalToConstant: 20)
        
        ])
        
    }
    
    
}
