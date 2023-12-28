//
//  ProfileDetailsTableViewCell.swift
//  Movie for todayApp
//
//  Created by Andrei Shpartou on 27/12/2023.
//

import UIKit

class ProfileSettingsItemCell: UITableViewCell {
    static let identifier = "ProfileSettingsItemCell"
    
    private lazy var iconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .primarySoft
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel(text: "", font: .montserratMedium12(), textColor: .textColorWhite)
        return label
    }()
    
    private lazy var accessoryImageView: UIImageView = { UIImageView(image: UIImage(named: "ProfileImageSet/arrow")) }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.superview?.backgroundColor = .primaryDark
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(label)
        accessoryView = accessoryImageView
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
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
    }
    
    func configure(with model: ProfileSettingsItemModel) {
        label.text = model.title
        iconImageView.image = model.image
    }
    
}
