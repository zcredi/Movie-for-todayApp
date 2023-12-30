import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let identifier = "\(SectionHeaderView.self)"
    
    private lazy var sectionHeaderStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .center
        return sv
    }()
    private lazy var headerTitle = UILabel(font: .boldSystemFont(ofSize: 16), textColor: .white)
    private lazy var seeAllButton: UIButton = {
        let button = UIButton(title: "See All", font: .systemFont(ofSize: 14), titleColor: .cyan)
        button.setContentHuggingPriority(.required, for: .horizontal)
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
        addSubviews(sectionHeaderStackView)
        
        NSLayoutConstraint.activate([
            sectionHeaderStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            sectionHeaderStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sectionHeaderStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sectionHeaderStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        sectionHeaderStackView.addArrangedSubview(headerTitle)
        sectionHeaderStackView.addArrangedSubview(seeAllButton)
    }
    
    public func setTitle(_ title: String) {
        headerTitle.text = title
    }
    
}
