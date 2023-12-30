import UIKit

protocol HomeCategoryTagPressed: AnyObject {
    func didTapButton(cell: HomeCategoryTagCollectionViewCell)
}

class HomeCategoryTagCollectionViewCell: UICollectionViewCell {
    weak var delegate: HomeCategoryTagPressed?
    static let identifier = "\(HomeCategoryTagCollectionViewCell.self)"
    private lazy var categoryButton: UIButton = {
        let button = UIButton(title: "All", font: .systemFont(ofSize: 12), titleColor: .white)
        button.layer.cornerRadius = 12
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(categoryButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func categoryButtonPressed(_ sender: UIButton) {
        delegate?.didTapButton(cell: self)
    }
    
    
    public func configureCell(_ title: String) {
        categoryButton.setTitle(title, for: .normal)
    }
    
    public func resetButtonState() {
        categoryButton.backgroundColor = .clear
        categoryButton.setTitleColor(.white, for: .normal)
    }
        
    public func toggleButtonState() {
        if categoryButton.backgroundColor == .clear {
            categoryButton.backgroundColor = .primarySoft
            categoryButton.setTitleColor(.cyan, for: .normal)
        } else {
            resetButtonState()
        }
    }
    
    
    private func setupUI() {
        addSubviews(categoryButton)
        
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: topAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryButton.setTitleColor(.white, for: .normal)
        categoryButton.backgroundColor = .clear
    }
}
