//
//  ActorsView.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 09.01.2024.
//

import UIKit

protocol ActorsProtocol: AnyObject {
    func selectItem (image: UIImageView, name: UILabel)
    
}

class ActorsView: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 64, height: 64)
        layout.minimumLineSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ActorsCell.self, forCellWithReuseIdentifier: ActorsCell.identifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
   weak var actorProtocol: ActorsProtocol?
    
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(ActorsCell.self, forCellWithReuseIdentifier: ActorsCell.identifier)
        assignDelegate()
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Methods
    func setDelegate(delegate: ActorsProtocol?) {
        actorProtocol = delegate
    }
    
    func assignDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupUI() {
        backgroundColor = .clear
        addSubview(collectionView)

    }
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
}
extension ActorsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

}
extension ActorsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorsCell.identifier, for: indexPath) as! ActorsCell
        // cell.viewForData() // возможно надо будет фиксить
        return cell
    }
    
}


