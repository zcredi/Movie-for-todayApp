//
//  RecentMovieView.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 05.01.2024.
//

import UIKit

protocol RecentMovieProtocol: AnyObject {
    func selectItem (image: UIImageView, containerFilm: UIView)
    
}

class RecentMovieView: UIView {

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 150, height: 200)
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecentMovieCell.self, forCellWithReuseIdentifier: RecentMovieCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    weak var recentDelegate: RecentMovieProtocol?
    
   // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(RecentMovieCell.self, forCellWithReuseIdentifier: RecentMovieCell.identifier)
        assignDelegate()
        setupUI()
        setupConstaints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   // MARK: Methods
    
    func setDelegate(delegate: RecentMovieProtocol?) {
        recentDelegate = delegate
    }
    
    func assignDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupUI() {
        backgroundColor = .clear
        layer.cornerRadius = 10
        addSubview(collectionView)
        collectionView.showsHorizontalScrollIndicator = true
    }
    
   
    func setupConstaints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
}

extension RecentMovieView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

}
extension RecentMovieView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentMovieCell.identifier, for: indexPath) as! RecentMovieCell
       // cell.viewForData() // возможно надо будет фиксить
        return cell
    }
    
    
    
}
