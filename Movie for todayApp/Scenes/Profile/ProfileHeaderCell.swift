//
//  ProfileHeaderCell.swift
//  Movie for todayApp
//
//  Created by Andrei Shpartou on 27/12/2023.
//
import UIKit

class ProfileHeaderCell: UITableViewCell {
    static let identifier = "ProfileHeaderCell"
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = { UILabel(text: "", font: .montserratSemiBold14(), textColor: .textColorWhite) }()
    
    private lazy var emailLabel: UILabel = { UILabel(text: "", font: .montserratRegular10(), textColor: .textColorDarkGrey) }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.frame.size.height
        
        let imageSize = size / 1.5
        profileImageView.frame = CGRect(x: (size - imageSize) / 2, y: (size - imageSize) / 2, width: imageSize, height: imageSize)
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        
        nameLabel.frame = CGRect(x: 30 + Int(profileImageView.frame.size.width),
                                 y: Int(contentView.frame.size.height) / 4,
                                 width: Int(contentView.frame.size.width - 30 - profileImageView.frame.size.width),
                                 height: Int(contentView.frame.size.height) / 2)
        nameLabel.sizeToFit()

        
        emailLabel.frame = CGRect(x: 30 + Int(profileImageView.frame.size.width),
                                  y: Int(contentView.frame.size.height) / 4 + Int(nameLabel.frame.size.height),
                                  width: Int(contentView.frame.size.width - 30 - profileImageView.frame.size.width),
                                  height: Int(contentView.frame.size.height) / 2)
        emailLabel.sizeToFit()
        
    }
    
    func configure(with model: ProfileHeaderModel) {
        profileImageView.image = model.image
        nameLabel.text = model.name
        emailLabel.text = model.email
    }
    
}

