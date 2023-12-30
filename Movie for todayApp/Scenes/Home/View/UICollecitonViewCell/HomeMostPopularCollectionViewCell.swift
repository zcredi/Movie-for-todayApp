import UIKit

class HomeMostPopularCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(HomeMostPopularCollectionViewCell.self)"
    private lazy var containerFilm: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = .primarySoft
        return view
    }()
    private lazy var titleFilmLabel = UILabel(text: "Life of PI", font: .boldSystemFont(ofSize: 14), textColor: .white)
    private lazy var categoryFilmLabel = UILabel(text: "Action", font: .systemFont(ofSize: 10), textColor: .white)
    private lazy var filmImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.backgroundColor = .systemPink
        return image
    }()
    
    private lazy var ratingBlur: VisualBlurEffect = {
        let blur = VisualBlurEffect(style: .systemUltraThinMaterialDark)
        blur.layer.cornerRadius = 12
        blur.clipsToBounds = true
        return blur
    }()
    
    private lazy var ratingImage = UIImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal))
    private lazy var ratingLabel = UILabel(text: "4.5", font: .systemFont(ofSize: 12), textColor: .systemOrange)
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.layer.cornerRadius = 12
    }
    
    private func setupUI() {
        addSubviews(containerFilm, filmImage)
        containerFilm.addSubviews(titleFilmLabel, categoryFilmLabel)
        filmImage.addSubviews(ratingBlur, ratingImage, ratingLabel)
        
        NSLayoutConstraint.activate([
            containerFilm.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerFilm.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerFilm.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerFilm.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            filmImage.topAnchor.constraint(equalTo: topAnchor),
            filmImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            filmImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            filmImage.bottomAnchor.constraint(equalTo: containerFilm.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleFilmLabel.topAnchor.constraint(equalTo: containerFilm.topAnchor, constant: 10),
            titleFilmLabel.leadingAnchor.constraint(equalTo: containerFilm.leadingAnchor, constant: 8),
            titleFilmLabel.trailingAnchor.constraint(equalTo: containerFilm.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            categoryFilmLabel.bottomAnchor.constraint(equalTo: containerFilm.bottomAnchor, constant: -8),
            categoryFilmLabel.leadingAnchor.constraint(equalTo: containerFilm.leadingAnchor, constant: 8),
            categoryFilmLabel.trailingAnchor.constraint(equalTo: containerFilm.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            ratingBlur.heightAnchor.constraint(equalToConstant: 30),
            ratingBlur.widthAnchor.constraint(equalToConstant: 55),
            ratingBlur.topAnchor.constraint(equalTo: filmImage.topAnchor, constant: 8),
            ratingBlur.trailingAnchor.constraint(equalTo: filmImage.trailingAnchor, constant: -8)
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
