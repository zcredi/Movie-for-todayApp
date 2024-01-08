//
//  DetailViewController.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let moviePosterBackgroundImageView = UIImageView()
    let starImageView = UIImageView()
    let ratingLabel = UILabel()
    let storylineLabel = UILabel()
    let castCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let moreButton = UIButton()
    let trailerButton = UIButton()
    let buyTicketButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupViews() {
        // Movie Poster Image
        moviePosterBackgroundImageView.image = UIImage(named: "MoviePoster")
        moviePosterBackgroundImageView.contentMode = .scaleAspectFill
        moviePosterBackgroundImageView.clipsToBounds = true
        
        // Star Image
        starImageView.image = UIImage(systemName: "star.fill")
        
        // Rating Label
        ratingLabel.text = "4.5"
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        // Storyline Label
        storylineLabel.text = "For the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed..."
        storylineLabel.font = UIFont.systemFont(ofSize: 12)
        storylineLabel.numberOfLines = 0
        
        // More Button
        moreButton.setTitle("More", for: .normal)
        moreButton.setTitleColor(.blue, for: .normal)
        moreButton.addTarget(self, action: #selector(showMoreStoryline), for: .touchUpInside)
        
        // Trailer Button
        trailerButton.setTitle("Trailer", for: .normal)
        // Style and target-action for trailerButton
        
        // Buy Ticket Button
        buyTicketButton.setTitle("Buy Ticket", for: .normal)
        // Style and target-action for buyTicketButton
        
        // Cast Collection View
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.register(CastCell.self, forCellWithReuseIdentifier: "CastCell")
        if let layout = castCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 70, height: 90)
        }
        castCollectionView.backgroundColor = .blue
        
        // Add subviews
        view.addSubview(moviePosterBackgroundImageView)
        view.addSubview(starImageView)
        view.addSubview(ratingLabel)
        view.addSubview(storylineLabel)
        view.addSubview(moreButton)
        view.addSubview(trailerButton)
        view.addSubview(buyTicketButton)
        view.addSubview(castCollectionView)
    }
    
    private func setupConstraints() {
        moviePosterBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
                starImageView.translatesAutoresizingMaskIntoConstraints = false
                ratingLabel.translatesAutoresizingMaskIntoConstraints = false
                storylineLabel.translatesAutoresizingMaskIntoConstraints = false
                moreButton.translatesAutoresizingMaskIntoConstraints = false
                trailerButton.translatesAutoresizingMaskIntoConstraints = false
                buyTicketButton.translatesAutoresizingMaskIntoConstraints = false
                castCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moviePosterBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                        moviePosterBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        moviePosterBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        moviePosterBackgroundImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.2),
                        
                        starImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        starImageView.topAnchor.constraint(equalTo: moviePosterBackgroundImageView.bottomAnchor, constant: 10),
                        starImageView.widthAnchor.constraint(equalToConstant: 25),
                        starImageView.heightAnchor.constraint(equalToConstant: 25),
                        
                        ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 8),
                        ratingLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
                        
                        storylineLabel.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 10),
                        storylineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        storylineLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        
                        moreButton.topAnchor.constraint(equalTo: storylineLabel.bottomAnchor, constant: 5),
                        moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        
                        trailerButton.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 20),
                        trailerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        trailerButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
                        trailerButton.heightAnchor.constraint(equalToConstant: 44),
                        
                        buyTicketButton.topAnchor.constraint(equalTo: trailerButton.topAnchor),
                        buyTicketButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
                        buyTicketButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        buyTicketButton.heightAnchor.constraint(equalTo: trailerButton.heightAnchor),
                        
                        castCollectionView.topAnchor.constraint(equalTo: trailerButton.bottomAnchor, constant: 20),
                        castCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        castCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        castCollectionView.heightAnchor.constraint(equalToConstant: 110),
                        castCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
    }
    
    private func setupNavigationBar() {
        // Navigation Bar setup
        navigationItem.title = "Spider-Man No Way..."
        let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favoriteTapped))
        navigationItem.rightBarButtonItem = heartButton
        
        // Make the navigation bar background translucent
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
    }
    
    @objc private func showMoreStoryline() {
        // Present a new view controller modally with the full storyline
    }
    
    @objc private func favoriteTapped() {
        // Handle favorite button tap
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
                // Configure the cell
                cell.nameLabel.text = "John Doe"
                cell.imageView.image = UIImage(named: "Avatar") // Replace with actual image
                return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 90)
    }
}

// MARK: - Custom UICollectionViewCell
class CastCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = frame.size.width / 2
        nameLabel.font = UIFont.systemFont(ofSize: 10)
        nameLabel.textAlignment = .center
        
        contentView.addSubview(imageView)
                contentView.addSubview(nameLabel)
                setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 60),
                imageView.heightAnchor.constraint(equalToConstant: 60),
                
                nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
}
