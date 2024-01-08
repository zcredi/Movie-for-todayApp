//
//  ResultViewCollection.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 09.01.2024.
//

import UIKit

protocol ResultProtocol: AnyObject {
    func selectItem (movieCard: UIView)
    
}

class ResultViewCollection: UIView {
    
    //MARK: UI
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 350, height: 200)
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ResultViewCell.self, forCellWithReuseIdentifier: ResultViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
   weak var resultProtocol: ResultProtocol?
    
    
    //MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(ResultViewCell.self, forCellWithReuseIdentifier: ResultViewCell.identifier)
        assignDelegate()
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Methods
    func setDelegate(delegate: ResultProtocol?) {
        resultProtocol = delegate
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
extension ResultViewCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

}
extension ResultViewCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultViewCell.identifier, for: indexPath) as! ResultViewCell
        // cell.viewForData() // возможно надо будет фиксить
        return cell
    }
    
}
