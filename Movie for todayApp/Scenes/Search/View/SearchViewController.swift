//
//  SearchViewController.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import UIKit


class SearchViewController: UIViewController {
    
    
    let recent = RecentMovieCell()
    // MARK: - UI
    
    let searchField: UISearchTextField = {
        
        let search = UISearchTextField()
        search.layer.cornerRadius = 15
        search.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        search.leftView?.tintColor = .white
        search.attributedPlaceholder = NSAttributedString(string: "Type title, categories, years, etc", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        search.textColor = .white
        return search
    }()
    let upcomingMovie: UILabel = {
       let title = UILabel()
        title.textColor = .white
        title.font = .montserratSemiBold16()
        title.text = "Upcoming Movie"
        return title
    }()
    
    let movieImageView: UIImageView = {
        let movieImage = UIImageView()
        movieImage.backgroundColor = .systemBlue
        movieImage.layer.cornerRadius = 15
        return movieImage
    }()
    let movieName: UILabel = {
        let title = UILabel()
        title.font = .montserratSemiBold16()
        title.textColor = .white
        title.text = "Spider man"
        title.numberOfLines = 1
        return title
    }()
    let year: UILabel = {
        let title = UILabel()
        title.text = "2015"
        title.textColor = .lightGray
        title.font = .montserratMedium12()
        return title
    }()
    let duration: UILabel = {
        let title = UILabel()
        title.textColor = .lightGray
        title.text = "140 Minutes"
        return title
    }()
    let genre: UILabel = {
        let title = UILabel()
        title.textColor = .lightGray
        title.text = "Action"
        return title
    }()
    
    let typeOfMovie: UILabel = {
        let title = UILabel()
        title.font = .montserratMedium12()
        title.textColor = .lightGray
        title.text = "Movie"
        return title
    }()
    
    let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.titleLabel?.font = .montserratMedium14()
        button.backgroundColor = .clear
        return button
    }()
    
    let recentMovieCell: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecentMovieCell.self, forCellWithReuseIdentifier: RecentMovieCell.identifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = .primaryDark
//        createCompositionalLayout()
//        horizontalSection()
        setupUI()
        setupConstraints()
//        collectionView(recentMovieCell, cellForItemAt: 1)
//        collectionViewLayout(recentMovieCell, numberOfItemsInSection: 1)
    }
    
    private func setupUI() {
        [searchField, upcomingMovie, recentMovieCell, movieImageView, movieName, year, duration, genre, typeOfMovie, seeAllButton].forEach {
           $0.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview($0)
       }
    }
    
    func setupConstraints () {
        
        NSLayoutConstraint.activate([
//            recent.topAnchor.constraint(equalTo: view.topAnchor,constant: 340),
//            recent.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//            recent.widthAnchor.constraint(equalToConstant: 360),
//            recent.heightAnchor.constraint(equalToConstant: 310),

            recentMovieCell.topAnchor.constraint(equalTo: view.topAnchor,constant: 450),
            recentMovieCell.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            recentMovieCell.widthAnchor.constraint(equalToConstant: 360),
            recentMovieCell.heightAnchor.constraint(equalToConstant: 310),
            
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            upcomingMovie.bottomAnchor.constraint(equalTo: movieImageView.topAnchor, constant: -10),
            upcomingMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            movieImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            movieImageView.widthAnchor.constraint(equalToConstant: 110),
            movieImageView.heightAnchor.constraint(equalToConstant: 150),
            
            movieName.topAnchor.constraint(equalTo: view.topAnchor, constant: 260),
            movieName.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            year.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 13),
            year.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            duration.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 13),
            duration.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            genre.topAnchor.constraint(equalTo: duration.bottomAnchor, constant: 13),
            genre.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            
            typeOfMovie.topAnchor.constraint(equalTo: duration.bottomAnchor, constant: 13),
            typeOfMovie.leadingAnchor.constraint(equalTo: genre.trailingAnchor, constant: 15),
            
            seeAllButton.bottomAnchor.constraint(equalTo: recentMovieCell.topAnchor, constant: -20),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)

            
            
        ])
    }
    
//    private func createCompositionalLayout() -> UICollectionViewLayout {
//
//        let layouts = UICollectionViewCompositionalLayout.init { sectionIndex, environment in
//            self.horizontalSection ()
//        }
//        return layouts
//    }
    
//    func horizontalSection() -> NSCollectionLayoutSection {
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
//                                              heightDimension: .fractionalHeight(1.1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1),
//                                               heightDimension: .estimated(200))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
//                                                       subitems: [item])
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        return section
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//           // Вернуть количество элементов
//        return 3
//       }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentMovieCell.identifier, for: indexPath) as! RecentMovieCell
        // Конфигурируем ячейку
//        cell.label.text = dataArray[indexPath.item]
        cell.movieImage.image = UIImage(systemName: "questionmark.app.fill")
        cell.genre.text = "Action"
        cell.movieName.text = "Spider man"
        return cell
    }
    func collectionViewLayout(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    
}
