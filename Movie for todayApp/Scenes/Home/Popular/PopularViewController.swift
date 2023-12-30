//
//  PopularViewController.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import Foundation
import UIKit

class PopularMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

let popularTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(PopularTableViewCell.self, forCellReuseIdentifier: "PopularCell")
    
    return tableView
    
}()

let popularMovies = ["From Api", "Spider man", "Batman", "Terminator", "Life of Pi", "1 + 1", "2 + 1", "Race"]


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularTableView.delegate = self
        popularTableView.dataSource = self
        
        view.addSubview(popularTableView)
        
        NSLayoutConstraint.activate([
            popularTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popularTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularTableView.topAnchor.constraint(equalTo: view.topAnchor),
            popularTableView.heightAnchor.constraint(equalToConstant: 50),])
        
        
    }



//MARK: - UITableViewDataSource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as! PopularTableViewCell
        cell.popularImageView.image = UIImage(named: "movie\(indexPath.row + 1)")
        cell.popularTitleLabel.text = popularMovies[indexPath.row]
        return cell
    }

//MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


class PopularTableViewCell: UITableViewCell {
    let popularImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let popularTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(popularImageView)
        contentView.addSubview(popularTitleLabel)
        
        NSLayoutConstraint.activate([
            popularImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            popularImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            popularImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            popularImageView.widthAnchor.constraint(equalToConstant: 80),
            
            popularTitleLabel.leadingAnchor.constraint(equalTo: popularImageView.trailingAnchor, constant: 10),
            popularTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            popularTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
}
