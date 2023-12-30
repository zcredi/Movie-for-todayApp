import UIKit

protocol HomeFavoriteButtonPressed: AnyObject {
    func favoriteButtonPressed()
}

class HomeNavigationBar: UIView {
    weak var delegate: HomeFavoriteButtonPressed?
    private lazy var personImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar")
        image.layer.cornerRadius = 20
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var greetingLabel = UILabel(text: "Hello, Smith", font: .boldSystemFont(ofSize: 16), textColor: .white)
    
    private lazy var favoriteView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .primarySoft
        return view
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(heartButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var homeSearchBar: SearchBar = {
        let searchBar = SearchBar()
        searchBar.layer.cornerRadius = 15
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(personImage, greetingLabel, favoriteView, favoriteButton, homeSearchBar)
        
        NSLayoutConstraint.activate([
            personImage.heightAnchor.constraint(equalToConstant: 40),
            personImage.widthAnchor.constraint(equalToConstant: 40),
            personImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            personImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            greetingLabel.centerYAnchor.constraint(equalTo: personImage.centerYAnchor),
            greetingLabel.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: 17)
        ])
        
        NSLayoutConstraint.activate([
            favoriteView.heightAnchor.constraint(equalToConstant: 32),
            favoriteView.widthAnchor.constraint(equalToConstant: 32),
            favoriteView.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),
            favoriteView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: favoriteView.topAnchor),
            favoriteButton.leadingAnchor.constraint(equalTo: favoriteView.leadingAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: favoriteView.trailingAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: favoriteView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            homeSearchBar.heightAnchor.constraint(equalToConstant: 40),
            homeSearchBar.topAnchor.constraint(equalTo: personImage.bottomAnchor, constant: 32),
            homeSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            homeSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    
    @IBAction private func heartButtonPressed(_ sender: UIButton) {
        delegate?.favoriteButtonPressed()
    }
    
    
}
