//
//  MovieListViewController.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import Foundation
import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    let genresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "GenreCell")
        
        return collectionView
    }()
    
    let moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        
        return tableView
    }()
    
    let genres = ["All", "Comedy", "Animation", "Documental", "Horror", "Triller"]
    let movies = ["Movie 1", "Movie 2", "Movie 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genresCollectionView.dataSource = self
        genresCollectionView.delegate = self
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        view.addSubview(genresCollectionView)
        view.addSubview(moviesTableView)
        
        NSLayoutConstraint.activate([
            genresCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            genresCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genresCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            genresCollectionView.heightAnchor.constraint(equalToConstant: 50),
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.topAnchor.constraint(equalTo: genresCollectionView.bottomAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCollectionViewCell
        cell.genreLabel.text = genres[indexPath.item]
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - UITableViewDataSource
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
            cell.movieImageView.image = UIImage(named: "movie\(indexPath.row + 1)")
            cell.movieTitleLabel.text = movies[indexPath.row]
            return cell
        }
        // MARK: - UITableViewDelegate
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    }

    class GenreCollectionViewCell: UICollectionViewCell {
        
        let genreLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(genreLabel)
            
            NSLayoutConstraint.activate([
                genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                genreLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                genreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    class MovieTableViewCell: UITableViewCell {
        
        let movieImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            
            return imageView
        }()
        
        let movieTitleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 16)
            
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubview(movieImageView)
            contentView.addSubview(movieTitleLabel)
            
            NSLayoutConstraint.activate([
                movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                movieImageView.widthAnchor.constraint(equalToConstant: 80),
                
                movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
                movieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
