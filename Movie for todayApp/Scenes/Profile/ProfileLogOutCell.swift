//
//  ProfileLogOutCell.swift
//  Movie for todayApp
//
//  Created by Andrei Shpartou on 27/12/2023.
//
import UIKit

class ProfileLogOutCell: UITableViewCell {
    static let identifier = "ProfileLogOutCell"
    
    private lazy var label: UILabel = {
        let label = UILabel(text: "", font: .montserratSemiBold10(), textColor: .systemRed)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.superview?.backgroundColor = .primaryDark
        contentView.addSubview(label)
        contentView.layer.cornerRadius = contentView.frame.height / 5
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 0,
                             y: 0,
                             width: Int(contentView.frame.size.width),
                             height: Int(contentView.frame.size.height))
    }
    
    func configure(with model: ProfileLogOutModel) {
        label.text = model.title
    }    
}

