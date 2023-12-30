import UIKit
class SearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSearchBar() {
        searchBarStyle = .minimal
        self.clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        setSearchFieldBackgroundImage(UIImage(), for: .normal)
        
        guard let searchTextField = value(forKey: "searchField") as? UITextField else { return }
        
        searchTextField.backgroundColor = .primarySoft
        searchTextField.textColor = .white
        searchTextField.tintColor = .white
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        if let glassIconView = searchTextField.leftView as? UIImageView {
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = .white
        }
        if let clearButton = searchTextField.value(forKey: "clearButton") as? UIButton {
            clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
            clearButton.tintColor = .white
        }
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search a title...", attributes: placeholderAttributes)
    }
}
