//
//  SliderCell.swift
//  Movie for todayApp
//
//  Created by Alexander Altman on 30.12.2023.
//

import UIKit
import Lottie

class SliderCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    var textLabel = UILabel()
    private let lottieView = LottieAnimationView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSlide()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // make convenience Labels
    private func setSlide() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        textLabel.textColor = .white
        textLabel.numberOfLines = 0
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .black)
        textLabel.font = UIFont.systemFont(ofSize: 16)
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        
        ])
    }
    
    func animationSetup(animationName: String) {
        contentView.addSubview(lottieView)
        
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.animation = LottieAnimation.named(animationName)
        lottieView.loopMode = .loop
        lottieView.contentMode = .scaleAspectFill
        lottieView.configuration.renderingEngine = .mainThread
        
        NSLayoutConstraint.activate([
        
            lottieView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lottieView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lottieView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lottieView.heightAnchor.constraint(equalToConstant: 300),
            
        ])
        
        lottieView.play()
    }
    
}
