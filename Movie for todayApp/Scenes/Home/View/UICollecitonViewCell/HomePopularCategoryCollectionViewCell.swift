import UIKit
import Kingfisher

class HomePopularCategoryCollectionViewCell: UICollectionViewCell {
    private let networkManager = NetworkManager()
    private let urlGenerator = URLRequestGenerator()
    
    static let identifier = "\(HomePopularCategoryCollectionViewCell.self)"
    private lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.backgroundColor = .systemBlue
        return image
    }()

    private lazy var movieCountLabel = UILabel(text: "50 movies", font: .systemFont(ofSize: 12), textColor: .white)
    private lazy var movieTitle = UILabel(text: "100 Great Films", font: .boldSystemFont(ofSize: 16), textColor: .white)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.layer.cornerRadius = 12
    }
    
    public func configureCell(_ model: Films) {
        let sizeImage = CGSize(width: 400, height: 250)
        guard let url = URL(string: model.cover.url) else { return }
        ImageCache.shared.downloadImage(from: url, imageSize: sizeImage) { [weak self] data in
            self?.categoryImage.image = data
        }
        movieTitle.text = model.name
        movieCountLabel.text = "\(model.moviesCount) movies"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImage.image = nil
        movieTitle.text = nil
        movieCountLabel.text = nil
    }
    
    private func setupUI() {
        addSubviews(categoryImage, movieCountLabel, movieTitle)
        
        NSLayoutConstraint.activate([
            categoryImage.topAnchor.constraint(equalTo: topAnchor),
            categoryImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            movieCountLabel.bottomAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: -16),
            movieCountLabel.leadingAnchor.constraint(equalTo: categoryImage.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            movieTitle.bottomAnchor.constraint(equalTo: movieCountLabel.bottomAnchor, constant: -24),
            movieTitle.leadingAnchor.constraint(equalTo: categoryImage.leadingAnchor, constant: 16),
            movieTitle.trailingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: -16)
        ])
    }
}
