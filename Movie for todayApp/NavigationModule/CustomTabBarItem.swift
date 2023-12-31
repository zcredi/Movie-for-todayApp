//
//  CustomTabBarItem.swift
//  Movie for todayApp
//
//  Created by Alexander Altman on 26.12.2023.
//

import UIKit

class CustomTabBarItem: UIView {
    
    //MARK: - UI Elements
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var backgroundView: UIView!
    var onTap: (() -> Void)?
    var isSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    //MARK: - Initialization and Life Cycle
    init(icon: UIImage, title: String) {
        super.init(frame: .zero)
        imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.montserratMedium14()
        titleLabel.textAlignment = .center
        titleLabel.isHidden = !isSelected
        titleLabel.alpha = isSelected ? 1.0 : 0.0
        
        backgroundView = UIView()
        backgroundView.layer.cornerRadius = 16
        backgroundView.isHidden = !isSelected
        backgroundView.alpha = isSelected ? 1.0 : 0.0
        
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        animate(isSelected: isSelected)
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        addSubview(backgroundView)
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: -8),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8)
        ])
        
        backgroundView.isHidden = true
    }
    
    private func updateAppearance() {
        let imageFrame = imageView.frame
        let imageX = isSelected ? (bounds.width / 2 - imageFrame.width / 2) : (bounds.width / 2 - imageFrame.width / 2 + 8)
        
        let backgroundWidth = bounds.width - 2 * 5
        let backgroundX = isSelected ? (imageX - 8) : (bounds.width / 2 - backgroundWidth / 2)
        
        let newX = isSelected ? bounds.midX : backgroundX
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.imageView.tintColor = self.isSelected ? .primaryBlueAccent : .textColorGrey
            self.titleLabel.textColor = self.isSelected ? .primaryBlueAccent : .textColorGrey
            self.titleLabel.alpha = self.isSelected ? 1 : 0
            self.backgroundView.backgroundColor = self.isSelected ? .primarySoft : .clear
            self.backgroundView.alpha = self.isSelected ? 1 : 0
            self.imageView.frame.origin.x = imageX
            self.titleLabel.frame.origin.x = self.imageView.frame.maxX + 8
            self.backgroundView.frame.origin.x = newX
        }, completion: { _ in
            if self.isSelected {
                self.titleLabel.isHidden = false
                self.backgroundView.isHidden = false
            } else {
                self.titleLabel.isHidden = true
                self.backgroundView.isHidden = true
            }
        })
    }
    
    @objc private func didTap() {
        onTap?()
    }

//MARK: - Methods
    func configureInitialLayout() {
        imageView.tintColor = isSelected ? .primaryBlueAccent : .textColorGrey
        titleLabel.textColor = isSelected ? .primaryBlueAccent : .textColorGrey
        titleLabel.alpha = isSelected ? 1 : 0
        backgroundView.alpha = isSelected ? 1 : 0
        
        // Adjust the background frame to cover both image and text
        let totalWidth = isSelected ? (imageView.frame.width + titleLabel.intrinsicContentSize.width + 16) : imageView.frame.width
        let contentOffset = max((bounds.width - totalWidth) / 2, 0)
        backgroundView.frame = CGRect(
            x: contentOffset,
            y: imageView.frame.minY - 4,
            width: totalWidth,
            height: imageView.frame.height + 8
        )
        
        // Adjust the imageView transform based on selection
        imageView.transform = isSelected ? CGAffineTransform(translationX: -30, y: 0) : .identity
        
        // Show/hide text and background based on isSelected
        if isSelected {
            titleLabel.isHidden = false
            backgroundView.isHidden = false
        } else {
            titleLabel.isHidden = true
            backgroundView.isHidden = true
        }
        
        layoutIfNeeded()
    }
    
    func animate(isSelected: Bool) {
        titleLabel.isHidden = false
        backgroundView.isHidden = false
        
        let labelSize = titleLabel.intrinsicContentSize
        let imageFrame = imageView.frame
        let totalWidth = isSelected ? (imageFrame.width + labelSize.width + 16) : imageFrame.width
        let imageX = isSelected ? (bounds.width / 2 - totalWidth / 2) : (bounds.width / 2 - imageFrame.width / 2)
        
        let backgroundWidth = isSelected ? (bounds.width - 2 * 5) : (imageFrame.width + 8)
        let backgroundX = isSelected ? (bounds.width / 2 - backgroundWidth / 2) : (bounds.width / 2 - imageFrame.width / 2)
        
        UIView.animate(withDuration: isSelected ? 0.0 : 0.3, animations: {
            self.imageView.tintColor = isSelected ? .primaryBlueAccent : .textColorGrey
            self.titleLabel.textColor = isSelected ? .primaryBlueAccent : .textColorGrey
            self.titleLabel.alpha = isSelected ? 1 : 0
            self.backgroundView.backgroundColor = isSelected ? .primarySoft : .clear
            self.backgroundView.alpha = isSelected ? 1 : 0
            self.imageView.frame.origin.x = max(imageX, 0)
            self.titleLabel.frame.origin.x = max(imageX + imageFrame.width + 8, 0)
            self.backgroundView.frame = CGRect(
                x: max(backgroundX, 0),
                y: imageFrame.minY - 12,
                width: backgroundWidth,
                height: imageFrame.height + 24
            )
        }, completion: { _ in
            if !isSelected {
                self.titleLabel.isHidden = true
                self.backgroundView.isHidden = true
            }
        })
    }
}
