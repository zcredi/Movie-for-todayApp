//
//  SearchCell.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 27.12.2023.
//

import UIKit

class RecentMovieCell: UICollectionViewCell {
    
   static let identifier = "RecentMovieCell"
    
    // MARK: - UI
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark.app.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let starImage: UIImageView = {
        let ratingView = UIImageView()
        ratingView.image = UIImage(systemName: "star.fill")
        ratingView.tintColor = .yellow
        ratingView.contentMode = .scaleAspectFit
        return ratingView
    }()
    
    let ratingNumber: UILabel = {
        var rating = UILabel()
        rating.text = "0.0"
        rating.textAlignment = .right
        rating.numberOfLines = 1
        return rating
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
    
    let descriptionContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.backgroundColor = UIColor(named: "primarySoft")
        container.spacing = 8
        
        return container
    }()
    let ratingContainer: UIStackView = {
        let container = UIStackView ()
        container.backgroundColor = UIColor(named: "primarySoft")
        container.layer.cornerRadius = 15
        container.axis = .horizontal
        container.spacing = 4
        
        return container
    }()
    
    
    // MARK: - LifeCycle
    override init(frame:CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    func setupContainers () {
        descriptionContainer.addSubview (genre)
        descriptionContainer.addSubview(movieName)
        ratingContainer.addSubview(ratingNumber)
        ratingContainer.addSubview(starImage)
    }
    
     func setupView() {
         [ratingContainer, descriptionContainer, movieImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
     }
        
    func setupConstraints () {
                NSLayoutConstraint.activate ([
                     movieImage.topAnchor.constraint(equalTo: self.topAnchor),
                     movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                     movieImage.heightAnchor.constraint(equalToConstant: 178),
                     movieImage.widthAnchor.constraint(equalToConstant: 135),
                     
                     descriptionContainer.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -40),
                     descriptionContainer.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor),
                     
                     ratingContainer.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: -8),
                     ratingContainer.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -8),
                     ratingContainer.widthAnchor.constraint(equalToConstant: 55 ),
                     ratingContainer.heightAnchor.constraint(equalToConstant: 25)
                    ])
    }
}
