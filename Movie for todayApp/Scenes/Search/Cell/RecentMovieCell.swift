//
//  SearchCell.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 27.12.2023.
//

import UIKit

class RecentMovieCell: UICollectionViewCell {
    
    static let identifier = "\(RecentMovieCell.self)"
    
    // MARK: - UI
    
    private lazy var containerFilm: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = .primarySoft
        return view
    }()
    
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        //imageView.tintColor = .systemBlue
        //imageView.image = UIImage(systemName: "network")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
        
    let movieName: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .montserratSemiBold14()
        nameLabel.text = "Spider man"
        nameLabel.textColor = .black
        return nameLabel
    }()
    
    let genre: UILabel = {
        let genreLabel = UILabel()
        genreLabel.font = .montserratMedium10()
        genreLabel.text = "Action"
        genreLabel.textColor = .lightGray
        return genreLabel
    }()
    
    private lazy var ratingBlur: VisualBlurEffect = {
        let blur = VisualBlurEffect(style: .systemUltraThinMaterialDark)
        blur.layer.cornerRadius = 12
        blur.clipsToBounds = true
        return blur
    }()
    
    private lazy var ratingImage = UIImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal))
    private lazy var ratingLabel = UILabel(text: "4.5", font: .systemFont(ofSize: 12), textColor: .systemOrange)
    
    // MARK: - LifeCycle
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    
    func setupView() {
//        [ratingBlur,ratingImage,ratingLabel,descriptionContainer,movieImage].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            self.addSubview($0)
//        }
        self.clipsToBounds = true
        addSubviews(containerFilm, movieImage)
        containerFilm.translatesAutoresizingMaskIntoConstraints = false
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        containerFilm.addSubviews(movieName, genre)
        movieImage.addSubviews(ratingBlur, ratingImage, ratingLabel)
    }
    
   public func viewForData () {
        self.containerFilm = containerFilm
        self.movieImage = movieImage
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerFilm.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerFilm.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerFilm.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerFilm.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImage.widthAnchor.constraint(equalToConstant: 200),
            movieImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            //movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 150),
            movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImage.bottomAnchor.constraint(equalTo: containerFilm.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            movieName.topAnchor.constraint(equalTo: containerFilm.topAnchor, constant: 10),
            movieName.leadingAnchor.constraint(equalTo: containerFilm.leadingAnchor, constant: 8),
            movieName.trailingAnchor.constraint(equalTo: containerFilm.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            genre.bottomAnchor.constraint(equalTo: containerFilm.bottomAnchor, constant: -8),
            genre.leadingAnchor.constraint(equalTo: containerFilm.leadingAnchor, constant: 8),
            genre.trailingAnchor.constraint(equalTo: containerFilm.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            ratingBlur.heightAnchor.constraint(equalToConstant: 30),
            ratingBlur.widthAnchor.constraint(equalToConstant: 55),
            ratingBlur.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 8),
            ratingBlur.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            ratingImage.heightAnchor.constraint(equalToConstant: 16),
            ratingImage.widthAnchor.constraint(equalToConstant: 16),
            ratingImage.centerYAnchor.constraint(equalTo: ratingBlur.centerYAnchor),
            ratingImage.leadingAnchor.constraint(equalTo: ratingBlur.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: ratingBlur.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingBlur.trailingAnchor, constant: -8)
        ])
    }
}
