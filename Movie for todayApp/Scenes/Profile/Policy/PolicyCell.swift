//
//  PolicyCell.swift
//  Movie for todayApp
//
//  Created by Andrei Shpartou on 30/12/2023.
//

import UIKit

class PolicyCell: UITableViewCell {
    static let identifier = "PolicyCell"
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .primaryDark
        textView.font = .systemFont(ofSize: 15.0)
        textView.textColor = .textColorWhiteGrey
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.superview?.backgroundColor = .primaryDark
        contentView.addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = contentView.frame.size.height - 10
        let width =  contentView.frame.size.width - 10
        textView.frame = CGRect(x: 0, y: 10, width: width, height: height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = nil
    }

    func configure(with sectionText: String) {
        textView.text = sectionText
    }

}
