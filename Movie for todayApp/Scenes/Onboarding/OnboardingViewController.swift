//
//  OnboardingViewController.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let sliderData: [SliderItem] = [
        SliderItem(title: "Slide 1", text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.", animationName: "Animation 1"),
        SliderItem(title: "Slide 2", text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.", animationName: "Animation 2"),
        SliderItem(title: "Slide 3", text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.", animationName: "Animation 3")
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
        collection.register(SliderCell.self, forCellWithReuseIdentifier: String(describing: SliderCell.self))
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.bounces = false
        
        return collection
    }()
    
    let safeAreaBackgroundView = UIView()
    
    private var pagers: [UIView] = []
    private var currentSlide = 0
    private var widthAncor: NSLayoutConstraint?
    
    lazy var skipButton: UIButton = {
       let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor.textColorWhite, for: .normal)
        button.titleLabel?.font = UIFont.montserratRegular14()
//        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var hStack: UIStackView = {
        let stack = UIStackView()
         stack.axis = .horizontal
         stack.alignment = .center
         stack.spacing = 0
         stack.distribution = .equalSpacing
         stack.translatesAutoresizingMaskIntoConstraints = false
         return stack
    }()
    
    lazy var nextButton: UIView = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextSlide))
        
        let nextImage = UIImageView()
        nextImage.image = UIImage(systemName: "chevron.right")
        nextImage.tintColor = .white
        nextImage.contentMode = .scaleAspectFit
        nextImage.translatesAutoresizingMaskIntoConstraints = false
        nextImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        nextImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
       
        let button = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.backgroundColor = .primaryBlueAccent
        button.layer.cornerRadius = 15
        button.isUserInteractionEnabled = true
        
        button.addGestureRecognizer(tapGesture)
        button.addSubview(nextImage)
        
        nextImage.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        nextImage.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        
        return button
    }()
    
    private func setStatusBar() {
        safeAreaBackgroundView.backgroundColor = UIColor.primaryDark
        safeAreaBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(safeAreaBackgroundView)
        
        NSLayoutConstraint.activate([
        safeAreaBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
        safeAreaBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        safeAreaBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        safeAreaBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setStatusBar()
        
        setControl()
    }
    
    private func setControl() {
        
        view.addSubview(hStack)
        
        let pagerStack = UIStackView()
        pagerStack.axis = .horizontal
        pagerStack.spacing = 5
        pagerStack.alignment = .center
        pagerStack.distribution = .fill
        pagerStack.translatesAutoresizingMaskIntoConstraints = false
        
        for tag in 1...sliderData.count {
         let pager = UIView()
            pager.tag = tag
            pager.translatesAutoresizingMaskIntoConstraints = false
            pager.backgroundColor = .white
            
            pager.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollToSlide(sender: ))))
            
            pager.layer.cornerRadius = 5
            self.pagers.append(pager)
            pagerStack.addArrangedSubview(pager)
        }
        
        vStack.addArrangedSubview(pagerStack)
        vStack.addArrangedSubview(skipButton)
        
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(nextButton)
        
        NSLayoutConstraint.activate([
        
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            hStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        
        ])

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
    
    @objc func nextSlide() {
        let maxSlide = sliderData.count
        
        if currentSlide < maxSlide - 1 {
            currentSlide += 1
            onboardingCollectionView.scrollToItem(at: IndexPath(item: currentSlide, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    @objc func scrollToSlide(sender: UIGestureRecognizer) {
        if let index = sender.view?.tag {
            onboardingCollectionView.scrollToItem(at: IndexPath(item: index - 1, section: 0), at: .centeredHorizontally, animated: true)
            
            currentSlide = index - 1
        }
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sliderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SliderCell.self), for: indexPath) as? SliderCell {
            cell.contentView.backgroundColor = UIColor.primarySoft
            cell.titleLabel.text = sliderData[indexPath.item].title
            cell.textLabel.text = sliderData[indexPath.item].text
            cell.animationSetup(animationName: sliderData[indexPath.item].animationName)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentSlide = indexPath.item
        
        pagers.forEach { page in
            let tag = page.tag
            let viewTag = indexPath.row + 1 // or item??
            
            page.constraints.forEach { constraints in
                page.removeConstraint(constraints)
            }
            
            if viewTag == tag {
                page.layer.opacity = 1
                widthAncor = page.widthAnchor.constraint(equalToConstant: 30)
            } else {
                page.layer.opacity = 0.5
                widthAncor = page.widthAnchor.constraint(equalToConstant: 10)
            }
            
            widthAncor?.isActive = true
            page.heightAnchor.constraint(equalToConstant: 10).isActive = true
            
            
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // try this for custom pager scroll
    }
    
}

struct SliderItem {
    var title: String
    var text: String
    var animationName: String
}
