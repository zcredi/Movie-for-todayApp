//
//  SearchViewController.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    let recent = RecentMovieCell()
    
    let recentMovieCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecentMovieCell.self, forCellWithReuseIdentifier: RecentMovieCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCompositionalLayout()
        horizontalSection()
        setupUI()
        setupConstraints()
        
    }
    
    private func setupUI() {
        [recentMovieCell, recent].forEach {
           $0.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview($0)
       }
    }
    
    func setupConstraints () {
        
        NSLayoutConstraint.activate([
            recent.topAnchor.constraint(equalTo: view.topAnchor,constant: 340),
            recent.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            recent.widthAnchor.constraint(equalToConstant: 360),
            recent.heightAnchor.constraint(equalToConstant: 310),
            recentMovieCell.topAnchor.constraint(equalTo: view.topAnchor,constant: 340),
            recentMovieCell.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            recentMovieCell.widthAnchor.constraint(equalToConstant: 360),
            recentMovieCell.heightAnchor.constraint(equalToConstant: 310)])
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layouts = UICollectionViewCompositionalLayout.init { sectionIndex, environment in
            self.horizontalSection ()
        }
        return layouts
    }
    
    func horizontalSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1),
                                               heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    
    
    
}
