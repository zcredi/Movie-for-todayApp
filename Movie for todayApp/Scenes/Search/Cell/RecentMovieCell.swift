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
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark.app.fill")
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
    
    let descriptionContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.backgroundColor = UIColor(named: "primarySoft")
        container.spacing = 8
        return container
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    func setupContainers () {
        descriptionContainer.addSubview (genre)
        descriptionContainer.addSubview(movieName)
    }
    
    func setupView() {
        [ratingBlur,ratingImage,ratingLabel,descriptionContainer,movieImage].forEach {
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
            
            ratingBlur.heightAnchor.constraint(equalToConstant: 30),
            ratingBlur.widthAnchor.constraint(equalToConstant: 55),
            ratingBlur.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 8),
            ratingBlur.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -8),
            
            ratingImage.heightAnchor.constraint(equalToConstant: 16),
            ratingImage.widthAnchor.constraint(equalToConstant: 16),
            ratingImage.centerYAnchor.constraint(equalTo: ratingBlur.centerYAnchor),
            ratingImage.leadingAnchor.constraint(equalTo: ratingBlur.leadingAnchor, constant: 8),
            
            ratingLabel.centerYAnchor.constraint(equalTo: ratingBlur.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingBlur.trailingAnchor, constant: -8)
        ])
    }
}
