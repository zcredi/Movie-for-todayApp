//
//  ResultViewCell.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 08.01.2024.
//

import UIKit

class ResultViewCell: UICollectionViewCell {
    
  static let identifier = "\(ResultViewCell.self)"
    
    //MARK: UI
   let movieCard = MovieCardView()

    
    
    // MARK: LifeCycle
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(movieCard)
        movieCard.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movieCard.topAnchor.constraint(equalTo: topAnchor),
            movieCard.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieCard.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieCard.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
}
