//
//  SearchViewController.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        setConstraints()
    }
    
    
    
    
    private lazy var testButton: UIButton = {
        let element = UIButton()
        element.setTitle("Details", for: .normal)
        element.backgroundColor = .systemGray
        element.addTarget(self, action: #selector(goToDetails), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    func setConstraints() {
        view.addSubview(testButton)
        NSLayoutConstraint.activate([
            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testButton.widthAnchor.constraint(equalToConstant: 350),
            testButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func goToDetails() {
        let vc = MovieDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
