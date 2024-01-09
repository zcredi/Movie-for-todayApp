//
//  SearchViewController.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import UIKit


class SearchViewController: UIViewController {
    
    // MARK: - UI elements
    private let recentMovieView = RecentMovieView()
    private let upcomingMovieView = MovieCardView()
    private let searchField: UISearchTextField = {
        let search = UISearchTextField()
        search.layer.cornerRadius = 15
        search.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        search.leftView?.tintColor = .white
        search.attributedPlaceholder = NSAttributedString(string: "Type title, categories, years, etc", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        search.textColor = .white
        return search
    }()

      private let recentMovieLabel = UILabel(text: "Recent Movie", font: .montserratSemiBold16(), textColor: .white)
      private let upcomingMovieLabel = UILabel(text: "Upcoming Movie", font: .montserratSemiBold16(), textColor: .white)

    
    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.titleLabel?.font = .montserratMedium14()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(seeAll), for: .touchUpInside)
        return button
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    // MARK: Methods
    private func setupUI() {
        [searchField, upcomingMovieLabel, recentMovieLabel, recentMovieView, seeAllButton, upcomingMovieView].forEach {
           $0.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview($0)
       }
    }
   private func setupConstraints () {
        NSLayoutConstraint.activate([
            
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            upcomingMovieLabel.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 90),
            upcomingMovieLabel.leadingAnchor.constraint(equalTo: recentMovieLabel.leadingAnchor),
            
            upcomingMovieView.topAnchor.constraint(equalTo: upcomingMovieLabel.bottomAnchor ,constant: 10),
            upcomingMovieView.leadingAnchor.constraint(equalTo: upcomingMovieLabel.leadingAnchor),
            
            recentMovieLabel.bottomAnchor.constraint(equalTo: recentMovieView.topAnchor, constant: -20),
            recentMovieLabel.leadingAnchor.constraint(equalTo: recentMovieView.leadingAnchor),
            
            recentMovieView.topAnchor.constraint(equalTo: view.topAnchor,constant: 550),
            recentMovieView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            recentMovieView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            recentMovieView.widthAnchor.constraint(equalToConstant: 360),
            
            seeAllButton.bottomAnchor.constraint(equalTo: recentMovieView.topAnchor, constant: -15),
            seeAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
        ])
    }

    @objc func seeAll (){
        let vc = ResultViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
