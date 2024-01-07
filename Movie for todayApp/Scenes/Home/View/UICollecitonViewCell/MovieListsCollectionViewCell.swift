import UIKit

class MovieListsCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(MovieListsCollectionViewCell.self)"
    private lazy var filmImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .red
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        return image
    }()
    
    private lazy var filmNameLabel = UILabel(text: "Movie name",font: .boldSystemFont(ofSize: 16), textColor: .white)
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(filmImage, filmNameLabel)
        
        NSLayoutConstraint.activate([
            filmImage.topAnchor.constraint(equalTo: topAnchor),
            filmImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            filmImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            filmImage.heightAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            filmNameLabel.topAnchor.constraint(equalTo: filmImage.bottomAnchor, constant: 12),
            filmNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            filmNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
