//
//  ActorsCell.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 09.01.2024.
//

import UIKit

class ActorsCell: UICollectionViewCell {
    
    static let identifier = "\(ActorsCell.self)"
    
    //MARK: UI
    private lazy var actorImage: UIImageView = {
      let actor = UIImageView()
      actor.backgroundColor = .systemRed
      actor.layer.cornerRadius = 25
        actor.contentMode = .scaleAspectFit
      return actor
    }()
    private lazy var actorName = UILabel(text: "John Doe", font: .systemFont(ofSize: 16), textColor: .black)
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        [actorImage, actorName ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            actorImage.topAnchor.constraint(equalTo: topAnchor),
            actorImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            actorImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            actorName.topAnchor.constraint(equalTo: actorImage.bottomAnchor, constant: -10),
            actorName.leadingAnchor.constraint(equalTo: actorImage.leadingAnchor),
            actorName.trailingAnchor.constraint(equalTo: actorImage.leadingAnchor),
            actorName.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
