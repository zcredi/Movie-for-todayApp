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
    private let cancel: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .montserratMedium12()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(cancelButton), for: .touchUpInside)
        return button
    }()
    private let result = ResultViewCollection()
    private let actors = ActorsView()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        view.backgroundColor = .primaryDark
    }
    
    // MARK: Methods
    private func setupUI() {
        [searchField, result, cancel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cancel.topAnchor.constraint(equalTo: searchField.topAnchor),
            cancel.leadingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: 10),
            cancel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            //searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            result.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 40),
            result.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            result.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            result.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
//            actors.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 40),
//            actors.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//            actors.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            actors.heightAnchor.constraint(equalToConstant: 70),
//            actors.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 450)
            
        ])
        
    }
    
    @objc  func cancelButton() {
//        let vc = SearchViewController()
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)

    }
    
}
