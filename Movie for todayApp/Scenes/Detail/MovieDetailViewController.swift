//
//  MovieDetailViewController.swift
//  Movie for todayApp
//
//  Created by Alexander Altman on 08.01.2024.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: - Dependencies
    let text = "For the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. Ghjdfalhdfaljhdsgf asldkhgfahdhfga alhghfhgapiueriug guruaerpiuhgrg gurqiuerhgiquherg qieurhgpiquerhgpiuhqeriguh qeriughqpeirugh."
    
    let navTitle = "Spider-Man No Way Home"
    
    //MARK: - UI Elements
    let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .orange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.5"
        label.textColor = .orange
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let castLabel: UILabel = {
        let label = UILabel()
        label.text = "Casts and Crew"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let stackImages = ["calendar", "clock", "film"]
    let stackLabels = ["2021", "148 Minutes", "Action"]
    
    private func setStack() {
        for (index, imageName) in stackImages.enumerated() {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .gray
            imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
            
            let label = UILabel()
            label.text = stackLabels[index]
            label.textColor = .gray
            
            descriptionStack.addArrangedSubview(imageView)
            descriptionStack.addArrangedSubview(label)
            
            if index < stackImages.count - 1 {
                let separatorView = UIView()
                separatorView.backgroundColor = .gray
                separatorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
                separatorView.heightAnchor.constraint(equalToConstant: 16).isActive = true
                descriptionStack.addArrangedSubview(separatorView)
            }
        }
    }
    
    let castCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private func setCastCollection() {
        castCollectionView.translatesAutoresizingMaskIntoConstraints = false
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.register(CastCell.self, forCellWithReuseIdentifier: "CastCell")
        
        if let layout = castCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 150, height: 50)
        }
        castCollectionView.backgroundColor = .primaryDark
    }
    
    let tabBarGhostView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "MoviePoster")
        return imageView
    }()
    
    let nestedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "MoviePoster")
        return imageView
    }()
    
    let overlayImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Overlay")
        return imageView
    }()
    
    lazy var textHeader: UILabel = {
        let label = UILabel()
        label.text = "Story Line"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var storyLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .white
        textView.text = text
        textView.numberOfLines = 6
        textView.font = .systemFont(ofSize: 14)
        return textView
    }()
    
    // Buttons
    lazy var trailerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Trailer", for: .normal)
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(trailerTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .primaryBlueAccent
        button.backgroundColor = UIColor.primarySoft
        button.layer.cornerRadius = 48 / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("More", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(showMoreScreen), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setCastCollection()
        setConstraints()
        setupNavigationBar()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        view.addSubview(scrollView)
        view.addSubview(tabBarGhostView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainImageView)
        contentView.addSubview(textHeader)
        contentView.addSubview(storyLabel)
        contentView.addSubview(moreButton)
        contentView.addSubview(castLabel)
        contentView.addSubview(castCollectionView)
        mainImageView.addSubview(overlayImageView)
        overlayImageView.addSubview(nestedImageView)
        overlayImageView.addSubview(trailerButton)
        overlayImageView.addSubview(shareButton)
        overlayImageView.addSubview(descriptionStack)
        setStack()
        overlayImageView.addSubview(starImageView)
        overlayImageView.addSubview(ratingLabel)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = navTitle
        let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteTapped))
        navigationItem.rightBarButtonItem = heartButton
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    //MARK: - ObjC Methods
    @objc func showMoreScreen() {
        let detailedTextViewController = DetailedTextViewController()
        detailedTextViewController.fullText = text
        present(detailedTextViewController, animated: true)
    }
    
    @objc private func favoriteTapped() {
        // Handle favorite button tap
    }
    
    @objc private func shareTapped() {
        // Handle share button tap
    }
    
    @objc private func trailerTapped() {
        // Handle trailer button tap
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
        cell.nameLabel.text = "John Doe"
        cell.jobLabel.text = "Director"
        cell.imageView.image = UIImage(named: "Avatar")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 50)
    }
}

//MARK: - Constraints
private extension MovieDetailViewController {
    func setConstraints() {
        scrollView.contentInsetAdjustmentBehavior = .never
        NSLayoutConstraint.activate([
            tabBarGhostView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarGhostView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarGhostView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarGhostView.heightAnchor.constraint(equalToConstant: 83),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: tabBarGhostView.topAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3),
            
            overlayImageView.topAnchor.constraint(equalTo: mainImageView.topAnchor),
            overlayImageView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor),
            overlayImageView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor),
            overlayImageView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            
            nestedImageView.centerXAnchor.constraint(equalTo: overlayImageView.centerXAnchor),
            nestedImageView.centerYAnchor.constraint(equalTo: overlayImageView.centerYAnchor),
            nestedImageView.widthAnchor.constraint(equalTo: overlayImageView.widthAnchor, multiplier: 0.5),
            nestedImageView.heightAnchor.constraint(equalTo: overlayImageView.heightAnchor, multiplier: 2/3),
            
            descriptionStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionStack.bottomAnchor.constraint(equalTo: starImageView.topAnchor, constant: -16),
            descriptionStack.heightAnchor.constraint(equalToConstant: 30),
            
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            starImageView.heightAnchor.constraint(equalToConstant: 16),
            starImageView.bottomAnchor.constraint(equalTo: trailerButton.topAnchor, constant: -8),
            starImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -8),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 8),
            ratingLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            
            trailerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 66),
            trailerButton.widthAnchor.constraint(equalToConstant: 115),
            trailerButton.heightAnchor.constraint(equalToConstant: 48),
            trailerButton.bottomAnchor.constraint(equalTo: overlayImageView.bottomAnchor, constant: -8),
            
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -75),
            shareButton.widthAnchor.constraint(equalToConstant: 48),
            shareButton.heightAnchor.constraint(equalToConstant: 48),
            shareButton.bottomAnchor.constraint(equalTo: overlayImageView.bottomAnchor, constant: -8),
            
            textHeader.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 16),
            textHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            storyLabel.topAnchor.constraint(equalTo: textHeader.bottomAnchor, constant: 8),
            storyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            storyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            moreButton.topAnchor.constraint(equalTo: storyLabel.bottomAnchor, constant: 8),
            moreButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            castLabel.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 20),
            castLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            castCollectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 16),
            castCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            castCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            castCollectionView.heightAnchor.constraint(equalToConstant: 80),
            castCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
