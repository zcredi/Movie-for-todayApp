//
//  ResultViewCell.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 08.01.2024.
//

import UIKit

class ResultViewCell: UICollectionViewCell {
    
    //MARK: UI
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    private let year = UILabel(text: "2015", font: .montserratMedium12(), textColor: .lightGray)
    private let movieName = UILabel(text: "Spider Man", font: .montserratSemiBold16(), textColor: .white)
    private let duration = UILabel(text: "140 minutes", font: .montserratMedium12(), textColor: .lightGray)
    private let genre = UILabel(text: "Action", font: .montserratMedium12(), textColor: .lightGray)
    private let typeOfMovie = UILabel(text: "Movie", font: .montserratMedium12(), textColor: .lightGray)

    
    
    // MARK: LifeCycle
    override init(frame:CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
