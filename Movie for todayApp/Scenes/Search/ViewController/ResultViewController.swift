//
//  SearchResult.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 04.01.2024.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - UI
    
    private let searchField: UISearchTextField = {
        let search = UISearchTextField()
        search.layer.cornerRadius = 15
        search.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        search.leftView?.tintColor = .white
        search.attributedPlaceholder = NSAttributedString(string: "Type title, categories, years, etc", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        search.textColor = .white
        return search
    }()
    let result = ResultViewCollection()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        view.backgroundColor = .primaryDark
    }
    
    // MARK: Methods
    private func setupUI() {
        [searchField, result].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            result.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 40),
            result.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            result.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            result.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
}
