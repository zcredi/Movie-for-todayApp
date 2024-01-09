import UIKit

class CustomNavigationBar: UIView {
    public var navigationController: UINavigationController?
    private lazy var backwardChevronView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .primarySoft
        return view
    }()
    
    private lazy var backwardChevronButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "chevron.left")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var navigationTitle = UILabel(font: .boldSystemFont(ofSize: 16), textColor: .white)
    private lazy var favoriteView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .primarySoft
        return view
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    
    init(title: String, hideFavoriteButton: Bool = true) {
        super.init(frame: .zero)
        self.navigationTitle.text = title
        setupUI()
        if hideFavoriteButton {
            self.hideFavoriteButton()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func hideFavoriteButton() {
        favoriteView.isHidden = true
        favoriteButton.isHidden = true
    }
    
    @IBAction private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        navigationTitle.textAlignment = .center
        addSubviews(backwardChevronView, navigationTitle, favoriteView)
        backwardChevronView.addSubviews(backwardChevronButton)
        favoriteView.addSubviews(favoriteButton)
        
        NSLayoutConstraint.activate([
            backwardChevronView.heightAnchor.constraint(equalToConstant: 32),
            backwardChevronView.widthAnchor.constraint(equalToConstant: 32),
            backwardChevronView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backwardChevronView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28)
        ])
        
        NSLayoutConstraint.activate([
            backwardChevronButton.topAnchor.constraint(equalTo: backwardChevronView.topAnchor, constant: 4),
            backwardChevronButton.leadingAnchor.constraint(equalTo: backwardChevronView.leadingAnchor, constant: 4),
            backwardChevronButton.trailingAnchor.constraint(equalTo: backwardChevronView.trailingAnchor, constant: -4),
            backwardChevronButton.bottomAnchor.constraint(equalTo: backwardChevronView.bottomAnchor, constant: -4)
        ])
        
        NSLayoutConstraint.activate([
            navigationTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            navigationTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            navigationTitle.leadingAnchor.constraint(equalTo: backwardChevronView.trailingAnchor, constant: 32)
        ])
        
        NSLayoutConstraint.activate([
            favoriteView.heightAnchor.constraint(equalToConstant: 32),
            favoriteView.widthAnchor.constraint(equalToConstant: 32),
            favoriteView.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: favoriteView.topAnchor, constant: 4),
            favoriteButton.leadingAnchor.constraint(equalTo: favoriteView.leadingAnchor, constant: 4),
            favoriteButton.trailingAnchor.constraint(equalTo: favoriteView.trailingAnchor, constant: -4),
            favoriteButton.bottomAnchor.constraint(equalTo: favoriteView.bottomAnchor, constant: -4),
        ])
    }
    
}
