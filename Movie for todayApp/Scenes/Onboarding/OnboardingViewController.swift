//
//  OnboardingViewController.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let sliderData: [SliderItem] = [
    
        SliderItem(color: .brown, title: "Slide 1", text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.", animationName: ""),
        SliderItem(color: .orange, title: "Slide 2", text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.", animationName: ""),
        SliderItem(color: .green, title: "Slide 3", text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.", animationName: "")
    
    ]
    
    
    lazy var onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
//        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(onboardingCollectionView)
        
        NSLayoutConstraint.activate([
            onboardingCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        ])
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sliderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        cell.contentView.backgroundColor = sliderData[indexPath.item].color
        return cell
    }
    
    
}


struct SliderItem {
    var color: UIColor
    var title: String
    var text: String
    var animationName: String
}
