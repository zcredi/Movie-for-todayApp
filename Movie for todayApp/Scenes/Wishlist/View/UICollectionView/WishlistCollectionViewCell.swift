import UIKit

class WishlistCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(WishlistCollectionViewCell.self)"
    private lazy var filmImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = UIImage(named: "spider-man")
        image.layer.cornerRadius = 12
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var actionLabel = UILabel(text: "Action", font: .systemFont(ofSize: 12), textColor: .white)
    private lazy var filmLabel = UILabel(text: "Spider-Man No Way Home", font: .boldSystemFont(ofSize: 14), textColor: .white)
    private lazy var categoryMovieLabel = UILabel(text: "Movie", font: .systemFont(ofSize: 12), textColor: .gray)
    private lazy var ratingImage = UIImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal))
    private lazy var ratingLabel = UILabel(text: "4.5", font: .boldSystemFont(ofSize: 12), textColor: .systemOrange)
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.backgroundColor = .primarySoft
        self.layer.cornerRadius = 12
        filmLabel.numberOfLines = 2
        addSubviews(filmImage, actionLabel, filmLabel, categoryMovieLabel, ratingImage, ratingLabel, favoriteButton)
        
        NSLayoutConstraint.activate([
            filmImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            filmImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            filmImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            filmImage.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            actionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            actionLabel.leadingAnchor.constraint(equalTo: filmImage.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            filmLabel.topAnchor.constraint(equalTo: actionLabel.bottomAnchor, constant: 8),
            filmLabel.leadingAnchor.constraint(equalTo: filmImage.trailingAnchor, constant: 16),
            filmLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            categoryMovieLabel.topAnchor.constraint(equalTo: filmLabel.bottomAnchor, constant: 8),
            categoryMovieLabel.leadingAnchor.constraint(equalTo: filmImage.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            ratingImage.heightAnchor.constraint(equalToConstant: 16),
            ratingImage.widthAnchor.constraint(equalToConstant: 16),
            ratingImage.centerYAnchor.constraint(equalTo: categoryMovieLabel.centerYAnchor),
            ratingImage.leadingAnchor.constraint(equalTo: categoryMovieLabel.trailingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: ratingImage.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: ratingImage.trailingAnchor, constant: 2)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
