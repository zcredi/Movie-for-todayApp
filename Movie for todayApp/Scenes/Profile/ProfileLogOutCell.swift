//
//  ProfileLogOutCell.swift
//  Movie for todayApp
//
//  Created by Andrei Shpartou on 27/12/2023.
//

import UIKit

class ProfileLogOutCell: UITableViewCell {
    static let identifier = "ProfileLogOutCell"
    
    private lazy var iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        //label.text = nil
        //label.font =
        //label.textColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 10, y: 6, width: size, height: size)
        
        let imageSize = size / 1.5
        iconImageView.frame = CGRect(x: (size - imageSize) / 2, y: (size - imageSize) / 2, width: imageSize, height: imageSize)
        
        label.frame = CGRect(x: 30 + Int(iconContainer.frame.size.width),
                             y: 0,
                             width: Int(contentView.frame.size.width - 30 - iconContainer.frame.size.width),
                             height: Int(contentView.frame.size.height))
                             
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
    }
    
    func configure(with model: ProfileLogOutModel) {
        label.text = model.title
        //iconImageView.image = model.image
        //iconContainer.backgroundColor = model.imageBackGroundColor
    }
    
}

