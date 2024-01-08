//
//  SearchViewController.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import UIKit


class SearchViewController: UIViewController {
    
    // MARK: - UI elements
    private let recentMovieView = RecentMovieView()
    private let upcomingMovie = MovieCardView()
    private let searchField: UISearchTextField = {
        let search = UISearchTextField()
        search.layer.cornerRadius = 15
        search.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        search.leftView?.tintColor = .white
        search.attributedPlaceholder = NSAttributedString(string: "Type title, categories, years, etc", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        search.textColor = .white
        return search
    }()
    private let movieImageView: UIImageView = {
        let movieImage = UIImageView()
        movieImage.backgroundColor = .systemBlue
        movieImage.layer.cornerRadius = 15
        return movieImage
    }()
    private let recentMovie = UILabel(text: "Recent Movie", font: .montserratSemiBold16(), textColor: .white)
    private let upcomingMovie = UILabel(text: "Upcoming Movie", font: .montserratSemiBold16(), textColor: .white)
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
    
    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.titleLabel?.font = .montserratMedium14()
        button.backgroundColor = .clear
        return button
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    // MARK: Methods
    private func setupUI() {
        
        [searchField, upcomingMovie, recentMovie, recentMovieView, movieImageView, movieName, year, duration, genre, typeOfMovie, seeAllButton].forEach {
           $0.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview($0)
       }
        movieImageView.addSubviews(ratingImage, ratingLabel, ratingBlur)

    }
   private func setupConstraints () {
        NSLayoutConstraint.activate([

            recentMovieView.topAnchor.constraint(equalTo: view.topAnchor,constant: 550),
            recentMovieView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            recentMovieView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            recentMovieView.widthAnchor.constraint(equalToConstant: 360),
            recentMovieView.heightAnchor.constraint(equalToConstant: 310),
            
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            upcomingMovie.bottomAnchor.constraint(equalTo: movieImageView.topAnchor, constant: -10),
            upcomingMovie.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            
            recentMovie.bottomAnchor.constraint(equalTo: recentMovieView.topAnchor, constant: -20),
            recentMovie.leadingAnchor.constraint(equalTo: recentMovieView.leadingAnchor),
            
            movieImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            movieImageView.leadingAnchor.constraint(equalTo: recentMovieView.leadingAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 110),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            
            movieName.topAnchor.constraint(equalTo: view.topAnchor, constant: 260),
            movieName.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            year.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 13),
            year.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            duration.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 13),
            duration.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            genre.topAnchor.constraint(equalTo: duration.bottomAnchor, constant: 13),
            genre.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            typeOfMovie.topAnchor.constraint(equalTo: duration.bottomAnchor, constant: 13),
            typeOfMovie.leadingAnchor.constraint(equalTo: genre.trailingAnchor, constant: 15),
            
            seeAllButton.bottomAnchor.constraint(equalTo: recentMovieView.topAnchor, constant: -15),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
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
        ])
    }

    
}
