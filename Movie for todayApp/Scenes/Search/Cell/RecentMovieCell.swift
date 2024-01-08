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
    
    private lazy var containerDescription: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = .primarySoft
        return view
    }()
    
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
        
   private lazy var movieName = UILabel(text: "Spider Man", font: UIFont.montserratMedium28(), textColor: .lightGray)
   private lazy var genre = UILabel(text: "Action1", font: UIFont.montserratMedium28(), textColor: .lightGray)
    
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

        self.clipsToBounds = false
        addSubviews(containerDescription, movieImage)
        containerDescription.translatesAutoresizingMaskIntoConstraints = false
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        containerDescription.addSubviews(movieName, genre)
        movieImage.addSubviews(ratingBlur, ratingImage, ratingLabel)
    }
    
   public func viewForData () {
        self.containerDescription = containerDescription
        self.movieImage = movieImage
        
    }
    
   private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerDescription.topAnchor.constraint(equalTo: movieImage.bottomAnchor),
            containerDescription.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerDescription.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerDescription.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerDescription.heightAnchor.constraint(equalToConstant: 60),
      
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            //movieImage.bottomAnchor.constraint(equalTo: containerDescription.topAnchor),
        
            movieName.topAnchor.constraint(equalTo: containerDescription.topAnchor, constant: 10),
            movieName.leadingAnchor.constraint(equalTo: containerDescription.leadingAnchor, constant: 8),
            movieName.trailingAnchor.constraint(equalTo: containerDescription.trailingAnchor, constant: -8),
     
            genre.bottomAnchor.constraint(equalTo: containerDescription.bottomAnchor, constant: -8),
            genre.leadingAnchor.constraint(equalTo: containerDescription.leadingAnchor, constant: 8),
            genre.trailingAnchor.constraint(equalTo: containerDescription.trailingAnchor, constant: -8),
   
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
