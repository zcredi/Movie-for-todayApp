import UIKit

class PopularMovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(PopularMovieViewController.self)"
    private lazy var filmImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .green
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
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
    private lazy var informationStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        sv.distribution = .fillEqually
        return sv
    }()
    private let filmImageName = ["calendar", "clock", "film"]
    private lazy var filmTitle = UILabel(text: "Film Name", font: .boldSystemFont(ofSize: 16), textColor: .white)
    private lazy var filmDateTitle = UILabel(text: "2021", font: .systemFont(ofSize: 12), textColor: .lightGray)
    private lazy var durationTitle = UILabel(text: "148 Minutes", font: .systemFont(ofSize: 12), textColor: .lightGray)
    private lazy var categoryFilmTitle = DynamicFontLabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell() {
        categoryFilmTitle.setDynamicFont(regularText: "Action | ", boldText: "Movie")
    }
    
    private func setupUI() {
        addSubviews(filmImage, filmTitle, informationStackView)
        filmImage.addSubviews(ratingBlur, ratingImage, ratingLabel)

        NSLayoutConstraint.activate([
            filmImage.heightAnchor.constraint(equalToConstant: 150),
            filmImage.widthAnchor.constraint(equalToConstant: 115),
            filmImage.topAnchor.constraint(equalTo: topAnchor),
            filmImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            filmImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            ratingBlur.heightAnchor.constraint(equalToConstant: 30),
            ratingBlur.widthAnchor.constraint(equalToConstant: 55),
            ratingBlur.topAnchor.constraint(equalTo: filmImage.topAnchor, constant: 8),
            ratingBlur.leadingAnchor.constraint(equalTo: filmImage.leadingAnchor, constant: 8)
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
        
        NSLayoutConstraint.activate([
            filmTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            filmTitle.leadingAnchor.constraint(equalTo: filmImage.trailingAnchor, constant: 16),
            filmTitle.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(equalTo: filmTitle.bottomAnchor, constant: 13),
            informationStackView.leadingAnchor.constraint(equalTo: filmImage.trailingAnchor, constant: 16),
            informationStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            informationStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        
        let infoTitles = [filmDateTitle, durationTitle, categoryFilmTitle]
        for (index, imageName) in filmImageName.enumerated() {
            let currentTitle = infoTitles[index]
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 16).isActive = true
            let imageView = UIImageView(image: UIImage(named: imageName))
            informationStackView.addArrangedSubview(view)
            view.addSubviews(currentTitle, imageView)
            
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 16),
                imageView.widthAnchor.constraint(equalToConstant: 16),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            ])
            
            NSLayoutConstraint.activate([
                currentTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                currentTitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
                currentTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
}
